import '../../../exports.dart';

class MyErrorWidget extends StatelessWidget {
  const MyErrorWidget({super.key, required this.error, this.fontSize});
  final Object? error;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    String message = error.toString();
    if (error is Failure) {
      final failure = error as Failure;
      message = failure.message();
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AS.redColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            Icons.error_outline,
            color: context.colors.error,
            size: 18,
          ),
          AS.wGap4,
          Flexible(
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: context.colors.error,
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
