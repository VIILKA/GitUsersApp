import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:g_hub/generated/locale_keys.g.dart';
import 'package:g_hub/data/repositories/githubUsers/github_users_repository.dart';
import 'package:g_hub/data/repositories/githubUsers/models/github_user.dart';
import 'package:g_hub/features/presentation/userDetailPage/widgets/user_data_item.dart';

class UserDetailPage extends StatefulWidget {
  const UserDetailPage({Key? key}) : super(key: key);

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  late GithubUser user;
  Map<String, dynamic>? userData;

  @override
  void didChangeDependencies() {
    final arg = ModalRoute.of(context)?.settings.arguments;

    if (arg == null) {
      print('НЕТУ ДАННЫХ');
      return;
    }

    user = arg as GithubUser;

    _getUserDetails();

    super.didChangeDependencies();
  }

  Future<void> _getUserDetails() async {
    print(user.name);
    userData = await GithubUsersRepository().fetchUserData(user.name);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 36, 41, 46),
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    user.name,
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  )
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 221, 221, 221),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: ClipOval(
                                child: Image(
                                  image: NetworkImage(user.imageUrl),
                                  height: 100,
                                  width: 100,
                                ),
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 0, 80, 19),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  width: 1,
                                  color: Color.fromARGB(255, 17, 109, 14)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (userData != null &&
                                      userData!['name'] != null)
                                    Text(
                                      userData!['name']!,
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w500),
                                    )
                                  else if (userData != null &&
                                      userData!['name'] != null)
                                    Text('-'),
                                  if (userData != null &&
                                      userData!['location'] != null)
                                    Text(
                                      userData!['location']!,
                                    )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    width: double.infinity,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 15, left: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (userData != null)
                            ..._buildUserDataWidgets()
                          else
                            CircularProgressIndicator(),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 221, 221, 221),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                            10), // Закругляем верхний левый угол
                        topRight: Radius.circular(
                            10), // Закругляем верхний правый угол
                      ),
                    ),
                  ),
                ),
              )
              // Показываем индикатор загрузки, пока данные загружаются
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildUserDataWidgets() {
    final List<Widget> widgets = [];

    // Пример извлечения данных из userData и создания виджетов для их отображения
    final String? company = userData!['company'] as String?;
    if (company != null) {
      widgets.add(UserDataItem(
        item: company,
        itemName: LocaleKeys.company.tr(),
      ));
    }

    final String? email = userData!['email'] as String?;
    if (email != null) {
      widgets.add(UserDataItem(
        item: email,
        itemName: LocaleKeys.email.tr(),
      ));
    }

    final String? blog = userData!['blog'] as String?;
    if (blog != null && blog != '') {
      widgets.add(UserDataItem(
        item: blog,
        itemName: LocaleKeys.blog.tr(),
      ));
    }

    final String? bio = userData!['bio'] as String?;
    if (bio != null) {
      widgets.add(UserDataItem(
        item: bio,
        itemName: LocaleKeys.bio.tr(),
      ));
    }

    return widgets;
  }
}
