 SMART ASSISTANT APP
====================

📌 Project Description:
----------------------
Smart Assistant App is a Flutter-based mobile application that simulates a real-world AI assistant.  
It allows users to view suggestions, interact via chat, and view chat history.

The app is designed with a modern UI and follows clean architecture using Provider for state management.

--------------------------------------------------

🚀 FEATURES:
------------
1. Suggestions with Pagination
   - Fetch and display suggestions from API
   - Load more on scroll

2. Chat Functionality
   - User can send messages
   - Assistant responds dynamically
   - Typing indicator included

3. Chat History
   - View previous messages
   - Clean UI display

4. Modern UI
   - ChatGPT-style design
   - Gradient bubbles
   - Dark/Light mode support

5. State Management
   - Implemented using Provider

--------------------------------------------------

📱 SCREENS:
-----------
1. Home Screen
   - Displays list of suggestions
   - Pagination implemented
   - Navigate to chat screen
   - Theme toggle available

2. Chat Screen
   - Chat interface with user and assistant messages
   - Auto scroll
   - Typing indicator

3. History Screen
   - Displays previous chat messages

--------------------------------------------------

🏗️ ARCHITECTURE:
----------------
lib/
│
├── models/
│   ├── suggestion_model.dart
│   ├── chat_model.dart
│
├── services/
│   ├── api_service.dart
│
├── providers/
│   ├── suggestion_provider.dart
│   ├── chat_provider.dart
│   ├── theme_provider.dart
│
├── screens/
│   ├── home_screen.dart
│   ├── chat_screen.dart
│   ├── history_screen.dart
│
├── widgets/
│   ├── chat_bubble.dart
│   ├── suggestion_card.dart
│
└── main.dart

--------------------------------------------------

⚙️ SETUP INSTRUCTIONS:
---------------------

1. Clone the Repository:
   git clone https://github.com/your-username/smart-assistant-app.git

2. Navigate to Project:
   cd smart-assistant-app

3. Install Dependencies:
   flutter pub get

4. Run the App:
   flutter run

--------------------------------------------------

📦 DEPENDENCIES:
----------------
- Flutter SDK
- Provider (State Management)

--------------------------------------------------

🔌 API DETAILS (DUMMY):
----------------------

1. GET /suggestions?page=1&limit=5
   - Returns list of suggestions

2. POST /chat
   Request:
   {
     "message": "Hello"
   }

   Response:
   {
     "reply": "AI response..."
   }

3. GET /chat/history
   - Returns previous messages

--------------------------------------------------

🖼️ SCREENSHOTS:
----------------

(Add these images in project folder: assets/screenshots/)

1. Home Screen:
   assets/screenshots/home.jpg

2. Chat Screen:
   assets/screenshots/chat.jpg

3. History Screen:
   assets/screenshots/history.jpg

--------------------------------------------------

🎯 ASSIGNMENT REQUIREMENTS COVERED:
----------------------------------
✔ Suggestions with Pagination  
✔ Chat UI  
✔ Chat History  
✔ Provider State Management  
✔ API Integration  
✔ Navigation  
✔ Theming  

--------------------------------------------------

🚀 FUTURE IMPROVEMENTS:
----------------------
- Real AI API integration
- Voice input feature
- Offline storage (Hive)
- Chat animations

--------------------------------------------------

👨‍💻 AUTHOR:
-------------
Shreyas Rangdal

--------------------------------------------------