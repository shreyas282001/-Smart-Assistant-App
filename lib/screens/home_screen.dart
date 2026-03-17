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
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SuggestionProvider>().fetchSuggestions();
    });
  }

  /// 🔥 REAL AI SUGGESTIONS (OVERRIDE)
  final List<Map<String, String>> aiSuggestions = [
    {
      "title": "Summarize Notes",
      "desc": "Convert long text into short summary"
    },
    {
      "title": "Email Reply",
      "desc": "Generate professional email response"
    },
    {
      "title": "Explain Code",
      "desc": "Understand any programming code"
    },
    {
      "title": "Write Blog",
      "desc": "Generate SEO friendly blog content"
    },
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final provider = context.watch<SuggestionProvider>();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      /// 🔝 APP BAR
      appBar: AppBar(
        elevation: 0,
        title: const Text("AI Assistant"),

        actions: [

          /// 🌙 DARK MODE
          IconButton(
            icon: Icon(themeProvider.isDark
                ? Icons.light_mode
                : Icons.dark_mode),
            onPressed: () =>
                context.read<ThemeProvider>().toggleTheme(),
          ),

          /// HISTORY
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const HistoryScreen()),
              );
            },
          )
        ],
      ),

      /// 📱 BODY
      body: Column(
        children: [

          /// 🔥 HERO HEADER
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: themeProvider.isDark
                    ? [Colors.black, Colors.grey.shade900]
                    : [Color(0xFF4A6CF7), Color(0xFF6A8DFF)],
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Hello 👋",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 6),
                Text("Ask anything, I’m here to help!",
                    style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),

          /// 🔍 SEARCH BAR
          Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 5)
                ],
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: "Ask AI anything...",
                  border: InputBorder.none,
                  icon: Icon(Icons.search),
                ),
              ),
            ),
          ),

          /// 💡 TITLE
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("Quick Actions",
                  style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ),

          const SizedBox(height: 10),

          /// 🔥 SUGGESTIONS (LIMITED)
          Expanded(
            child: provider.isLoading
                ? _loadingUI()
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: aiSuggestions.length,
                    itemBuilder: (context, index) {
                      final item = aiSuggestions[index];

                      return _card(item, index);
                    },
                  ),
          ),
        ],
      ),

      /// 💬 FLOATING CHAT BUTTON
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF4A6CF7),
        child: const Icon(Icons.chat),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => const ChatScreen()),
          );
        },
      ),
    );
  }

  /// ================= CARD =================
  Widget _card(Map<String, String> item, int index) {
  return GestureDetector(
    onTap: () {
      print("CLICKED: ${item['title']}"); // ✅ DEBUG

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ChatScreen(
            initialMessage: item['title'],
          ),
        ),
      );
    },

    child: Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8)
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.auto_awesome),
          const SizedBox(width: 10),
          Expanded(
            child: Text(item['title']!),
          ),
          const Icon(Icons.arrow_forward_ios, size: 14)
        ],
      ),
    ),
  );
}

  /// ================= LOADING =================
  Widget _loadingUI() {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (_, __) => Container(
        margin: const EdgeInsets.all(12),
        height: 80,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}