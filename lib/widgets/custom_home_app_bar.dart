import 'package:doc_saver_app/helper/size_box_helper.dart';
import 'package:doc_saver_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class CustomHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(170),
      child: Container(
        color: const Color(0xff1e5376),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "assets/images/icon_text.png",
                      width: 150,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.settings),
                      color: Colors.white,
                    )
                  ],
                ),
                SizeBoxHelper.sizeBox20,
                CustomTextField(
                  controller: TextEditingController(),
                  hintText: 'Enter the title of the document',
                  prefixIconData: Icons.search,
                  validator: (value) {
                    return null;
                  },
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Text('Go'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(150);
}
