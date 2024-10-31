import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class ChatMessage {
  final String text;
  final bool isMe;
  final DateTime timestamp;
  final String? attachmentUrl;
  final bool isAnimated;
  final String? reactionEmoji;

  ChatMessage({
    required this.text,
    required this.isMe,
    required this.timestamp,
    this.attachmentUrl,
    this.isAnimated = false,
    this.reactionEmoji,
  });
}

class BeautifulChatDialog extends StatefulWidget {
  final String title;
  final String otherUserName;
  final String otherUserAvatar;

  const BeautifulChatDialog({
    super.key,
    required this.title,
    required this.otherUserName,
    required this.otherUserAvatar,
  });

  static void show(
    BuildContext context, {
    required String title,
    required String otherUserName,
    required String otherUserAvatar,
  }) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) =>
          BeautifulChatDialog(
        title: title,
        otherUserName: otherUserName,
        otherUserAvatar: otherUserAvatar,
      ),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutQuart,
          )),
          child: child,
        );
      },
    );
  }

  @override
  State<BeautifulChatDialog> createState() => _BeautifulChatDialogState();
}

class _BeautifulChatDialogState extends State<BeautifulChatDialog>
    with TickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  bool _isTyping = false;
  bool _showEmoji = false;
  late AnimationController _bounceController;
  final Random _random = Random();

  // Dynamic Response System
  final Map<String, List<String>> _responses = {
    'greeting': [
      "Hey there! 👋 How's your day going?",
      "Hello! 😊 Wonderful to see you!",
      "Hi friend! 🌟 What brings you here today?",
      "Greetings! 🎉 Hope you're having a fantastic day!",
      "Hiya! 👋 What's up?",
      "Hey! 😃 How's everything?",
    ],
    'how_are_you': [
      "I'm doing great, thanks for asking! 😊 How about you?",
      "Living my best digital life! 🌟 You?",
      "Feeling energetic and ready to chat! ⚡ How are you?",
      "Just perfect! 🎯 Hope you're having a wonderful day too!",
      "I'm fantastic! 😄 How are you doing?",
      "Couldn't be better! 😁 How about yourself?",
    ],
    'name': [
      "I'm Tech Apostle! 🚀 Nice to meet you!",
      "They call me Tech Apostle - your friendly neighborhood chat assistant! 😎",
      "Tech Apostle at your service! 🌟",
      "The name's Apostle, Tech Apostle! 🎯",
      "I'm your friendly AI, Tech Apostle! 🤖",
      "Tech Apostle here, ready to assist! 🛠️",
    ],
    'favorite_color': [
      "I love all colors, but blue is quite calming! 💙",
      "Green is the color of life! 🌿 What's yours?",
      "Red is so vibrant and full of energy! ❤️",
      "Yellow is like a burst of sunshine! 🌞",
      "Purple is so royal and majestic! 👑",
      "Orange is warm and inviting! 🍊",
    ],
    'weather': [
      "I hope it's sunny where you are! ☀️",
      "Rainy days are perfect for coding! 🌧️",
      "Snow is so magical! ❄️",
      "I love a good thunderstorm! ⛈️",
      "Clear skies are the best! 🌤️",
      "Cloudy days have their own charm! ☁️",
    ],
  };

  // Extended emoji list
  final List<String> _emojis = [
    "😊",
    "😂",
    "🥰",
    "😍",
    "😎",
    "🤔",
    "😅",
    "👍",
    "🚀",
    "💫",
    "⭐",
    "🌟",
    "✨",
    "💡",
    "🎯",
    "🎨",
    "🌈",
    "🎭",
    "🎪",
    "🎠",
    "🎡",
    "🎢",
    "🎪",
    "🎭",
    "🌺",
    "🌸",
    "🌼",
    "🌻",
    "🌹",
    "🍀",
    "🌿",
    "🌴",
    "💖",
    "💝",
    "💕",
    "💓",
    "💗",
    "💞",
    "💘",
    "💟",
    "😃",
    "😄",
    "😁",
    "😆",
    "😅",
    "🤣",
    "😂",
    "🙂",
    "🙃",
    "😉",
    "😊",
    "😇",
    "🥳",
    "🤩",
    "😋",
    "😜",
    "🤪",
    "😝",
    "🤑",
    "🤗",
    "🤭",
    "🤫",
    "🤔",
    "🤐",
    "🤨",
    "😐",
    "😑",
    "😶",
    "😏",
    "😒",
    "🙄",
    "😬",
    "🤥",
    "😌",
    "😔",
    "😪",
    "🤤",
    "😴",
    "😷",
    "🤒",
    "🤕",
    "🤢",
    "🤮",
    "🤧",
    "😵",
    "🤯",
    "🤠",
    "🥳",
    "🥺",
    "🤓",
    "🧐",
    "😎",
    "🤡",
    "🥸",
    "😈",
    "👿",
    "👹",
    "👺",
    "💀",
    "☠️",
    "👻",
    "👽",
    "👾",
    "🤖",
  ];

  @override
  void initState() {
    super.initState();
    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    // Add some sample messages
    _messages.addAll([
      ChatMessage(
        text: "Hey there! 👋",
        isMe: false,
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
      ChatMessage(
        text: "Hi! How are you?",
        isMe: true,
        timestamp: DateTime.now().subtract(const Duration(minutes: 4)),
      ),
    ]);
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    final messageText = _messageController.text.toLowerCase();
    final currentMessage = ChatMessage(
      text: _messageController.text,
      isMe: true,
      timestamp: DateTime.now(),
    );

    setState(() {
      _messages.add(currentMessage);
      _messageController.clear();
      _showEmoji = false;
      _listKey.currentState?.insertItem(_messages.length - 1);
    });

    // Generate response based on message content
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _isTyping = true;
      });

      String responseType = 'greeting';
      if (messageText.contains('how are you')) {
        responseType = 'how_are_you';
      } else if (messageText.contains('your name') ||
          messageText.contains("who are you")) {
        responseType = 'name';
      } else if (messageText.contains('favorite color')) {
        responseType = 'favorite_color';
      } else if (messageText.contains('weather')) {
        responseType = 'weather';
      }

      Future.delayed(const Duration(seconds: 2), () {
        final response = _getRandomResponse(responseType);
        setState(() {
          _isTyping = false;
          final responseMessage = ChatMessage(
            text: response,
            isMe: false,
            timestamp: DateTime.now(),
            isAnimated: true,
          );
          _messages.add(responseMessage);
          _listKey.currentState?.insertItem(_messages.length - 1);
        });
        _scrollToBottom();
        _bounceController.forward().then((_) => _bounceController.reverse());
      });
    });

    _scrollToBottom();
  }

  String _getRandomResponse(String type) {
    final responses = _responses[type] ?? ['Hello!'];
    return responses[_random.nextInt(responses.length)];
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        final message = ChatMessage(
          text: "Sent an attachment",
          isMe: true,
          timestamp: DateTime.now(),
          attachmentUrl: result.files.single.name,
        );
        _messages.add(message);
        _listKey.currentState?.insertItem(_messages.length - 1);
      });
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            children: [
              // Chat Header
              _buildHeader(),

              // Messages List
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        image: const DecorationImage(
                          image: NetworkImage('assets/chat_wallpaper.jpeg'),
                          opacity: 0.1,
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: AnimatedList(
                        key: _listKey,
                        controller: _scrollController,
                        padding: const EdgeInsets.all(16),
                        initialItemCount: _messages.length,
                        itemBuilder: (context, index, animation) {
                          final message = _messages[index];
                          return SlideTransition(
                            position: animation.drive(
                              Tween<Offset>(
                                begin: const Offset(0, 1),
                                end: Offset.zero,
                              ).chain(CurveTween(curve: Curves.easeInOut)),
                            ),
                            child: _buildMessageBubble(message),
                          );
                        },
                      ),
                    ),
                    if (_isTyping)
                      Positioned(
                        bottom: 0,
                        left: 16,
                        child: BubbleSpecialThree(
                          text: "typing...",
                          color: Colors.grey.shade200,
                          tail: true,
                          isSender: false,
                        ),
                      ),
                  ],
                ),
              ),

              // Input Area
              _buildInputArea(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.otherUserAvatar),
            radius: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.otherUserName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Online",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    final time = DateFormat('HH:mm').format(message.timestamp);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment:
            message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isMe) ...[
            CircleAvatar(
              backgroundImage: NetworkImage(widget.otherUserAvatar),
              radius: 16,
            ),
            const SizedBox(width: 8),
          ],
          Column(
            crossAxisAlignment: message.isMe
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              BubbleSpecialThree(
                text: message.text,
                color: message.isMe
                    ? Theme.of(context).primaryColor
                    : Colors.grey.shade200,
                tail: true,
                isSender: message.isMe,
                textStyle: TextStyle(
                  color: message.isMe ? Colors.white : Colors.black,
                  fontSize: 16,
                ),
              ),
              if (message.attachmentUrl != null)
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.attachment, size: 20),
                      const SizedBox(width: 8),
                      Text(message.attachmentUrl!),
                    ],
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  time,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_showEmoji)
            Container(
              height: 200,
              padding: const EdgeInsets.all(8),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 8,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemCount: _emojis.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _messageController.text += _emojis[index];
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        _emojis[index],
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                  );
                },
              ),
            ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.emoji_emotions_outlined),
                onPressed: () {
                  setState(() {
                    _showEmoji = !_showEmoji;
                  });
                },
              ),
              IconButton(
                icon: const Icon(Icons.attach_file),
                onPressed: _pickFile,
              ),
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                  ),
                  maxLines: null,
                  textCapitalization: TextCapitalization.sentences,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.send, color: Colors.white),
                  onPressed: _sendMessage,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
