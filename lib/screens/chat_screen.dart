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

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.initialMessage != null &&
          widget.initialMessage!.isNotEmpty) {

        print("SENDING INITIAL MESSAGE"); // ✅ DEBUG

        context
            .read<ChatProvider>()
            .sendMessage(widget.initialMessage!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ChatProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Assistant")),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: provider.messages.length,
              itemBuilder: (context, index) {
                final msg = provider.messages[index];
                bool isUser = msg['sender'] == "user";

                return Align(
                  alignment: isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: isUser
                          ? Colors.blue
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(msg['message'] ?? ""),
                  ),
                );
              },
            ),
          ),

          Row(
            children: [
              Expanded(
                child: TextField(controller: controller),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  final text = controller.text.trim();
                  if (text.isEmpty) return;

                  context.read<ChatProvider>().sendMessage(text);
                  controller.clear();
                },
              )
            ],
          )
        ],
      ),
    );
  }
}