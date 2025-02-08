import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:aspectumai/core/app_route.gr.dart';
import 'package:aspectumai/core/resources/colors.dart';
import 'package:aspectumai/core/resources/images.dart';
import 'package:aspectumai/core/utils/extensions/context_ext.dart';
import 'package:aspectumai/core/widgets/app_button.dart';
import 'package:aspectumai/core/widgets/app_spacer.dart';
import 'package:aspectumai/core/widgets/app_text_form.dart';

@RoutePage()
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 219,
              width: context.screenWidth,
              child: Stack(
                children: [
                  Container(
                    width: context.screenWidth,
                    height: double.infinity,
                    color: AppColors.primary,
                  ),
                  Image.asset(
                    ImageConstants.authBg,
                    width: context.screenWidth,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),

                  /// content
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 24,
                        right: 40,
                        bottom: 40,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () => context.router.maybePop(),
                            child: const Icon(
                              Icons.arrow_back_sharp,
                              color: AppColors.white,
                            ),
                          ),
                          const AppSpacer.height(24),
                          const Text(
                            'Register',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 32,
                            ),
                          ),
                          const AppSpacer.height(12),
                          GestureDetector(
                            onTap: () {
                              context.router.replaceAll([const LoginRoute()]);
                            },
                            child: const Text.rich(
                              TextSpan(
                                text: "Already have an account?",
                                children: [
                                  TextSpan(
                                    text: ' Sign in',
                                    style: TextStyle(
                                      color: AppColors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              ),
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// form
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const AppTextForm(
                    label: 'Full name',
                    hint: 'Enter your email',
                    type: AppTextFormType.outlined,
                    backgroundColor: AppColors.white,
                  ),
                  const AppSpacer.height(16),
                  const AppTextForm(
                    label: 'Username',
                    hint: 'Enter your password',
                    type: AppTextFormType.outlined,
                    backgroundColor: AppColors.white,
                  ),
                  const AppSpacer.height(16),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(
                        color: AppColors.blue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const AppSpacer.height(32),
                  AppButton(
                    text: 'Register',
                    onPressed: () {},
                    width: context.screenWidth,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
