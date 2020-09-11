import 'package:equatable/equatable.dart';

abstract class CounterState extends Equatable {
  final int count;

  CounterState(this.count);
  @override
  List<Object> get props => [count];
}

class InitialCounterState extends CounterState {
  InitialCounterState(int count) : super(count);
  @override
  String toString() {
    return "$count";
  }
}
