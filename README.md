# Cognifyz IT Solutions – Android Development Internship

**Intern:** Md Rounaq Ali  
**Ref:** CTI/A1/C361826  
**Position:** Android Development Intern  
**Duration:** 28 May 2026 – 28 June 2026  
**Technology:** Flutter & Dart  

---

## 📁 Project Structure

```
cognifyz_internship/
├── task1_hello_world/        → Task 1: Hello World App (Level 1 - Beginner)
├── task2_button_interaction/ → Task 2: Button Interaction (Level 1 - Beginner)
├── task3_list_display/       → Task 3: List Display (Level 2 - Intermediate)
├── task4_basic_ui/           → Task 4: Basic UI Layout (Level 2 - Intermediate)
├── task5_fetch_data/         → Task 5: Fetch & Display Data (Level 3 - Advanced)
├── task6_simple_form/        → Task 6: Simple Form (Level 3 - Advanced)
├── task7_database_usage/     → Task 7: Database Usage (Level 4 - Expert)
├── task8_navigation/         → Task 8: Implement Navigation (Level 4 - Expert)
└── unified_portfolio_app/   → Master App: All 8 Tasks Combined
```

---

## 🚀 How to Run

### Prerequisites
- Flutter SDK installed (`flutter --version` to verify)
- Android Emulator or physical Android device connected

### Run any individual task app:
```bash
# Example: Task 1
cd task1_hello_world
flutter pub get
flutter run
```

### Run the Unified Portfolio App (recommended):
```bash
cd unified_portfolio_app
flutter pub get
flutter run
```

---

## ✅ Task Summary

### Level 1 – Beginner

#### Task 1: Hello World App
- **File:** `task1_hello_world/lib/main.dart`
- **What it does:** Builds an Android app displaying "Hello World!" with:
  - Animated fade, scale, and slide entrance effects
  - A gradient-masked typography heading
  - Profile card with intern name and reference number
  - Three info cards showing Flutter, Dart, and Cognifyz branding

#### Task 2: Button Interaction
- **File:** `task2_button_interaction/lib/main.dart`
- **What it does:** Enhances the app with button interactions:
  - A pulsing circular CLICK ME button (FloatingActionButton style)
  - Click counter and points score system
  - Milestone SnackBars that trigger at 1, 5, 10, 25, 50 clicks
  - Progress bar showing next milestone
  - Haptic feedback on every click

---

### Level 2 – Intermediate

#### Task 3: List Display
- **File:** `task3_list_display/lib/main.dart`
- **What it does:** Displays a list of Android development technologies:
  - Expandable card list with SizeTransition animations
  - Searchable filter for all items
  - Colored badges showing technology level/category
  - Animated rotation arrow on expand/collapse

#### Task 4: Basic UI Layout
- **File:** `task4_basic_ui/lib/main.dart`
- **What it does:** Builds an app with multiple activities and UI layouts:
  - Bottom NavigationBar with 3 tabs (Home, Portfolio, Stats)
  - Home tab: gradient banner, 2×2 grid of quick access cards
  - Portfolio tab: complete task completion list
  - Stats tab: stat boxes and animated level progress bars

---

### Level 3 – Advanced

#### Task 5: Fetch and Display Data
- **File:** `task5_fetch_data/lib/main.dart`
- **What it does:** Fetches live user data from the internet:
  - Calls `https://jsonplaceholder.typicode.com/users` using the `http` package
  - Shows loading indicator while fetching
  - Shows error state with retry button on failure
  - Displays user cards with name, email, city, and company
  - Pull-to-refresh button in the AppBar
  - Searchable user list

#### Task 6: Simple Form
- **File:** `task6_simple_form/lib/main.dart`
- **What it does:** Creates a form with submission logic:
  - Fields: Full Name, Email, Phone, Role (Dropdown), Message
  - Validates all fields with custom error messages
  - Terms & Conditions checkbox required before submission
  - 2-second loading animation on submit
  - Animated success screen with scale + fade animation

---

### Level 4 – Expert

#### Task 7: Basic Database Usage
- **File:** `task7_database_usage/lib/main.dart`
- **What it does:** Integrates a SQLite database using `sqflite`:
  - DatabaseHelper class with `onCreate`, `insert`, `query`, `delete` methods
  - Table schema: `id, name, email, role, created_at`
  - Modal bottom sheet for adding new users with form validation
  - Swipeable delete with confirmation dialog
  - Real-time record count display

#### Task 8: Implement Navigation
- **File:** `task8_navigation/lib/main.dart`
- **What it does:** Implements smooth custom transitions using PageRouteBuilder:
  - **Slide Right** – `SlideTransition` from `Offset(1.0, 0.0)`
  - **Fade** – `FadeTransition` opacity animation
  - **Scale / Zoom** – `ScaleTransition` with `Curves.easeOutBack`
  - **Slide Up** – `SlideTransition` from `Offset(0.0, 1.0)`
  - About screen reachable via fade navigation
  - Each destination screen has a back button using `Navigator.pop()`

---

## 📱 Unified Portfolio App

The `unified_portfolio_app/` folder contains a master application integrating all 8 tasks:
- **Dashboard Screen** – Shows intern profile, 100% completion card, and links to all tasks
- **Task Screens** – Each task has its own dedicated screen embedded in the same app
- **Custom Transitions** – All navigation within the app uses slide transitions

---

## 📦 Dependencies Used

| Package | Version | Purpose |
|---------|---------|---------|
| `google_fonts` | ^6.1.0 | Premium Outfit typography |
| `http` | ^1.2.1 | Task 5 – API fetch |
| `sqflite` | ^2.3.3 | Task 7 – SQLite database |
| `path` | ^1.9.0 | Task 7 – Database path |

---

## 📤 Submission

Submitted via: https://forms.gle/c3QZCheEySRDPV6V6  
**Format:** ZIP file per task or full project ZIP

---

## 🌐 GitHub Push Guide

To host this project on your GitHub profile and showcase your portfolio, follow these steps:

### Step 1: Initialize Git
Open your terminal in the `cognifyz_internship` folder and run:
```bash
git init
git add .
git commit -m "Initial commit: Completed all 8 Cognifyz Internship Tasks"
```

### Step 2: Create a Repository on GitHub
1. Go to [GitHub.com](https://github.com/) and log in.
2. Click the **+** icon in the top right and select **New repository**.
3. Name it `cognifyz_android_internship` (or similar).
4. Add a short description, keep it **Public**, and do NOT initialize with a README/gitignore (since you already have them).
5. Click **Create repository**.

### Step 3: Push Your Code
Copy the two commands provided by GitHub (under "push an existing repository") and paste them into your terminal. They will look like this:
```bash
git remote add origin https://github.com/YOUR_USERNAME/cognifyz_android_internship.git
git branch -M main
git push -u origin main
```
*(Make sure to replace `YOUR_USERNAME` with your actual GitHub username!)*

---

*Cognifyz IT Solutions Pvt. Ltd. | www.cognifyz.com | support@cognifyz.com*
