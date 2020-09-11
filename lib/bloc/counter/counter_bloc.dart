import 'package:bloc/bloc.dart';
import 'package:pokedex_but_flutter/bloc/counter/counter.dart';
import 'package:pokedex_but_flutter/bloc/counter/counter_event.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc(CounterState initialState) : super(initialState);

  @override
  Stream<CounterState> mapEventToState(CounterEvent event) async* {
    if (event is Increment) {
      yield InitialCounterState(state.count + (state.count < 5 ? 1 : 0));
    } else if (event is Decrement) {
      yield InitialCounterState(state.count - (state.count > 1 ? 1 : 0));
    } else if (event is Reset) {
      yield InitialCounterState(1);
    }
  }
}
