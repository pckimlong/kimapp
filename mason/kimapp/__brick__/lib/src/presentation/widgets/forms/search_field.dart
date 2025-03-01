import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app_text_form_field.dart';

class SearchField extends HookConsumerWidget {
  const SearchField({
    super.key,
    required this.onChanged,
    this.maxWidth = 400,
    this.placeholder = 'Search...',
    this.debounceDuration = 250,
    this.alignment = Alignment.centerLeft,
    this.builder,
    this.autofocus = false,
    this.initialValue,
  });

  final String? initialValue;
  final void Function(String) onChanged;
  final double maxWidth;
  final String placeholder;
  final int? debounceDuration;
  final Alignment alignment;
  final bool autofocus;

  final Widget Function(
    BuildContext context,
    TextEditingController controller,
    VoidCallback? clear,
  )? builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ctr = useTextEditingController(text: initialValue);
    final showClear = useState(false);

    useMemoized(() {
      ctr.addListener(() {
        EasyDebounce.debounce(
          'search_field_${key.hashCode}',
          Duration(milliseconds: debounceDuration ?? 0),
          () {
            onChanged(ctr.text);
          },
        );
        if (ctr.text.isEmpty && showClear.value) {
          showClear.value = false;
        } else {
          showClear.value = ctr.text.isNotEmpty;
        }
      });
      return null;
    });

    if (builder != null) {
      return builder!(context, ctr, showClear.value ? ctr.clear : null);
    }

    return Align(
      alignment: alignment,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: AppTextFormField(
          textCapitalization: TextCapitalization.none,
          autofocus: autofocus,
          controller: ctr,
          leading: const Icon(Icons.search),
          trailing: showClear.value
              ? IconButton(
                  onPressed: () {
                    ctr.clear();
                  },
                  icon: const Icon(Icons.close),
                )
              : null,
          hintText: placeholder,
        ),
      ),
    );
  }
}
