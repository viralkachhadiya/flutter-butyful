import 'dart:async';
import 'dart:convert';

import 'package:Butyful/Utils/api.dart';
import 'package:Butyful/Utils/session.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

part 'production_event.dart';
part 'production_state.dart';

class ProductionBloc extends Bloc<ProductionEvent, ProductionState> {
  ProductionBloc() : super(ProductionInitial());

  @override
  Stream<ProductionState> mapEventToState(
    ProductionEvent event,
  ) async* {
    if (event is AddProduction) {
      yield ProductionLoading();
      final responsestatus = await postitem(event.production);
      yield ProductionLoaded(responsestates: responsestatus);
    }
  }

  Future postitem(Map itemmaster) async {
    Map responsestatus;
    final String token = usersession["_token"];
    try {
      final response = await http.post(
        Api.BASE_URI + Api.PRODUCTIONAPI,
        body: json.encode(itemmaster),
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
      return responsestatus;
    } catch (e) {
      print(e);
    }
  }
}
