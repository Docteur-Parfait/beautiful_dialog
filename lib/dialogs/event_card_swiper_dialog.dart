import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class EventData {
  final String title;
  final String subtitle;
  final String description;
  final String time;
  final String distance;
  final String imageUrl;

  EventData({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.time,
    required this.distance,
    required this.imageUrl,
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
  late final List<EventData> events;
  bool isExpanded = false;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    controller = CardSwiperController();
    events = [
      EventData(
        title: 'Hacktoberfest',
        subtitle: 'Global Open Source Celebration',
        description: 'Join the month-long celebration of open source software. Contribute to projects, earn swag, and connect with developers worldwide.',
        time: '10:00 AM - 6:00 PM',
        distance: '2.5 km',
        imageUrl: 'assets/hacktoberfest.jpg',
      ),
      EventData(
        title: 'Devfest',
        subtitle: 'Google Developer Groups Conference',
        description: 'Annual tech conference featuring the latest in Android, Web, and Cloud technologies. Network with experts and learn about cutting-edge developments.',
        time: '9:00 AM - 5:00 PM',
        distance: '3.8 km',
        imageUrl: 'assets/devfest.jpg',
      ),
      EventData(
        title: 'Pycon Africa',
        subtitle: 'Pan-African Python Conference',
        description: 'The largest Python conference in Africa. Join workshops, talks, and sprints focused on Python development and its applications in AI/ML.',
        time: '8:30 AM - 4:30 PM',
        distance: '5.2 km',
        imageUrl: 'assets/pycon.jpg',
      ),
      EventData(
        title: 'Google I/O',
        subtitle: 'Annual Developer Conference',
        description: 'Google\'s flagship developer conference showcasing the latest innovations in Android, AI, Cloud, and more. Experience hands-on labs and technical sessions.',
        time: '11:00 AM - 7:00 PM',
        distance: '4.1 km',
        imageUrl: 'assets/googleio.jpg',
      ),
      EventData(
        title: 'ICP Meet up Togo',
        subtitle: 'Internet Computer Protocol Community',
        description: 'Join the ICP community in Togo to discuss blockchain technology, decentralized applications, and the future of web3 development.',
        time: '2:00 PM - 6:00 PM',
        distance: '1.3 km',
        imageUrl: 'assets/icp.jpg',
      ),
      EventData(
        title: 'AWS Community Day',
        subtitle: 'Cloud Computing Excellence',
        description: 'A day of learning and sharing about Amazon Web Services. Deep dive into serverless, containers, and cloud architecture best practices.',
        time: '9:30 AM - 5:30 PM',
        distance: '3.0 km',
        imageUrl: 'assets/aws.jpg',
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
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
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
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
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
                  Padding(
                    padding: const EdgeInsets.all(16),
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
                  if (isExpanded) ...[
                    const Divider(height: 1),
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
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.access_time,
                                      color: Colors.grey[600]),
                                  const SizedBox(width: 4),
                                  Text(
                                    data.time,
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.location_on,
                                      color: Colors.grey[600]),
                                  const SizedBox(width: 4),
                                  Text(
                                    data.distance,
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
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
      backgroundColor: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(16),
        width: 400,
        height: 600,
        child: Column(
          children: [
            const Text(
              'Tech Events Near You',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: events.isEmpty
                  ? Center(
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
                        ],
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
                          if (currentIndex == null) {
                            events.removeAt(previousIndex);
                          }
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
                  onPressed: () => controller.swipe(CardSwiperDirection.left),
                  icon: const Icon(Icons.close),
                  label: const Text('Decline'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton.icon(
                  onPressed: () => controller.swipe(CardSwiperDirection.right),
                  icon: const Icon(Icons.check),
                  label: const Text('Accept'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
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