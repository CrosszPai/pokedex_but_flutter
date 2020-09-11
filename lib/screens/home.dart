import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_but_flutter/bloc/counter/counter.dart';
import 'package:pokedex_but_flutter/bloc/counter/counter_bloc.dart';
import 'package:pokedex_but_flutter/bloc/counter/counter_event.dart';
import 'package:pokedex_but_flutter/bloc/pokemon/pokemon.dart';
import 'package:pokedex_but_flutter/bloc/pokemon/pokemon_bloc.dart';
import 'package:pokedex_but_flutter/components/CounterButton.dart';
import 'package:pokedex_but_flutter/screens/detail.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final CounterBloc counterBloc = BlocProvider.of<CounterBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pokedex",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: BlocBuilder<CounterBloc, CounterState>(
          builder: (context, state) {
            return Column(children: [
              Text(
                "Generation : ${state.count.toString()}",
                style: TextStyle(fontSize: 32),
              ),
              BlocBuilder<PokemonBloc, PokemonState>(builder: (ctx, pkm) {
                if (pkm is PokemonList) {
                  return Expanded(
                    child: ListView.separated(
                      itemCount: pkm.pokemons.length,
                      itemBuilder: (context, index) => FlatButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/detail',
                                arguments: ScreenArguments(
                                    pkm.pokemons[index].name, ""));
                          },
                          child: Text(pkm.pokemons[index].name)),
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(
                        height: 32,
                        color: Colors.transparent,
                      ),
                    ),
                  );
                } else if (pkm is PokemonQueryFail) {
                  return Text(pkm.reason);
                }
                return null;
              }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CounterButton(
                    onTap: () {
                      counterBloc.add(Decrement());
                    },
                    text: "dec",
                  ),
                  CounterButton(
                    onTap: () {
                      counterBloc.add(Reset());
                    },
                    text: "rst",
                  ),
                  CounterButton(
                    onTap: () {
                      counterBloc.add(Increment());
                    },
                    text: "inc",
                  )
                ],
              )
            ]);
          },
        ),
      ),
    );
  }
}
