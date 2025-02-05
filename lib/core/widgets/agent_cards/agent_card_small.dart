import 'package:flutter/material.dart';
import 'package:flutter_gemini_ai/core/resources/colors.dart';
import 'package:flutter_gemini_ai/core/widgets/app_spacer.dart';

class AgentCardSmall extends StatelessWidget {
  final String title, category, description, imageUrl;

  const AgentCardSmall({
    super.key,
    required this.title,
    required this.category,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 86,
      width: 330,
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Container(
            height: double.infinity,
            width: 60,
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
                Text(
                  description,
                  style: const TextStyle(fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
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
                          style: TextStyle(fontSize: 12, color: AppColors.grey),
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
                          style: TextStyle(fontSize: 12, color: AppColors.grey),
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
    );
  }
}
