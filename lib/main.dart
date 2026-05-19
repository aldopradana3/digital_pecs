import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:permission_handler/permission_handler.dart';
import 'core/routes/app_routes.dart';
import 'features/auth/login_screen.dart';
import 'features/auth/signup_screen.dart';
import 'features/home/home_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Permission.microphone.request();
  await Permission.photos.request();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await _initApp();

  FlutterNativeSplash.remove();

  runApp(const MyApp());
}

Future<void> _initApp() async {
  // Nanti di sini cek token remember me
  // final token = await AuthService().getSavedToken();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'Digital PECS',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xFFFAFAFA),
            useMaterial3: true,
          ),
          initialRoute: AppRoutes.login,
          routes: {
            AppRoutes.login : (context) => const LoginScreen(),
            AppRoutes.home  : (context) => const HomeScreen(),
            AppRoutes.daftar  : (context) => const DaftarScreen(),
          },
        );
      }
    );
  }
}