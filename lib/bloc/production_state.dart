part of 'production_bloc.dart';

abstract class ProductionState extends Equatable {
  const ProductionState();
}

class ProductionInitial extends ProductionState {
  @override
  List<Object> get props => [];
}

class ProductionLoading extends ProductionState {
  @override
  List<Object> get props => throw UnimplementedError();
}

class ProductionLoaded extends ProductionState {
  final Map responsestates;
  ProductionLoaded({this.responsestates});
  @override
  List<Object> get props => throw UnimplementedError();
}
