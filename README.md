# Flutter Developer Portfolio

A comprehensive collection of 8 modular Flutter applications demonstrating progressive mastery of mobile development concepts, ranging from core UI rendering to local SQLite databases and REST API integrations. 

This repository was originally developed as part of an Android Development internship curriculum and has been refactored into a scalable, production-ready portfolio.

## 📁 Project Architecture

The workspace is organized into isolated packages to ensure modularity. It includes 8 distinct micro-apps and 1 unified master app.

```
cognifyz_internship/
├── task1_hello_world/        → UI rendering & Custom Animations
├── task2_button_interaction/ → Gestures & State Management
├── task3_list_display/       → Performant ListViews & Filtering
├── task4_basic_ui/           → Bottom Navigation & Complex Layouts
├── task5_fetch_data/         → REST API Networking & Async States
├── task6_simple_form/        → Input Validation & Form Handling
├── task7_database_usage/     → SQLite CRUD Operations (Web/Android)
├── task8_navigation/         → Custom Route Transitions
└── unified_portfolio_app/    → Master App: All 8 Modules Integrated
```

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (v3.0.0 or higher)
- Chrome (for web testing) or Android Emulator

### Running Locally
You can run any individual module or the master app natively on your machine:

```bash
# Example: Run the Unified Dashboard
cd unified_portfolio_app
flutter pub get
flutter run -d chrome
```

---

## 🛠️ Technical Highlights

### 1. Cross-Platform Compatibility
All modules, including the local SQLite database (`sqflite`), have been configured to compile natively on Android and perfectly on Google Chrome via `sqflite_common_ffi_web`.

### 2. State Management
Implements robust local state management using StatefulWidgets, handling asynchronous network calls, caching, and loading/error UI overlays.

### 3. Design System
- **Typography:** Uses `google_fonts` (Outfit) exclusively.
- **Theming:** Implements a strict Material Design 3 dark mode theme (`#1A1A2E` surface, `#6C63FF` primary).
- **Animations:** Extensive use of `FadeTransition`, `ScaleTransition`, `SizeTransition`, and custom `PageRouteBuilder` navigation stacks.

---

## 🌐 GitHub Push Guide

To host this project on your GitHub profile and showcase your portfolio, follow these steps:

### Step 1: Initialize Git
Open your terminal in the `cognifyz_internship` folder and run:
```bash
git init
git add .
git commit -m "Initial commit: Completed all 8 Flutter Development Modules"
```

### Step 2: Create a Repository on GitHub
1. Go to [GitHub.com](https://github.com/) and log in.
2. Click the **+** icon in the top right and select **New repository**.
3. Name it `flutter-portfolio-modules` (or similar).
4. Add a short description, keep it **Public**, and do NOT initialize with a README/gitignore (since you already have them).
5. Click **Create repository**.

### Step 3: Push Your Code
Copy the two commands provided by GitHub (under "push an existing repository") and paste them into your terminal. They will look like this:
```bash
git remote add origin https://github.com/YOUR_USERNAME/flutter-portfolio-modules.git
git branch -M main
git push -u origin main
```
*(Make sure to replace `YOUR_USERNAME` with your actual GitHub username!)*

---

*Developed by Md Rounaq Ali.*
