# 🌟 Screenify Mobile

A Flutter mobile application for **Screenify**, connecting to the backend via a configurable **BASE_URL**.

## 🚀 Getting Started

Follow these steps to set up and run the project.

---

## 📌 1. Clone the Repository

```bash
git clone https://github.com/your-repo/screenify-mobile.git
cd screenify-mobile
```

---

## 🌍 2. Configure the Backend URL

You have **two options** to set the `BASE_URL` (backend API URL):

### 🔹 Option 1: Use an `.env` File (Recommended)

1. **Create a `.env` file** in the root folder of the project:

```bash
touch .env
```

2. **Add the `BASE_URL` inside it**:

```env
BASE_URL=https://your-backend-url.com
```

3. **Run the project using the `.env` file**:

```bash
flutter run --dart-define-from-file=.env
```

---

### 🔹 Option 2: Pass `BASE_URL` Directly

If you don’t want to create a `.env` file, you can pass the URL **when running the app**:

```bash
flutter run --dart-define=BASE_URL=https://your-backend-url.com
```

---

## 📦 3. Install Dependencies

Ensure you have Flutter installed, then run:

```bash
flutter pub get
```

---

## 📱 4. Running the App

To run the app on a **physical device or emulator**, use:

```bash
flutter run
```

Or specify a platform:

```bash
flutter run -d android   # Run on Android
flutter run -d ios       # Run on iOS
```

For a **release build**, use:

```bash
flutter build apk --dart-define-from-file=.env  # Android
flutter build ios --dart-define-from-file=.env  # iOS
```

---

## 🛠 5. Troubleshooting

### 🔹 Check Dependencies
If you run into issues, try:  

```bash
flutter clean
flutter pub get
```

### 🔹 Verify BASE_URL
Make sure the backend URL is **correct** and **accessible**.

---

## 💡 6. Additional Commands

| Command                          | Description                           |
|----------------------------------|---------------------------------------|
| `flutter pub get`                | Install dependencies                 |
| `flutter clean`                  | Clear build cache                    |
| `flutter run --release`          | Run in release mode                  |
| `flutter build apk`              | Build APK for Android                |
| `flutter build ios`              | Build iOS app                        |

---

## 📝 7. Backend Setup (For Development)

If you are running the backend locally, follow these steps:

1. **Navigate to the `Presentation` folder:**

```bash
cd Presentation
```

2. **Initialize user secrets:**

```bash
dotnet user-secrets init
```

3. **Set up the `secrets.json` file:**

```json
{
  "ConnectionString": "(your_db_connection_string)",
  "AzureStorage": {
    "ConnectionString": "(your_azure_account_storage_connection_string_with_key)",
    "ContainerName": "(your_avatars_container_name)"
  },
  "JWT": {
    "Issuer": "(server_that_issues_token)",
    "Audience": "(server_that_receives_token)",
    "SigningKey": "(your_512bit_signing_key)"
  },
  "SendGrid": {
    "ApiKey": "(your_sendgrid_api_key)",
    "FromEmail": "(email_which_sends_mails)",
    "FromName": "(e.g. Screenify-reply)"
  },
  "HangfireConnection": "(your_hangfire_connection_string)",
  "BaseUrl": "(your_server_url_that_holds_backend)"
}
```

4. **Run database migrations:**

```bash
dotnet ef migrations add YourMigrationName --project Infrastructure --startup-project Presentation
```

5. **Update the database:**

```bash
dotnet ef database update --project Infrastructure --startup-project Presentation
```

6. **Run the backend:**

```bash
dotnet run --project Presentation
```

By default, **Swagger** should open in your browser, allowing you to test API endpoints.

---

## 👨‍💻 Contributing

Feel free to submit PRs or report issues! 🚀

---

## 🐝 License

MIT License © 2024 **Screenify Mobile**

