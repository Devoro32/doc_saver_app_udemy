import 'package:doc_saver_app/helper/size_box_helper.dart';
import 'package:doc_saver_app/provider/user_info_provider.dart';
import 'package:doc_saver_app/widgets/screen_background.dart';
import 'package:doc_saver_app/widgets/settings_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  static String routeName = '/settingsScreen';
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserInfoProvider>(
      context,
      listen: false,
    );
    provider.getUserName();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ScreenBackgroundWidget(
          child: Column(
        children: [
          Consumer<UserInfoProvider>(builder: (context, provider, child) {
            return SettingsCardWidget(
              title: provider.userName,
              leadingIcon: Icons.person,
              trailing: IconButton(
                onPressed: () {
                  provider.updateUsername('Devero');
                },
                icon: const Icon(Icons.edit),
              ),
            );
          }),
          SettingsCardWidget(
            title: 'user@user.com',
            leadingIcon: Icons.email,
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
