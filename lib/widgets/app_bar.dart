import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as app_bar;
import '../main.dart';
import '../screens/information_screen.dart';
import '../screens/stickers_screen.dart';

class AppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const AppBar({Key? key, required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return app_bar.AppBar(
      title: Text(title),
      actions: [
        PopupMenuButton(
          itemBuilder: (_) => [
            const PopupMenuItem(
              value: PopupMenuOptions.staticStickers,
              child: Text("Static Stickers"),
            ),
            const PopupMenuItem(
              value: PopupMenuOptions.remoteStickers,
              child: Text("Remote Stickers"),
            ),
            const PopupMenuItem(
              value: PopupMenuOptions.informations,
              child: Text("Information"),
            )
          ],
          onSelected: (PopupMenuOptions selectedOption) {
            if (selectedOption == PopupMenuOptions.staticStickers) {
              Navigator.of(context).pushReplacementNamed(
                StickersScreen.routeName,
                arguments: 'staticStickers',
              );
            } else if (selectedOption == PopupMenuOptions.remoteStickers) {
              Navigator.of(context).pushReplacementNamed(
                StickersScreen.routeName,
                arguments: 'remoteStickers',
              );
            } else if (selectedOption == PopupMenuOptions.informations &&
                ModalRoute.of(context)!.settings.name !=
                    InformationScreen.routeName) {
              Navigator.of(context).pushNamed(
                InformationScreen.routeName,
              );
            }
          },
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
