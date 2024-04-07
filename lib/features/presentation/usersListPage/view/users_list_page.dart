import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_hub/data/repositories/githubUsers/github_users_repository.dart';
import 'package:g_hub/data/repositories/githubUsers/models/github_user.dart';
import 'package:g_hub/features/presentation/usersListPage/bloc/users_list_bloc.dart';
import 'package:g_hub/features/presentation/usersListPage/widgets/app_bar_widget.dart';
import 'package:g_hub/features/presentation/usersListPage/widgets/my_grid_view.dart';
import 'package:g_hub/features/presentation/usersListPage/widgets/users_list_Loading_failure.dart';

class UsersListPage extends StatefulWidget {
  const UsersListPage({Key? key}) : super(key: key);

  @override
  State<UsersListPage> createState() => _UsersListPageState();
}

class _UsersListPageState extends State<UsersListPage> {
  int since = 0;
  List<GithubUser> myUsersList = [];
  final UsersListBloc usersListBloc = UsersListBloc(GithubUsersRepository());
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadMoreUsers();
    scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 36, 41, 46),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBarWidget(),
      ),
      body: SafeArea(
        child: BlocBuilder<UsersListBloc, UsersListState>(
          bloc: usersListBloc,
          builder: (context, state) {
            switch (state.runtimeType) {
              case UsersListLoaded:
                myUsersList.addAll((state as UsersListLoaded).usersList);
                return MyGridView(
                  scrollController: scrollController,
                  myUsersList: myUsersList,
                );
              case UsersListLoadingFailure:
                return UsersListLoadingFailureWidget();
              default:
                return Center(
                  child: CircularProgressIndicator(color: Colors.amber),
                );
            }
          },
        ),
      ),
    );
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      _loadMoreUsers();
    }
  }

  void _loadMoreUsers() {
    final lastUserId = myUsersList.isNotEmpty ? myUsersList.last.id : 0;
    usersListBloc.add(UsersListLoad(since: lastUserId));
  }
}
