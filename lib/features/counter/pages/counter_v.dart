import 'package:flutter/material.dart';

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
        title: Text("Counter App",style: Theme.of(context).textTheme.headlineLarge,),
      ),
      body: Column(
        mainAxisAlignment: .center,
        crossAxisAlignment: .center,
        children: [
          Text("0",style: Theme.of(context).textTheme.headlineLarge,),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: .center,
            children: [
              ElevatedButton(onPressed: (){}, child: Text("Increment"),),
              SizedBox(width: 20,),
              ElevatedButton(onPressed: (){}, child: Text("Decrement"),),
            ],
          )
        ],
      ),
    );
  }
}
