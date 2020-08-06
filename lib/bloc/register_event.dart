part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}
class AddUser extends RegisterEvent {
  final Map user;

  AddUser({this.user});

  @override
  List<Object> get props => throw UnimplementedError();
}
