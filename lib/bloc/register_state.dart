part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();
}

class RegisterInitial extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisterLoading extends RegisterState {
  @override
  List<Object> get props => throw UnimplementedError();
}

class RegisterLoaded extends RegisterState {
  final Map responsestatus;
  RegisterLoaded({this.responsestatus});
  @override
  List<Object> get props => throw UnimplementedError();
}
