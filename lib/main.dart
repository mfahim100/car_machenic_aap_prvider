import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/UI/Views/main_screen.dart';
import 'package:provider_test/core/providers/auth_provider.dart';
import 'package:provider_test/core/providers/main_provider.dart';
import 'package:provider_test/core/providers/profile_provider.dart';
import 'package:provider_test/core/providers/task_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'UI/Views/home_screen.dart';
import 'core/utils/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AuthProvider()),
            ChangeNotifierProvider(create: (_) => MainProvider()),
            ChangeNotifierProvider(create: (_)=>TaskProvider()),
            ChangeNotifierProvider(create: (_)=>ProfileProvider()),
          ],
          child:  MaterialApp(
            theme: AppTheme.get(isLight: true),
            darkTheme: AppTheme.get(isLight: false),
            debugShowCheckedModeBanner: false,
            home:
            FirebaseAuth.instance.currentUser !=null?
                const MainScreen():
            const HomeScreen(),
            builder: EasyLoading.init(),
          ),
        );
      },
    );
  }
}
