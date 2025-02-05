import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gemini_ai/core/resources/colors.dart';
import 'package:flutter_gemini_ai/core/resources/illustrations.dart';
import 'package:flutter_gemini_ai/core/resources/images.dart';
import 'package:flutter_gemini_ai/core/utils/extensions/context_ext.dart';
import 'package:flutter_gemini_ai/core/widgets/app_button.dart';
import 'package:flutter_gemini_ai/core/widgets/app_spacer.dart';
import 'package:flutter_gemini_ai/core/widgets/app_text_form.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// header
            SizedBox(
              height: 263,
              width: context.screenSize.width,
              child: Stack(
                children: [
                  Container(
                    width: context.screenSize.width,
                    height: double.infinity,
                    color: AppColors.primary,
                  ),
                  Image.asset(
                    ImageConstants.authBg,
                    width: context.screenSize.width,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  const Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 24,
                        right: 40,
                        bottom: 40,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Sign in to your Account',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 32,
                            ),
                          ),
                          AppSpacer.height(12),
                          Text.rich(
                            TextSpan(
                              text: "Don't have an account?",
                              children: [
                                TextSpan(
                                  text: ' Sign up',
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
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// main form
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const AppTextForm(
                    label: 'Email',
                    hint: 'Enter your email',
                    type: AppTextFormType.outlined,
                    backgroundColor: AppColors.white,
                  ),
                  const AppSpacer.height(16),
                  const AppTextForm(
                    label: 'Password',
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
                    text: 'Log in',
                    onPressed: () {},
                    width: context.screenSize.width,
                  ),
                  const AppSpacer.height(24),
                  const Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: AppColors.stroke,
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Or login with',
                          style: TextStyle(
                            color: AppColors.darkGrey,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: AppColors.stroke,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                  const AppSpacer.height(16),
                  AppButton(
                    onPressed: () {},
                    width: context.screenSize.width,
                    type: AppButtonType.outlined,
                    body: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          IllustrationConstants.google,
                          width: 24,
                          height: 24,
                        ),
                        const AppSpacer.width(10),
                        const Text(
                          'Google',
                          style: TextStyle(
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
