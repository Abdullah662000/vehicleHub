import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vehiclehub_pakistan/core/theme/app_colors.dart';
import 'package:vehiclehub_pakistan/l10n/app_strings.dart';
import 'package:vehiclehub_pakistan/providers/providers.dart';
import 'package:vehiclehub_pakistan/shared/widgets/vh_button.dart';
import 'package:vehiclehub_pakistan/shared/widgets/vh_text_field.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _signup() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    await ref.read(authStateProvider.notifier).signup(
          fullName: _nameCtrl.text,
          email: _emailCtrl.text,
          password: _passwordCtrl.text,
          phone: _phoneCtrl.text,
        );
    if (mounted) {
      setState(() => _loading = false);
      context.push('/otp', extra: _phoneCtrl.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = ref.watch(localeProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.pop()),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tr('createAccount', lang),
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  tr('signupSubtitle', lang),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondary,
                      ),
                ),
                const SizedBox(height: 32),
                VhTextField(
                  label: tr('fullName', lang),
                  controller: _nameCtrl,
                  prefixIcon: Icons.person_outline,
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 16),
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
                  label: tr('phone', lang),
                  controller: _phoneCtrl,
                  prefixIcon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
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
                const SizedBox(height: 24),
                VhButton(
                  label: tr('signup', lang),
                  onPressed: _signup,
                  loading: _loading,
                  fullWidth: true,
                  size: VhButtonSize.lg,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(tr('hasAccount', lang)),
                    TextButton(
                      onPressed: () => context.pop(),
                      child: Text(tr('login', lang)),
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
