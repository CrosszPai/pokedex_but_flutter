import 'package:http/http.dart' as http;
import 'package:pokedex_but_flutter/helper/helper.dart';

class PokemonRepositoy {
  Future getPokemon({int generation = 1}) async {
    var gen = generationToLimit(generation);
    var lim = gen[1] - gen[0] + 1;
    var offset = gen[0] - 1;
    return http
        .get("https://pokeapi.co/api/v2/pokemon?limit=$lim&offset=$offset");
  }
}
