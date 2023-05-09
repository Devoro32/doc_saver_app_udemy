import 'package:doc_saver_app/helper/size_box_helper.dart';
import 'package:doc_saver_app/widgets/screen_background.dart';
import 'package:doc_saver_app/widgets/settings_card.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  static String routeName = '/settingsScreen';
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ScreenBackgroundWidget(
          child: Column(
        children: [
          SettingsCardWidget(
            title: 'Username',
            leadingIcon: Icons.person,
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(Icons.edit),
            ),
          ),
          SettingsCardWidget(
            title: 'user@user.com',
            leadingIcon: Icons.person,
          ),
          SettingsCardWidget(
            title: 'Logout',
            leadingIcon: Icons.logout,
          )
        ],
      )),
    );
  }
}
