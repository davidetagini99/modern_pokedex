// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'package:custom_pokedex/components/AppBar.dart';
import 'package:custom_pokedex/screens/pokemons_details.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class PokemonList extends StatefulWidget {
  final String generation;

  const PokemonList({Key? key, required this.generation}) : super(key: key);

  @override
  _PokemonListState createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  late List<String> pokemons = [];

  @override
  void initState() {
    super.initState();
    fetchPokemonList();
  }

  Future<void> fetchPokemonList() async {
    final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/generation/${widget.generation.toLowerCase()}'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['pokemon_species'];
      setState(() {
        pokemons = data.map((e) => e['name']).cast<String>().toList();
      });
    } else {
      throw Exception('Failed to load pokemons');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: "",
        actions: [],
        elevation: 0,
        shadowColor: Theme.of(context).colorScheme.secondary,
      ),
      body: pokemons.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: pokemons.length,
              itemBuilder: (context, index) {
                return ListTile(
                  textColor: Theme.of(context).colorScheme.secondary,
                  title: Text(pokemons[index]),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PokemonDetails(pokemonName: pokemons[index]),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
