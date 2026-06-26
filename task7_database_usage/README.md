# Task 7 – Basic Database Usage
**Cognifyz IT Solutions Pvt. Ltd. | Android Development Internship**
**Intern:** Md Rounaq Ali | **Ref:** CTI/A1/C361826 | **Level:** 4 – Expert

---

## 📋 Objective
Integrate a simple SQLite database into the app.

## ✅ Requirements Implemented
- **`DatabaseHelper`** – Singleton class managing database creation and versioning
- SQLite table **`users`** with columns: `id`, `name`, `email`, `role`, `created_at`
- Full **CRUD operations:**
  - `insertUser()` – INSERT
  - `getAllUsers()` – SELECT with ORDER BY
  - `deleteUser()` – DELETE by ID
  - `updateUser()` – UPDATE by ID
  - `getUserCount()` – COUNT query
- Modal bottom sheet form for adding users with validation
- Delete confirmation dialog before removing records
- Real-time record count display in header

## 🚀 How to Run
```bash
flutter run                  # Android device/emulator
flutter run -d chrome        # Chrome browser (web)
```
> ⚠️ SQLite works natively on Android. On Chrome (web), sqflite uses an IndexedDB fallback.

## 📦 Dependencies
- `google_fonts` – Outfit font
- `sqflite` – SQLite local database
- `path` – Database file path resolution

---
*Cognifyz IT Solutions Pvt. Ltd. | support@cognifyz.com | www.cognifyz.com*
