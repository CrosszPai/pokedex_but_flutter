import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_but_flutter/bloc/counter/counter_bloc.dart';
import 'package:pokedex_but_flutter/bloc/pokemon/pokemon.dart';
import 'package:pokedex_but_flutter/bloc/pokemon/pokemon_model.dart';
import 'package:pokedex_but_flutter/bloc/pokemon/pokemon_event.dart';
import 'package:pokedex_but_flutter/bloc/pokemon/pokemon_repository.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final CounterBloc counterBloc;
  final PokemonRepositoy pokemonRepositoy;
  StreamSubscription countSubscription;
  PokemonBloc(
      {PokemonState initialState,
      @required this.counterBloc,
      @required this.pokemonRepositoy})
      : super(initialState) {
    pokemonRepositoy.getPokemon().then((value) {
      try {
        List<dynamic> data = jsonDecode(value.body)['results'];
        this.add(SetPokemon(data));
      } catch (e) {
        this.add(GotPokemonError(e.toString()));
      }
    }).catchError((err) {
      this.add(GotPokemonError(err.toString()));
    });
    countSubscription = counterBloc.listen((counter) {
      pokemonRepositoy.getPokemon(generation: counter.count).then((value) {
        try {
          List<dynamic> data = jsonDecode(value.body)['results'];
          this.add(SetPokemon(data));
        } catch (e) {
          this.add(GotPokemonError(e.toString()));
        }
      }).catchError((err) {
        this.add(GotPokemonError(err.toString()));
      });
    });
  }
  @override
  Future<void> close() {
    countSubscription.cancel();
    return super.close();
  }

  @override
  Stream<PokemonState> mapEventToState(PokemonEvent event) async* {
    if (event is SetPokemon) {
      yield* _mapSetPokemonToState(event);
    }
    if (event is GotPokemonError) {
      yield PokemonQueryFail(event.reason);
    }
  }

  Stream<PokemonState> _mapSetPokemonToState(SetPokemon event) async* {
    if (state is PokemonState) {
      List<Pokemon> real =
          event.pokemonRaw.map((e) => Pokemon(e['name'], e['url'])).toList();
      yield PokemonList(real);
    }
  }
}
