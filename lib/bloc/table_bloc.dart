import 'dart:async';
import 'dart:convert';

import 'package:Butyful/Model/table.dart';
import 'package:Butyful/Utils/api.dart';
import 'package:Butyful/Utils/session.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

part 'table_event.dart';
part 'table_state.dart';

class TableBloc extends Bloc<TableEvent, TableState> {
  TableBloc() : super(TableInitial());

  @override
  Stream<TableState> mapEventToState(
    TableEvent event,
  ) async* {
    if (event is LoadTable) {
      yield TableLoading();
      final List<Table> tablelist = await _fetchtable();
      yield TableLoaded(tablelist: tablelist);
    }
  }

  Future<List<Table>> _fetchtable() async {
    Map responseJson;
    final String token = usersession["_token"];
    List<Table> tablelist;

    try {
      final response = await http.get(Api.BASE_URI + Api.TABLEAPI, headers: {
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        if (responseJson["status"]) {
          tablelist = (responseJson["tables"] as List)
              .map((value) => Table.fromjson(value))
              .toList();
          print(responseJson);
        }
      } else {
        responseJson = json.decode(response.body);
      }
    } catch (e) {
      print(e);
    }
    return tablelist;
  }
}
