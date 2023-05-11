import 'package:doc_saver_app/helper/size_box_helper.dart';
import 'package:doc_saver_app/provider/auth_provider.dart';
import 'package:doc_saver_app/provider/user_info_provider.dart';
import 'package:doc_saver_app/widgets/custom_button.dart';
import 'package:doc_saver_app/widgets/custom_text_field.dart';
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
                    TextEditingController controller = TextEditingController();

                    //provider.updateUsername('Devero');
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Container(
                          height: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                CustomTextField(
                                  controller: controller,
                                  hintText: 'Enter a new username',
                                  prefixIconData: Icons.person,
                                  validator: (value) {
                                    return null;
                                  },
                                  labelText: 'Username',
                                ),
                                SizeBoxHelper.sizeBox20,
                                CustomButton(
                                    onPressed: () {
                                      print(' Controller value: $controller');
                                      provider.updateUsername(
                                          controller.text, context);
                                    },
                                    title: 'Update username'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ); //showModalBottomSheet
                  },
                  icon: const Icon(Icons.edit),
                ),
              );
            }),
            SettingsCardWidget(
              title: provider.user!.email!,
              leadingIcon: Icons.email,
            ),
            SettingsCardWidget(
              title: 'Logout',
              leadingIcon: Icons.logout,
              trailing: IconButton(
                onPressed: () {
                  Provider.of<AuthProvider>(context, listen: false)
                      .logOut(context);
                },
                icon: const Icon(
                  Icons.logout,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
