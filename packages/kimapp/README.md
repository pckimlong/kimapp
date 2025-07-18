# Kimapp Framework

A comprehensive Flutter development framework that provides schema-first database modeling, type-safe code generation, and seamless integration with Supabase and Riverpod state management.

## Overview

Kimapp is designed to accelerate Flutter development by providing a powerful set of tools for:
- **Schema-First Development**: Define your data models using intuitive Dart classes
- **Type-Safe Code Generation**: Automatically generate models, table constants, and ID classes
- **Database Integration**: Seamless Supabase integration with query builders
- **State Management**: Built-in Riverpod integration for reactive programming
- **Functional Programming**: Leverages fpdart for robust error handling and data transformations

## Architecture

Kimapp follows a layered architecture that separates concerns and promotes maintainability:

```
                                     
             Flutter App             
                                     $
          Generated Models           
     (User, Product, Category)       
                                     $
         Kimapp Framework            
  " Schema Definitions               
  " Field Types (ID, Join, Normal)   
  " Model Variations                 
  " Table Builders                   
                                     $
       State Management              
    (Riverpod Integration)           
                                     $
        Database Layer               
     (Supabase Integration)          
                                     
```

## Core Concepts

### 1. Schema Definition

Schemas are the foundation of Kimapp. They define your data structure and drive code generation:

```dart
@Schema(tableName: 'users', className: 'User')
class UserSchema extends KimappSchema {
  // ID field with type-safe wrapper generation
  final id = Field.id<String>('id').generateAs('UserId');
  
  // Regular fields
  final name = Field<String>('name');
  final email = Field<String>('email');
  final createdAt = Field<DateTime>('created_at');
  
  // Join field for relationships
  final profile = Field.join<ProfileModel>()
    .withForeignKey('profile_id')
    .withCandidateKey('id');
  
  // Ignored field (in table constants but not models)
  final internalFlag = Field.ignore('internal_flag');

  @override
  List<Model> get models => [
    // Full model with all fields
    Model('UserModel')..inheritAllFromBase(),
    
    // Lite model with limited fields
    Model('UserLiteModel')..inheritAllFromBase(excepts: [createdAt]),
    
    // Custom model with specific fields
    Model('UserCreateParam')..addFields({'name': name, 'email': email}),
    
    // Table model for Supabase views
    Model('UserDetailModel')..table('v_user_detail')..inheritAllFromBase(),
  ];
}
```

### 2. Field Types

Kimapp supports various field types for different use cases:

#### ID Fields
```dart
final id = Field.id<String>('id').generateAs('UserId');
// Generates: class UserId extends Identity<String> { ... }
```

#### Regular Fields
```dart
final name = Field<String>('name');
final age = Field<int>('age');
final tags = Field<IList<String>>('tags');
```

#### Join Fields (Foreign Key Relationships)
```dart
final category = Field.join<CategoryModel>()
  .withForeignKey('category_id')
  .withCandidateKey('id');
```

#### Ignore Fields
```dart
final hiddenField = Field.ignore('internal_column');
// Included in table constants, excluded from models
```

### 3. Model Variations

Generate multiple model classes from a single schema:

```dart
@override
List<Model> get models => [
  // Base model with all fields
  Model('ProductModel')..inheritAllFromBase(),
  
  // Lite version (performance optimized)
  Model('ProductLiteModel')..inheritAllFromBase(excepts: [description, metadata]),
  
  // Create parameter (for API calls)
  Model('CreateProductParam')..addFields({'name': name, 'price': price}),
  
  // Update parameter (partial updates)
  Model('UpdateProductParam')..addFields({'id': id, 'name': name}),
  
  // Database view model
  Model('ProductDetailModel')..table('v_product_details')..inheritAllFromBase(),
];
```

### 4. Identity Objects

Type-safe ID wrappers prevent ID mixing and provide validation:

```dart
// Generated from Field.id<String>('id').generateAs('UserId')
class UserId extends Identity<String> {
  const UserId(String value) : super(value);
  
  // Automatic validation
  @override
  String call() {
    if (value.isEmpty) throw ArgumentError('User ID cannot be empty');
    return value;
  }
}

// Usage
final userId = UserId('user_123');
final userIdValue = userId(); // Validated access
```

### 5. Table Constants

Generated table classes provide compile-time safety for database queries:

```dart
// Generated from UserSchema
class UserTable {
  static const String tableName = 'users';
  static const String id = 'id';
  static const String name = 'name';
  static const String email = 'email';
  static const String createdAt = 'created_at';
  static const String profileId = 'profile_id'; // From join field
}

// Usage in Supabase queries
final users = await supabase
  .from(UserTable.tableName)
  .select('${UserTable.id}, ${UserTable.name}')
  .eq(UserTable.email, 'user@example.com');
```

## Key Features

### Type Safety
- Compile-time validation of database field names
- Type-safe ID classes prevent ID confusion
- Null-safety throughout the framework

### Code Generation Integration
- Works with Freezed for immutable models
- JSON serialization support
- Builder pattern for complex configurations

### Database Agnostic Core
- Core framework is database-agnostic
- Supabase integration via helper packages
- Extensible for other database providers

### Functional Programming Support
- Built on fpdart for functional programming patterns
- Result types for error handling
- Immutable data structures with fast_immutable_collections

### State Management Integration
- Seamless Riverpod integration
- Reactive programming patterns
- Caching and offline persistence support

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  kimapp: ^0.0.3  # When published
  kimapp_generator: ^0.0.2  # When published
  
dev_dependencies:
  build_runner: ^2.4.7
  freezed: ^2.4.6
```

## Quick Start

1. **Define your schema:**

```dart
// user_schema.dart
import 'package:kimapp/kimapp.dart';

@Schema(tableName: 'users', className: 'User')
class UserSchema extends KimappSchema {
  final id = Field.id<String>('id').generateAs('UserId');
  final name = Field<String>('name');
  final email = Field<String>('email');

  @override
  List<Model> get models => [
    Model('UserModel')..inheritAllFromBase(),
    Model('UserLiteModel')..inheritAllFromBase(excepts: [email]),
  ];
}
```

2. **Run code generation:**

```bash
dart run build_runner build
```

3. **Use generated code:**

```dart
// Generated code provides:
// - UserModel class (with Freezed integration)
// - UserLiteModel class
// - UserId identity class
// - UserTable constants class

final user = UserModel(
  id: UserId('user_123'),
  name: 'John Doe',
  email: 'john@example.com',
);

// Type-safe database queries
final query = supabase
  .from(UserTable.tableName)
  .select('${UserTable.id}, ${UserTable.name}');
```

## Advanced Usage

### Complex Relationships

```dart
@Schema(tableName: 'orders', className: 'Order')
class OrderSchema extends KimappSchema {
  final id = Field.id<String>('id').generateAs('OrderId');
  final customerId = Field.id<String>('customer_id').generateAs('CustomerId');
  final total = Field<double>('total');
  final status = Field<String>('status');
  
  // Join relationships
  final customer = Field.join<CustomerModel>()
    .withForeignKey('customer_id')
    .withCandidateKey('id');
    
  final items = Field.join<IList<OrderItemModel>>()
    .withForeignKey('id')
    .withCandidateKey('order_id');

  @override
  List<Model> get models => [
    Model('OrderModel')..inheritAllFromBase(),
    Model('OrderWithCustomerModel')..table('v_orders_with_customer')..inheritAllFromBase(),
    Model('CreateOrderParam')..addFields({'customerId': customerId, 'total': total}),
  ];
}
```

### Custom Model Fields

```dart
@override
List<Model> get models => [
  // Add computed or transformed fields
  Model('UserDisplayModel')
    ..inheritAllFromBase()
    ..addFields({
      'displayName': Field<String>('display_name'),
      'isActive': Field<bool>('is_active'),
    }),
];
```

## Integration with Other Packages

### Supabase Integration
```dart
// Use generated table constants for type-safe queries
final users = await supabase
  .from(UserTable.tableName)
  .select('*')
  .eq(UserTable.status, 'active')
  .order(UserTable.createdAt);
```

### Riverpod Integration
```dart
final userProvider = FutureProvider.family<UserModel, UserId>((ref, id) async {
  final response = await supabase
    .from(UserTable.tableName)
    .select('*')
    .eq(UserTable.id, id.value)
    .single();
    
  return UserModel.fromJson(response);
});
```

## Best Practices

1. **Schema Organization**: Group related schemas in feature directories
2. **Model Variations**: Create specific models for different use cases (API, UI, Database)
3. **ID Types**: Always use generated ID classes for type safety
4. **Field Naming**: Use database naming conventions in schema, let code generation handle Dart conventions
5. **Relationships**: Use join fields for database relationships, regular fields for embedded data

## Error Handling

Kimapp integrates with fpdart for functional error handling:

```dart
import 'package:fpdart/fpdart.dart';

Future<Either<Failure, UserModel>> createUser(CreateUserParam param) async {
  try {
    final response = await supabase
      .from(UserTable.tableName)
      .insert(param.toJson())
      .select()
      .single();
      
    return Right(UserModel.fromJson(response));
  } catch (e) {
    return Left(DatabaseFailure(e.toString()));
  }
}
```

## Performance Considerations

- **Model Variations**: Use lite models for list views to reduce memory usage
- **Selective Queries**: Use table constants to select only needed fields
- **Identity Objects**: Lightweight validation without performance overhead
- **Immutable Collections**: Fast_immutable_collections for efficient data structures

## Debugging and Development

### Generated Code Location
Generated files are placed alongside your schema files with extensions:
- `.g.dart` - Generated models and serialization
- `.freezed.dart` - Freezed generated code
- `.table.dart` - Table constants (if using table structure generator)

### Common Issues
1. **Missing Imports**: Ensure all required packages are imported in schema files
2. **Build Conflicts**: Run `dart run build_runner clean` before rebuilding
3. **Type Errors**: Check that join field types match actual model classes

## Contributing

This framework is designed to be extensible. Common extension points:
- Custom field types
- Additional code generators
- Database provider integrations
- State management patterns

## Related Packages

- `kimapp_generator` - Code generation engine
- `kimapp_utils` - Utility functions and helpers
- `kimapp_supabase_helper` - Supabase-specific integrations
- `autoverpod` - Riverpod widget generation
- `numpad_input` - Specialized UI components

---

**Note**: This package is currently in development (v0.0.3) and not published to pub.dev. It's designed for internal use and will be made public when ready for broader adoption.