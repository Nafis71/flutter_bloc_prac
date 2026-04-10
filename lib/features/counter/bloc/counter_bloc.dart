import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_prac/features/counter/bloc/counter_event.dart';
import 'package:flutter_bloc_prac/features/counter/bloc/counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(counter: 0)) {
    on<IncrementCounter>(_incrementCounter);
    on<DecrementCounter>(_decrementCounter);
  }

  void _incrementCounter(IncrementCounter event, Emitter<CounterState> emit) {
    emit(state.copyWith(counter: (state.counter ?? 0) + 1));
  }

  void _decrementCounter(DecrementCounter even, Emitter<CounterState> emit){
    emit(state.copyWith(counter: (state.counter ?? 0) - 1));
  }
}
