// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// KimappStateWidgetGenerator
// **************************************************************************

// ignore_for_file: unused_import, depend_on_referenced_packages
import 'package:example/demo_schema.schema.dart';
import 'state_widget_example.dart';
import 'dart:core';
import 'package:example/other_schema.schema.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef DemoStateWidgetBuilder = Widget Function(
  BuildContext context,
  WidgetRef ref,
  AsyncValue<DemoModel> state,
);

class DemoStateWidget extends StatelessWidget {
  const DemoStateWidget({
    super.key,
    this.child,
    this.builder,
  }) : assert(
          builder != null || child != null,
          'Either child or builder must be provided, but not both.',
        );

  final Widget? child;
  final DemoStateWidgetBuilder? builder;

  @override
  Widget build(BuildContext context) {
    final content = builder != null
        ? Consumer(
            builder: (context, ref, _) {
              final state = ref.watch(demoProvider);
              return builder!(context, ref, state);
            },
          )
        : child!;

    return content;
  }
}

typedef DemoStateWidgetIdWidgetBuilder = Widget Function(
  BuildContext context,
  WidgetRef ref,
  AsyncValue<DemoId> id,
);

class DemoStateWidgetIdWidget extends StatelessWidget {
  const DemoStateWidgetIdWidget({
    super.key,
    required this.builder,
  });

  final DemoStateWidgetIdWidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final state = ref.watch(
          demoProvider.select((state) => state.whenData((data) => data.id)),
        );
        return builder(context, ref, state);
      },
    );
  }
}

typedef DemoStateWidgetNameWidgetBuilder = Widget Function(
  BuildContext context,
  WidgetRef ref,
  AsyncValue<String?> name,
);

class DemoStateWidgetNameWidget extends StatelessWidget {
  const DemoStateWidgetNameWidget({
    super.key,
    required this.builder,
  });

  final DemoStateWidgetNameWidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final state = ref.watch(
          demoProvider.select((state) => state.whenData((data) => data.name)),
        );
        return builder(context, ref, state);
      },
    );
  }
}

typedef DemoStateWidgetDescriptionWidgetBuilder = Widget Function(
  BuildContext context,
  WidgetRef ref,
  AsyncValue<String?> description,
);

class DemoStateWidgetDescriptionWidget extends StatelessWidget {
  const DemoStateWidgetDescriptionWidget({
    super.key,
    required this.builder,
  });

  final DemoStateWidgetDescriptionWidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final state = ref.watch(
          demoProvider
              .select((state) => state.whenData((data) => data.description)),
        );
        return builder(context, ref, state);
      },
    );
  }
}

typedef DemoStateWidgetAgeWidgetBuilder = Widget Function(
  BuildContext context,
  WidgetRef ref,
  AsyncValue<int> age,
);

class DemoStateWidgetAgeWidget extends StatelessWidget {
  const DemoStateWidgetAgeWidget({
    super.key,
    required this.builder,
  });

  final DemoStateWidgetAgeWidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final state = ref.watch(
          demoProvider.select((state) => state.whenData((data) => data.age)),
        );
        return builder(context, ref, state);
      },
    );
  }
}

typedef DemoStateWidgetAddressWidgetBuilder = Widget Function(
  BuildContext context,
  WidgetRef ref,
  AsyncValue<String?> address,
);

class DemoStateWidgetAddressWidget extends StatelessWidget {
  const DemoStateWidgetAddressWidget({
    super.key,
    required this.builder,
  });

  final DemoStateWidgetAddressWidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final state = ref.watch(
          demoProvider
              .select((state) => state.whenData((data) => data.address)),
        );
        return builder(context, ref, state);
      },
    );
  }
}

typedef DemoStateWidgetOtherWidgetBuilder = Widget Function(
  BuildContext context,
  WidgetRef ref,
  AsyncValue<OtherModel?> other,
);

class DemoStateWidgetOtherWidget extends StatelessWidget {
  const DemoStateWidgetOtherWidget({
    super.key,
    required this.builder,
  });

  final DemoStateWidgetOtherWidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final state = ref.watch(
          demoProvider.select((state) => state.whenData((data) => data.other)),
        );
        return builder(context, ref, state);
      },
    );
  }
}
