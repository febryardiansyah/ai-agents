import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini_ai/core/app_route.gr.dart';
import 'package:flutter_gemini_ai/core/resources/colors.dart';
import 'package:flutter_gemini_ai/core/widgets/app_spacer.dart';

class AgentsCardLarge extends StatelessWidget {
  final String title, category, description, imageUrl;

  const AgentsCardLarge({
    super.key,
    required this.title,
    required this.category,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final router = context.router;

    return GestureDetector(
      onTap: () {
        router.push(const ChatRoute());
      },
      child: Container(
        height: 151,
        width: 330,
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              height: double.infinity,
              width: 95,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.grey,
              ),
            ),
            const AppSpacer.width(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const AppSpacer.height(8),
                  if (category.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xff8CC0DE),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        category,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  const AppSpacer.height(6),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const Spacer(),
                  const Row(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.bookmark, size: 16, color: AppColors.grey),
                          SizedBox(width: 4),
                          Text(
                            "40",
                            style:
                                TextStyle(fontSize: 12, color: AppColors.grey),
                          ),
                        ],
                      ),
                      AppSpacer.width(10),
                      Row(
                        children: [
                          Icon(Icons.chat, size: 16, color: AppColors.grey),
                          SizedBox(width: 4),
                          Text(
                            "40",
                            style:
                                TextStyle(fontSize: 12, color: AppColors.grey),
                          ),
                        ],
                      ),
                    ],
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
