part of 'table_bloc.dart';

abstract class TableState extends Equatable {
  const TableState();
}

class TableInitial extends TableState {
  @override
  List<Object> get props => [];
}
class TableLoading extends TableState {
  @override
  List<Object> get props => throw UnimplementedError();
}

class TableLoaded extends TableState {
  final List<Table> tablelist;
  TableLoaded({this.tablelist});
  @override
  List<Object> get props => throw UnimplementedError();
}