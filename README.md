# flutter_application_1

A new Flutter project.

## Connect to MySQL with XAMPP

Flutter apps should not connect directly to MySQL. This project uses a small PHP
API in `backend/` as a bridge. The Products screen reads its categories and
product counts from that API; registration and login validate users against the
`users` table.

### Set up XAMPP

1. Start Apache and MySQL in the XAMPP Control Panel.
2. Ensure your `babyshop_db` database has the tables in
   [`database/schema.sql`](database/schema.sql). If you already imported an
   earlier copy of the schema, make sure its tables are in `babyshop_db`.
3. Copy the project's `backend` folder into `C:\xampp\htdocs\babyshop_api`.
4. If your MySQL login is not the XAMPP default (`root` with an empty
   password), update `C:\xampp\htdocs\babyshop_api\config.php`.
5. Test the API in a browser at
   `http://localhost/babyshop_api/api.php?action=health`. It should return
   `{"status":"ok"}`.

### Run the Flutter app

The app uses `http://localhost/babyshop_api/api.php` for web/desktop and
`http://10.0.2.2/babyshop_api/api.php` for the Android emulator. For a physical
phone, pass your computer's LAN address, for example
`flutter run --dart-define=API_BASE_URL=http://192.168.1.10/babyshop_api/api.php`,
and keep both devices on the same Wi-Fi. A phone cannot use `localhost` to
reach XAMPP on your computer.

Registration hashes passwords before storing them. Users can log in with their
username or email. Copy `backend/` into XAMPP again after changing the API code.
Never put MySQL credentials in the Flutter app. The remaining order and
wishlist screens still use sample UI data.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
