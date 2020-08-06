import 'dart:async';
import 'dart:convert';

import 'package:Butyful/Utils/api.dart';
import 'package:Butyful/Utils/session.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

part 'item_master_event.dart';
part 'item_master_state.dart';

class ItemMasterBloc extends Bloc<ItemMasterEvent, ItemMasterState> {
  ItemMasterBloc() : super(ItemMasterInitial());

  @override
  Stream<ItemMasterState> mapEventToState(
    ItemMasterEvent event,
  ) async* {
    if (event is AddItem) {
      yield ItemLoading();
      final responsestatus = await postitem(event.itemmaster);
      yield ItemLoaded(responsestates: responsestatus);
    }
  }

  Future postitem(Map itemmaster) async {
    Map responsestatus;
    final String token = usersession["_token"];
    try {
      final response = await http.post(
        Api.BASE_URI + Api.IMRAPI,
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

  // Future<List<ItemCategory>> _fetchcategory() async {
  //   Map responseJson;
  //   final String token = usersession["_token"];
  //   List<ItemCategory> categorylist;

  //   try {
  //     final response = await http.get(Api.BASE_URI + Api.CATEGORYAPI, headers: {
  //       'Authorization': 'Bearer $token',
  //     });

  //     if (response.statusCode == 200) {
  //       responseJson = json.decode(response.body);
  //       if (responseJson["status"]) {
  //         categorylist = (responseJson["categorys"] as List)
  //             .map((value) => ItemCategory.fromJson(value))
  //             .toList();
  //         print(responseJson);
  //       }
  //     } else {
  //       responseJson = json.decode(response.body);
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  //   return categorylist;
  // }
}
