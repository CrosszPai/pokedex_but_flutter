import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex_but_flutter/bloc/pokemon/pokemon_model.dart';

class ScreenArguments {
  final String detail;
  final String message;

  ScreenArguments(this.detail, this.message);
}

class PokemonDetail extends StatefulWidget {
  @override
  _PokemonDetailState createState() => _PokemonDetailState();
}

class _PokemonDetailState extends State<PokemonDetail>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  var pokemon;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      ScreenArguments arg = ModalRoute.of(context).settings.arguments;
      http
          .get('https://pokeapi.co/api/v2/pokemon/${arg.detail}')
          .then((value) => value.body)
          .then((value) {
        return jsonDecode(value);
      }).then((value) {
        setState(() {
          pokemon = value;
        });
        print(pokemon['sprites']['front_default']);
      });
    });
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(pokemon);
    final ScreenArguments arg = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text(arg.detail),
          backgroundColor: Color.fromARGB(255, 93, 58, 207),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              pokemon != null
                  ? Image.network(
                      pokemon['sprites']['front_default'],
                      width: 300,
                      height: 300,
                      fit: BoxFit.fill,
                    )
                  : Container()
            ],
          ),
        ));
  }
}
