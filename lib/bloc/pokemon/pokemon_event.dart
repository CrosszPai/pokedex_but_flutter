import 'package:equatable/equatable.dart';

abstract class PokemonEvent extends Equatable {}

class SetPokemon extends PokemonEvent {
  final List<dynamic> pokemonRaw;

  SetPokemon(this.pokemonRaw);
  @override
  List<Object> get props => [pokemonRaw];
}

class GotPokemonError extends PokemonEvent {
  final String reason;

  GotPokemonError(this.reason);

  @override
  List<Object> get props => [reason];
}
