import 'dart:async';
import 'dart:convert';

import 'package:Butyful/Model/itemcategory.dart';
import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:equatable/equatable.dart';
import 'package:Butyful/Utils/api.dart';
import 'package:Butyful/Utils/session.dart';
import 'package:http/http.dart' as http;

part 'item_category_event.dart';
part 'item_category_state.dart';

class ItemCategoryBloc extends Bloc<ItemCategoryEvent, ItemCategoryState> {
  ItemCategoryBloc() : super(ItemCategoryInitial());

  @override
  Stream<ItemCategoryState> mapEventToState(
    ItemCategoryEvent event,
  ) async* {
    if (event is LoadCategory) {
    
      yield CategoryLoading();
      final List<ItemCategory> categorylist = await _fetchcategory();
      yield CategoryLoaded(categorylist: categorylist);
    }
  }

  Future<List<ItemCategory>> _fetchcategory() async {
    Map responseJson;
    final String token = usersession["_token"];
    List<ItemCategory> categorylist;

    try {
      final response = await http.get(Api.BASE_URI + Api.CATEGORYAPI, headers: {
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        if (responseJson["status"]) {
          categorylist = (responseJson["categorys"] as List)
              .map((value) => ItemCategory.fromJson(value))
              .toList();
          print(responseJson);
        }
      } else {
        responseJson = json.decode(response.body);
      }
    } catch (e) {
      print(e);
    }
    return categorylist;
  }
}
