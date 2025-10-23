// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_widget_v2.dart';

// **************************************************************************
// KimappFormGenerator
// **************************************************************************

/// Mixin use for update properties. You will need to add this mixin to provider in order to make it work
mixin _$ProductCreateForm on _$ProductCreate {
  void onNameChanged(String newName) => state = state.copyWith(name: newName);
}

bool _debugCheckHasProductCreateFormWidget(BuildContext context) {
  assert(() {
    if ((context.widget is! ProductCreateFormWidget &&
            context.findAncestorWidgetOfExactType<ProductCreateFormWidget>() ==
                null) &&
        (context.widget is! ProductCreateFormBuilderWidget &&
            context.findAncestorWidgetOfExactType<
                    ProductCreateFormBuilderWidget>() ==
                null)) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary(
            'No ProductCreateFormWidget or ProductCreateFormBuilderWidget found'),
        ErrorDescription(
          '${context.widget.runtimeType} widgets require a ProductCreateFormWidget or ProductCreateFormBuilderWidget widget ancestor.',
        ),
      ]);
    }
    return true;
  }());
  return true;
}

typedef ProductCreateFormChildBuilder = Widget Function(
  WidgetRef ref,
  GlobalKey<FormState> formKey,
  ProviderStatus<void> status,
  bool isProgressing,
  Failure? failure,
  Future<void> Function() submit,
);

class ProductCreateFormWidget extends HookConsumerWidget {
  /// Base form widget for [ProductCreate] provider
  ///
  /// It required to add this as parent widget of fields widget if [ProductCreate] is a family provider
  /// , otherwise it's optional
  const ProductCreateFormWidget({
    super.key,
    this.formKey,
    this.autovalidateMode,
    this.onPopInvokedWithResult,
    this.onChanged,
    required this.builder,
  });

  /// Form key. If null it will be created by widget
  final GlobalKey<FormState>? formKey;
  final AutovalidateMode? autovalidateMode;
  final void Function(bool, Object?)? onPopInvokedWithResult;
  final void Function()? onChanged;

  /// Child widget builder
  ///
  /// * Don't forget to do form validation before execute this. If it is a form widget type
  /// This callback will also save form state and check validation of form if it a form type
  /// ```
  /// {
  ///   // Do form validation
  ///   formKey.currentState!.save();
  ///   if (!formKey.currentState!.validate()) return;
  ///
  ///   // call submit here
  ///   ... submit(...);
  /// }
  /// ```
  final ProductCreateFormChildBuilder builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cachedFormKey =
        useMemoized(() => formKey ?? GlobalKey<FormState>(), [formKey]);

    final status =
        ref.watch(productCreateProvider.select((value) => value.status));
    final isProgressing = status.isInProgress;
    final failure = status.failure;
    final controller = ref.watch(productCreateProvider.notifier);

    return Form(
      key: cachedFormKey,
      onChanged: onChanged,
      autovalidateMode: autovalidateMode,
      onPopInvokedWithResult: onPopInvokedWithResult,
      child: builder(
        ref,
        cachedFormKey,
        status,
        isProgressing,
        failure,
        controller.call,
      ),
    );
  }
}

/// Form builder widget for [ProductCreate] provider
class ProductCreateFormBuilderWidget extends ConsumerWidget {
  const ProductCreateFormBuilderWidget({
    super.key,
    required this.builder,
    this.child,
  });

  final Widget Function(
    BuildContext context,
    WidgetRef ref,
    ProviderStatus<void> status,
    ProductCreate notifier,
    Widget? child,
  ) builder;
  final Widget? child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(
      child: child,
      builder: (context, ref, child) {
        final notifier = ref.watch(productCreateProvider.notifier);
        final status =
            ref.watch(productCreateProvider.select((value) => value.status));
        return builder(
          context,
          ref,
          status,
          notifier,
          child,
        );
      },
    );
  }
}

/// Widget for manage for [ProductCreate] provider status
class ProductCreateStatusWidget extends ConsumerWidget {
  const ProductCreateStatusWidget({
    super.key,
    required this.builder,
    this.child,
  });

  final Widget Function(
    BuildContext context,
    WidgetRef ref,
    ProviderStatus<void> status,
    ProductCreate notifier,
    Widget? child,
  ) builder;
  final Widget? child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    assert(_debugCheckHasProductCreateFormWidget(context));

    final notifier = ref.watch(productCreateProvider.notifier);
    final status =
        ref.watch(productCreateProvider.select((value) => value.status));

    return builder(context, ref, status, notifier, child);
  }
}

/// Widget for manage for [ProductCreate] provider state
class ProductCreateStateWidget extends ConsumerWidget {
  const ProductCreateStateWidget({
    super.key,
    required this.builder,
    this.child,
  });

  final Widget Function(
    BuildContext context,
    WidgetRef ref,
    ProductCreateState state,
    ProductCreate notifier,
    Widget? child,
  ) builder;
  final Widget? child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    assert(_debugCheckHasProductCreateFormWidget(context));

    final notifier = ref.watch(productCreateProvider.notifier);
    final state = ref.watch(productCreateProvider);

    return builder(context, ref, state, notifier, child);
  }
}

/// Widget that manages [ProductCreate] provider state with a selector to optimize performance by reducing unnecessary rebuilds.
/// The selector allows watching only specific parts of the state that are needed.
class ProductCreateSelectWidget<Selected> extends ConsumerWidget {
  const ProductCreateSelectWidget({
    super.key,
    required this.selector,
    required this.builder,
    this.child,
  });

  final Selected Function(ProductCreateState state) selector;
  final Widget Function(
    BuildContext context,
    WidgetRef ref,
    Selected selected,
    ProductCreate notifier,
    Widget? child,
  ) builder;
  final Widget? child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    assert(_debugCheckHasProductCreateFormWidget(context));

    final notifier = ref.watch(productCreateProvider.notifier);
    final selected = ref.watch(productCreateProvider.select(selector));

    return builder(context, ref, selected, notifier, child);
  }
}

/// Widget that expose [ProductCreate] provider notifier manage the state
/// using this ensure the state is correct map even it is family provider
class ProductCreateNotifierWidget extends ConsumerWidget {
  const ProductCreateNotifierWidget({
    super.key,
    required this.builder,
  });

  final Widget Function(
    BuildContext context,
    WidgetRef ref,
    ProductCreate notifier,
  ) builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    assert(_debugCheckHasProductCreateFormWidget(context));

    final notifier = ref.watch(productCreateProvider.notifier);

    return builder(context, ref, notifier);
  }
}

typedef ProductCreateNameChildBuilder = Widget Function(
  WidgetRef ref,
  TextEditingController textController,
  String name,
  void Function(String newName) changeName,
  bool showValidation,
);

/// Widget form field for property [name]. To use this widget. You will need to add [ProductCreateFormWidget] widget as ancestor
/// otherwise assert error will be thrown
class ProductCreateNameFieldWidget extends HookConsumerWidget {
  const ProductCreateNameFieldWidget({
    super.key,
    this.controller,
    required this.builder,
  });
  final ProductCreateNameChildBuilder builder;

  /// TextEditingController of text field widget. If null it will create by widget
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    assert(_debugCheckHasProductCreateFormWidget(context));

    final notifier = ref.watch(productCreateProvider.notifier);
    final state =
        ref.watch(productCreateProvider.select((value) => value.name));
    final controller = this.controller ?? useTextEditingController(text: state);

    // Listen for provider changes
    ref.listen(productCreateProvider.select((value) => value.name), (
      previous,
      next,
    ) {
      if (previous != next && controller.text != next) {
        controller.text = next ?? '';
      }
    });

    // Setup text listener
    useEffect(() {
      void listener() {
        final currentValue = ref.read(productCreateProvider).name;
        if (currentValue != controller.text) {
          notifier.onNameChanged(controller.text);
        }
      }

      controller.addListener(listener);
      return () => controller.removeListener(listener);
    }, [controller]);

    final showValidation = ref
        .watch(productCreateProvider.select((value) => value.status.isFailure));
    return builder(
      ref,
      controller,
      state,
      notifier.onNameChanged,
      showValidation,
    );
  }
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProductCreate)
@formWidget
const productCreateProvider = ProductCreateProvider._();

@formWidget
final class ProductCreateProvider
    extends $NotifierProvider<ProductCreate, ProductParam> {
  const ProductCreateProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'productCreateProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$productCreateHash();

  @$internal
  @override
  ProductCreate create() => ProductCreate();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProductParam value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProductParam>(value),
    );
  }
}

String _$productCreateHash() => r'119ee77791e5e1d1e8d4a99914d9727d41df8b6a';

@formWidget
abstract class _$ProductCreate extends $Notifier<ProductParam> {
  ProductParam build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ProductParam, ProductParam>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<ProductParam, ProductParam>,
        ProductParam,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
