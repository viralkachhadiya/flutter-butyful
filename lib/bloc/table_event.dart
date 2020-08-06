part of 'table_bloc.dart';

abstract class TableEvent extends Equatable {
  const TableEvent();
}

class LoadTable extends TableEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}
