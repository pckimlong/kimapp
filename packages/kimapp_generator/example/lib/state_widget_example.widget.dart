// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// KimappStateWidgetGenerator
// **************************************************************************

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'state_widget_example.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef ClassGenerateStateWidgetBuilder = Widget Function(
  BuildContext context,
  WidgetRef ref,
  AsyncValue<List<ExampleModel>> state,
);

class ClassGenerateStateWidget extends StatelessWidget {
  const ClassGenerateStateWidget({
    super.key,
    required this.param,
    required this.builder,
  });

  final int param;

  final ClassGenerateStateWidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final state = ref.watch(classGenerateProvider(param));
        return builder(context, ref, state);
      },
    );
  }
}

bool _debugCheckHasClassGenerate2StateWidget(BuildContext context) {
  assert(() {
    if (context.widget is! ClassGenerate2StateWidget &&
        context.findAncestorWidgetOfExactType<ClassGenerate2StateWidget>() ==
            null) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('No ClassGenerate2StateWidget found'),
        ErrorDescription(
          '${context.widget.runtimeType} widgets require a ClassGenerate2StateWidget widget ancestor.',
        ),
      ]);
    }
    return true;
  }());
  return true;
}

class _ClassGenerate2ParamsProvider extends InheritedWidget {
  const _ClassGenerate2ParamsProvider({
    required this.a,
    required super.child,
  });

  final int a;

  static _ClassGenerate2ParamsProvider? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_ClassGenerate2ParamsProvider>();
  }

  @override
  bool updateShouldNotify(_ClassGenerate2ParamsProvider oldWidget) {
    return a != oldWidget.a;
  }
}

typedef ClassGenerate2StateWidgetBuilder = Widget Function(
  BuildContext context,
  WidgetRef ref,
  AsyncValue<ExampleModel> state,
);

class ClassGenerate2StateWidget extends StatelessWidget {
  const ClassGenerate2StateWidget({
    super.key,
    required this.a,
    this.child,
    this.builder,
  }) : assert(
          builder != null || child != null,
          'Either child or builder must be provided, but not both.',
        );

  final int a;
  final Widget? child;
  final ClassGenerate2StateWidgetBuilder? builder;

  @override
  Widget build(BuildContext context) {
    final content = builder != null
        ? Consumer(
            builder: (context, ref, _) {
              final state = ref.watch(classGenerate2Provider(a));
              return builder!(context, ref, state);
            },
          )
        : child!;

    return _ClassGenerate2ParamsProvider(
      a: a,
      child: content,
    );
  }
}

typedef ClassGenerate2StateWidgetIdWidgetBuilder = Widget Function(
  BuildContext context,
  WidgetRef ref,
  AsyncValue<int> id,
);

class ClassGenerate2StateWidgetIdWidget extends StatelessWidget {
  const ClassGenerate2StateWidgetIdWidget({
    super.key,
    required this.builder,
  });

  final ClassGenerate2StateWidgetIdWidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    assert(_debugCheckHasClassGenerate2StateWidget(context));
    final param = _ClassGenerate2ParamsProvider.of(context)!;

    return Consumer(
      builder: (context, ref, child) {
        final int a = param.a;

        final state = ref.watch(
          classGenerate2Provider(a)
              .select((state) => state.whenData((data) => data.id)),
        );
        return builder(context, ref, state);
      },
    );
  }
}

typedef ClassGenerate2StateWidgetNameWidgetBuilder = Widget Function(
  BuildContext context,
  WidgetRef ref,
  AsyncValue<String> name,
);

class ClassGenerate2StateWidgetNameWidget extends StatelessWidget {
  const ClassGenerate2StateWidgetNameWidget({
    super.key,
    required this.builder,
  });

  final ClassGenerate2StateWidgetNameWidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    assert(_debugCheckHasClassGenerate2StateWidget(context));
    final param = _ClassGenerate2ParamsProvider.of(context)!;

    return Consumer(
      builder: (context, ref, child) {
        final int a = param.a;

        final state = ref.watch(
          classGenerate2Provider(a)
              .select((state) => state.whenData((data) => data.name)),
        );
        return builder(context, ref, state);
      },
    );
  }
}

bool _debugCheckHasClassGenerate3StateWidget(BuildContext context) {
  assert(() {
    if (context.widget is! ClassGenerate3StateWidget &&
        context.findAncestorWidgetOfExactType<ClassGenerate3StateWidget>() ==
            null) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('No ClassGenerate3StateWidget found'),
        ErrorDescription(
          '${context.widget.runtimeType} widgets require a ClassGenerate3StateWidget widget ancestor.',
        ),
      ]);
    }
    return true;
  }());
  return true;
}

class _ClassGenerate3ParamsProvider extends InheritedWidget {
  const _ClassGenerate3ParamsProvider({
    required this.a,
    required this.b,
    required super.child,
  });

  final int a;
  final String b;

  static _ClassGenerate3ParamsProvider? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_ClassGenerate3ParamsProvider>();
  }

  @override
  bool updateShouldNotify(_ClassGenerate3ParamsProvider oldWidget) {
    return a != oldWidget.a || b != oldWidget.b;
  }
}

typedef ClassGenerate3StateWidgetBuilder = Widget Function(
  BuildContext context,
  WidgetRef ref,
  AsyncValue<ExampleModel> state,
);

class ClassGenerate3StateWidget extends StatelessWidget {
  const ClassGenerate3StateWidget({
    super.key,
    required this.a,
    this.b = "Hello",
    this.child,
    this.builder,
  }) : assert(
          builder != null || child != null,
          'Either child or builder must be provided, but not both.',
        );

  final int a;
  final String b;
  final Widget? child;
  final ClassGenerate3StateWidgetBuilder? builder;

  @override
  Widget build(BuildContext context) {
    final content = builder != null
        ? Consumer(
            builder: (context, ref, _) {
              final state = ref.watch(classGenerate3Provider(a, b: b));
              return builder!(context, ref, state);
            },
          )
        : child!;

    return _ClassGenerate3ParamsProvider(
      a: a,
      b: b,
      child: content,
    );
  }
}

typedef ClassGenerate3StateWidgetIdWidgetBuilder = Widget Function(
  BuildContext context,
  WidgetRef ref,
  AsyncValue<int> id,
);

class ClassGenerate3StateWidgetIdWidget extends StatelessWidget {
  const ClassGenerate3StateWidgetIdWidget({
    super.key,
    required this.builder,
  });

  final ClassGenerate3StateWidgetIdWidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    assert(_debugCheckHasClassGenerate3StateWidget(context));
    final param = _ClassGenerate3ParamsProvider.of(context)!;

    return Consumer(
      builder: (context, ref, child) {
        final int a = param.a;
        final String b = param.b;

        final state = ref.watch(
          classGenerate3Provider(a, b: b)
              .select((state) => state.whenData((data) => data.id)),
        );
        return builder(context, ref, state);
      },
    );
  }
}

typedef ClassGenerate3StateWidgetNameWidgetBuilder = Widget Function(
  BuildContext context,
  WidgetRef ref,
  AsyncValue<String> name,
);

class ClassGenerate3StateWidgetNameWidget extends StatelessWidget {
  const ClassGenerate3StateWidgetNameWidget({
    super.key,
    required this.builder,
  });

  final ClassGenerate3StateWidgetNameWidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    assert(_debugCheckHasClassGenerate3StateWidget(context));
    final param = _ClassGenerate3ParamsProvider.of(context)!;

    return Consumer(
      builder: (context, ref, child) {
        final int a = param.a;
        final String b = param.b;

        final state = ref.watch(
          classGenerate3Provider(a, b: b)
              .select((state) => state.whenData((data) => data.name)),
        );
        return builder(context, ref, state);
      },
    );
  }
}

typedef NormalValueGenerateStateWidgetBuilder = Widget Function(
  BuildContext context,
  WidgetRef ref,
  String state,
);

class NormalValueGenerateStateWidget extends StatelessWidget {
  const NormalValueGenerateStateWidget({
    super.key,
    required this.a,
    required this.builder,
  });

  final String a;

  final NormalValueGenerateStateWidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final state = ref.watch(normalValueGenerateProvider(a));
        return builder(context, ref, state);
      },
    );
  }
}

typedef NormalGenerateStateWidgetBuilder = Widget Function(
  BuildContext context,
  WidgetRef ref,
  ExampleModel state,
);

class NormalGenerateStateWidget extends StatelessWidget {
  const NormalGenerateStateWidget({
    super.key,
    this.child,
    this.builder,
  }) : assert(
          builder != null || child != null,
          'Either child or builder must be provided, but not both.',
        );

  final Widget? child;
  final NormalGenerateStateWidgetBuilder? builder;

  @override
  Widget build(BuildContext context) {
    final content = builder != null
        ? Consumer(
            builder: (context, ref, _) {
              final state = ref.watch(normalGenerateProvider);
              return builder!(context, ref, state);
            },
          )
        : child!;

    return content;
  }
}

typedef NormalGenerateStateWidgetIdWidgetBuilder = Widget Function(
  BuildContext context,
  WidgetRef ref,
  int id,
);

class NormalGenerateStateWidgetIdWidget extends StatelessWidget {
  const NormalGenerateStateWidgetIdWidget({
    super.key,
    required this.builder,
  });

  final NormalGenerateStateWidgetIdWidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final state = ref.watch(
          normalGenerateProvider.select((state) => state.id),
        );
        return builder(context, ref, state);
      },
    );
  }
}

typedef NormalGenerateStateWidgetNameWidgetBuilder = Widget Function(
  BuildContext context,
  WidgetRef ref,
  String name,
);

class NormalGenerateStateWidgetNameWidget extends StatelessWidget {
  const NormalGenerateStateWidgetNameWidget({
    super.key,
    required this.builder,
  });

  final NormalGenerateStateWidgetNameWidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final state = ref.watch(
          normalGenerateProvider.select((state) => state.name),
        );
        return builder(context, ref, state);
      },
    );
  }
}

typedef NormalGenerateListStateWidgetBuilder = Widget Function(
  BuildContext context,
  WidgetRef ref,
  List<ExampleModel> state,
);

class NormalGenerateListStateWidget extends StatelessWidget {
  const NormalGenerateListStateWidget({
    super.key,
    required this.builder,
  });

  final NormalGenerateListStateWidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final state = ref.watch(normalGenerateListProvider);
        return builder(context, ref, state);
      },
    );
  }
}

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
  AsyncValue<ExampleModel> state,
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
  AsyncValue<int> id,
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
  AsyncValue<String> name,
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

typedef AsyncListGenerateStateWidgetBuilder = Widget Function(
  BuildContext context,
  WidgetRef ref,
  AsyncValue<List<ExampleModel>> state,
);

class AsyncListGenerateStateWidget extends StatelessWidget {
  const AsyncListGenerateStateWidget({
    super.key,
    required this.builder,
  });

  final AsyncListGenerateStateWidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final state = ref.watch(asyncListGenerateProvider);
        return builder(context, ref, state);
      },
    );
  }
}

typedef AsyncIListGenerateStateWidgetBuilder = Widget Function(
  BuildContext context,
  WidgetRef ref,
  AsyncValue<IList<ExampleModel>> state,
);

class AsyncIListGenerateStateWidget extends StatelessWidget {
  const AsyncIListGenerateStateWidget({
    super.key,
    required this.builder,
  });

  final AsyncIListGenerateStateWidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final state = ref.watch(asyncIListGenerateProvider);
        return builder(context, ref, state);
      },
    );
  }
}
