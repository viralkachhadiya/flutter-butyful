part of 'production_bloc.dart';

abstract class ProductionEvent extends Equatable {
  const ProductionEvent();
}
class AddProduction extends ProductionEvent {
  final Map production;
  AddProduction({this.production});
  @override
  List<Object> get props => throw UnimplementedError();
}