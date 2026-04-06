import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rentify_app/common_widgets/theme/app_constants.dart';
import 'package:rentify_app/common_widgets/theme/theme_extensions.dart';
import 'package:rentify_app/constants/assets.dart';
import 'package:rentify_app/features/authentication/provider/signup_view_model.dart';
import 'package:rentify_app/routing/routes.dart';
import 'package:rentify_app/utils/form/validation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _signInRecognizer = TapGestureRecognizer();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _signInRecognizer.dispose();
    super.dispose();
  }

  void handleSignup() async {
    final state = ref.watch(signupViewModelProvider);
    final vm = ref.read(signupViewModelProvider.notifier);

    if (state.isLoading) return;
    if (!_formKey.currentState!.validate()) return;
    final router = GoRouter.of(context);
    final isSuccess = await vm.signupWithEmailAndPassword(_emailController.text, _passwordController.text);
    if (!mounted) return;
    if (isSuccess) {
      router.go(Routes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(signupViewModelProvider);
    final vm = ref.read(signupViewModelProvider.notifier); //AuthException

    String? errorTxt;

    if (state.hasError && state.error is AuthException) {
      final error = state.error as AuthApiException;
      errorTxt = error.message;
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
              Text("Create your account", style: context.textTheme.displayMedium),
              context.gapSM,
              Text(
                "Take less than a minute.",
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
                      forceErrorText: errorTxt,
                      onChanged: (_) {
                        if (state.hasError) {
                          vm.clearError();
                        }
                      },
                    ),
                    context.gapLG,
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(labelText: "Password"),
                      obscureText: true,
                      validator: validatePassword,
                    ),
                    context.gapLG,
                    TextFormField(
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(labelText: "Confirm Password"),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Please confirm your password';
                        if (value != _passwordController.text) return 'Passwords do not match';
                        return null;
                      },
                    ),
                    context.gapXXL,
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: handleSignup,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (state.isLoading)
                              CircularProgressIndicator()
                                  .size(width: 16, height: 16)
                                  .paddingOnly(right: AppConstants.spacingSM),
                            Text("Sign up"),
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
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(Assets.googleLogo).size(width: 20, height: 20),
                    context.gapSM,
                    Text("Sign up with Google"),
                  ],
                ),
              ),
              context.gap(AppConstants.spacingXXL * 2),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: "Already have an account? "),
                    TextSpan(
                      text: "Sign In",
                      recognizer: _signInRecognizer
                        ..onTap = () {
                          context.push(Routes.login);
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
