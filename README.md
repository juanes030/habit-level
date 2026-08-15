# HabitLevel

HabitLevel is a mobile application for building habits, participating in challenges, and improving personal consistency through social interaction and gamification.

The project is being built with **Flutter** and **Firebase**, with the goal of becoming a real production-ready application that can eventually be published on the Google Play Store.

> 🚧 **Status:** Early development

## 🎯 Project Goals

HabitLevel started as a project to practice Flutter and Firebase, but it is being designed from the beginning with production in mind.

The main goals are:

* Create and track personal habits.
* Create and participate in challenges.
* Compete or collaborate with other users.
* Track progress and consistency.
* Introduce gamification through experience, levels, achievements, and streaks.
* Learn and apply good software architecture and development practices.
* Eventually publish the application on the Google Play Store.

## 🛠️ Tech Stack

### Mobile

* Flutter
* Dart
* BLoC / Cubit
* Equatable
* GetIt
* Injectable
* GoRouter

### Backend

* Firebase Authentication
* Cloud Firestore
* Firebase Storage *(planned)*
* Firebase Cloud Messaging *(planned)*
* Firebase Analytics *(planned)*
* Firebase Crashlytics *(planned)*
* Firebase App Check *(planned)*
* Cloud Functions *(planned)*

## 🏗️ Architecture

HabitLevel uses a **Feature-First architecture combined with Clean Architecture**.

The project will be organized around application features rather than technical layers.

```text
lib/
├── app/
├── core/
└── features/
    ├── auth/
    ├── home/
    ├── habits/
    ├── challenges/
    ├── profile/
    └── social/
```

Each feature follows the same general structure:

```text
feature/
├── data/
├── domain/
└── presentation/
```

The expected flow is:

```text
Presentation
     ↓
BLoC / Cubit
     ↓
Use Case
     ↓
Repository
     ↓
Data Source
     ↓
Firebase
```

The goal is to keep the presentation layer independent from Firebase and make the application easier to test, maintain, and scale.

## 🔥 Firebase

The initial Firebase backend includes:

* Firebase Authentication with email and password.
* Cloud Firestore.

The initial Firestore data model contains:

```text
Firestore
├── users
├── habits
├── habit_completions
├── challenges
└── challenge_participants
```

Security rules are being designed so authenticated users can only access the resources they are authorized to access.

## 🚀 Planned Features

### Authentication

* [x] Firebase project configured
* [x] Email/password authentication configured
* [ ] Flutter authentication flow
* [ ] User profile creation
* [ ] Login
* [ ] Registration
* [ ] Logout
* [ ] Password recovery

### Habits

* [ ] Create habits
* [ ] Edit habits
* [ ] Delete/deactivate habits
* [ ] Complete habits
* [ ] Habit history
* [ ] Streaks
* [ ] Progress statistics

### Challenges

* [ ] Create challenges
* [ ] Discover public challenges
* [ ] Join challenges
* [ ] Leave challenges
* [ ] Track participant progress
* [ ] Challenge rankings

### Social

* [ ] User profiles
* [ ] Friends / connections
* [ ] Invite users to challenges
* [ ] Social activity
* [ ] Notifications

### Gamification

* [ ] Experience points
* [ ] Levels
* [ ] Streak rewards
* [ ] Achievements
* [ ] Statistics

## 📱 Future Production Features

The project is planned to eventually include:

* Firebase Cloud Messaging
* Firebase Crashlytics
* Firebase Analytics
* Firebase App Check
* Cloud Functions
* Firebase Storage
* Automated testing
* Performance optimization
* Privacy policy
* Google Play Store release

## 📌 Project Status

HabitLevel is currently in the **initial development stage**.

The Firebase backend has been started and the Flutter application is being prepared using a scalable architecture.

More features and documentation will be added as development progresses.

## 👨‍💻 Development

This project is developed as both a learning experience and a real-world application project, with emphasis on:

* Clean Architecture
* SOLID principles
* State management with BLoC
* Dependency injection
* Firebase integration
* Security
* Testing
* Maintainability
* Production readiness
