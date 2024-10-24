import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'dart:math';

class CardData {
  final String title;
  final String subtitle;
  final List<Color> gradientColors;

  CardData({
    required this.title,
    required this.subtitle,
    required this.gradientColors,
  });
}

class CardSwiperDialog extends StatelessWidget {
  static void showCardSwiperDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return const CardSwiperDialogContent();
      },
    );
  }

  const CardSwiperDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

class CardSwiperDialogContent extends StatefulWidget {
  const CardSwiperDialogContent({super.key});

  @override
  State<CardSwiperDialogContent> createState() =>
      _CardSwiperDialogContentState();
}

class _CardSwiperDialogContentState extends State<CardSwiperDialogContent> {
  late final CardSwiperController controller;
  late final List<CardData> cards;
  final Random random = Random();

  @override
  void initState() {
    super.initState();
    controller = CardSwiperController();
    cards = [
      CardData(
        title: 'Innovation',
        subtitle: 'Embrace new ideas and technologies.',
        gradientColors: [
          const Color(0xFFFF4B6B),
          const Color(0xFFFF8B9E),
        ],
      ),
      CardData(
        title: 'Teamwork',
        subtitle: 'Collaborate and achieve together.',
        gradientColors: [
          const Color(0xFF4BC0FF),
          const Color(0xFF80D8FF),
        ],
      ),
      CardData(
        title: 'Excellence',
        subtitle: 'Strive for the best in everything you do.',
        gradientColors: [
          const Color(0xFF4BFF9F),
          const Color(0xFF80FFB4),
        ],
      ),
      CardData(
        title: 'Integrity',
        subtitle: 'Act with honesty and transparency.',
        gradientColors: [
          const Color(0xFFFFD700),
          const Color(0xFFFFE135),
        ],
      ),
      CardData(
        title: 'Creativity',
        subtitle: 'Think outside the box and innovate.',
        gradientColors: [
          const Color(0xFF8A2BE2),
          const Color(0xFFBA55D3),
        ],
      ),
      CardData(
        title: 'Passion',
        subtitle: 'Put your heart into your work.',
        gradientColors: [
          const Color(0xFFFF4500),
          const Color(0xFFFF6347),
        ],
      ),
    ];
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget _buildCard(CardData data) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: data.gradientColors,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  data.subtitle,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  CardSwiperDirection _getRandomDirection() {
    const directions = CardSwiperDirection.values;
    return directions[random.nextInt(directions.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(16),
        width: 400, 
        height: 600, 
        child: Column(
          children: [
            const Text(
              'Card Swiper',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: CardSwiper(
                controller: controller,
                cardsCount: cards.length,
                cardBuilder:
                    (context, index, horizontalThreshold, verticalThreshold) {
                  return _buildCard(cards[index]);
                },
                onSwipe: (previousIndex, currentIndex, direction) {
                  return true;
                },
                numberOfCardsDisplayed: 3,
                backCardOffset: const Offset(25, 15),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                scale: 0.9,
                duration: const Duration(milliseconds: 300),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => controller.swipe(CardSwiperDirection.left),
                  icon: const Icon(Icons.close, size: 32),
                  color: Colors.red,
                ),
                const SizedBox(width: 32),
                IconButton(
                  onPressed: () => controller.swipe(CardSwiperDirection.right),
                  icon: const Icon(Icons.check, size: 32),
                  color: Colors.green,
                ),
                const SizedBox(width: 32),
                IconButton(
                  onPressed: () => controller.undo(),
                  icon: const Icon(Icons.undo, size: 32),
                  color: Colors.blue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
