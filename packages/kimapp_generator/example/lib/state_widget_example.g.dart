// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_widget_example.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExampleModelImpl _$$ExampleModelImplFromJson(Map<String, dynamic> json) =>
    _$ExampleModelImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$$ExampleModelImplToJson(_$ExampleModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

// **************************************************************************
// TableModelGenerator
// **************************************************************************

const _tableExampleModel = TableBuilder(
  tableName: "xxx",
  columns: [
    ColumnBuilder('id'),
    ColumnBuilder('name'),
  ],
);

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$normalValueGenerateHash() =>
    r'245286696c6d3b19f584633dafc1ddc748ed10b2';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [normalValueGenerate].
@ProviderFor(normalValueGenerate)
const normalValueGenerateProvider = NormalValueGenerateFamily();

/// See also [normalValueGenerate].
class NormalValueGenerateFamily extends Family<String> {
  /// See also [normalValueGenerate].
  const NormalValueGenerateFamily();

  /// See also [normalValueGenerate].
  NormalValueGenerateProvider call(
    String a,
  ) {
    return NormalValueGenerateProvider(
      a,
    );
  }

  @override
  NormalValueGenerateProvider getProviderOverride(
    covariant NormalValueGenerateProvider provider,
  ) {
    return call(
      provider.a,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'normalValueGenerateProvider';
}

/// See also [normalValueGenerate].
class NormalValueGenerateProvider extends AutoDisposeProvider<String> {
  /// See also [normalValueGenerate].
  NormalValueGenerateProvider(
    String a,
  ) : this._internal(
          (ref) => normalValueGenerate(
            ref as NormalValueGenerateRef,
            a,
          ),
          from: normalValueGenerateProvider,
          name: r'normalValueGenerateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$normalValueGenerateHash,
          dependencies: NormalValueGenerateFamily._dependencies,
          allTransitiveDependencies:
              NormalValueGenerateFamily._allTransitiveDependencies,
          a: a,
        );

  NormalValueGenerateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.a,
  }) : super.internal();

  final String a;

  @override
  Override overrideWith(
    String Function(NormalValueGenerateRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: NormalValueGenerateProvider._internal(
        (ref) => create(ref as NormalValueGenerateRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        a: a,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<String> createElement() {
    return _NormalValueGenerateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is NormalValueGenerateProvider && other.a == a;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, a.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin NormalValueGenerateRef on AutoDisposeProviderRef<String> {
  /// The parameter `a` of this provider.
  String get a;
}

class _NormalValueGenerateProviderElement
    extends AutoDisposeProviderElement<String> with NormalValueGenerateRef {
  _NormalValueGenerateProviderElement(super.provider);

  @override
  String get a => (origin as NormalValueGenerateProvider).a;
}

String _$normalGenerateHash() => r'74fcbde295f47f4f84c16e78a64bbfa5520a75af';

/// See also [normalGenerate].
@ProviderFor(normalGenerate)
final normalGenerateProvider = AutoDisposeProvider<ExampleModel>.internal(
  normalGenerate,
  name: r'normalGenerateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$normalGenerateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef NormalGenerateRef = AutoDisposeProviderRef<ExampleModel>;
String _$normalGenerateListHash() =>
    r'8c72a46f50b9f24399cb04a1bf6223ee6f6c9892';

/// See also [normalGenerateList].
@ProviderFor(normalGenerateList)
final normalGenerateListProvider =
    AutoDisposeProvider<List<ExampleModel>>.internal(
  normalGenerateList,
  name: r'normalGenerateListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$normalGenerateListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef NormalGenerateListRef = AutoDisposeProviderRef<List<ExampleModel>>;
String _$asyncGenerateHash() => r'1edc5ecce3a8b435844909cde77991f78a83eb5f';

/// See also [asyncGenerate].
@ProviderFor(asyncGenerate)
const asyncGenerateProvider = AsyncGenerateFamily();

/// See also [asyncGenerate].
class AsyncGenerateFamily extends Family<AsyncValue<ExampleModel>> {
  /// See also [asyncGenerate].
  const AsyncGenerateFamily();

  /// See also [asyncGenerate].
  AsyncGenerateProvider call(
    int hello,
  ) {
    return AsyncGenerateProvider(
      hello,
    );
  }

  @override
  AsyncGenerateProvider getProviderOverride(
    covariant AsyncGenerateProvider provider,
  ) {
    return call(
      provider.hello,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'asyncGenerateProvider';
}

/// See also [asyncGenerate].
class AsyncGenerateProvider extends AutoDisposeFutureProvider<ExampleModel> {
  /// See also [asyncGenerate].
  AsyncGenerateProvider(
    int hello,
  ) : this._internal(
          (ref) => asyncGenerate(
            ref as AsyncGenerateRef,
            hello,
          ),
          from: asyncGenerateProvider,
          name: r'asyncGenerateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$asyncGenerateHash,
          dependencies: AsyncGenerateFamily._dependencies,
          allTransitiveDependencies:
              AsyncGenerateFamily._allTransitiveDependencies,
          hello: hello,
        );

  AsyncGenerateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.hello,
  }) : super.internal();

  final int hello;

  @override
  Override overrideWith(
    FutureOr<ExampleModel> Function(AsyncGenerateRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AsyncGenerateProvider._internal(
        (ref) => create(ref as AsyncGenerateRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        hello: hello,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<ExampleModel> createElement() {
    return _AsyncGenerateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AsyncGenerateProvider && other.hello == hello;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, hello.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AsyncGenerateRef on AutoDisposeFutureProviderRef<ExampleModel> {
  /// The parameter `hello` of this provider.
  int get hello;
}

class _AsyncGenerateProviderElement
    extends AutoDisposeFutureProviderElement<ExampleModel>
    with AsyncGenerateRef {
  _AsyncGenerateProviderElement(super.provider);

  @override
  int get hello => (origin as AsyncGenerateProvider).hello;
}

String _$asyncListGenerateHash() => r'ef3bdcd26e4fe4d36b2937ef9ba5a637ca51a1d3';

/// See also [asyncListGenerate].
@ProviderFor(asyncListGenerate)
final asyncListGenerateProvider =
    AutoDisposeFutureProvider<List<ExampleModel>>.internal(
  asyncListGenerate,
  name: r'asyncListGenerateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$asyncListGenerateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AsyncListGenerateRef = AutoDisposeFutureProviderRef<List<ExampleModel>>;
String _$asyncIListGenerateHash() =>
    r'f40f0be92ebd721afbdedb9c01ebf46dd5b65c0a';

/// See also [asyncIListGenerate].
@ProviderFor(asyncIListGenerate)
final asyncIListGenerateProvider =
    AutoDisposeFutureProvider<IList<ExampleModel>>.internal(
  asyncIListGenerate,
  name: r'asyncIListGenerateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$asyncIListGenerateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AsyncIListGenerateRef
    = AutoDisposeFutureProviderRef<IList<ExampleModel>>;
String _$classGenerateHash() => r'b8acece3ddd0f61254070574a32778b52007c1c5';

abstract class _$ClassGenerate
    extends BuildlessAutoDisposeAsyncNotifier<List<ExampleModel>> {
  late final int param;

  FutureOr<List<ExampleModel>> build(
    int param,
  );
}

/// See also [ClassGenerate].
@ProviderFor(ClassGenerate)
const classGenerateProvider = ClassGenerateFamily();

/// See also [ClassGenerate].
class ClassGenerateFamily extends Family<AsyncValue<List<ExampleModel>>> {
  /// See also [ClassGenerate].
  const ClassGenerateFamily();

  /// See also [ClassGenerate].
  ClassGenerateProvider call(
    int param,
  ) {
    return ClassGenerateProvider(
      param,
    );
  }

  @override
  ClassGenerateProvider getProviderOverride(
    covariant ClassGenerateProvider provider,
  ) {
    return call(
      provider.param,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'classGenerateProvider';
}

/// See also [ClassGenerate].
class ClassGenerateProvider extends AutoDisposeAsyncNotifierProviderImpl<
    ClassGenerate, List<ExampleModel>> {
  /// See also [ClassGenerate].
  ClassGenerateProvider(
    int param,
  ) : this._internal(
          () => ClassGenerate()..param = param,
          from: classGenerateProvider,
          name: r'classGenerateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$classGenerateHash,
          dependencies: ClassGenerateFamily._dependencies,
          allTransitiveDependencies:
              ClassGenerateFamily._allTransitiveDependencies,
          param: param,
        );

  ClassGenerateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.param,
  }) : super.internal();

  final int param;

  @override
  FutureOr<List<ExampleModel>> runNotifierBuild(
    covariant ClassGenerate notifier,
  ) {
    return notifier.build(
      param,
    );
  }

  @override
  Override overrideWith(ClassGenerate Function() create) {
    return ProviderOverride(
      origin: this,
      override: ClassGenerateProvider._internal(
        () => create()..param = param,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        param: param,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ClassGenerate, List<ExampleModel>>
      createElement() {
    return _ClassGenerateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ClassGenerateProvider && other.param == param;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, param.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ClassGenerateRef
    on AutoDisposeAsyncNotifierProviderRef<List<ExampleModel>> {
  /// The parameter `param` of this provider.
  int get param;
}

class _ClassGenerateProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ClassGenerate,
        List<ExampleModel>> with ClassGenerateRef {
  _ClassGenerateProviderElement(super.provider);

  @override
  int get param => (origin as ClassGenerateProvider).param;
}

String _$classGenerate2Hash() => r'2ed887a765d6f309fd2dcf9d1d99c325a87838e2';

abstract class _$ClassGenerate2
    extends BuildlessAutoDisposeAsyncNotifier<ExampleModel> {
  late final int a;

  FutureOr<ExampleModel> build(
    int a,
  );
}

/// See also [ClassGenerate2].
@ProviderFor(ClassGenerate2)
const classGenerate2Provider = ClassGenerate2Family();

/// See also [ClassGenerate2].
class ClassGenerate2Family extends Family<AsyncValue<ExampleModel>> {
  /// See also [ClassGenerate2].
  const ClassGenerate2Family();

  /// See also [ClassGenerate2].
  ClassGenerate2Provider call(
    int a,
  ) {
    return ClassGenerate2Provider(
      a,
    );
  }

  @override
  ClassGenerate2Provider getProviderOverride(
    covariant ClassGenerate2Provider provider,
  ) {
    return call(
      provider.a,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'classGenerate2Provider';
}

/// See also [ClassGenerate2].
class ClassGenerate2Provider
    extends AutoDisposeAsyncNotifierProviderImpl<ClassGenerate2, ExampleModel> {
  /// See also [ClassGenerate2].
  ClassGenerate2Provider(
    int a,
  ) : this._internal(
          () => ClassGenerate2()..a = a,
          from: classGenerate2Provider,
          name: r'classGenerate2Provider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$classGenerate2Hash,
          dependencies: ClassGenerate2Family._dependencies,
          allTransitiveDependencies:
              ClassGenerate2Family._allTransitiveDependencies,
          a: a,
        );

  ClassGenerate2Provider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.a,
  }) : super.internal();

  final int a;

  @override
  FutureOr<ExampleModel> runNotifierBuild(
    covariant ClassGenerate2 notifier,
  ) {
    return notifier.build(
      a,
    );
  }

  @override
  Override overrideWith(ClassGenerate2 Function() create) {
    return ProviderOverride(
      origin: this,
      override: ClassGenerate2Provider._internal(
        () => create()..a = a,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        a: a,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ClassGenerate2, ExampleModel>
      createElement() {
    return _ClassGenerate2ProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ClassGenerate2Provider && other.a == a;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, a.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ClassGenerate2Ref on AutoDisposeAsyncNotifierProviderRef<ExampleModel> {
  /// The parameter `a` of this provider.
  int get a;
}

class _ClassGenerate2ProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ClassGenerate2,
        ExampleModel> with ClassGenerate2Ref {
  _ClassGenerate2ProviderElement(super.provider);

  @override
  int get a => (origin as ClassGenerate2Provider).a;
}

String _$classGenerate3Hash() => r'1056a2079522928b47a2aa1c1dbaba75fa08f01d';

abstract class _$ClassGenerate3
    extends BuildlessAutoDisposeAsyncNotifier<ExampleModel> {
  late final int a;
  late final String b;

  FutureOr<ExampleModel> build(
    int a, {
    String b = "Hello",
  });
}

/// See also [ClassGenerate3].
@ProviderFor(ClassGenerate3)
const classGenerate3Provider = ClassGenerate3Family();

/// See also [ClassGenerate3].
class ClassGenerate3Family extends Family<AsyncValue<ExampleModel>> {
  /// See also [ClassGenerate3].
  const ClassGenerate3Family();

  /// See also [ClassGenerate3].
  ClassGenerate3Provider call(
    int a, {
    String b = "Hello",
  }) {
    return ClassGenerate3Provider(
      a,
      b: b,
    );
  }

  @override
  ClassGenerate3Provider getProviderOverride(
    covariant ClassGenerate3Provider provider,
  ) {
    return call(
      provider.a,
      b: provider.b,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'classGenerate3Provider';
}

/// See also [ClassGenerate3].
class ClassGenerate3Provider
    extends AutoDisposeAsyncNotifierProviderImpl<ClassGenerate3, ExampleModel> {
  /// See also [ClassGenerate3].
  ClassGenerate3Provider(
    int a, {
    String b = "Hello",
  }) : this._internal(
          () => ClassGenerate3()
            ..a = a
            ..b = b,
          from: classGenerate3Provider,
          name: r'classGenerate3Provider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$classGenerate3Hash,
          dependencies: ClassGenerate3Family._dependencies,
          allTransitiveDependencies:
              ClassGenerate3Family._allTransitiveDependencies,
          a: a,
          b: b,
        );

  ClassGenerate3Provider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.a,
    required this.b,
  }) : super.internal();

  final int a;
  final String b;

  @override
  FutureOr<ExampleModel> runNotifierBuild(
    covariant ClassGenerate3 notifier,
  ) {
    return notifier.build(
      a,
      b: b,
    );
  }

  @override
  Override overrideWith(ClassGenerate3 Function() create) {
    return ProviderOverride(
      origin: this,
      override: ClassGenerate3Provider._internal(
        () => create()
          ..a = a
          ..b = b,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        a: a,
        b: b,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ClassGenerate3, ExampleModel>
      createElement() {
    return _ClassGenerate3ProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ClassGenerate3Provider && other.a == a && other.b == b;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, a.hashCode);
    hash = _SystemHash.combine(hash, b.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ClassGenerate3Ref on AutoDisposeAsyncNotifierProviderRef<ExampleModel> {
  /// The parameter `a` of this provider.
  int get a;

  /// The parameter `b` of this provider.
  String get b;
}

class _ClassGenerate3ProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ClassGenerate3,
        ExampleModel> with ClassGenerate3Ref {
  _ClassGenerate3ProviderElement(super.provider);

  @override
  int get a => (origin as ClassGenerate3Provider).a;
  @override
  String get b => (origin as ClassGenerate3Provider).b;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
