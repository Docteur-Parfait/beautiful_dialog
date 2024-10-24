import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class EventData {
  final String title;
  final String subtitle;
  final String description;
  final String time;
  final String date;
  final String location;
  final String imageUrl;
  final Color primaryColor;

  EventData({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.time,
    required this.date,
    required this.location,
    required this.imageUrl,
    required this.primaryColor,
  });
}

class EventCardSwiperDialog extends StatelessWidget {
  static void showEventCardSwiperDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return const EventCardSwiperDialogContent();
      },
    );
  }

  const EventCardSwiperDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

class EventCardSwiperDialogContent extends StatefulWidget {
  const EventCardSwiperDialogContent({super.key});

  @override
  State<EventCardSwiperDialogContent> createState() =>
      _EventCardSwiperDialogContentState();
}

class _EventCardSwiperDialogContentState
    extends State<EventCardSwiperDialogContent> {
  late final CardSwiperController controller;
  late List<EventData> events;
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    controller = CardSwiperController();
    events = [
      EventData(
        title: 'Payaza Fintech Connect',
        subtitle: 'Diving into the Fintech space',
        description:
            'Join industry leaders and innovators for a deep dive into the future of financial technology. Explore trends, challenges, and opportunities in the African fintech ecosystem.',
        date: 'October 25',
        time: '9:00 AM',
        location: 'Cedi Conference Centre',
        imageUrl: 'assets/fintech.jpg',
        primaryColor: const Color(0xFF6B4EE6),
      ),
      EventData(
        title: 'APP & PIZZA',
        subtitle:
            'Developing with excellence: Best practices in the development progress',
        description:
            'A casual meetup combining coding and pizza! Share development best practices, network with fellow developers, and enjoy some delicious pizza while discussing the latest in app development.',
        date: 'October 25',
        time: '6:00 PM',
        location: 'Spado Hub',
        imageUrl: 'assets/apppizza.jpg',
        primaryColor: const Color(0xFFE64E4E),
      ),
      EventData(
        title: 'Film Creativity Action',
        subtitle: 'Exploring Creative Filmmaking',
        description:
            'A two-day immersive experience in creative filmmaking. Learn from industry experts, participate in workshops, and network with fellow creators in the beautiful settings of Legon Botanical Gardens.',
        date: 'October 25-26',
        time: '10:00 AM',
        location: 'Legon Botanical Gardens',
        imageUrl: 'assets/film.jpg',
        primaryColor: const Color(0xFF4EA1E6),
      ),
      EventData(
        title: 'Flutter Ghana',
        subtitle:
            'Building a Successful Global Flutter SaaS App from anywhere in the world',
        description:
            'Join the Flutter Ghana community for an intensive workshop on building scalable SaaS applications with Flutter. Learn about global best practices and how to succeed in the international market.',
        date: 'October 26',
        time: '9:00 AM - 2:00 PM',
        location: 'Stanbic Incubator',
        imageUrl: 'assets/flutter.jpg',
        primaryColor: const Color(0xFF4ECDE6),
      ),
      EventData(
        title: 'ICP Meet up Togo',
        subtitle: "Explorer l'avenir de l'Internet décentralisé",
        description:
            "Participez au premier ICP Meetup Togo pour découvrir comment le protocole Internet Computer (ICP) peut transformer l'infrastructure internet et promouvoir une économie numérique décentralisée en Afrique.",
        date: 'October 26',
        time: '8:00 AM - 1:00 PM',
        location: 'Agora Senghor, Lomé-Togo',
        imageUrl: 'assets/icp.jpg',
        primaryColor: const Color(0xFF4EE6B9),
      ),
      EventData(
        title: 'Hacktoberfest',
        subtitle: 'Global Open Source Celebration',
        description:
            'Join the month-long celebration of open source software. Contribute to projects, earn swag, and connect with developers worldwide.',
        date: 'October',
        time: '10:00 AM - 6:00 PM',
        location: 'Virtual & Local Meetups',
        imageUrl: 'assets/hacktoberfest.jpg',
        primaryColor: const Color(0xFFE64E8B),
      ),
      EventData(
        title: 'Devfest',
        subtitle: 'Google Developer Groups Conference',
        description:
            'Annual tech conference featuring the latest in Android, Web, and Cloud technologies. Network with experts and learn about cutting-edge developments.',
        date: 'November 4',
        time: '9:00 AM - 5:00 PM',
        location: 'Accra International Conference Centre',
        imageUrl: 'assets/devfest.jpg',
        primaryColor: const Color(0xFF4EE665),
      ),
    ];
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget _buildCard(EventData data) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: data.primaryColor.withOpacity(0.2),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  image: DecorationImage(
                    image: AssetImage(data.imageUrl),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      data.primaryColor.withOpacity(0.1),
                      BlendMode.overlay,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                border: Border.all(
                  color: data.primaryColor.withOpacity(0.1),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: data.primaryColor,
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
                  if (isExpanded) ...[
                    Divider(
                      height: 1,
                      color: data.primaryColor.withOpacity(0.2),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.description,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[800],
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Icon(Icons.access_time,
                                        color: data.primaryColor, size: 18),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data.date,
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: data.primaryColor,
                                            ),
                                          ),
                                          Text(
                                            data.time,
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(Icons.location_on,
                                        color: data.primaryColor, size: 18),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        data.location,
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey[600],
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(16),
        width: 400,
        height: 600,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              decoration: const BoxDecoration(
                // Removed gradient and set a solid color
                color: Colors.white,
              ),
              child: const Text(
                'Event Cards',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: events.isEmpty
                  ? Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.event_busy,
                              size: 64,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No more events',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Check back later for new events',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[400],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : CardSwiper(
                      controller: controller,
                      cardsCount: events.length,
                      cardBuilder: (context, index, horizontalThreshold,
                          verticalThreshold) {
                        return _buildCard(events[index]);
                      },
                      onSwipe: (previousIndex, currentIndex, direction) {
                        setState(() {
                          events.removeAt(previousIndex);
                          isExpanded = false;
                        });
                        return true;
                      },
                      numberOfCardsDisplayed: 3,
                      backCardOffset: const Offset(25, 15),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 24),
                      scale: 0.9,
                    ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: events.isEmpty
                      ? null
                      : () => controller.swipe(CardSwiperDirection.left),
                  icon: const Icon(Icons.close),
                  label: const Text('Decline'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[400],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 2,
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton.icon(
                  onPressed: events.isEmpty
                      ? null
                      : () => controller.swipe(CardSwiperDirection.right),
                  icon: const Icon(Icons.check),
                  label: const Text('Accept'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[400],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 2,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
