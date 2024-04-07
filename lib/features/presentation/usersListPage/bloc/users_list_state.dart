part of 'users_list_bloc.dart';

abstract class UsersListState {}

class UsersListInitial extends UsersListState {}

class UsersListLoading extends UsersListState {}

class UsersListLoaded extends UsersListState {
  final List<GithubUser> usersList;

  UsersListLoaded({required this.usersList});
}

class UsersListLoadingFailure extends UsersListState {
  final Object? exception;

  UsersListLoadingFailure({this.exception});
}
