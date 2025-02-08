import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:aspectumai/core/resources/illustrations.dart';
import 'package:aspectumai/core/resources/colors.dart';
import 'package:aspectumai/core/utils/extensions/context_ext.dart';
import 'package:aspectumai/core/widgets/app_spacer.dart';
import 'package:aspectumai/core/widgets/app_text_form.dart';
import 'package:flutter_svg/svg.dart';

@RoutePage()
class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomInsets = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: bottomInsets),
        child: const _ChatInput(),
      ),
      floatingActionButton:
          bottomInsets < 1 ? const _SuggestionStarters() : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: AppColors.white),
        elevation: 0,
        shadowColor: Colors.transparent,
        title: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.red,
              ),
            ),
            const AppSpacer.width(14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Math Solver',
                      style: TextStyle(fontSize: 16, color: AppColors.white),
                    ),
                    const AppSpacer.width(8),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(IllustrationConstants.coin,
                              width: 10, height: 10),
                          const AppSpacer.width(4),
                          const Text(
                            '1',
                            style:
                                TextStyle(fontSize: 10, color: AppColors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Row(
                  children: [
                    Text(
                      'See details',
                      style: TextStyle(fontSize: 10, color: AppColors.grey),
                    ),
                    AppSpacer.width(4),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: AppColors.grey,
                      size: 10,
                    ),
                  ],
                )
              ],
            ),
            const Spacer(),
            const Icon(Icons.bookmark_outline, color: AppColors.white),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: AppColors.secondary,
            height: 1.0,
          ),
        ),
      ),
      body: const _ChatBody(),
    );
  }
}

class _ChatBody extends StatelessWidget {
  const _ChatBody();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 10,
            ),
            child: Column(
              children: [
                _AssistantMessage(
                  text:
                      "Hello there! I'm an AI assistant created by OpenAI. I'm here to help you with information, answer your questions, and assist you with various tasks. How can I help you today?",
                ),
                AppSpacer.height(16),
                _UserMessage(text: "What is 1 + 1"),
                AppSpacer.height(16),
                _AssistantMessage(
                  text:
                      "Hello there! I'm an AI assistant created by OpenAI. I'm here to help you with information, answer your questions, and assist you with various tasks. How can I help you today?",
                ),
                // AppSpacer.height(16),
                // UserMessage(text: "What is 1 + 1"),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _AssistantMessage extends StatelessWidget {
  final String text;
  const _AssistantMessage({required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
            ),
          ),
          const AppSpacer.width(6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(text, style: const TextStyle(color: Colors.white)),
                const AppSpacer.height(8),
                const Icon(Icons.copy, color: AppColors.grey, size: 14),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _UserMessage extends StatelessWidget {
  final String text;
  const _UserMessage({required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: SizedBox(
        width: context.screenWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 18,
              ),
              decoration: const BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    text,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 14,
                    ),
                  ),
                  const AppSpacer.height(10),
                  Container(
                    width: context.screenWidth * 0.7,
                    height: 200,
                    decoration: BoxDecoration(
                      color: AppColors.grey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
            ),
            const AppSpacer.width(6),
            Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatInput extends StatelessWidget {
  const _ChatInput();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(
        right: 20,
        left: 20,
        bottom: 20,
      ),
      child: AppTextForm(
        hint: 'Ask anything..',
        prefixIcon: Icon(Icons.add_photo_alternate, color: AppColors.white),
        suffixIcon: Icon(Icons.send, color: AppColors.white),
      ),
    );
  }
}

class _SuggestionStarters extends StatelessWidget {
  const _SuggestionStarters();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Row(
        children: List.generate(2, (index) {
          return Expanded(
            child: Container(
              margin: EdgeInsets.only(
                right: index == 0 ? 10 : 0,
                left: index == 1 ? 10 : 0,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.secondary),
                color: AppColors.primary,
              ),
              child: const Text(
                'What Can you do?',
                style: TextStyle(fontSize: 14),
              ),
            ),
          );
        }),
      ),
    );
  }
}
