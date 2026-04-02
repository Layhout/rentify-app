import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rentify_app/common_widgets/theme/app_constants.dart';
import 'package:rentify_app/common_widgets/theme/theme_extensions.dart';
import 'package:rentify_app/routing/routes.dart';

class OnboardScreen extends StatelessWidget {
  const OnboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          Column(
                children: [
                  Column(
                    children: [
                      Text(
                        "Rentify",
                        style: context.textTheme.bodyLarge?.copyWith(letterSpacing: AppConstants.spacingXS),
                      ),
                      context.gapXXL,
                      Text("Borrow anything.", style: context.textTheme.displayLarge, textAlign: TextAlign.center),
                      Text(
                        "Lend with confidence.",
                        style: context.textTheme.displayLarge?.copyWith(
                          color: context.colorScheme.primary,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      context.gapXXL,
                      Text(
                        "The marketplace for renting things and services from prople nearby",
                        style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.outline),
                        textAlign: TextAlign.center,
                      ).paddingSymmetric(horizontal: AppConstants.spacingXXL),
                    ],
                  ).expanded(),
                  FilledButton(
                    onPressed: () {
                      SignupRoute().push(context);
                    },
                    child: Text("Get Started"),
                  ).size(width: double.infinity),
                  context.gapLG,
                  InkWell(
                    onTap: () {
                      LoginRoute().push(context);
                    },
                    child: Text(
                      "I already have an account",
                      style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.primary),
                    ),
                  ),
                  context.gapXXL,
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: "BY CONTINUING, YOU AGREE TO OUR "),
                        TextSpan(
                          text: "TERMS ",
                          style: context.textTheme.labelSmall?.copyWith(
                            color: context.colorScheme.primary,
                            letterSpacing: 2,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                        TextSpan(text: "& "),
                        TextSpan(
                          text: "PRIVACY POLICY",
                          style: context.textTheme.labelSmall?.copyWith(
                            color: context.colorScheme.primary,
                            letterSpacing: 2,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                    style: context.textTheme.labelSmall?.copyWith(color: context.colorScheme.outline, letterSpacing: 2),
                  ).paddingSymmetric(horizontal: AppConstants.spacingXXL),
                ],
              )
              .paddingOnly(
                left: AppConstants.spacingMD,
                right: AppConstants.spacingMD,
                top: AppConstants.spacingXXL,
                bottom: AppConstants.spacingMD,
              )
              .size(width: double.infinity, height: double.infinity)
              .safeArea(),
    );
  }
}
