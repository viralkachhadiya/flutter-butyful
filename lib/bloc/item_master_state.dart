part of 'item_master_bloc.dart';

abstract class ItemMasterState extends Equatable {
  const ItemMasterState();
}

class ItemMasterInitial extends ItemMasterState {
  @override
  List<Object> get props => [];
}

// class CategoryLoading extends ItemMasterState {
//   @override
//   List<Object> get props => throw UnimplementedError();
// }

// class CategoryLoaded extends ItemMasterState {
//   final List<ItemCategory> categorylist;
//   CategoryLoaded({this.categorylist});
//   @override
//   List<Object> get props => throw UnimplementedError();
// }

class ItemLoading extends ItemMasterState {
  @override
  List<Object> get props => throw UnimplementedError();
}

class ItemLoaded extends ItemMasterState {
  final Map responsestates;
  ItemLoaded({this.responsestates});
  @override
  List<Object> get props => throw UnimplementedError();
}
