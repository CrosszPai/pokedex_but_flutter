import 'package:equatable/equatable.dart';
import 'package:pokedex_but_flutter/bloc/pokemon/pokemon_model.dart';

abstract class PokemonState extends Equatable {
  PokemonState();
  @override
  List<Object> get props => [];
}

class PokemonList extends PokemonState {
  final List<Pokemon> pokemons;

  PokemonList([this.pokemons = const []]);

  @override
  List<Object> get props => [pokemons];

  @override
  String toString() {
    return pokemons.toString();
  }
}

class PokemonQueryFail extends PokemonState {
  final String reason;

  PokemonQueryFail(this.reason);

  @override
  List<Object> get props => [reason];

  @override
  String toString() {
    return reason;
  }
}
