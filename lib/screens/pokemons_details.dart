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
    final response = await http.get(Uri.parse(
        'https://pokeapi.co/api/v2/pokemon/${widget.pokemonName.toLowerCase()}'));
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
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 120,
              color: Theme.of(context).colorScheme.primary,
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
                  height: 345,
                  color: Theme.of(context).colorScheme.primary,
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
                              "indn",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  top: 45,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 500,
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        imageUrl != null
                        ? Image.network(
                          imageUrl!,
                          width: 320,
                          height: 300,
                          fit: BoxFit.cover,
                        )
                        : CircularProgressIndicator(), // circular progress indicator injects when the data system can't find the sprite of the selected pokemon
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}