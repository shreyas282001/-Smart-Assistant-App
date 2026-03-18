import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/suggestion_provider.dart';
import '../providers/theme_provider.dart';
import 'chat_screen.dart';
import 'history_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();

    Future.microtask(() =>
        context.read<SuggestionProvider>().fetchSuggestions());

    controller.addListener(() {
      if (controller.position.pixels >=
          controller.position.maxScrollExtent - 100) {
        context.read<SuggestionProvider>().fetchSuggestions();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SuggestionProvider>();
    final theme = context.watch<ThemeProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Smart Assistant"),
        actions: [
          IconButton(
            icon: Icon(theme.isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: theme.toggleTheme,
          ),
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const HistoryScreen()));
            },
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF4A6CF7), Color(0xFF6A8DFF)],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: const Text(
              "Ask anything ✨",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: controller,
              itemCount: provider.suggestions.length,
              itemBuilder: (_, i) {
                final item = provider.suggestions[i];

                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(item['title']),
                    subtitle: Text(item['description']),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ChatScreen(initialMessage: item['title']),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.chat),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const ChatScreen()));
        },
      ),
    );
  }
}