import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../application/auth/auth_bloc.dart';
import '../../l10n/app_localizations.dart';
import '../widgets/social_login_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            context.go('/');
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.red),
            );
          }
        },
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth > 700;
                return Container(
                  constraints: BoxConstraints(maxWidth: isWide ? 900 : 450),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha((0.05 * 255).toInt()),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isWide ? 40 : 24,
                      vertical: isWide ? 40 : 32,
                    ),
                    child: isWide
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 4,
                                child: _LogoSection(isWide: true),
                              ),
                              Container(
                                width: 1,
                                height: 400,
                                margin: const EdgeInsets.symmetric(horizontal: 40),
                                color: Colors.grey.shade100,
                              ),
                              Expanded(
                                flex: 6,
                                child: _LoginForm(
                                  emailController: _emailController,
                                  passwordController: _passwordController,
                                  isWide: true,
                                ),
                              ),
                            ],
                          )
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _LogoSection(isWide: false),
                              const SizedBox(height: 32),
                              _LoginForm(
                                emailController: _emailController,
                                passwordController: _passwordController,
                                isWide: false,
                              ),
                            ],
                          ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _LogoSection extends StatelessWidget {
  final bool isWide;
  const _LogoSection({required this.isWide});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.terrain_rounded,
            size: isWide ? 64 : 48,
            color: Colors.green.shade700,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          AppLocalizations.of(context)!.appTitle.toUpperCase(),
          style: TextStyle(
            fontSize: isWide ? 32 : 28,
            fontWeight: FontWeight.bold,
            color: Colors.green.shade800,
            letterSpacing: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          AppLocalizations.of(context)!.welcomeMessage,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey.shade600,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _LoginForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isWide;

  const _LoginForm({
    required this.emailController,
    required this.passwordController,
    required this.isWide,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          controller: emailController,
          decoration: InputDecoration(
            labelText: 'Email',
            prefixIcon: const Icon(Icons.email_outlined),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Mật khẩu',
            prefixIcon: const Icon(Icons.lock_outline),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            child: Text(
              'Quên mật khẩu?',
              style: TextStyle(color: Colors.green.shade700),
            ),
          ),
        ),
        const SizedBox(height: 24),
        BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return ElevatedButton(
              onPressed: state is AuthLoading
                  ? null
                  : () {
                      context.read<AuthBloc>().add(
                            LoginRequested(
                              emailController.text,
                              passwordController.text,
                            ),
                          );
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade700,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: state is AuthLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text(
                      'Đăng nhập',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            );
          },
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(child: Divider(color: Colors.grey.shade300)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Hoặc',
                style: TextStyle(color: Colors.grey.shade500),
              ),
            ),
            Expanded(child: Divider(color: Colors.grey.shade300)),
          ],
        ),
        const SizedBox(height: 24),
        SocialLoginButton(
          label: AppLocalizations.of(context)!.loginWithGoogle,
          icon: Image.asset(
            'assets/icons/logo_google.png',
            height: 24,
          ),
          onPressed: () {
            context.read<AuthBloc>().add(GoogleLoginRequested());
          },
        ),
        const SizedBox(height: 12),
        SocialLoginButton(
          label: AppLocalizations.of(context)!.loginWithApple,
          icon: const Icon(Icons.apple, size: 28),
          onPressed: () {
            context.read<AuthBloc>().add(AppleLoginRequested());
          },
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Chưa có tài khoản? ',
              style: TextStyle(color: Colors.grey.shade600),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Đăng ký ngay',
                style: TextStyle(
                  color: Colors.green.shade700,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
