import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_but_flutter/bloc/appObserver.dart';
import 'package:pokedex_but_flutter/bloc/counter/counter.dart';
import 'package:pokedex_but_flutter/bloc/counter/counter_bloc.dart';
import 'package:pokedex_but_flutter/bloc/pokemon/pokemon.dart';
import 'package:pokedex_but_flutter/bloc/pokemon/pokemon_bloc.dart';
import 'package:pokedex_but_flutter/bloc/pokemon/pokemon_repository.dart';
import 'package:pokedex_but_flutter/screens/detail.dart';

import 'package:pokedex_but_flutter/screens/home.dart';

void main() {
  Bloc.observer = AppObserver();
  final BlocProvider<CounterBloc> blocProvider = BlocProvider<CounterBloc>(
    create: (_) => CounterBloc(InitialCounterState(1)),
    child: BlocProvider(
        create: (context) => PokemonBloc(
            pokemonRepositoy: PokemonRepositoy(),
            counterBloc: BlocProvider.of<CounterBloc>(context),
            initialState: PokemonList()),
        child: MyApp()),
  );
  runApp(blocProvider);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/': (context) => HomeScreen(),
        '/detail': (context) => PokemonDetail()
      },
    );
  }
}
