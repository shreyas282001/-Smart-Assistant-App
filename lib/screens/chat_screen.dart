import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/chat_provider.dart';

class ChatScreen extends StatefulWidget {
  final String? initialMessage;

  const ChatScreen({super.key, this.initialMessage});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (widget.initialMessage != null) {
        context.read<ChatProvider>().sendMessage(widget.initialMessage!);
      }
    });
  }

  void scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ChatProvider>();

    scrollToBottom();

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),

      /// ================= APPBAR =================
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF0F172A),
        title: const Text(
          "AI Assistant",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      /// ================= BODY =================
      body: Column(
        children: [

          /// ================= CHAT LIST =================
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: provider.messages.length,
              itemBuilder: (_, i) {
                final msg = provider.messages[i];
                bool isUser = msg['sender'] == "user";

                return Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 6),
                  child: Row(
                    mainAxisAlignment: isUser
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /// BOT AVATAR
                      if (!isUser)
                        const CircleAvatar(
                          radius: 14,
                          backgroundColor: Color(0xFF4A6CF7),
                          child: Icon(Icons.smart_toy,
                              size: 14, color: Colors.white),
                        ),

                      if (!isUser) const SizedBox(width: 8),

                      /// MESSAGE BUBBLE
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            gradient: isUser
                                ? const LinearGradient(
                                    colors: [
                                      Color(0xFF4A6CF7),
                                      Color(0xFF6A8DFF)
                                    ],
                                  )
                                : null,
                            color:
                                isUser ? null : const Color(0xFF1E293B),
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(16),
                              topRight: const Radius.circular(16),
                              bottomLeft:
                                  Radius.circular(isUser ? 16 : 4),
                              bottomRight:
                                  Radius.circular(isUser ? 4 : 16),
                            ),
                          ),
                          child: Text(
                            msg['message'] ?? "",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),

                      if (isUser) const SizedBox(width: 8),

                      /// USER AVATAR
                      if (isUser)
                        const CircleAvatar(
                          radius: 14,
                          backgroundColor: Colors.white24,
                          child: Icon(Icons.person,
                              size: 14, color: Colors.white),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),

          /// ================= TYPING =================
          if (provider.isTyping)
            const Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  SizedBox(width: 10),
                  Text("AI is typing...",
                      style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),

          /// ================= INPUT =================
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Color(0xFF020617),
              border: Border(
                top: BorderSide(color: Colors.white12),
              ),
            ),
            child: Row(
              children: [

                /// TEXT FIELD
                Expanded(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E293B),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      controller: controller,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: "Ask anything...",
                        hintStyle:
                            TextStyle(color: Colors.white54),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                /// SEND BUTTON
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF4A6CF7),
                        Color(0xFF6A8DFF)
                      ],
                    ),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send,
                        color: Colors.white),
                    onPressed: () {
                      context
                          .read<ChatProvider>()
                          .sendMessage(controller.text);
                      controller.clear();
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}