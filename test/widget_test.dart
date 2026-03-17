import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:smart_assistant_app/providers/chat_provider.dart';
import 'package:smart_assistant_app/providers/suggestion_provider.dart';
import 'package:smart_assistant_app/screens/home_screen.dart';

void main() {
  testWidgets('App UI loads correctly', (WidgetTester tester) async {

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => SuggestionProvider()),
          ChangeNotifierProvider(create: (_) => ChatProvider()),
        ],
        child: const MaterialApp(
          home: HomeScreen(),
        ),
      ),
    );

    // Wait for UI to build
    await tester.pump(const Duration(seconds: 1));

    // Check AppBar title
    expect(find.text("Smart Assistant"), findsOneWidget);
  });
}