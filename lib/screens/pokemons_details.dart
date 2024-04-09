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

  @override
  void initState() {
    super.initState();
    fetchPokemonImage();
  }

  Future<void> fetchPokemonImage() async {
    final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/${widget.pokemonName.toLowerCase()}'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      setState(() {
        imageUrl = data['sprites']['front_default'];
      });
    } else {
      throw Exception('Failed to load pokemon details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(),
    );
  }
}
