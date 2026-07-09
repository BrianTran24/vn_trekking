import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Lớp tiện ích cung cấp các hiệu ứng chuyển trang tối ưu cho Web
class WebTransitions {
  /// Hiệu ứng FadeTransition (Mờ dần) - Rất phổ biến trên Web
  static CustomTransitionPage<T> fade<T>({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionDuration: const Duration(milliseconds: 200),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
          child: child,
        );
      },
    );
  }

  /// Không có hiệu ứng (Tức thời) - Giống hành vi của các website truyền thống
  static NoTransitionPage<T> none<T>({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
  }) {
    return NoTransitionPage<T>(
      key: state.pageKey,
      child: child,
    );
  }
}
