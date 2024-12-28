import '../../../exports.dart';
import 'my_error_widget.dart';

class FailureWidget extends ConsumerWidget {
  const FailureWidget({
    super.key,
    required this.failure,
    this.topPadding = 16,
    this.fontSize = 14,
  });

  final Object? failure;
  final double topPadding;
  final double fontSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (failure == null) return const SizedBox.shrink();

    String message;
    if (failure is Failure) {
      message = (failure as Failure).message();
    } else {
      message = failure.toString();
    }

    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: MyErrorWidget(error: message, fontSize: fontSize),
    );
  }
}
