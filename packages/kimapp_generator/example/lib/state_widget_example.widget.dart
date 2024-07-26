// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// KimappStateWidgetGenerator
// **************************************************************************

// ignore_for_file: unused_import, depend_on_referenced_packages
import 'package:example/demo_schema.schema.dart';
import 'state_widget_example.dart';
import 'dart:core';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

bool _debugCheckHasAsyncGenerateStateWidget(BuildContext context) {
  assert(() {
    if (context.widget is! AsyncGenerateStateWidget &&
        context.findAncestorWidgetOfExactType<AsyncGenerateStateWidget>() ==
            null) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('No AsyncGenerateStateWidget found'),
        ErrorDescription(
          '${context.widget.runtimeType} widgets require a AsyncGenerateStateWidget widget ancestor.',
        ),
      ]);
    }
    return true;
  }());
  return true;
}

class _AsyncGenerateParamsProvider extends InheritedWidget {
  const _AsyncGenerateParamsProvider({
    required this.hello,
    required super.child,
  });

  final int hello;

  static _AsyncGenerateParamsProvider? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_AsyncGenerateParamsProvider>();
  }

  @override
  bool updateShouldNotify(_AsyncGenerateParamsProvider oldWidget) {
    return hello != oldWidget.hello;
  }
}

typedef AsyncGenerateStateWidgetBuilder = Widget Function(
  BuildContext context,
  WidgetRef ref,
  AsyncValue<DemoModel> state,
);

class AsyncGenerateStateWidget extends StatelessWidget {
  const AsyncGenerateStateWidget({
    super.key,
    required this.hello,
    this.child,
    this.builder,
  }) : assert(
          builder != null || child != null,
          'Either child or builder must be provided, but not both.',
        );

  final int hello;
  final Widget? child;
  final AsyncGenerateStateWidgetBuilder? builder;

  @override
  Widget build(BuildContext context) {
    final content = builder != null
        ? Consumer(
            builder: (context, ref, _) {
              final state = ref.watch(asyncGenerateProvider(hello));
              return builder!(context, ref, state);
            },
          )
        : child!;

    return _AsyncGenerateParamsProvider(
      hello: hello,
      child: content,
    );
  }
}

typedef AsyncGenerateStateWidgetIdWidgetBuilder = Widget Function(
  BuildContext context,
  WidgetRef ref,
  AsyncValue<DemoId> id,
);

class AsyncGenerateStateWidgetIdWidget extends StatelessWidget {
  const AsyncGenerateStateWidgetIdWidget({
    super.key,
    required this.builder,
  });

  final AsyncGenerateStateWidgetIdWidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    assert(_debugCheckHasAsyncGenerateStateWidget(context));
    final param = _AsyncGenerateParamsProvider.of(context)!;

    return Consumer(
      builder: (context, ref, child) {
        final int hello = param.hello;

        final state = ref.watch(
          asyncGenerateProvider(hello)
              .select((state) => state.whenData((data) => data.id)),
        );
        return builder(context, ref, state);
      },
    );
  }
}

typedef AsyncGenerateStateWidgetNameWidgetBuilder = Widget Function(
  BuildContext context,
  WidgetRef ref,
  AsyncValue<String?> name,
);

class AsyncGenerateStateWidgetNameWidget extends StatelessWidget {
  const AsyncGenerateStateWidgetNameWidget({
    super.key,
    required this.builder,
  });

  final AsyncGenerateStateWidgetNameWidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    assert(_debugCheckHasAsyncGenerateStateWidget(context));
    final param = _AsyncGenerateParamsProvider.of(context)!;

    return Consumer(
      builder: (context, ref, child) {
        final int hello = param.hello;

        final state = ref.watch(
          asyncGenerateProvider(hello)
              .select((state) => state.whenData((data) => data.name)),
        );
        return builder(context, ref, state);
      },
    );
  }
}

typedef AsyncGenerateStateWidgetDescriptionWidgetBuilder = Widget Function(
  BuildContext context,
  WidgetRef ref,
  AsyncValue<String?> description,
);

class AsyncGenerateStateWidgetDescriptionWidget extends StatelessWidget {
  const AsyncGenerateStateWidgetDescriptionWidget({
    super.key,
    required this.builder,
  });

  final AsyncGenerateStateWidgetDescriptionWidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    assert(_debugCheckHasAsyncGenerateStateWidget(context));
    final param = _AsyncGenerateParamsProvider.of(context)!;

    return Consumer(
      builder: (context, ref, child) {
        final int hello = param.hello;

        final state = ref.watch(
          asyncGenerateProvider(hello)
              .select((state) => state.whenData((data) => data.description)),
        );
        return builder(context, ref, state);
      },
    );
  }
}

typedef AsyncGenerateStateWidgetOtherWidgetBuilder = Widget Function(
  BuildContext context,
  WidgetRef ref,
  AsyncValue<InvalidType> other,
);

class AsyncGenerateStateWidgetOtherWidget extends StatelessWidget {
  const AsyncGenerateStateWidgetOtherWidget({
    super.key,
    required this.builder,
  });

  final AsyncGenerateStateWidgetOtherWidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    assert(_debugCheckHasAsyncGenerateStateWidget(context));
    final param = _AsyncGenerateParamsProvider.of(context)!;

    return Consumer(
      builder: (context, ref, child) {
        final int hello = param.hello;

        final state = ref.watch(
          asyncGenerateProvider(hello)
              .select((state) => state.whenData((data) => data.other)),
        );
        return builder(context, ref, state);
      },
    );
  }
}
