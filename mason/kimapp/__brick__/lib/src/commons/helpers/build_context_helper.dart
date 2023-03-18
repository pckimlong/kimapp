// Package imports:
import 'package:responsive_framework/responsive_wrapper.dart';

// Project imports:
import '../../../exports.dart';

extension BuildContextHelper on BuildContext {
  ResponsiveWrapperData get responsive => ResponsiveWrapper.of(this);

  bool get isMobile => responsive.isMobile || responsive.isSmallerThan(MOBILE);

  bool get isTable =>
      (responsive.isLargerThan(MOBILE) && responsive.isSmallerThan(DESKTOP)) || responsive.isTablet;

  bool get isDesktop => responsive.isLargerThan(TABLET) || responsive.isDesktop;
}
