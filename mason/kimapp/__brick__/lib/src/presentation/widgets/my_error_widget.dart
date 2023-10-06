
import '../../../exports.dart';

class MyErrorWidget extends StatelessWidget {
  const MyErrorWidget({Key? key, required this.error}) : super(key: key);
  final Object? error;

  @override
  Widget build(BuildContext context) {
    String message = error.toString();
    if (error is Failure) {
      final failure = error as Failure;
      message = failure.message();
    }

    return Text(message);
  }
}
