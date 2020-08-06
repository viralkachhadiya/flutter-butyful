part of 'item_master_report_bloc.dart';

abstract class ItemMasterReportState extends Equatable {
  const ItemMasterReportState();
}

class ItemMasterReportInitial extends ItemMasterReportState {
  @override
  List<Object> get props => [];
}

class ItemMasterReportLoading extends ItemMasterReportState {
  @override
  List<Object> get props => throw UnimplementedError();
}

class ItemMaterReportLoaded extends ItemMasterReportState {
  final List<ItemMasterReport> imrlist;
  ItemMaterReportLoaded({this.imrlist});
  @override
  List<Object> get props => throw UnimplementedError();
}
