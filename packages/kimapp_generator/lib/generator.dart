library kimapp_generator;

import 'package:riverpod/riverpod.dart';

class DataService {
  const DataService({
    required this.baseName,
    this.maxParams = 3,
  });

  /// Specifies the maximum number of parameters before auto-generating a parameter class.
  ///
  /// This value determines when a method's parameters should be encapsulated into a separate class.
  /// If the number of parameters in a method exceeds this threshold, a parameter class will be
  /// automatically generated to improve code readability and maintainability.
  ///
  /// Default value is 3, meaning methods with more than 3 parameters will use a parameter class.
  ///
  /// Example:
  /// ```dart
  /// @DataService(maxParamsBeforeClass: 5)
  /// ```
  /// In this case, methods with 6 or more parameters will use a parameter class.
  final int maxParams;

  /// Base name for all generated classes and methods.
  ///
  /// This name is used as a prefix for generated classes and methods.
  /// For example, if baseName is 'Demo', it will generate 'DemoParams', 'DemoDataService',
  final String baseName;
}

abstract class KimappDataService {
  Ref get ref;

  Future<void> dispose() async {}
}

/// Annotation for generating form-related providers and widgets.
///
/// This annotation is used to mark methods in a KimappDataService
/// for which form-related providers, state classes, and widgets
/// should be automatically generated.
class FormGenerator {
  /// Creates a FormGeneratable annotation.
  ///
  /// Use this to annotate methods in a KimappDataService subclass
  /// that should have associated form functionality generated.
  const FormGenerator({
    this.keepAlive = false,
  });

  /// Whether to keep provider alive
  /// default is false
  final bool keepAlive;
}

/// Convenience constant for the FormGeneratable annotation.
const formGenerator = FormGenerator();

/// Annotation for generating executable provider classes.
///
/// This annotation is used to mark methods in a KimappDataService
/// for which a provider class should be automatically generated
/// to execute the method and manage its state.
class Executable {
  /// Creates an Executable annotation.
  ///
  /// Use this to annotate methods in a KimappDataService subclass
  /// that should have an associated provider class generated for execution.
  const Executable();
}

/// Convenience constant for the Executable annotation.
const executable = Executable();

/// Annotation for generating data fetching provider classes.
///
/// This annotation is used to mark methods in a KimappDataService
/// for which a provider class should be automatically generated
/// to fetch data from the underlying backend or other data sources.
class DataFetcher {
  /// Creates a DataFetcher annotation.
  ///
  /// Use this to annotate methods in a KimappDataService subclass
  /// that should have an associated provider class generated for data fetching.
  ///
  /// [enableCache] indicates whether the generated provider should implement caching mechanisms.
  const DataFetcher({
    this.keepAlive = false,
    this.cacheTime,
  });

  /// Whether to keep provider alive
  final bool keepAlive;
  final Duration? cacheTime;
}

/// Convenience constant for the DataFetcher annotation with default settings.
const dataFetcher = DataFetcher();

/// Annotation for generating pagination-aware data fetching provider classes.
///
/// This annotation is used to mark methods in a KimappDataService
/// for which a set of provider classes should be automatically generated
/// to handle paginated data fetching from the underlying backend or other data sources.
class PaginationFetcher {
  /// Creates a PaginationFetcher annotation.
  ///
  /// Use this to annotate methods in a KimappDataService subclass
  /// that should have associated provider classes generated for paginated data fetching.
  ///
  /// [pageLimit] specifies the number of items per page.
  /// [cacheTime] specifies how long the fetched data should be cached.
  const PaginationFetcher({
    required this.pageLimit,
    this.cacheTime = const Duration(minutes: 5),
  });

  /// The number of items to fetch per page.
  final int pageLimit;

  /// The duration for which fetched data should be cached.
  final Duration cacheTime;
}
