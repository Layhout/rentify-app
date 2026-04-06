import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rentify_app/common_widgets/theme/app_constants.dart';
import 'package:rentify_app/common_widgets/theme/theme_extensions.dart';
import 'package:rentify_app/constants/assets.dart';
import 'package:rentify_app/features/authentication/provider/login_view_model.dart';
import 'package:rentify_app/routing/routes.dart';
import 'package:rentify_app/utils/form/validation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
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
    ref.listen(loginViewModelProvider, (previous, next) {
      if (previous == next) return;

      if (next.hasError && next.error is AuthException) {
        final error = next.error as AuthException;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.message)));
      }
    });

    final state = ref.watch(loginViewModelProvider);
    final vm = ref.read(loginViewModelProvider.notifier);

    String? errorTxt;

    if (state.hasError && state.error is AuthApiException) {
      final error = state.error as AuthApiException;
      errorTxt = error.statusCode == "400" ? "Invalid email or password" : null;
    }

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          padding: context.paddingOnly(
            left: AppConstants.spacingMD,
            right: AppConstants.spacingMD,
            top: AppConstants.spacingXXL,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Welcome back", style: context.textTheme.displayMedium),
              context.gapSM,
              Text(
                "Everything you need for renting, in one place",
                style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.outline),
              ),
              context.gapXXL,
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(labelText: "Email"),
                      validator: validateEmail,
                    ),
                    context.gapLG,
                    TextFormField(
                      obscureText: true,
                      controller: _passwordController,
                      decoration: InputDecoration(labelText: "Password"),
                      forceErrorText: errorTxt,
                      onChanged: (_) {
                        if (state.hasError) {
                          vm.clearError();
                        }
                      },
                    ),
                    context.gapMD,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Text(
                            "Forgot Password",
                            style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.primary),
                          ),
                        ),
                      ],
                    ),
                    context.gapLG,
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {
                          if (state.isLoading) return;
                          if (!_formKey.currentState!.validate()) return;
                          vm.loginWithEmailAndPassword(_emailController.text, _passwordController.text);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (state.isLoading)
                              CircularProgressIndicator()
                                  .size(width: 16, height: 16)
                                  .paddingOnly(right: AppConstants.spacingSM),
                            Text("Login"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              context.gapXXL,
              Row(
                children: [
                  Divider().expanded(),
                  Text(
                    "OR CONTINUE WITH",
                    style: context.textTheme.labelMedium,
                  ).paddingSymmetric(horizontal: AppConstants.spacingMD),
                  Divider().expanded(),
                ],
              ),
              context.gapXXL,
              OutlinedButton(
                onPressed: () async {
                  await vm.loginWithGoogle();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(Assets.googleLogo).size(width: 20, height: 20),
                    context.gapSM,
                    Text("Sign in with Google"),
                  ],
                ),
              ),
              context.gap(AppConstants.spacingXXL * 2),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: "Don't have an account? "),
                    TextSpan(
                      text: "Sign Up",
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.push(Routes.signup);
                        },
                      style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.primary),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ).size(width: double.infinity),
            ],
          ),
        ).safeArea(),
      ),
    );
  }
}
