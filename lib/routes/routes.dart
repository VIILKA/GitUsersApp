import 'package:flutter/material.dart';
import 'package:g_hub/features/presentation/userDetailPage/view/user_detail_page.dart';
import 'package:g_hub/features/presentation/usersListPage/view/users_list_page.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> routes = {
    '/user': (context) => UserDetailPage(),
    '/': (context) => UsersListPage()
  };
}
