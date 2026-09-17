# Mobile App Dev (Flutter) Internship — Weeks 1–4

Complete solution set for the SkillNexis Mobile App Development (Flutter) internship tasks supplied in the weekly PDFs.

## What's included
- Week 1: Dart/Flutter fundamentals, Hello Flutter, profile card, image/text/button layout, business card and Personal Info mini-project.
- Week 2: Two-screen Todo app, Navigator, bottom navigation with 3 tabs, validated form, Drawer navigation, login → home navigation, calculator and Expense Tracker UI.
- Week 3: REST API with `http`, JSON parsing, `ListView.builder`, SharedPreferences, Firebase Auth/Firestore service classes, and a Weather Forecast implementation pattern.
- Week 4: Student Attendance capstone, date-wise attendance, dark mode, Firebase-ready data layer, testing and Android deployment notes.

## Run locally

```bash
flutter pub get
flutter run
```

The core demos run without Firebase credentials. Firebase features are provided as a ready-to-configure service layer.

## Firebase setup

1. Create a Firebase project and add the Android/iOS apps.
2. Run `flutterfire configure` from the project root.
3. Initialize Firebase in `main()` with the generated `DefaultFirebaseOptions`.
4. Enable Email/Password Authentication and Firestore.
5. Add Firestore security rules appropriate for your project.

Never commit service-account JSON files, private keys, or API secrets. For OpenWeather use `--dart-define=OPENWEATHER_API_KEY=...`.

## Task mapping

| Week | Requirement | Solution |
|---|---|---|
| 1 | Hello Flutter / profile / image-text-button / business card | `Week1Screen`, `ProfileCard`, `BusinessCard` |
| 2 | Todo + add screen / Navigator / bottom nav / form / Drawer / calculator | `Week2Screen` and related screens |
| 2 | Login + Home navigation | `LoginScreen`, `SimpleHomeScreen` |
| 2 | Expense Tracker mini-project | `ExpenseTrackerScreen` |
| 3 | Public API + JSON + dynamic list | `ApiDemoScreen` |
| 3 | SharedPreferences | `StorageDemoScreen` |
| 3 | Firebase Auth / Firestore | `lib/services/` |
| 3 | Weather Forecast | `WeatherService`, `WeatherScreen` |
| 4 | Student Attendance capstone | `Week4Screen` |
| 4 | Dark mode | `ThemeController` |
| 4 | Testing | `test/widget_test.dart` |

The supplied Week 4 sheet lists three capstone options; this repository implements the Student Attendance App option as the self-contained capstone.
