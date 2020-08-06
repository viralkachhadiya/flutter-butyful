import 'dart:async';
import 'dart:convert';

import 'package:Butyful/Model/item_master_report.dart';
import 'package:Butyful/Utils/api.dart';
import 'package:Butyful/Utils/session.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

part 'item_master_report_event.dart';
part 'item_master_report_state.dart';

class ItemMasterReportBloc
    extends Bloc<ItemMasterReportEvent, ItemMasterReportState> {
  ItemMasterReportBloc() : super(ItemMasterReportInitial());

  @override
  Stream<ItemMasterReportState> mapEventToState(
    ItemMasterReportEvent event,
  ) async* {
    if (event is LoadItemMasterReport) {
      yield ItemMasterReportLoading();
      final List<ItemMasterReport> imrlist = await _fetchIMR();
      yield ItemMaterReportLoaded(imrlist: imrlist);
    }
  }

  Future<List<ItemMasterReport>> _fetchIMR() async {
    Map responseJson;
    final String token = usersession["_token"];
    List<ItemMasterReport> itemlist;

    try {
      final response = await http.get(Api.BASE_URI + Api.IMRAPI, headers: {
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        if (responseJson["status"]) {
          itemlist = (responseJson["items"] as List)
              .map((value) => ItemMasterReport.fromJson(value))
              .toList();
        }
      } else {
        responseJson = json.decode(response.body);
      }
    } catch (e) {
      print(e);
    }
    return itemlist;
  }
}
