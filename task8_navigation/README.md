# Task 8 – Implement Navigation
**Cognifyz IT Solutions Pvt. Ltd. | Android Development Internship**
**Intern:** Md Rounaq Ali | **Ref:** CTI/A1/C361826 | **Level:** 4 – Expert

---

## 📋 Objective
Enhance the app with smooth navigation between screens.

## ✅ Requirements Implemented
- Implemented **navigation between multiple screens** using Flutter's `Navigator`
- 4 custom transition animations (equivalent to Android Intent animations):
  1. **Slide Right** – `SlideTransition` from `Offset(1.0, 0.0)` – classic push
  2. **Fade** – `FadeTransition` – smooth opacity cross-fade
  3. **Scale / Zoom** – `ScaleTransition` with `Curves.easeOutBack`
  4. **Slide Up** – `SlideTransition` from `Offset(0.0, 1.0)` – bottom sheet style
- **About screen** – navigated to via fade transition, shows intern profile
- All screens have **back navigation** using `Navigator.pop()`
- Smooth transition tested end-to-end for seamless user experience

## 🚀 How to Run
```bash
flutter run                  # Android device/emulator
```

## 📦 Dependencies
- `google_fonts` – Outfit font


