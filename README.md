# 📰 Flutter News App

A Flutter-based mobile application that displays the latest news articles using a public News API.
The app follows Clean Architecture principles and includes user-focused features like bookmarking
and daily notifications.

## 📱 Features

- 🔍 **News Feed Integration**  
  Fetches real-time news articles from a public News API, categorized and sorted for better user
  experience.

- ⭐ **Bookmark System**  
  Users can bookmark their favorite articles for offline access. Bookmarked data is stored locally
  using SQLite or SharedPreferences.

- ⏰ **Daily Notifications**  
  Sends a daily reminder (e.g., at 8:00 AM) to encourage users to read the latest news. Implemented
  using WorkManager and local notification services.

- ⚙️ **Modern Flutter Stack**
    - **State Management:** BLoC
    - **Dependency Injection:** GetIt
    - **Local Storage:** SQLite / SharedPreferences
    - **HTTP Client:** Dio
    - **Others:** Dartz, Equatable

- 💻 **Responsive UI**  
  A clean and responsive design that supports both Android and iOS devices.

## 🧱 Architecture

This project uses **Clean Architecture** and separates the app into distinct layers:

- **Presentation Layer:** Widgets and BLoC for UI and state management
- **Domain Layer:** Use cases and entities
- **Data Layer:** Repository implementation, local & remote data sources