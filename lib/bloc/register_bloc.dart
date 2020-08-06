import 'dart:async';
import 'dart:convert';

import 'package:Butyful/Utils/api.dart';
import 'package:Butyful/Utils/session.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial());

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is AddUser) {
      yield RegisterLoading();
      final Map response = await postuser(event.user);
      yield RegisterLoaded(responsestatus: response);
    }
  }

  Future postuser(Map data) async {
    Map responsestatus;
    final String token = usersession["_token"];
    print(token);
    try {
      final response = await http.post(
        Api.BASE_URI + Api.REGISTERAPI,
        body: json.encode(data),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        print(response.body);
        responsestatus = json.decode(response.body);
      } else {
        responsestatus = json.decode(response.body);
      }
      print(response.body);
      return responsestatus;
    } catch (e) {
      print(e);
    }
  }
}
