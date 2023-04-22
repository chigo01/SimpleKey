import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_key/src/feautures/Home%20Screen/presentation/views/homeScreen.dart';
import 'package:simple_key/src/feautures/auth/data/controller/provider/provider.dart';
import 'package:simple_key/src/feautures/message/presentation/message_preview.dart';
import 'package:simple_key/src/feautures/propertyPost/presentation/views/propertEntry.dart';
import 'package:simple_key/src/feautures/userProfile/presentation/views/userprofile/user_profile.dart';

import 'PaymentPage.dart';
import 'menu_widget.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  MenuItem currentItem = menuItems[0];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) =>
            ZoomDrawer(
          menuBackgroundColor: Theme.of(context).primaryColor,
          borderRadius: 24.0,
          angle: -1,
          slideWidth: MediaQuery.of(context).size.width * .5,
          menuScreen: Builder(builder: (context) {
            return MenuPage(
              currentItem: currentItem,
              onSelectedItem: (item) {
                setState(() => currentItem = item);

                ZoomDrawer.of(context)?.close();
              },
            );
          }),
          mainScreen: getScreen(ref),
        ),
      ),
    );
  }

  dynamic getScreen(WidgetRef ref) {
    switch (currentItem.title) {
      case 'Post Property':
        return const PropertyPost();
      case 'Home':
        return const HomeScreen();
      case 'Profile':
        return const Profile();
      case 'Messages':
        return const MessagePreview();
      case 'Notifications':
        return const Notifications();
      default:
        return LogOut();
      // return ref.read(authNotifierProvider.notifier).signOut().whenComplete(
      //       () => const LogOut(),
      //     );
    }
  }
}
