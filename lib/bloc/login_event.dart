part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class Authenticate extends LoginEvent {
  final Map user;

  Authenticate({this.user});

  @override
  List<Object> get props => throw UnimplementedError();
}
