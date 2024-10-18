import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:picapool/firebase_options.dart';
import 'package:picapool/functions/auth/auth_controller.dart';
import 'package:picapool/functions/location/location_provider.dart';
import 'package:picapool/screens/home_screen.dart';
import 'package:picapool/screens/login_screen.dart';
import 'package:picapool/widgets/bottom_navbar/common_bottom_navbar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  void getLocation(WidgetRef ref) {
    ref.read(locationProvider.notifier).getLocation();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState =
        ref.watch(authControllerProvider); // Watch for auth changes

    return GetMaterialApp(
      title: 'Picapool',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          textSelectionTheme:
              const TextSelectionThemeData(cursorColor: Color(0xffffffff))),
      // Navigate based on the auth state
      home: _handleAuthState(authState),
    );
  }

  Widget _handleAuthState(AuthState authState) {
    if (authState.isLoading) {
      // Show loading indicator while checking authentication
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (authState.auth != null && authState.user != null) {
      // If the user is logged in, navigate to the HomeScreen
      return const NewBottomBar();
    } else {
      // If the user is not logged in, navigate to the LoginScreen
      return const LoginScreen();
    }
  }
}
