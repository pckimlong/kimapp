# Kimapp Schema Generator - AI Reference Guide

## Core Purpose
Kimapp Schema Generator is a Dart/Flutter package that generates type-safe database models and table structures from simple schema definitions.

## Key Features
- Database table structure generation
- Dart models with Freezed integration
- Type-safe ID classes
- Table relationships via join fields
- Multiple model variations from single schema

## Essential Usage Example
```dart
@Schema(tableName: 'users', className: 'User')
class UserSchema extends KimappSchema {
  final id = Field.id<int>('id').generateAs('UserId');
  final name = Field<String>('name');
  final email = Field<String?>('email');
  
  @override
  List<Model> get models => [
    Model('UserDetailModel')
      ..addFields({
        'id': id,
        'fullName': name,
        'contactEmail': email,
      }),
  ];
}
```

## Field Types Quick Reference
1. Basic Fields:
   ```dart
   Field<String>('name')        // Required
   Field<String?>('email')      // Optional
   Field<int>('age')           // Numeric
   ```

2. ID Fields:
   ```dart
   Field.id<int>('id').generateAs('UserId')
   ```

3. Join Fields:
   ```dart
   Field.join<ProfileModel?>()
     .withForeignKey('profile_id')
     .withCandidateKey('id')
   ```

## Common Tasks

### Creating Relationships
```dart
// One-to-one
final profile = Field.join<ProfileModel?>()
  .withForeignKey('profile_id')
  .withCandidateKey('id');

// One-to-many
final posts = Field.join<List<PostModel>>()
  .withForeignKey('user_id')
  .withCandidateKey('author_id');
```

### Multiple Models
```dart
@override
List<Model> get models => [
  Model('UserDetailModel')
    ..addFields({
      'id': id,
      'fullName': name,
    }),
  Model('UserLiteModel')
    ..inheritAllFromBase()
    ..addFields({
      'displayName': name,
    }),
];
```

## Generated Output Types
- Table classes (field constants)
- ID classes (type-safe identifiers)
- Base model classes (with Freezed)
- Additional model variations

## Code Generation Commands
```bash
dart run build_runner build    # One-time build
dart run build_runner watch    # Watch mode
```

For more detailed information about specific features or advanced usage, please refer to the full documentation.