import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_hub/data/repositories/githubUsers/github_users_repository.dart';
import 'package:g_hub/data/repositories/githubUsers/models/github_user.dart';

part 'users_list_event.dart';
part 'users_list_state.dart';

class UsersListBloc extends Bloc<UsersListEvent, UsersListState> {
  final GithubUsersRepository githubUsersRepository;

  UsersListBloc(this.githubUsersRepository) : super(UsersListInitial()) {
    on<UsersListLoad>((event, emit) async {
      try {
        final usersList =
            await githubUsersRepository.fetchUsers(since: event.since);
        emit(UsersListLoaded(usersList: usersList));
      } catch (e) {
        emit(UsersListLoadingFailure(exception: e));
      }
    });
  }
}
