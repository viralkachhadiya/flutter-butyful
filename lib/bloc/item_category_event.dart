part of 'item_category_bloc.dart';

abstract class ItemCategoryEvent extends Equatable {
  const ItemCategoryEvent();
}

class LoadCategory extends ItemCategoryEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}

