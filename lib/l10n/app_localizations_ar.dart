// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'VN Trekking';

  @override
  String get loginWithGoogle => 'تسجيل الدخول باستخدام Google';

  @override
  String get loginWithFacebook => 'تسجيل الدخول باستخدام Facebook';

  @override
  String get loginWithApple => 'تسجيل الدخول باستخدام Apple';

  @override
  String get welcomeMessage => 'مرحبًا بك في VN Trekking!';
}
