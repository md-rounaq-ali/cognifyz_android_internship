# SQLite CRUD Application

A local database Flutter application implementing full Create, Read, Update, and Delete operations using SQLite. Developed as part of the Android Development portfolio.

## ✨ Features

- **Singleton Database Helper:** Manages SQLite initialization, connection pooling, and versioning safely.
- **Full CRUD Support:** Executes asynchronous SQL statements to manipulate user records.
- **Bottom Sheet Forms:** Clean, modal-based UI for data entry without leaving the main context.
- **Destructive Action Safeguards:** Requires explicit user confirmation via dialogs before deleting records.
- **Cross-Platform Database:** Fully configured to run seamlessly on Android, iOS, and Web (via `sqflite_common_ffi_web`).

## 🛠️ Tech Stack

- **Framework:** Flutter
- **Local Storage:** `sqflite`, `path`
- **Web Support:** `sqflite_common_ffi_web`

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (v3.0.0 or higher)

### Installation & Run

1. Navigate to the project directory:
   ```bash
   cd task7_database_usage
   ```
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the application:
   ```bash
   flutter run
   ```

---
*Developed by Md Rounaq Ali.*
