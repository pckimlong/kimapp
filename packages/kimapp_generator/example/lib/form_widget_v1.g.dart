// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_widget_v1.dart';

// **************************************************************************
// KimappFormGenerator
// **************************************************************************

/// Mixin use for update properties. You will need to add this mixin to provider in order to make it work
mixin _$FormWidgetExampleForm on _$FormWidgetExample {
  void onNameChanged(String newName) => state = state.copyWith(name: newName);
}

bool _debugCheckHasFormWidgetExampleFormWidget(BuildContext context) {
  assert(() {
    if ((context.widget is! FormWidgetExampleFormWidget &&
            context.findAncestorWidgetOfExactType<
                    FormWidgetExampleFormWidget>() ==
                null) &&
        (context.widget is! FormWidgetExampleFormBuilderWidget &&
            context.findAncestorWidgetOfExactType<
                    FormWidgetExampleFormBuilderWidget>() ==
                null)) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary(
            'No FormWidgetExampleFormWidget or FormWidgetExampleFormBuilderWidget found'),
        ErrorDescription(
          '${context.widget.runtimeType} widgets require a FormWidgetExampleFormWidget or FormWidgetExampleFormBuilderWidget widget ancestor.',
        ),
      ]);
    }
    return true;
  }());
  return true;
}

typedef FormWidgetExampleFormChildBuilder = Widget Function(
  WidgetRef ref,
  GlobalKey<FormState> formKey,
  ProviderStatus<bool> status,
  bool isProgressing,
  Failure? failure,
  Future<ProviderStatus<bool>> Function() submit,
);

class FormWidgetExampleFormWidget extends HookConsumerWidget {
  /// Base form widget for [FormWidgetExample] provider
  ///
  /// It required to add this as parent widget of fields widget if [FormWidgetExample] is a family provider
  /// , otherwise it's optional
  const FormWidgetExampleFormWidget({
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
  final FormWidgetExampleFormChildBuilder builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cachedFormKey =
        useMemoized(() => formKey ?? GlobalKey<FormState>(), [formKey]);

    final status =
        ref.watch(formWidgetExampleProvider.select((value) => value.status));
    final isProgressing = status.isInProgress;
    final failure = status.failure;
    final controller = ref.watch(formWidgetExampleProvider.notifier);

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

/// Form builder widget for [FormWidgetExample] provider
class FormWidgetExampleFormBuilderWidget extends ConsumerWidget {
  const FormWidgetExampleFormBuilderWidget({
    super.key,
    required this.builder,
    this.child,
  });

  final Widget Function(
    BuildContext context,
    WidgetRef ref,
    ProviderStatus<bool> status,
    FormWidgetExample notifier,
    Widget? child,
  ) builder;
  final Widget? child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(
      child: child,
      builder: (context, ref, child) {
        final notifier = ref.watch(formWidgetExampleProvider.notifier);
        final status = ref
            .watch(formWidgetExampleProvider.select((value) => value.status));
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

/// Widget for manage for [FormWidgetExample] provider status
class FormWidgetExampleStatusWidget extends ConsumerWidget {
  const FormWidgetExampleStatusWidget({
    super.key,
    required this.builder,
    this.child,
  });

  final Widget Function(
    BuildContext context,
    WidgetRef ref,
    ProviderStatus<bool> status,
    FormWidgetExample notifier,
    Widget? child,
  ) builder;
  final Widget? child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    assert(_debugCheckHasFormWidgetExampleFormWidget(context));

    final notifier = ref.watch(formWidgetExampleProvider.notifier);
    final status =
        ref.watch(formWidgetExampleProvider.select((value) => value.status));

    return builder(context, ref, status, notifier, child);
  }
}

/// Widget for manage for [FormWidgetExample] provider state
class FormWidgetExampleStateWidget extends ConsumerWidget {
  const FormWidgetExampleStateWidget({
    super.key,
    required this.builder,
    this.child,
  });

  final Widget Function(
    BuildContext context,
    WidgetRef ref,
    FormWidgetExampleState state,
    FormWidgetExample notifier,
    Widget? child,
  ) builder;
  final Widget? child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    assert(_debugCheckHasFormWidgetExampleFormWidget(context));

    final notifier = ref.watch(formWidgetExampleProvider.notifier);
    final state = ref.watch(formWidgetExampleProvider);

    return builder(context, ref, state, notifier, child);
  }
}

/// Widget that manages [FormWidgetExample] provider state with a selector to optimize performance by reducing unnecessary rebuilds.
/// The selector allows watching only specific parts of the state that are needed.
class FormWidgetExampleSelectWidget<Selected> extends ConsumerWidget {
  const FormWidgetExampleSelectWidget({
    super.key,
    required this.selector,
    required this.builder,
    this.child,
  });

  final Selected Function(FormWidgetExampleState state) selector;
  final Widget Function(
    BuildContext context,
    WidgetRef ref,
    Selected selected,
    FormWidgetExample notifier,
    Widget? child,
  ) builder;
  final Widget? child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    assert(_debugCheckHasFormWidgetExampleFormWidget(context));

    final notifier = ref.watch(formWidgetExampleProvider.notifier);
    final selected = ref.watch(formWidgetExampleProvider.select(selector));

    return builder(context, ref, selected, notifier, child);
  }
}

/// Widget that expose [FormWidgetExample] provider notifier manage the state
/// using this ensure the state is correct map even it is family provider
class FormWidgetExampleNotifierWidget extends ConsumerWidget {
  const FormWidgetExampleNotifierWidget({
    super.key,
    required this.builder,
  });

  final Widget Function(
    BuildContext context,
    WidgetRef ref,
    FormWidgetExample notifier,
  ) builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    assert(_debugCheckHasFormWidgetExampleFormWidget(context));

    final notifier = ref.watch(formWidgetExampleProvider.notifier);

    return builder(context, ref, notifier);
  }
}

typedef FormWidgetExampleNameChildBuilder = Widget Function(
  WidgetRef ref,
  TextEditingController textController,
  String name,
  void Function(String newName) changeName,
  bool showValidation,
);

/// Widget form field for property [name]. To use this widget. You will need to add [FormWidgetExampleFormWidget] widget as ancestor
/// otherwise assert error will be thrown
class FormWidgetExampleNameFieldWidget extends HookConsumerWidget {
  const FormWidgetExampleNameFieldWidget({
    super.key,
    this.controller,
    required this.builder,
  });
  final FormWidgetExampleNameChildBuilder builder;

  /// TextEditingController of text field widget. If null it will create by widget
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    assert(_debugCheckHasFormWidgetExampleFormWidget(context));

    final notifier = ref.watch(formWidgetExampleProvider.notifier);
    final state =
        ref.watch(formWidgetExampleProvider.select((value) => value.name));
    final controller = this.controller ?? useTextEditingController(text: state);

    // Listen for provider changes
    ref.listen(formWidgetExampleProvider.select((value) => value.name), (
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
        final currentValue = ref.read(formWidgetExampleProvider).name;
        if (currentValue != controller.text) {
          notifier.onNameChanged(controller.text);
        }
      }

      controller.addListener(listener);
      return () => controller.removeListener(listener);
    }, [controller]);

    final showValidation = ref.watch(
        formWidgetExampleProvider.select((value) => value.status.isFailure));
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

String _$formWidgetExampleHash() => r'0a4697bcf4f1346f889952094b7591febef2718d';

/// See also [FormWidgetExample].
@ProviderFor(FormWidgetExample)
final formWidgetExampleProvider = AutoDisposeNotifierProvider<FormWidgetExample,
    FormWidgetExampleState>.internal(
  FormWidgetExample.new,
  name: r'formWidgetExampleProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$formWidgetExampleHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FormWidgetExample = AutoDisposeNotifier<FormWidgetExampleState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
