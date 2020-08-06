part of 'item_master_bloc.dart';

abstract class ItemMasterEvent extends Equatable {
  const ItemMasterEvent();
}

class AddItem extends ItemMasterEvent {
  final Map itemmaster;
  AddItem({this.itemmaster});
  @override
  List<Object> get props => throw UnimplementedError();
}

// class LoadCategory extends ItemMasterEvent {
//   @override
//   List<Object> get props => throw UnimplementedError();
// }