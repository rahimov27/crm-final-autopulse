import 'package:autopulse/resources/colors.dart';
import 'package:autopulse/resources/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(
        () {
          _messages.add({'user': _controller.text});
          _controller.clear();
        },
      );
      // Here you can add your API call to send the message
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 4.0, vertical: 3.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(150),
                  color: AppColors.appBarBackgroundColor,
                ),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: AppColors.iconsBackgroundColor.withOpacity(0.10),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          'assets/logo.svg',
                          width: 34,
                          height: 34,
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Text("Chat", style: AppFonts.appBarText),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: AppColors.iconsBackgroundColor.withOpacity(0.10),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          'assets/push.svg',
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                if (message.containsKey('user')) {
                  return _buildUserMessage(context, message['user']!);
                } else {
                  return _buildBotMessage(context, message['bot']!);
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Type a message",
                      hintStyle: AppFonts.chatText
                          .copyWith(color: Colors.grey, fontSize: 14),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: _sendMessage,
                  foregroundColor: Colors.white,
                  backgroundColor: AppColors.mainBlueColor,
                  child: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserMessage(BuildContext context, String message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 200),
            child: Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const ShapeDecoration(
                  color: Color(0xFF1463FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                ),
                child: Text(
                  message,
                  style: AppFonts.chatText,
                ),
              ),
            ),
          ),
          Container(
            width: 24,
            height: 24,
            decoration: const ShapeDecoration(
              image: DecorationImage(
                image: NetworkImage("https://via.placeholder.com/24x24"),
                fit: BoxFit.fill,
              ),
              shape: OvalBorder(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBotMessage(BuildContext context, String message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: const ShapeDecoration(
              image: DecorationImage(
                image: NetworkImage("https://via.placeholder.com/24x24"),
                fit: BoxFit.fill,
              ),
              shape: OvalBorder(),
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 220),
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: AppColors.widgetsColors,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Text(message, style: AppFonts.chatText),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
