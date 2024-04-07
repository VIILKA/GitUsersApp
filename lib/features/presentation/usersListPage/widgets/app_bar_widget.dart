import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:g_hub/generated/locale_keys.g.dart';

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({
    super.key,
  });

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 8,
      shadowColor: Colors.black,
      backgroundColor: Color.fromARGB(255, 45, 186, 78),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
      title: Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Color.fromARGB(250, 36, 41, 46),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              LocaleKeys.github_users.tr(),
              style: TextStyle(color: Colors.white), // Цвет текста
            ),
            IconButton(
              icon: Icon(Icons.language_outlined),
              color: Colors.white, // Цвет иконки
              onPressed: () {
                if (context.locale == Locale('ru')) {
                  context.setLocale(Locale('en'));
                } else {
                  context.setLocale(Locale('ru'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
