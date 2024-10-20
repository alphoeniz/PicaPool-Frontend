import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:picapool/firebase_options.dart';
import 'package:picapool/screen_router.dart';
import 'package:picapool/screens/Public%20Chat/publicChatScreen.dart';
import 'package:picapool/screens/chats/chat_homeScreen.dart';
import 'package:picapool/screens/home_screen.dart';
import 'package:picapool/screens/login_screen.dart';

void main() async{
    WidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: ".env");
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    runApp(const MyApp());
  }


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'picapool',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          textSelectionTheme:
              const TextSelectionThemeData(cursorColor: Color(0xffffffff))),
      // home: const LoginScreen(),
      // home: const HomeScreen(),
      home: PublicChatPage(),
      // home: const CreateCabShareScreen(),
      // home: const CreatePoolScreen(),
    );
  }
}
