import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:picapool/widgets/home/down_sheet.dart';
import 'package:picapool/widgets/home/explore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: NewBottomBar(),
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(color: Color(0xff02005D)),
        child: Stack(
          children: [
            const ExploreWidget(),
            Container(
              alignment: Alignment.bottomCenter,
              child: const DownSheet(),
            ),
            // Container(alignment: Alignment.bottomCenter, child: const UpSheet())
          ],
        ),
      ),
    );
  }
}
