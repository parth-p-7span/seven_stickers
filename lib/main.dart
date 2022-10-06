import 'package:flutter/material.dart';
import 'package:seven_stickers/screens/information_screen.dart';
import 'package:seven_stickers/screens/sticker_pack_info_screen.dart';
import 'package:seven_stickers/screens/stickers_screen.dart';

enum PopupMenuOptions {
  staticStickers,
  remoteStickers,
  informations,
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: StickersScreen.routeName,
      routes: {
        StickersScreen.routeName: (ctx) => const StickersScreen(),
        StickerPackInfoScreen.routeName: (ctx) => const StickerPackInfoScreen(),
        InformationScreen.routeName: (ctx) => const InformationScreen()
      },
    );
  }
}
