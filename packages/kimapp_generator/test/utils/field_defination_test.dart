import 'package:kimapp_generator/src/utils/field_defination.dart';
import 'package:test/test.dart';

void main() {
  group('FieldDefination', () {
    test('constructor creates instance with correct values', () {
      final field = FieldDefination(
        name: 'username',
        type: 'String',
        defaultValue: null,
        isOptional: false,
        comment: ['User display name'],
      );

      expect(field.name, equals('username'));
      expect(field.type, equals('String'));
      expect(field.defaultValue, isNull);
      expect(field.isOptional, isFalse);
      expect(field.comment, equals(['User display name']));
    });

    test('constructor uses empty list as default for comment', () {
      final field = FieldDefination(
        name: 'username',
        type: 'String',
        defaultValue: null,
        isOptional: false,
      );

      expect(field.comment, isEmpty);
    });

    group('isNullable getter', () {
      test('returns true for nullable types', () {
        final field = FieldDefination(
          name: 'age',
          type: 'int?',
          defaultValue: null,
          isOptional: true,
        );

        expect(field.isNullable, isTrue);
      });

      test('returns false for non-nullable types', () {
        final field = FieldDefination(
          name: 'name',
          type: 'String',
          defaultValue: null,
          isOptional: false,
        );

        expect(field.isNullable, isFalse);
      });

      test('handles complex generic types correctly', () {
        final field = FieldDefination(
          name: 'items',
          type: 'List<String?>?',
          defaultValue: null,
          isOptional: true,
        );

        expect(field.isNullable, isTrue);
      });
    });

    group('typeWithNoNullable getter', () {
      test('removes question mark from nullable types', () {
        final field = FieldDefination(
          name: 'age',
          type: 'int?',
          defaultValue: null,
          isOptional: true,
        );

        expect(field.typeWithNoNullable, equals('int'));
      });

      test('leaves non-nullable types unchanged', () {
        final field = FieldDefination(
          name: 'name',
          type: 'String',
          defaultValue: null,
          isOptional: false,
        );

        expect(field.typeWithNoNullable, equals('String'));
      });

      test('handles complex generic types correctly', () {
        final field = FieldDefination(
          name: 'items',
          type: 'List<String?>?',
          defaultValue: null,
          isOptional: true,
        );

        expect(field.typeWithNoNullable, equals('List<String?>'));
      });
    });

    group('toClassField()', () {
      test('generates correct field declaration for non-nullable type', () {
        final field = FieldDefination(
          name: 'count',
          type: 'int',
          defaultValue: null,
          isOptional: false,
        );

        expect(field.toClassField(), equals('final int count;'));
      });

      test('generates correct field declaration with single line comment', () {
        final field = FieldDefination(
          name: 'count',
          type: 'int',
          defaultValue: null,
          isOptional: false,
          comment: ['Number of items'],
        );

        expect(field.toClassField(),
            equals('/// Number of items\nfinal int count;'));
      });

      test('generates correct field declaration with multi-line comments', () {
        final field = FieldDefination(
          name: 'count',
          type: 'int',
          defaultValue: null,
          isOptional: false,
          comment: [
            'Number of items',
            'Must be positive',
            'Defaults to zero if not specified',
          ],
        );

        expect(
          field.toClassField(),
          equals(
              '/// Number of items\n/// Must be positive\n/// Defaults to zero if not specified\nfinal int count;'),
        );
      });

      test('handles complex generic types with comments correctly', () {
        final field = FieldDefination(
          name: 'items',
          type: 'List<Map<String, dynamic>>',
          defaultValue: null,
          isOptional: false,
          comment: [
            'List of dynamic items',
            'Each item is a map of string to dynamic'
          ],
        );

        expect(
          field.toClassField(),
          equals(
              '/// List of dynamic items\n/// Each item is a map of string to dynamic\nfinal List<Map<String, dynamic>> items;'),
        );
      });
    });

    group('toNamedConstructorField()', () {
      test('generates field with default value', () {
        final field = FieldDefination(
          name: 'isActive',
          type: 'bool',
          defaultValue: 'true',
          isOptional: false,
        );

        expect(
          field.toNamedConstructorField(),
          equals('this.isActive = true,'),
        );
      });

      test('generates optional field when nullable', () {
        final field = FieldDefination(
          name: 'email',
          type: 'String?',
          defaultValue: null,
          isOptional: true,
        );

        expect(
          field.toNamedConstructorField(),
          equals('this.email,'),
        );
      });

      test('generates required field for non-nullable type', () {
        final field = FieldDefination(
          name: 'price',
          type: 'double',
          defaultValue: null,
          isOptional: false,
        );

        expect(
          field.toNamedConstructorField(),
          equals('required this.price,'),
        );
      });

      test('respects commaSeperator parameter', () {
        final field = FieldDefination(
          name: 'id',
          type: 'int',
          defaultValue: null,
          isOptional: false,
        );

        expect(
          field.toNamedConstructorField(commaSeperator: false),
          equals('required this.id'),
        );
      });

      test('handles nullable type with default value correctly', () {
        final field = FieldDefination(
          name: 'count',
          type: 'int?',
          defaultValue: '0',
          isOptional: true,
        );

        expect(
          field.toNamedConstructorField(),
          equals('this.count = 0,'),
        );
      });

      test('handles complex generic types correctly', () {
        final field = FieldDefination(
          name: 'data',
          type: 'Map<String, List<int>>?',
          defaultValue: 'const {}',
          isOptional: true,
        );

        expect(
          field.toNamedConstructorField(),
          equals('this.data = const {},'),
        );
      });
    });
  });
}
