# Flutter Project Architecture Guide

## Core Tech Stack
- Flutter + Supabase backend
- State Management: hooks_riverpod + flutter_hooks
- Code Generation: freezed_annotation, riverpod_annotation
- Navigation: auto_route
- Custom Utilities: kimapp packages (base helpers, generators, supabase_helper)

## Project Structure
```
lib/
├── config.dart         # Global configuration
├── exports.dart        # Centralized exports
├── main.dart          # Production entry
├── main_dev.dart      # Development entry
└── src/
    ├── commons/       # Shared utilities
    │   ├── account/   # Current user & auth management
    │   ├── cache_manager/
    │   ├── device/    # Device info
    │   ├── errors/    # Error handling
    │   ├── file/      # File operations
    │   ├── helpers/   # Utility functions
    │   └── supabase/  # Supabase config
    ├── features/      # Core business logic
    │   └── feature_name/  # Example feature
    │       ├── providers/
    │       │   ├── feature_create_provider.dart
    │       │   ├── feature_detail_provider.dart
    │       │   ├── feature_list_provider.dart
    │       │   └── providers.dart
    │       ├── i_feature_repo.dart
    │       ├── feature_schema.dart  # Schema definition
    │       └── feature.dart         # Feature exports
    └── presentation/
        ├── app/      # App-wide resources
        ├── modules/  # Feature UI
        ├── router/   # Navigation
        ├── startup/  # Initialization
        └── widgets/  # Reusable components
```

## Key Architecture Components

### 1. Schema Definition
Each schema should be defined in its own file to maintain separation of concerns and improve maintainability. Here's an example of proper schema organization:


```dart
import 'package:kimapp/kimapp_schema.dart';

@Schema(
  tableName: 'features', // Table name
  className: 'Feature', // The class it will generate
  baseModelName: 'FeatureModel',
)
class FeatureSchema extends KimappSchema {
  // Define fields with types and database columns
  final id = Field.id<int>('id').generateAs('FeatureId'); // This should only use one to generate the ID. If later on we want to use this id for another table, just use Field<FeatureId>('id') like other fields
  final name = Field<String>('name');
  final description = Field<String?>('description'); // Nullable
  final isActive = Field<bool>('is_active');
  final relatedFeature = Field.join<RelatedFeatureModel>()
    .withForeignKey('related_id'); // If it is a foreign key

  @override
  List<Model> get models => [
    // Optionally create another model. Besure to create it only when needed to avoid overhead
    // Can create lightweight models for lists
    Model('FeatureLiteModel')
      ..addFields({'id': id, 'name': name})
      ..table(), // enable table feature for supabase
    Model('FeatureDetailModel')
      ..inheritAllFromBase(excepts: [relatedFeature]) // all fields from base except related
      ..addFields({'extra': Field<String>('extra')}) // add extra
      ..table(), 

    // Define different model variations, easy clone from base model using addFields
    Model('FeatureCreateParam')
      ..addFields({
        'name': name,
        'isActive': isActive,
      }),
    Model('FeatureUpdateParam')
      ..addFields({
        'name': name,
        'relatedId': relatedFeature,
      }),
  ];
}
```

The schema system provides:
- Automatic model generation with freezed
- Type-safe ID classes
- Supabase table definitions
- Relationship handling
- Multiple model variations (create, update, lite)
- Generated model class will located in `src/features/feature_name/feature_schema.schema.dart`
- It best practice to create new file for each new schema
- Must run build_runner to generate code

### 2. Repository Pattern
```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../feature_name/feature_name_schema.schama.dart'; // Generated model class located here
import '../../../exports.dart'; // Most required imports are inside it

export 'i_feature_repo.dart';

@Riverpod(keepAlive: true)
IFeatureRepo featureRepo(Ref ref) => _Impl(ref);

abstract class IFeatureRepo {
  Future<Either<Failure, FeatureModel>> create(FeatureCreateParam data);
  Future<Either<Failure, FeatureModel>> findOne(FeatureId id);
  Future<Either<Failure, List<FeatureLiteModel>>> findAll(FeatureListParam param);
}

// Implementation with Supabase
class _Impl implements IFeatureRepo {
  @override
  Future<Either<Failure, FeatureModel>> create(FeatureCreateParam data) async {
    return await errorHandler(() async {
      return await _ref
        .read(supabaseProvider)
        .client
        .from(FeatureModel.table.tableName)
        .insert(data.toJson())
        .select(FeatureModel.table.selectStatement)
        .single()
        .withConverter((data) => right(FeatureModel.fromJson(data)));
    });
  }
}
```

### 3. Provider Types

#### Simple Action Provider
For single actions like delete, toggle:
```dart
@riverpod
class FeatureDelete extends _$FeatureDelete {
  @override
  ProviderStatus<Unit> build(FeatureId id) => const ProviderStatus.initial();

  Future<ProviderStatus<Unit>> call() async {
    return await perform((state) async {
      final result = await ref.read(featureRepoProvider).delete(id);
      return result.getOrThrow();
    });
  }
}
```

#### Form Providers
For handling form state and actions:

```dart
@freezed
class FeatureCreateState with _$FeatureCreateState,
    ProviderStatusClassMixin<FeatureCreateState, FeatureModel> {
  const factory FeatureCreateState({
    required String name,
    @Default(ProviderStatus.initial()) ProviderStatus<FeatureModel> status,
  }) = _FeatureCreateState;

  FeatureCreateParam toParam() {
    if (name.isBlank) throw 'Name is required';
    return FeatureCreateParam(name: name);
  }
}

@kimappForm
@riverpod
class FeatureCreate extends _$FeatureCreate with _$FeatureCreateForm {
  Future<ProviderStatus<FeatureModel>> call() async {
    return await perform((state) async {
      final result = await ref.read(featureRepoProvider).create(state.toParam());
      return result.getOrThrow();
    });
  }
}
```

### 4. Application Initialization

Two approaches available:

#### Startup Tasks
For system initialization before app starts:
```dart
class InitMySystemTask extends StartUpTask {
  const InitMySystemTask();
  
  @override
  Future<void> initialize(LaunchContext context) async {
    await context.container.read(mySystemProvider.future);
  }
}

// Add to startup.dart
const tasks = [
  InitCacheManagerTask(),
  InitMySystemTask(),  // Your new task
];
```

#### AppState Provider
For user-facing initialization:
- Add to AppState's _initialize method
- Gets loading UI and error handling
- Can be retriggered when needed

### 5. UI Implementation
Using generated form widgets:
```dart
FeatureCreateFormWidget(
  child: (ref, formKey, status, isProgressing, failure, submit) {
    return Column(
      children: [
        FeatureCreateFormNameWidget(
          builder: (ref, controller, name, changeName, showValidation) {
            return TextFormField(
              controller: controller,
              decoration: InputDecoration(
                labelText: 'Name',
                errorText: showValidation && name.isBlank ? 'Required' : null,
              ),
            );
          },
        ),
        AsyncValueWidget(
          value: status,
          onData: (_) => ElevatedButton(
            onPressed: submit,
            child: Text('Create'),
          ),
        ),
      ],
    );
  },
)
```

## Best Practices

1. Schema Design
- Define clear field types and relationships
- Use appropriate model variations
- Consider query optimization in schema design

2. Error Handling
- Use Either<Failure, Success> pattern
- Failure is a prebuild class from kimapp package
- Handle errors at the provider level
- Provide user-friendly error messages

3. State Management
- Keep providers focused and single-purpose
- Use appropriate provider types
- Follow the ProviderStatus pattern

4. Code Organization
- Group related files in feature directories
- Use consistent naming conventions
- Leverage code generation

5. Form Implementation
- Use @kimappForm for consistent handling
- Validate in toParam methods
- Use generated widgets for UI