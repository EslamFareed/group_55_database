part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}


class LoadingGetFriendsState extends HomeState{}
class SuccessGetFriendsState extends HomeState{}
class ErrorGetFriendsState extends HomeState{}