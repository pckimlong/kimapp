// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$animalHash() => r'07d5eb9d6e9c522f36bf4b05a9ba040026979394';

/// See also [Animal].
@ProviderFor(Animal)
final animalProvider =
    AutoDisposeAsyncNotifierProvider<Animal, AnimalModel>.internal(
  Animal.new,
  name: r'animalProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$animalHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Animal = AutoDisposeAsyncNotifier<AnimalModel>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

// **************************************************************************
// RiverpodStateWidgetGenerator
// **************************************************************************

final providerDefinition = {
  "baseName": "Animal",
  "returnType": {
    "rawType": "Future<AnimalModel>",
    "baseType": "AnimalModel",
    "wrapperType": "Future",
    "classInfo": null
  },
  "providerName": "animalProvider",
  "providerType": "ProviderType.classBased",
  "familyParameters": [],
  "methods": [
    {
      "name": "build",
      "returnType": "Future<AnimalModel>",
      "parameters": [],
      "isStatic": false,
      "annotations": ["@override"],
      "documentation": null
    }
  ],
  "modifiers": [],
  "documentation": null,
  "dependencies": [],
  "genericParameters": {}
};
/*A widget that provides a scoped access point for AnimalProvider state management.

 This widget must be placed above any widgets that need to access the state. It provides
 multiple ways to handle state rendering through various callback options.

 Key Features:
 * Centralized state management and dependency injection
 * Multiple rendering options through different callbacks
 * Automatic error and loading state handling for async providers
 * Theme-aware default loading and error states

 Available Callbacks:
 * [builder] - Full control over rendering with access to context, ref, AsyncValue<T>, and child.
   When provided, other callbacks ([loading], [error], [data]) are ignored and you must
   manually handle the async states using asyncValue.when()
 * [child] - Simple widget to display when no complex building logic is needed


 Simple Usage:
 ```dart
 AnimalProviderProviderScope(
   familyKey: stringValue,
   child: const YourWidget(),
 )
 ```

 Advanced Usage with Builder:
 ```dart
 AnimalProviderProviderScope(
   familyKey: stringValue,
   builder: (context, ref, asyncValue, child) {
     // Manual handling of async states
     return asyncValue.when(
       data: (data) => Text(data),
       loading: () => const CircularProgressIndicator(),
       error: (error, stack) => Text('Something went wrong'),
     );
   },
 )
 ```

 Advanced Usage with State Handlers:
 ```dart
 AnimalProviderProviderScope(
   familyKey: stringValue,
   loading: () => const CustomLoadingIndicator(),
   error: (error, stack) => CustomErrorWidget(error: error),
   data: (data) => DataDisplay(data: data),
 )
 ```

 See also:
 * [AnimalProviderParamsWidget] - For family parameter access
 * [AnimalProviderStateWidget] - For direct state access
 * [AnimalProviderSelectWidget] - For optimized state selection
*/
