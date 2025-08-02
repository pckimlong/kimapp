# KimappSchema Documentation

> **Type-Safe Database Models & Code Generation for Flutter/Dart**

KimappSchema is a powerful code generation system that transforms simple schema definitions into type-safe database models, table structures, and Riverpod widgets. Built for Flutter applications using Supabase, it eliminates boilerplate and ensures type safety across your data layer.

## 🚀 Quick Start

```dart
@Schema(tableName: 'users', className: 'User')
class UserSchema extends KimappSchema {
  final id = Field.id<int>('id').generateAs('UserId');
  final name = Field<String>('name');
  final email = Field<String?>('email');
  
  @override
  List<Model> get models => [
    Model('UserLiteModel')
      ..table()
      ..copyFields([id, name, email]),
  ];
}
```

**Generated Result:**
- ✅ Type-safe models with Freezed integration
- ✅ Database table constants  
- ✅ ID wrapper classes
- ✅ JSON serialization
- ✅ Supabase integration helpers

## 📚 Documentation Index

### Getting Started
- **[Installation & Setup](./setup.md)** - Get up and running quickly
- **[Core Concepts](./concepts.md)** - Understanding schemas, fields, and models
- **[Your First Schema](./first-schema.md)** - Step-by-step tutorial

### Schema Definition
- **[Field Types](./field-types.md)** - All available field types and configurations
- **[Model Definitions](./model-definitions.md)** - Creating and configuring models
- **[Relationships](./relationships.md)** - Join fields and associations

### Advanced Features
- **[Inheritance & Field Selection](./inheritance.md)** - Model inheritance patterns
- **[Table Generation](./table-generation.md)** - Database integration
- **[ID Classes](./id-classes.md)** - Type-safe identifiers

### Integration
- **[Supabase Integration](./supabase.md)** - Working with Supabase database
- **[Riverpod Widgets](./riverpod.md)** - Generated state management
- **[JSON Serialization](./json.md)** - API integration patterns

### Reference
- **[API Reference](./api-reference.md)** - Complete API documentation
- **[Examples](./examples.md)** - Real-world usage examples
- **[Troubleshooting](./troubleshooting.md)** - Common issues and solutions
- **[Migration Guide](./migration.md)** - Upgrading between versions

## 🎯 Key Features

### 🔒 **Type Safety**
- Compile-time error checking
- Type-safe ID classes
- Generic field definitions
- Strong typing throughout

### 🏗️ **Code Generation** 
- Automatic model creation
- Table structure constants
- JSON serialization
- Riverpod providers

### 🔄 **Flexible Models**
- Multiple models per schema
- Field inheritance
- Custom field selection
- Empty models support

### 🗄️ **Database Integration**
- Supabase optimized
- Table name constants
- Query helpers
- Relationship support

## 🤖 AI Assistant Guide

This documentation is optimized for both human developers and AI assistants. Each section includes:

- **Clear examples** with complete code snippets
- **Common patterns** for typical use cases  
- **Error scenarios** with solutions
- **Best practices** for optimal results

When helping users with KimappSchema:
1. Always check the relevant documentation sections
2. Provide complete, working examples
3. Include error handling patterns
4. Reference the troubleshooting guide for issues

## 🔧 Development Commands

```bash
# Generate code once
dart run build_runner build --delete-conflicting-outputs

# Watch for changes
dart run build_runner watch --delete-conflicting-outputs

# Clean generated files
dart run build_runner clean
```

## 📁 Project Structure

```
lib/
├── src/
│   ├── features/
│   │   ├── user/
│   │   │   ├── user_schema.dart           # Your schema
│   │   │   ├── user_schema.schema.dart    # Generated models
│   │   │   ├── user_schema.schema.freezed.dart # Freezed
│   │   │   └── user_schema.schema.g.dart  # JSON
│   │   └── post/
│   │       ├── post_schema.dart
│   │       └── ...
```

## 🆘 Need Help?

- 📖 **Check the documentation** sections above
- 🐛 **Found a bug?** Check [Troubleshooting](./troubleshooting.md)
- 💡 **Need examples?** See [Examples](./examples.md)
- 🔧 **Integration issues?** See [Supabase Integration](./supabase.md)

---

**Next:** [Installation & Setup](./setup.md) →