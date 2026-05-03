# Flutter Examples Bundle

This repository contains three distinct Flutter examples designed to help you bootstrap your mobile development journey. Each example is a standalone project that can be run independently or detached into its own repository.

## 📁 Repository Structure

```text
.
├── registration_example/     # User Registration & Profile Flow
├── bmi_basic_example/        # Standard BMI Calculator (Material UI)
└── bmi_premium_example/      # High-End BMI Calculator (Custom Premium UI)
```

---

## 🚀 How to Run

To run any of the examples, navigate into its directory and use the standard Flutter commands:

### 1. Registration Example
```bash
cd registration_example
flutter run
```
*   **Features:** Multi-field form validation, password visibility toggle, and seamless navigation to a user profile screen.

### 2. BMI Basic Example
```bash
cd bmi_basic_example
flutter run
```
*   **Features:** Clean Material design matching standard UI patterns. Simple height/weight inputs with immediate result calculation.

### 3. BMI Premium Example
```bash
cd bmi_premium_example
flutter run
```
*   **Features:** Premium Dark Mode UI, interactive sliders, custom components, and smooth modal-based result presentation.

---

## ✂️ How to Detach Examples

If you want to move one of these examples into its own separate folder or repository, follow these steps:

1.  **Copy the folder:** Simply copy the desired project folder (e.g., `bmi_premium_example`) to your new location.
2.  **Initialize Git (Optional):**
    ```bash
    cd your_new_location/bmi_premium_example
    git init
    ```
3.  **Get Dependencies:**
    ```bash
    flutter pub get
    ```
4.  **Ready to go!** The project is fully self-contained with its own `pubspec.yaml`, `android`, `ios`, and `web` directories.

---

## 🛠 Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed and configured.
- [Android Studio](https://developer.android.com/studio) or [VS Code](https://code.visualstudio.com/) with Flutter extension.
- A physical device or emulator/simulator.

---

## 🎨 Design Previews

| Example | Design Focus |
| :--- | :--- |
| **Registration** | Form Logic & Navigation |
| **BMI Basic** | Standard Material UI |
| **BMI Premium** | Premium UX & Custom Styles |

---
*Happy Coding!* 🚀
