import 'dart:async';
import 'dart:convert';
import 'package:Butyful/Utils/api.dart';
import 'package:Butyful/Utils/session.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is Authenticate) {
      yield LoginLoading();
      final Map response = await postuser(event.user);
      yield LoginLoaded(responsestatus: response);
    }
  }

  Future postuser(Map data) async {
    Map responsestatus;
    try {
      final response = await http.post(
        Api.BASE_URI + Api.USERAPI,
        body: json.encode(data),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        print(response.body);
        responsestatus = json.decode(response.body);
        if (responsestatus["status"]) {
          box.put("user", responsestatus);
        }
      } else {
        responsestatus = json.decode(response.body);
      }
      return responsestatus;
    } catch (e) {
      print(e);
    }
  }
}
