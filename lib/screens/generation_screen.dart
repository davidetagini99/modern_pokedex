// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields

import 'dart:convert';
import 'package:custom_pokedex/classes/UppercaseChars.dart';
import 'package:custom_pokedex/components/AppBar.dart';
import 'package:custom_pokedex/screens/pokemons_details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GenerationScreen extends StatefulWidget {
  final String generationName;

  GenerationScreen({required this.generationName});

  @override
  _GenerationScreenState createState() => _GenerationScreenState();
}

class _GenerationScreenState extends State<GenerationScreen> {
  late List<dynamic> pokemonList = [];

  Future<void> fetchPokemonOfGeneration() async {
    final response = await http.get(Uri.parse(
        'https://pokeapi.co/api/v2/generation/${widget.generationName}'));
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData.containsKey('pokemon_species')) {
        setState(() {
          pokemonList = responseData['pokemon_species'];
        });
      } else {
        throw Exception('Pokemon species data not found in response');
      }
    } else {
      throw Exception('Failed to load Pokémon of this generation');
    }
  }

  late UppercaseChars _uppercaseChars = UppercaseChars();

  @override
  void initState() {
    super.initState();
    fetchPokemonOfGeneration();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "",
        backgroundColor: Theme.of(context).colorScheme.background,
        actions: [],
        elevation: 0,
        shadowColor: Theme.of(context).colorScheme.secondary,
      ),
      body: Padding(
        padding: EdgeInsets.all(13.0),
        child: pokemonList.isEmpty
            ? Center(child: CircularProgressIndicator())
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 160,
                  crossAxisSpacing: 12.0,
                  mainAxisSpacing: 12.0,
                ),
                itemCount: pokemonList.length,
                itemBuilder: (context, index) {
                  final pokemon = pokemonList[index];
                  final pokemonName =
                      _uppercaseChars.capitalize(pokemon['name']);
                  final pokemonUrl = pokemon['url'];
                  final pokemonId =
                      int.parse(pokemonUrl.split('/').reversed.toList()[1]);

                  final imageUrl =
                      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$pokemonId.png';

                  return Container(
                    color: Colors.transparent,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PokemonDetails(pokemonName: pokemonName),
                          ),
                        );
                      },
                      child: Card(
                        color: Theme.of(context).colorScheme.tertiary,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              imageUrl,
                            ),
                            Text(
                              pokemonName,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
