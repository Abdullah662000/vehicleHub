import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vehiclehub_pakistan/core/theme/app_colors.dart';
import 'package:vehiclehub_pakistan/l10n/app_strings.dart';
import 'package:vehiclehub_pakistan/providers/providers.dart';
import 'package:vehiclehub_pakistan/shared/widgets/vh_button.dart';
import 'package:vehiclehub_pakistan/shared/widgets/vh_text_field.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    await ref.read(authStateProvider.notifier).login(
          email: _emailCtrl.text.trim(),
          password: _passwordCtrl.text,
        );
    if (!mounted) return;
    setState(() => _loading = false);
    final auth = ref.read(authStateProvider);
    if (auth.errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(auth.errorMessage!)),
      );
      return;
    }
    final phone = auth.user?.phone;
    if (phone != null && phone.isNotEmpty) {
      context.push('/otp', extra: phone);
    } else {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = ref.watch(localeProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Text(
                  tr('welcomeBack', lang),
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  tr('loginSubtitle', lang),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondary,
                      ),
                ),
                const SizedBox(height: 32),
                VhTextField(
                  label: tr('email', lang),
                  controller: _emailCtrl,
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                VhTextField(
                  label: tr('password', lang),
                  controller: _passwordCtrl,
                  prefixIcon: Icons.lock_outline,
                  obscureText: true,
                  validator: (v) =>
                      v == null || v.length < 6 ? 'Min 6 chars' : null,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(tr('forgotPassword', lang)),
                  ),
                ),
                const SizedBox(height: 8),
                VhButton(
                  label: tr('login', lang),
                  onPressed: _loading ? null : () => _login(),
                  loading: _loading,
                  fullWidth: true,
                  size: VhButtonSize.lg,
                ),
                const SizedBox(height: 24),
                Center(
                  child: Text(
                    tr('orContinue', lang),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                const SizedBox(height: 16),
                VhButton(
                  label: tr('continueGoogle', lang),
                  variant: VhButtonVariant.outline,
                  icon: Icons.g_mobiledata,
                  onPressed: () {},
                  fullWidth: true,
                ),
                const SizedBox(height: 12),
                VhButton(
                  label: tr('continueApple', lang),
                  variant: VhButtonVariant.outline,
                  icon: Icons.apple,
                  onPressed: () {},
                  fullWidth: true,
                ),
                const SizedBox(height: 12),
                VhButton(
                  label: tr('phoneLogin', lang),
                  variant: VhButtonVariant.soft,
                  icon: Icons.phone_outlined,
                  onPressed: () => context.push('/otp'),
                  fullWidth: true,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(tr('noAccount', lang)),
                    TextButton(
                      onPressed: () => context.push('/signup'),
                      child: Text(tr('signup', lang)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
