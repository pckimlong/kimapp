import 'dart:html';

import '../../../../exports.dart';

class SplashWidget extends StatelessWidget {
  const SplashWidget({
    super.key,
    this.loadedInMain = false,
    this.appVersion,
    this.error,
  });

  final bool loadedInMain;
  final String? appVersion;
  final String? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FadeIn(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'កំពុងដំណើរការ...',
                style: TextStyle(
                  fontSize: 28,
                ),
              ),
              AS.hGap8,
              const SizedBox(
                width: 200,
                child: LinearProgressIndicator(
                  color: Colors.black,
                ),
              ),
              AS.hGap8,
              Text(appVersion ?? ""),
              if (error != null && !loadedInMain) ...[
                const SizedBox(height: 16),
                Text(error),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
