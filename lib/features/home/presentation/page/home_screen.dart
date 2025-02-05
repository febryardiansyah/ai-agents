import 'package:flutter/material.dart';
import 'package:flutter_gemini_ai/core/resources/colors.dart';
import 'package:flutter_gemini_ai/core/widgets/agent_cards/agent_card_large.dart';
import 'package:flutter_gemini_ai/core/widgets/agent_cards/agent_card_small.dart';
import 'package:flutter_gemini_ai/core/widgets/app_spacer.dart';
import 'package:flutter_gemini_ai/core/widgets/label.dart';
import 'package:flutter_gemini_ai/core/widgets/section_header.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// header
            const AppSpacer.height(kToolbarHeight),
            const Row(
              children: [
                CircleAvatar(
                    // backgroundImage: NetworkImage(
                    //   "https://via.placeholder.com/150",
                    // ),
                    ),
                AppSpacer.width(8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome, Febry Ardiansyah",
                      style: TextStyle(fontSize: 16),
                    ),
                    Row(
                      children: [
                        Text(
                          "See Profile",
                          style: TextStyle(
                            color: AppColors.grey,
                            fontSize: 12,
                          ),
                        ),
                        AppSpacer.width(4),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: AppColors.grey,
                          size: 10,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const AppSpacer.height(16),
            const _SearchBar(),
            const AppSpacer.height(16),

            /// carousel
            CarouselSlider(
              options: CarouselOptions(
                height: 200,
                enableInfiniteScroll: true,
                autoPlay: true,
                viewportFraction: 1,
              ),
              items: List.generate(3, (index) {
                return const CarouselCard(
                  title: "Disney Master",
                  category: "Creative & Art",
                  description:
                      "Lorem ipsum damet Lorem ipsum damet Lorem ipsum damet ipsum damet",
                  imageUrl:
                      "https://analyticsindiamag.com/wp-content/uploads/2020/08/432a6b258bfa7df163a88bed81255db6.jpg",
                );
              }),
            ),
            const AppSpacer.height(16),

            /// category filter
            const _CategoryFilter(),
            const AppSpacer.height(16),

            /// popular
            const SectionHeader(title: "Popular"),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  5,
                  (index) {
                    return const Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: AgentsCardLarge(
                        title: "Math Solver",
                        category: "Education",
                        description: "Lorem ipsum damet Lorem ipsum damet",
                        imageUrl: "https://via.placeholder.com/100",
                      ),
                    );
                  },
                ),
              ),
            ),
            const AppSpacer.height(16),

            /// newest
            const SectionHeader(title: "Newest"),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  Row(
                    children: List.generate(
                      5,
                      (index) {
                        return const Padding(
                          padding: EdgeInsets.only(right: 16),
                          child: AgentCardSmall(
                            title: "Math Solver",
                            category: "Education",
                            description: "Lorem ipsum damet Lorem ipsum damet",
                            imageUrl: "https://via.placeholder.com/100",
                          ),
                        );
                      },
                    ),
                  ),
                  const AppSpacer.height(18),
                  Row(
                    children: List.generate(
                      5,
                      (index) {
                        return const Padding(
                          padding: EdgeInsets.only(right: 16),
                          child: AgentCardSmall(
                            title: "Math Solver",
                            category: "Education",
                            description: "Lorem ipsum damet Lorem ipsum damet",
                            imageUrl: "https://via.placeholder.com/100",
                          ),
                        );
                      },
                    ),
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

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.secondary,
        prefixIcon: const Icon(Icons.search, color: Colors.white70),
        hintText: "Search Tools..",
        hintStyle: const TextStyle(color: Colors.white70),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class CarouselCard extends StatelessWidget {
  final String title, category, description, imageUrl;

  const CarouselCard({
    super.key,
    required this.title,
    required this.category,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 7,
              left: 11,
            ),
            child: LabelWidget(label: category),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(color: Colors.white70),
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryFilter extends StatelessWidget {
  const _CategoryFilter();

  @override
  Widget build(BuildContext context) {
    final List<String> labels = [
      "All",
      "Productivity & Work",
      "Creative & Art",
      "Education & Learning",
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: labels
            .map(
              (label) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: LabelWidget(label: label),
              ),
            )
            .toList(),
      ),
    );
  }
}
