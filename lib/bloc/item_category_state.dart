part of 'item_category_bloc.dart';

abstract class ItemCategoryState extends Equatable {
  const ItemCategoryState();
}

class ItemCategoryInitial extends ItemCategoryState {
  @override
  List<Object> get props => [];
}

class CategoryLoading extends ItemCategoryState {
  @override
  List<Object> get props => throw UnimplementedError();
}

class CategoryLoaded extends ItemCategoryState {
  final List<ItemCategory> categorylist;
  CategoryLoaded({this.categorylist});
  @override
  List<Object> get props => throw UnimplementedError();
}
