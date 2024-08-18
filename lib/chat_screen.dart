import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini_ai/bloc/chat_bloc.dart';
import 'package:flutter_gemini_ai/chat_model.dart';
import 'package:flutter_gemini_ai/utils.dart';
import 'package:flutter_gemini_ai/bloc/image_picker_cubit.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final scrollCtrl = ScrollController();
  final textController = TextEditingController();
  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.grey.shade900,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ));

    focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey.shade900,
      floatingActionButton: chatTextField(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: BlocListener<ImagePickerCubit, ImagePickerState>(
        listener: (context, state) {
          if (state.status == BlocStatus.loading) {
            showLoadingDialog(context);
          }
          if (state.status == BlocStatus.error) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
          if (state.status == BlocStatus.loaded) {
            Navigator.pop(context);
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: kBottomNavigationBarHeight),
            child: BlocBuilder<ChatBloc, List<ChatModel>>(
              builder: (context, state) {
                if (state.isEmpty) {
                  return const Center(
                    child: Text(
                      'There are no messages yet, start chatting!',
                      // style: TextStyle(color: Colors.white),
                    ),
                  );
                }

                return ListView.builder(
                  controller: scrollCtrl,
                  padding: const EdgeInsets.all(20),
                  itemCount: state.length,
                  itemBuilder: (context, index) {
                    final message = state[index];

                    return Padding(
                      padding: EdgeInsets.only(bottom: message.isUser ? 0 : 32),
                      child: ChatWidget(chatData: message),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollCtrl.animateTo(
        scrollCtrl.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  void sendMessage(String message, [List<String> imagePath = const []]) async {
    textController.clear();
    if (imagePath.isNotEmpty) {
      context
          .read<ChatBloc>()
          .add(StartImageChatEvent(message: message, imagePaths: imagePath));
    } else {
      context.read<ChatBloc>().add(StartChatEvent(message: message));
    }
    clearImage();
    scrollToBottom();
  }

  void clearImage() => context.read<ImagePickerCubit>().clearImage();

  Widget chatTextField() {
    return BlocBuilder<ImagePickerCubit, ImagePickerState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(8),
          color: Colors.white,
          child: Builder(builder: (context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (state.status == BlocStatus.loaded &&
                    state.imagePaths.isNotEmpty) ...[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: state.imagePaths.map((path) {
                        return Stack(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade800,
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: FileImage(File(path)),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 4,
                              right: 4,
                              child: GestureDetector(
                                onTap: clearImage,
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
                TextFormField(
                  focusNode: focusNode,
                  controller: textController,
                  // maxLines: 4,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  textInputAction: TextInputAction.send,
                  onFieldSubmitted: (value) {
                    sendMessage(
                      textController.text,
                      state.status == BlocStatus.loaded ? state.imagePaths : [],
                    );
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter a prompt here',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    // filled: true,
                    // fillColor: focusNode.hasFocus
                    //     ? Colors.grey.shade400
                    //     : Colors.grey.shade700,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                    suffixIcon: GestureDetector(
                      child: const Icon(Icons.send),
                      onTap: () {
                        focusNode.unfocus();
                        sendMessage(
                          textController.text,
                          state.status == BlocStatus.loaded
                              ? state.imagePaths
                              : [],
                        );
                      },
                    ),
                    prefixIcon: GestureDetector(
                      child: const Icon(Icons.add_photo_alternate_outlined),
                      onTap: () {
                        context.read<ImagePickerCubit>().pickImage();
                      },
                    ),
                  ),
                ),
              ],
            );
          }),
        );
      },
    );
  }
}

class ChatWidget extends StatelessWidget {
  final ChatModel chatData;

  const ChatWidget({super.key, required this.chatData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (chatData.isUser) ...[
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey.shade800,
                      maxRadius: 16,
                      child: const Icon(Icons.person, color: Colors.white70),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        chatData.text,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                if (chatData.imagePaths.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: chatData.imagePaths.map((e) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(File(e), height: 100),
                      );
                    }).toList(),
                  ),
                ],
              ],
            ),
          ),
        ],
        const SizedBox(height: 8),
        if (!chatData.isUser) ...[
          Image.asset(GEMINI_ICON, height: 24, width: 24),
          const SizedBox(height: 8),
          if (chatData.isLoading)
            const Center(child: CircularProgressIndicator())
          else ...[
            MarkdownBody(
              data: chatData.text,
              onTapLink: (text, href, title) {
                print('text: $text, href: $href, title: $title');
              },
              selectable: true,
              styleSheetTheme: MarkdownStyleSheetBaseTheme.material,
              styleSheet: MarkdownStyleSheet(
                  // p: const TextStyle(color: Colors.white),
                  // h1: const TextStyle(color: Colors.white),
                  // h2: const TextStyle(color: Colors.white),
                  // h3: const TextStyle(color: Colors.white),
                  ),
            )
          ],
        ]
      ],
    );
  }
}
