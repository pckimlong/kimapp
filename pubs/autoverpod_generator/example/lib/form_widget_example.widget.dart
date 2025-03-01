// **************************************************************************
// GENERATED CODE - DO NOT MODIFY BY HAND
// **************************************************************************
// ignore_for_file: type=lint, duplicate_import, unnecessary_import, unused_import, unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark
// coverage:ignore-file

import 'package:autoverpod_generator_example/form_widget_example.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kimapp_utils/kimapp_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:typed_data';
import 'package:autoverpod/autoverpod.dart';
import 'package:autoverpod_generator_example/form_widget_example.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:core';

class _UpdateUserFormInheritedWidget extends InheritedWidget {
  const _UpdateUserFormInheritedWidget({
    required this.formKey,
    required this.params,
    required super.child,
  });

  final GlobalKey<FormState> formKey;
  final ({int id}) params;

  static _UpdateUserFormInheritedWidget of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_UpdateUserFormInheritedWidget>()!;
  }

  @override
  bool updateShouldNotify(covariant _UpdateUserFormInheritedWidget oldWidget) {
    return formKey != oldWidget.formKey && params != oldWidget.params;
  }
}

class _UpdateUserProxyWidgetRef extends WidgetRef {
  _UpdateUserProxyWidgetRef(this._ref);

  final WidgetRef _ref;

  ({int id}) get params => _UpdateUserFormInheritedWidget.of(context).params;

  AsyncValue<bool>? get status =>
      _ref.watch(updateUserCallStatusProvider((id: params.id)));

  GlobalKey<FormState> get formKey =>
      _UpdateUserFormInheritedWidget.of(context).formKey;

  UpdateUser get notifier => _ref.read(updateUserProvider(params.id).notifier);

  /// Submits the form. Internally this calls [notifier.submit] with the form key validated.
  Future<AsyncValue<bool>> submit({required Uint8List? photoBytes}) async {
    if (!(formKey.currentState?.validate() ?? false)) {
      return AsyncValue.error(
        Exception('Form is not valid'),
        StackTrace.current,
      );
    }
    formKey.currentState?.save();

    return await notifier(photoBytes: photoBytes);
  }

  UpdateUserModel get state => _ref.watch(updateUserProvider(params.id));

  Selected select<Selected>(Selected Function(UpdateUserModel) selector) => _ref
      .watch(updateUserProvider(params.id).select((value) => selector(value)));

  @override
  BuildContext get context => _ref.context;

  @override
  bool exists(ProviderBase<Object?> provider) => _ref.exists(provider);

  @override
  void invalidate(ProviderOrFamily provider) => _ref.invalidate(provider);

  @override
  void listen<T>(
    ProviderListenable<T> provider,
    void Function(T?, T) listener, {
    void Function(Object, StackTrace)? onError,
  }) => _ref.listen(provider, listener, onError: onError);

  @override
  ProviderSubscription<T> listenManual<T>(
    ProviderListenable<T> provider,
    void Function(T?, T) listener, {
    void Function(Object, StackTrace)? onError,
    bool fireImmediately = false,
  }) => _ref.listenManual(
    provider,
    listener,
    onError: onError,
    fireImmediately: fireImmediately,
  );

  @override
  T read<T>(ProviderListenable<T> provider) => _ref.read(provider);

  @override
  State refresh<State>(Refreshable<State> provider) => _ref.refresh(provider);

  @override
  T watch<T>(ProviderListenable<T> provider) => _ref.watch(provider);
}

class UpdateUserFormScope extends ConsumerStatefulWidget {
  const UpdateUserFormScope({
    super.key,
    required this.id,
    this.formKey,
    this.autovalidateMode,
    this.onPopInvokedWithResult,
    required this.builder,
    this.child,
    this.onSuccessed,
  }) : assert(
         child != null || builder != null,
         'Either child or builder must be provided',
       );
  final int id;
  final Widget Function(
    BuildContext context,
    _UpdateUserProxyWidgetRef ref,
    Widget? child,
  )?
  builder;
  final Widget? child;
  final GlobalKey<FormState>? formKey;
  final AutovalidateMode? autovalidateMode;
  final void Function(bool, Object?)? onPopInvokedWithResult;
  final void Function(BuildContext context, bool value)? onSuccessed;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UpdateUserFormScopeState();
}

class _UpdateUserFormScopeState extends ConsumerState<UpdateUserFormScope> {
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
    ref.listen(updateUserCallStatusProvider((id: widget.id)), (previous, next) {
      if (previous?.hasValue == false && next?.hasValue == true) {
        widget.onSuccessed?.call(context, next!.requireValue);
      }
    });

    return _UpdateUserFormInheritedWidget(
      formKey: _cachedFormKey,
      params: (id: widget.id),
      child: Form(
        key: _cachedFormKey,
        autovalidateMode: widget.autovalidateMode,
        onPopInvokedWithResult: widget.onPopInvokedWithResult,
        child: Consumer(
          builder: (context, ref, child) {
            if (widget.builder != null) {
              return widget.builder!(
                context,
                _UpdateUserProxyWidgetRef(ref),
                widget.child,
              );
            }

            return widget.child!;
          },
        ),
      ),
    );
  }
}

bool _debugCheckHasUpdateUserForm(BuildContext context) {
  assert(() {
    if (context.widget is! UpdateUserFormScope &&
        context.findAncestorWidgetOfExactType<UpdateUserFormScope>() == null) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('No UpdateUserFormScope found'),
        ErrorDescription(
          '${context.widget.runtimeType} widgets require a UpdateUserFormScope widget ancestor.',
        ),
      ]);
    }
    return true;
  }());
  return true;
}

class UpdateUserFormParams extends ConsumerWidget {
  const UpdateUserFormParams({super.key, required this.builder});

  final Widget Function(
    BuildContext context,
    _UpdateUserProxyWidgetRef ref,
    ({int id}) params,
  )
  builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasUpdateUserForm(context);

    final params = _UpdateUserFormInheritedWidget.of(context).params;
    return builder(context, _UpdateUserProxyWidgetRef(ref), params);
  }
}

class UpdateUserFormSelect<Selected> extends ConsumerWidget {
  const UpdateUserFormSelect({
    super.key,
    required this.selector,
    required this.builder,
    this.onStateChanged,
  });

  final Selected Function(UpdateUserModel state) selector;
  final Widget Function(
    BuildContext context,
    _UpdateUserProxyWidgetRef ref,
    Selected value,
  )
  builder;
  final void Function(Selected? previous, Selected? next)? onStateChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasUpdateUserForm(context);

    if (onStateChanged != null) {
      final params = _UpdateUserFormInheritedWidget.of(context).params;
      ref.listen(
        updateUserProvider(params.id).select((value) => selector(value)),
        (pre, next) {
          if (pre != next) onStateChanged!(pre, next);
        },
      );
    }
    final stateRef = _UpdateUserProxyWidgetRef(ref);
    return builder(context, stateRef, stateRef.select(selector));
  }
}

class UpdateUserFormState extends ConsumerWidget {
  const UpdateUserFormState({
    super.key,
    required this.builder,
    this.child,
    this.onStateChanged,
  });

  /// The builder function that constructs the widget tree.
  /// Access the state directly via ref.state, which is equivalent to ref.watch(updateUserProvider(params.id))
  ///
  /// For selecting specific fields, use ref.select() - e.g. ref.select((value) => value.someField)
  /// The ref parameter provides type-safe access to the provider state and notifier
  final Widget Function(
    BuildContext context,
    _UpdateUserProxyWidgetRef ref,
    Widget? child,
  )
  builder;
  final Widget? child;
  final void Function(UpdateUserModel? previous, UpdateUserModel? next)?
  onStateChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasUpdateUserForm(context);

    if (onStateChanged != null) {
      final params = _UpdateUserFormInheritedWidget.of(context).params;
      ref.listen(updateUserProvider(params.id), (pre, next) {
        if (pre != next) onStateChanged!(pre, next);
      });
    }
    return UpdateUserFormParams(
      builder:
          (context, ref, params) =>
              builder(context, _UpdateUserProxyWidgetRef(ref), child),
    );
  }
}

class UpdateUserFormStatus extends ConsumerWidget {
  const UpdateUserFormStatus({super.key, required this.builder});

  final Widget Function(
    BuildContext context,
    _UpdateUserProxyWidgetRef ref,
    AsyncValue<bool>? status,
  )
  builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasUpdateUserForm(context);

    final stateRef = _UpdateUserProxyWidgetRef(ref);
    return builder(context, stateRef, stateRef.status);
  }
}

class _UpdateUserNameProxyWidgetRef extends _UpdateUserProxyWidgetRef {
  _UpdateUserNameProxyWidgetRef(super._ref, {required this.textController});

  /// Text controller for the field. This is automatically created by the form widget and handles cleanup automatically.
  final TextEditingController textController;

  String get name => select((state) => state.name);

  void updateName(String newValue) => notifier.updateName(newValue);
}

class UpdateUserNameField extends ConsumerStatefulWidget {
  const UpdateUserNameField({
    super.key,
    this.textController,
    required this.builder,
  });

  /// Text controller for the field. If not provided, one will be created automatically.
  final TextEditingController? textController;

  /// Builder function that will be called with the context and ref.
  /// Field utilities are accessible via [ref]
  final Widget Function(BuildContext context, _UpdateUserNameProxyWidgetRef ref)
  builder;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      UpdateUserNameFieldState();
}

class UpdateUserNameFieldState extends ConsumerState<UpdateUserNameField> {
  late final TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    final params = _UpdateUserFormInheritedWidget.of(context).params;
    final initialValue = ref.read(updateUserProvider(params.id)).name;
    _textController =
        widget.textController ?? TextEditingController(text: initialValue);

    // Setup listener for provider changes
    ref.listenManual(
      updateUserProvider(params.id).select((value) => value.name),
      _handleFieldValueChange,
      fireImmediately: false,
    );

    _textController.addListener(_syncTextToProvider);
  }

  /// Handles when the provider value changes and updates the text controller
  void _handleFieldValueChange(dynamic previous, dynamic next) {
    if (previous == next) return;
    if (_textController.text == next) return;

    // Ensure we're not updating a disposed controller
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _textController.text = next;
      }
    });
  }

  /// Syncs text field changes to the provider
  void _syncTextToProvider() {
    if (!mounted) return;
    final params = _UpdateUserFormInheritedWidget.of(context).params;
    ref
        .read(updateUserProvider(params.id).notifier)
        .updateName(_textController.text);
  }

  @override
  void dispose() {
    _textController.removeListener(_syncTextToProvider);
    // Only dispose if we created the controller
    if (widget.textController == null) {
      _textController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _debugCheckHasUpdateUserForm(context);

    final proxy = _UpdateUserNameProxyWidgetRef(
      ref,
      textController: _textController,
    );
    return widget.builder(context, proxy);
  }
}

class _UpdateUserAgeProxyWidgetRef extends _UpdateUserProxyWidgetRef {
  _UpdateUserAgeProxyWidgetRef(super._ref);

  int? get age => select((state) => state.age);

  void updateAge(int? newValue) => notifier.updateAge(newValue);
}

class UpdateUserAgeField extends ConsumerWidget {
  const UpdateUserAgeField({super.key, required this.builder});

  final Widget Function(BuildContext context, _UpdateUserAgeProxyWidgetRef ref)
  builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasUpdateUserForm(context);

    final proxy = _UpdateUserAgeProxyWidgetRef(ref);
    return builder(context, proxy);
  }
}

class _UpdateUserEmailProxyWidgetRef extends _UpdateUserProxyWidgetRef {
  _UpdateUserEmailProxyWidgetRef(super._ref, {required this.textController});

  /// Text controller for the field. This is automatically created by the form widget and handles cleanup automatically.
  final TextEditingController textController;

  String? get email => select((state) => state.email);

  void updateEmail(String? newValue) => notifier.updateEmail(newValue);
}

class UpdateUserEmailField extends ConsumerStatefulWidget {
  const UpdateUserEmailField({
    super.key,
    this.textController,
    required this.builder,
  });

  /// Text controller for the field. If not provided, one will be created automatically.
  final TextEditingController? textController;

  /// Builder function that will be called with the context and ref.
  /// Field utilities are accessible via [ref]
  final Widget Function(
    BuildContext context,
    _UpdateUserEmailProxyWidgetRef ref,
  )
  builder;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      UpdateUserEmailFieldState();
}

class UpdateUserEmailFieldState extends ConsumerState<UpdateUserEmailField> {
  late final TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    final params = _UpdateUserFormInheritedWidget.of(context).params;
    final initialValue = ref.read(updateUserProvider(params.id)).email;
    _textController =
        widget.textController ?? TextEditingController(text: initialValue);

    // Setup listener for provider changes
    ref.listenManual(
      updateUserProvider(params.id).select((value) => value.email),
      _handleFieldValueChange,
      fireImmediately: false,
    );

    _textController.addListener(_syncTextToProvider);
  }

  /// Handles when the provider value changes and updates the text controller
  void _handleFieldValueChange(dynamic previous, dynamic next) {
    if (previous == next) return;
    if (_textController.text == next) return;

    // Ensure we're not updating a disposed controller
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _textController.text = next ?? "";
      }
    });
  }

  /// Syncs text field changes to the provider
  void _syncTextToProvider() {
    if (!mounted) return;
    final params = _UpdateUserFormInheritedWidget.of(context).params;
    ref
        .read(updateUserProvider(params.id).notifier)
        .updateEmail(_textController.text);
  }

  @override
  void dispose() {
    _textController.removeListener(_syncTextToProvider);
    // Only dispose if we created the controller
    if (widget.textController == null) {
      _textController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _debugCheckHasUpdateUserForm(context);

    final proxy = _UpdateUserEmailProxyWidgetRef(
      ref,
      textController: _textController,
    );
    return widget.builder(context, proxy);
  }
}

class _UpdateUserAddressProxyWidgetRef extends _UpdateUserProxyWidgetRef {
  _UpdateUserAddressProxyWidgetRef(super._ref, {required this.textController});

  /// Text controller for the field. This is automatically created by the form widget and handles cleanup automatically.
  final TextEditingController textController;

  String? get address => select((state) => state.address);

  void updateAddress(String? newValue) => notifier.updateAddress(newValue);
}

class UpdateUserAddressField extends ConsumerStatefulWidget {
  const UpdateUserAddressField({
    super.key,
    this.textController,
    required this.builder,
  });

  /// Text controller for the field. If not provided, one will be created automatically.
  final TextEditingController? textController;

  /// Builder function that will be called with the context and ref.
  /// Field utilities are accessible via [ref]
  final Widget Function(
    BuildContext context,
    _UpdateUserAddressProxyWidgetRef ref,
  )
  builder;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      UpdateUserAddressFieldState();
}

class UpdateUserAddressFieldState
    extends ConsumerState<UpdateUserAddressField> {
  late final TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    final params = _UpdateUserFormInheritedWidget.of(context).params;
    final initialValue = ref.read(updateUserProvider(params.id)).address;
    _textController =
        widget.textController ?? TextEditingController(text: initialValue);

    // Setup listener for provider changes
    ref.listenManual(
      updateUserProvider(params.id).select((value) => value.address),
      _handleFieldValueChange,
      fireImmediately: false,
    );

    _textController.addListener(_syncTextToProvider);
  }

  /// Handles when the provider value changes and updates the text controller
  void _handleFieldValueChange(dynamic previous, dynamic next) {
    if (previous == next) return;
    if (_textController.text == next) return;

    // Ensure we're not updating a disposed controller
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _textController.text = next ?? "";
      }
    });
  }

  /// Syncs text field changes to the provider
  void _syncTextToProvider() {
    if (!mounted) return;
    final params = _UpdateUserFormInheritedWidget.of(context).params;
    ref
        .read(updateUserProvider(params.id).notifier)
        .updateAddress(_textController.text);
  }

  @override
  void dispose() {
    _textController.removeListener(_syncTextToProvider);
    // Only dispose if we created the controller
    if (widget.textController == null) {
      _textController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _debugCheckHasUpdateUserForm(context);

    final proxy = _UpdateUserAddressProxyWidgetRef(
      ref,
      textController: _textController,
    );
    return widget.builder(context, proxy);
  }
}

class _UpdateUserPhoneProxyWidgetRef extends _UpdateUserProxyWidgetRef {
  _UpdateUserPhoneProxyWidgetRef(super._ref, {required this.textController});

  /// Text controller for the field. This is automatically created by the form widget and handles cleanup automatically.
  final TextEditingController textController;

  String? get phone => select((state) => state.phone);

  void updatePhone(String? newValue) => notifier.updatePhone(newValue);
}

class UpdateUserPhoneField extends ConsumerStatefulWidget {
  const UpdateUserPhoneField({
    super.key,
    this.textController,
    required this.builder,
  });

  /// Text controller for the field. If not provided, one will be created automatically.
  final TextEditingController? textController;

  /// Builder function that will be called with the context and ref.
  /// Field utilities are accessible via [ref]
  final Widget Function(
    BuildContext context,
    _UpdateUserPhoneProxyWidgetRef ref,
  )
  builder;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      UpdateUserPhoneFieldState();
}

class UpdateUserPhoneFieldState extends ConsumerState<UpdateUserPhoneField> {
  late final TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    final params = _UpdateUserFormInheritedWidget.of(context).params;
    final initialValue = ref.read(updateUserProvider(params.id)).phone;
    _textController =
        widget.textController ?? TextEditingController(text: initialValue);

    // Setup listener for provider changes
    ref.listenManual(
      updateUserProvider(params.id).select((value) => value.phone),
      _handleFieldValueChange,
      fireImmediately: false,
    );

    _textController.addListener(_syncTextToProvider);
  }

  /// Handles when the provider value changes and updates the text controller
  void _handleFieldValueChange(dynamic previous, dynamic next) {
    if (previous == next) return;
    if (_textController.text == next) return;

    // Ensure we're not updating a disposed controller
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _textController.text = next ?? "";
      }
    });
  }

  /// Syncs text field changes to the provider
  void _syncTextToProvider() {
    if (!mounted) return;
    final params = _UpdateUserFormInheritedWidget.of(context).params;
    ref
        .read(updateUserProvider(params.id).notifier)
        .updatePhone(_textController.text);
  }

  @override
  void dispose() {
    _textController.removeListener(_syncTextToProvider);
    // Only dispose if we created the controller
    if (widget.textController == null) {
      _textController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _debugCheckHasUpdateUserForm(context);

    final proxy = _UpdateUserPhoneProxyWidgetRef(
      ref,
      textController: _textController,
    );
    return widget.builder(context, proxy);
  }
}
