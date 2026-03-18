import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/chat_provider.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ChatProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("History")),
      body: ListView.builder(
        itemCount: provider.messages.length,
        itemBuilder: (_, i) {
          final msg = provider.messages[i];

          return ListTile(
            title: Text(msg['message'] ?? ""),
            subtitle: Text(msg['sender'] ?? ""),
          );
        },
      ),
    );
  }
}