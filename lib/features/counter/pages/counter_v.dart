import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_prac/features/counter/bloc/counter_bloc.dart';
import 'package:flutter_bloc_prac/features/counter/bloc/counter_event.dart';
import 'package:flutter_bloc_prac/features/counter/bloc/counter_state.dart';

class CounterView extends StatefulWidget {
  const CounterView({super.key});

  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Counter App",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      body: Column(
        mainAxisAlignment: .center,
        crossAxisAlignment: .center,
        children: [
          BlocBuilder<CounterBloc, CounterState>(
            builder: (context, state) {
              return Text(
                state.counter.toString(),
                style: Theme.of(context).textTheme.headlineLarge,
              );
            },
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: .center,
            children: [
              ElevatedButton(
                onPressed: () {
                  context.read<CounterBloc>().add(IncrementCounter());
                },
                child: Text("Increment"),
              ),
              SizedBox(width: 20),
              ElevatedButton(onPressed: () {
                context.read<CounterBloc>().add(DecrementCounter());
              }, child: Text("Decrement")),
            ],
          ),
        ],
      ),
    );
  }
}
