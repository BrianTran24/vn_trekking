import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  final String label;
  final Widget icon;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final BorderSide? side;

  const SocialLoginButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.side,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: icon,
      ),
      label: Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      style: OutlinedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor ?? Colors.black87,
        side: side ?? BorderSide(color: Colors.grey.shade300),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        minimumSize: const Size(double.infinity, 48),
      ),
    );
  }
}
