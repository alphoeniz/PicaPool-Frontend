// import 'package:flutter/material.dart';
// import 'package:picapool/dummy_screen.dart';
// import 'package:picapool/screens/home_screen.dart';
// import 'package:picapool/utils/svg_icon.dart';
// import 'package:picapool/widgets/bottom_navbar/bottom_bar.dart';

// class ScreenRouter extends StatefulWidget {
//   const ScreenRouter({super.key});

//   @override
//   State<ScreenRouter> createState() => _ScreenRouterState();
// }

// class _ScreenRouterState extends State<ScreenRouter> {
//   int currentIndex = 0;

//   List<Widget> tabList = [
//     const HomeScreen(),
//     const DummyScreen(),
//     const DummyScreen(),
//     const DummyScreen(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Stack(children: [
//         tabList[currentIndex],
//         Container(
//           alignment: Alignment.bottomCenter,
//           child: BottomBar(
//             items: const [
//               SvgIcon(
//                 'assets/bottombar/Home1.svg',
//                 size: 22,
//               ),
//               SvgIcon(
//                 'assets/bottombar/chats.svg',
//                 size: 24,
//               ),
//               SvgIcon(
//                 'assets/bottombar/alert.svg',
//                 size: 24,
//               ),
//               SvgIcon(
//                 'assets/bottombar/settings.svg',
//                 size: 24,
//               ),
//             ],
//             activeItems: const [
//               SvgIcon(
//                 'assets/bottombar/Home1_active.svg',
//                 size: 22,
//               ),
//               SvgIcon(
//                 'assets/bottombar/chats_active.svg',
//                 size: 24,
//               ),
//               SvgIcon(
//                 'assets/bottombar/alert_active.svg',
//                 size: 24,
//               ),
//               SvgIcon(
//                 'assets/bottombar/settings_active.svg',
//                 size: 24,
//               ),
//             ],
//             titles: const ['home', 'chats', 'alerts', 'settings'],
//             currentIndex: 0,
//             onTap: (value) {
//               setState(() {
//                 currentIndex = value;
//               });
//             },
//           ),
//         ),
//       ]),
//     );
//   }
// }
