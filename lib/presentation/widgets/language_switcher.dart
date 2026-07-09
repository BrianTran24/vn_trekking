import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../application/locale/locale_bloc.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleBloc, LocaleState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<Locale>(
              value: state.locale,
              icon: Icon(Icons.keyboard_arrow_down_rounded, 
                  size: 18, color: Colors.grey.shade600),
              elevation: 8,
              style: TextStyle(
                color: Colors.grey.shade800,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              onChanged: (Locale? newLocale) {
                if (newLocale != null) {
                  context.read<LocaleBloc>().add(ChangeLocale(newLocale));
                }
              },
              items: _getSupportedLocales().map((localeInfo) {
                return DropdownMenuItem<Locale>(
                  value: localeInfo.locale,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        localeInfo.flag,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 8),
                      Text(localeInfo.name),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  List<_LocaleInfo> _getSupportedLocales() {
    return [
      _LocaleInfo(const Locale('vi'), 'VN', 'Tiếng Việt'),
      _LocaleInfo(const Locale('en'), 'US', 'English'),
      _LocaleInfo(const Locale('zh'), 'CN', '中文'),
      _LocaleInfo(const Locale('hi'), 'IN', 'हिन्दी'),
      _LocaleInfo(const Locale('es'), 'ES', 'Español'),
      _LocaleInfo(const Locale('fr'), 'FR', 'Français'),
      _LocaleInfo(const Locale('ar'), 'SA', 'العربية'),
    ];
  }
}

class _LocaleInfo {
  final Locale locale;
  final String flag;
  final String name;

  _LocaleInfo(this.locale, String countryCode, this.name)
      : flag = countryCode.toUpperCase().replaceAllMapped(
            RegExp(r'[A-Z]'),
            (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));
}
