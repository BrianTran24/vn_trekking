import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WebNavBar extends StatelessWidget {
  const WebNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.05 * 255).toInt()),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Logo
          InkWell(
            onTap: () => context.go('/'),
            child: Row(
              children: [
                Icon(Icons.terrain, color: Colors.green.shade700, size: 32),
                const SizedBox(width: 10),
                Text(
                  'VN TREKKING',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade700,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          // Menu Items
          _NavBarItem(
            title: 'Trang chủ',
            onTap: () => context.go('/'),
            isActive: GoRouterState.of(context).matchedLocation == '/',
          ),
          _NavBarItem(
            title: 'Cung đường',
            onTap: () => context.go('/trails'),
            isActive: GoRouterState.of(context).matchedLocation == '/trails',
          ),
          _NavBarItem(
            title: 'Về chúng tôi',
            onTap: () {},
          ),
          const SizedBox(width: 20),
          ElevatedButton(
            onPressed: () => context.go('/login'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade700,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Tham gia ngay'),
          ),
        ],
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool isActive;

  const _NavBarItem({
    required this.title,
    required this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                color: isActive ? Colors.green.shade700 : Colors.black87,
              ),
            ),
            if (isActive)
              Container(
                margin: const EdgeInsets.only(top: 4),
                height: 2,
                width: 20,
                color: Colors.green.shade700,
              ),
          ],
        ),
      ),
    );
  }
}
