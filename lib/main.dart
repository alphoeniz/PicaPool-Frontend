import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:picapool/controllers/bindings/product_bindings.dart';
import 'package:picapool/controllers/network_controller.dart';
import 'package:picapool/controllers/sell_form_controller.dart';
import 'package:picapool/firebase_options.dart';
import 'package:picapool/screen_router.dart';
import 'package:picapool/screens/Public%20Chat/publicChatScreen.dart';
import 'package:picapool/screens/chats/chat_homeScreen.dart';
import 'package:picapool/screens/home_screen.dart';
import 'package:picapool/screens/login_screen.dart';
import 'package:picapool/utils/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SystemChrome.setPreferredOrientations(
    <DeviceOrientation>[
      DeviceOrientation.portraitUp
    ]
  );
  Get.put(FormController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      enableLog: true,
      initialBinding: ProductBindings(),
      title: 'picapool',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          textSelectionTheme:
              const TextSelectionThemeData(cursorColor: Color(0xffffffff))),
      // Implement Auth
      // tokenExists ? homeScreen : loginScreen
      getPages: GetRoutes.routes,
    );
  }
}
