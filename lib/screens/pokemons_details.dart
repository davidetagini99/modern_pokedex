// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PokemonDetails extends StatefulWidget {
  final String pokemonName;

  const PokemonDetails({Key? key, required this.pokemonName}) : super(key: key);

  @override
  _PokemonDetailsState createState() => _PokemonDetailsState();
}

class _PokemonDetailsState extends State<PokemonDetails> {
  String? imageUrl;
  int? pokemonId;

  Future<void> fetchPokemonImage() async {
    final pokemonName = widget.pokemonName.toLowerCase();
    final response = await http
        .get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$pokemonName'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final String newImageUrl = data['sprites']['front_default'];

      setState(() {
        imageUrl = newImageUrl;
      });
    } else {
      throw Exception('Failed to load Pokémon details');
    }
  }

  Future<void> fetchPokemonId(String idPokemon) async {
    final pokemonNumber = idPokemon.toLowerCase();

    final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$pokemonNumber'));

    if(response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final int newPokemonId = data['id'];

      setState(() {
        pokemonId = newPokemonId;
      });
    }
    else {
      throw Exception("failed to load pokemon number");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPokemonImage();
    fetchPokemonId(widget.pokemonName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 120,
              color: Theme.of(context).colorScheme.tertiary,
              padding: EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 380,
                  color: Theme.of(context).colorScheme.tertiary,
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.pokemonName,
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        width: 200,
                        height: 200,
                        color: Colors.transparent,
                        padding: EdgeInsets.all(7.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              pokemonId != null ? pokemonId.toString() : '',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 300,
                      height: 500,
                      color: Colors.transparent,
                      padding: EdgeInsets.only(
                        top: 40.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          imageUrl != null
                              ? Image.network(
                                  imageUrl!,
                                  width: 220,
                                  height: 210,
                                  fit: BoxFit.fill,
                                )
                              : CircularProgressIndicator(),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
