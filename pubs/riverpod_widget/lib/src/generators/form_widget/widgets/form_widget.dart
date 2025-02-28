import 'package:riverpod_widget/src/generators/form_widget/form_widget_names.dart';
import 'package:riverpod_widget/src/models/provider_definition.dart';

String generateFormWidget(ProviderDefinition provider) {
  return '''
class ${provider.formWidgetName} extends ConsumerStatefulWidget {
  const ${provider.formWidgetName}({
    super.key,
    required this.id,
    this.formKey,
    this.autovalidateMode,
    this.onPopInvokedWithResult,
    required this.builder,
    this.child,
    this.onInitLoading,
    this.onInitError,
    this.onSuccessed,
  }) : assert(child != null || builder != null, 'Either child or builder must be provided');

  final int id;
  final Widget Function(
    BuildContext context,
    ${provider.formBaseProxyWidgetName} ref,
    Widget? child,
  )? builder;
  final Widget? child;
  final GlobalKey<FormState>? formKey;
  final AutovalidateMode? autovalidateMode;
  final void Function(bool, Object?)? onPopInvokedWithResult;
  final Widget Function()? onInitLoading;
  final Widget Function(Object error, StackTrace stack)? onInitError;
  final void Function(BuildContext context, bool value)? onSuccessed;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _${provider.formWidgetName}State();
}

class _${provider.formWidgetName}State extends ConsumerState<${provider.formWidgetName}> {
  late final GlobalKey<FormState> _cachedFormKey;

  @override
  void initState() {
    super.initState();
    _cachedFormKey = widget.formKey ?? GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _cachedFormKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      ${provider.callStatusProviderNameWithFamily(prefix: 'widget')},
      (previous, next) {
        if (previous?.hasValue == false && next?.hasValue == true) {
          widget.onSuccessed?.call(context, next!.requireValue);
        }
      },
    );

    final isInitializedAsync = ref.watch(
      ${provider.providerNameWithFamily(prefix: 'widget')}.select((_) => _.whenData((_) => true)),
    );

    return ${provider.formInheritedWidgetName}(
      formKey: _cachedFormKey,
      params: (id: widget.id),
      child: Form(
        key: _cachedFormKey,
        autovalidateMode: widget.autovalidateMode,
        onPopInvokedWithResult: widget.onPopInvokedWithResult,
        child: isInitializedAsync.when(
          data: (_) {
            if (widget.builder != null) {
              return widget.builder!(
                context,
                ${provider.formBaseProxyWidgetName}(ref),
                widget.child,
              );
            }

            return widget.child!;
          },
          error: (error, stack) =>
              widget.onInitError?.call(error, stack) ??
              Theme.of(context).extension<KimappThemeExtension>()?.defaultErrorStateWidget?.call(
                    context,
                    ref,
                    error,
                  ) ??
              const SizedBox.shrink(),
          loading: () {
            return widget.onInitLoading?.call() ??
                Theme.of(context)
                    .extension<KimappThemeExtension>()
                    ?.defaultLoadingStateWidget
                    ?.call(context, ref) ??
                const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
  ''';
}
