# Field Types Reference

Fields are the building blocks of KimappSchema. This guide covers all available field types, their configurations, and usage patterns.

## Basic Field Syntax

All fields follow this pattern:
```dart
final fieldName = Field<DataType>('database_column_name');
```

## Field Types Overview

| Type | Purpose | Example |
|------|---------|---------|
| **Normal** | Standard data fields | `Field<String>('name')` |
| **ID** | Primary keys with type safety | `Field.id<int>('id')` |
| **Join** | Database relationships | `Field.join<UserModel>()` |
| **Ignore** | Table-only fields | `Field.ignore('internal_field')` |

---

## 1. Normal Fields

Standard fields for storing data values.

### Basic Types

```dart
class UserSchema extends KimappSchema {
  // String fields
  final name = Field<String>('name');           // Required
  final email = Field<String?>('email');       // Optional
  
  // Numeric fields  
  final age = Field<int>('age');               // Required integer
  final score = Field<double?>('score');       // Optional decimal
  final rating = Field<num>('rating');         // Generic number
  
  // Boolean fields
  final isActive = Field<bool>('is_active');   // Required
  final isVerified = Field<bool?>('verified'); // Optional
  
  // DateTime fields
  final createdAt = Field<DateTime>('created_at');     // Required
  final lastLogin = Field<DateTime?>('last_login');    // Optional
}
```

### Collection Fields

**Preferred:** Use `IList` for immutable collections:

```dart
final tags = Field<IList<String>>('tags');
final scores = Field<IList<int>>('scores');
final metadata = Field<IList<Map<String, dynamic>>>('metadata');
```

**Also Works:** Regular `List` (but not preferred):

```dart
final items = Field<List<String>>('items');
```

### Custom Types

You can use any Dart type that's JSON serializable:

```dart
// Enums
final status = Field<UserStatus>('status');

// Custom classes (must implement toJson/fromJson)
final address = Field<Address>('address');

// Maps
final settings = Field<Map<String, dynamic>>('settings');
```

### Nullable vs Non-Nullable

```dart
// Required fields (not nullable)
final name = Field<String>('name');        // Must have value
final age = Field<int>('age');             // Must have value

// Optional fields (nullable)  
final nickname = Field<String?>('nickname'); // Can be null
final score = Field<int?>('score');          // Can be null
```

---

## 2. ID Fields

ID fields create type-safe identifier classes and are used for primary keys.

### Basic ID Field

```dart
final id = Field.id<int>('id');
```

**Generates:**
- `UserIdId` class (wrapper for type safety)
- JSON serialization methods
- Validation and factory methods

### Custom ID Class Names

```dart
final id = Field.id<int>('id').generateAs('UserId');
```

**Generates:** `UserId` class instead of `UserSchemaId`

### Supported ID Types

```dart
// Integer IDs (most common)
final id = Field.id<int>('id');

// String IDs (UUIDs, etc.)
final uuid = Field.id<String>('uuid');

// Custom ID types
final customId = Field.id<CustomIdType>('custom_id');
```

### Generated ID Class Features

For `Field.id<int>('id').generateAs('UserId')`:

```dart
// Generated UserId class
class UserId extends Identity<int> {
  const UserId._(this.value);
  
  @override
  final int value;
  
  // Factory constructors
  factory UserId.fromJson(dynamic value) { ... }
  factory UserId.fromValue(int value) { ... }
  factory UserId.empty() { ... }  // For int/String types only
}
```

### Important ID Field Rules

1. **One per schema:** Each schema should have exactly one ID field
2. **No duplicates in models:** Models can't have multiple ID fields
3. **Cross-schema references:** Reference IDs from other schemas as normal fields:

```dart
// In PostSchema - referencing UserSchema's ID
final authorId = Field<UserId>('author_id');  // Not Field.id!
```

---

## 3. Join Fields

Join fields define relationships between models, optimized for Supabase joins.

### Basic Join Field

```dart
final user = Field.join<UserModel?>()
  .withForeignKey('user_id')        // Column in current table
  .withCandidateKey('id');          // Column in target table
```

### Join Field Configuration

```dart
// One-to-one relationship (nullable)
final profile = Field.join<ProfileModel?>()
  .withForeignKey('profile_id')     // Current table foreign key
  .withCandidateKey('id');          // Profile table primary key

// One-to-many relationship  
final posts = Field.join<IList<PostModel>>()
  .withForeignKey('author_id')      // Post table foreign key
  .withCandidateKey('id');          // User table primary key
```

### Join Field Patterns

**One-to-One (Optional):**
```dart
final profile = Field.join<ProfileModel?>()
  .withForeignKey('profile_id')
  .withCandidateKey('id');
```

**One-to-One (Required):**
```dart
final profile = Field.join<ProfileModel>()  // No ? = required
  .withForeignKey('profile_id')
  .withCandidateKey('id');
```

**One-to-Many:**
```dart
final posts = Field.join<IList<PostModel>>()
  .withForeignKey('author_id')      // Foreign key points to this model
  .withCandidateKey('id');          // This model's primary key
```

**Many-to-Many (via junction table):**
```dart
final tags = Field.join<IList<TagModel>>()
  .withForeignKey('post_id')        // Junction table column
  .withCandidateKey('tag_id');      // Target model key
```

### Supabase Integration

Join fields generate optimized Supabase queries:

```dart
// Generated query helper
final query = supabase
  .from(UserModel.tableName)
  .select('*, profile:profiles(*)')  // Auto-generated
  .eq('id', userId.value);
```

---

## 4. Ignore Fields

Ignore fields are included in table definitions but excluded from model classes.

### Basic Ignore Field

```dart
final internalFlag = Field.ignore('internal_processing_flag');
```

**Result:**
- ✅ Included in table constants
- ❌ Excluded from generated models
- ✅ Available for database operations

### Use Cases

```dart
class UserSchema extends KimappSchema {
  final id = Field.id<int>('id');
  final name = Field<String>('name');
  
  // Database-managed fields (not in models)
  final createdAt = Field.ignore('created_at');    // DB timestamp
  final updatedAt = Field.ignore('updated_at');    // DB timestamp
  final version = Field.ignore('version');         // Optimistic locking
  
  // Internal processing fields
  final processingStatus = Field.ignore('processing_status');
}
```

**Generated Table Class:**
```dart
class UserTable {
  static const String createdAt = 'created_at';    // Available
  static const String updatedAt = 'updated_at';    // Available
  static const String version = 'version';         // Available
}
```

**Generated Model Class:**
```dart
class UserModel {
  // Only includes non-ignored fields
  final UserId id;
  final String name;
  // No createdAt, updatedAt, version fields
}
```

---

## Field Validation & Error Handling

KimappSchema provides comprehensive validation with helpful error messages:

### Duplicate Field Names

```dart
Model('UserModel')
  ..inheritAllFromBase()
  ..addFields({'name': customName})  // ERROR: 'name' already inherited
```

**Error Message:**
```
Duplicate field name 'name' found in model 'UserModel'.
Field 'name' is already defined from: inherited from base
Cannot redefine the same field name from: addFields/copyFields

Solutions:
- Use a different field name in your addFields map (e.g., 'name2': name)
- Remove the field from inheritAllFromBase using excepts parameter
- Use a different field reference in copyFields
```

### Invalid Field References

```dart
..copyFields([id, invalidField, name])  // ERROR: 'invalidField' not found
```

**Error Message:**
```
Invalid field references in copyFields: invalidField
Available fields: id, name, email

Solutions:
- Check field name spelling and case sensitivity
- Ensure fields are defined in your schema class
- Use addFields instead if defining new fields
Example: final invalidField = Field<String>('invalid_field');
```

### Multiple ID Fields

```dart
..addFields({
  'id1': Field.id<int>('id'),
  'id2': Field.id<String>('uuid')  // ERROR: Multiple IDs
})
```

**Error Message:**
```
Multiple ID fields found in model 'UserModel': id1, id2
Each model can only have one ID field.

Solutions:
- Keep only one ID field
- Convert extra ID fields to normal fields using Field<YourType>('field_name')
- Use excepts parameter in inheritAllFromBase to exclude unwanted ID fields
```

---

## Best Practices

### 1. Naming Conventions

```dart
// Good: Clear, descriptive names
final firstName = Field<String>('first_name');
final emailAddress = Field<String?>('email_address');
final createdAt = Field<DateTime>('created_at');

// Avoid: Ambiguous or shortened names
final fn = Field<String>('fn');
final e = Field<String?>('e');
```

### 2. Nullable Fields

```dart
// Good: Explicit nullability
final email = Field<String?>('email');        // Can be null
final name = Field<String>('name');           // Required

// Consider: Business logic implications
final deletedAt = Field<DateTime?>('deleted_at');  // Soft delete pattern
```

### 3. Collection Fields

```dart
// Preferred: IList for immutability
final tags = Field<IList<String>>('tags');

// Acceptable: Regular List
final items = Field<List<String>>('items');

// Good: Typed collections
final scores = Field<IList<int>>('scores');
final metadata = Field<IList<Map<String, dynamic>>>('metadata');
```

### 4. ID Field Strategy

```dart
// Good: One ID per schema with clear naming
final id = Field.id<int>('id').generateAs('UserId');

// Good: Reference other IDs as normal fields
final authorId = Field<UserId>('author_id');   // In PostSchema
final categoryId = Field<CategoryId?>('category_id');  // Optional reference
```

### 5. Join Field Organization

```dart
// Good: Clear relationship naming
final profile = Field.join<ProfileModel?>()
  .withForeignKey('profile_id')
  .withCandidateKey('id');

final posts = Field.join<IList<PostModel>>()
  .withForeignKey('author_id')     // This user's posts
  .withCandidateKey('id');
```

---

## Common Patterns

### User Profile Pattern

```dart
@Schema(tableName: 'users', className: 'User')
class UserSchema extends KimappSchema {
  final id = Field.id<int>('id').generateAs('UserId');
  final email = Field<String>('email');
  final firstName = Field<String?>('first_name');
  final lastName = Field<String?>('last_name');
  final isActive = Field<bool>('is_active');
  final createdAt = Field<DateTime>('created_at');
  
  // Relationships
  final profile = Field.join<ProfileModel?>()
    .withForeignKey('profile_id')
    .withCandidateKey('id');
    
  final posts = Field.join<IList<PostModel>>()
    .withForeignKey('author_id')
    .withCandidateKey('id');
    
  // Database-managed fields
  final updatedAt = Field.ignore('updated_at');
}
```

### Content Management Pattern

```dart
@Schema(tableName: 'posts', className: 'Post')
class PostSchema extends KimappSchema {
  final id = Field.id<int>('id').generateAs('PostId');
  final title = Field<String>('title');
  final content = Field<String?>('content');
  final status = Field<PostStatus>('status');
  final publishedAt = Field<DateTime?>('published_at');
  
  // Foreign keys
  final authorId = Field<UserId>('author_id');
  final categoryId = Field<CategoryId?>('category_id');
  
  // Collections
  final tags = Field<IList<String>>('tags');
  final metadata = Field<Map<String, dynamic>>('metadata');
  
  // Relationships
  final author = Field.join<UserModel>()
    .withForeignKey('author_id')
    .withCandidateKey('id');
    
  final comments = Field.join<IList<CommentModel>>()
    .withForeignKey('post_id')
    .withCandidateKey('id');
}
```

---

**← [Setup](./setup.md)** | **[Model Definitions](./model-definitions.md) →**