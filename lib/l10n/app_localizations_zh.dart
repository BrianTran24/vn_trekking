// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'VN Trekking';

  @override
  String get loginWithGoogle => '使用 Google 登录';

  @override
  String get loginWithFacebook => '使用 Facebook 登录';

  @override
  String get loginWithApple => '使用 Apple 登录';

  @override
  String get welcomeMessage => '欢迎来到 VN Trekking！';
}
