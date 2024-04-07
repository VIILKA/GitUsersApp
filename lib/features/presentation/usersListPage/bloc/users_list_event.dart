part of 'users_list_bloc.dart';

abstract class UsersListEvent {}

class UsersListLoad extends UsersListEvent {
  final int since;

  UsersListLoad({required this.since});
}
