// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'package:custom_pokedex/components/AppBar.dart';
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
      appBar: CustomAppBar(
        title: "",
        backgroundColor: Theme.of(context).colorScheme.background,
        actions: [],
        elevation: 0,
        shadowColor: Theme.of(context).colorScheme.secondary,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 40.0),
        child: Container(
          color: Colors.blue,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                color: Colors.green,
                padding: EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.pokemonName,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "inserire id pokemon",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 27,
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      child: Container(
                        // This is your indigo container
                        alignment: Alignment.center,
                        width: 200,
                        height: 200,
                        color: Colors.indigo,
                        child: Column(
                          mainAxisAlignment:
                              MainAxisAlignment.start, // Center the contents
                          children: [
                            imageUrl != null
                                ? Image.network(
                                    imageUrl!,
                                  )
                                : CircularProgressIndicator(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


/*
Text(
                widget.pokemonName,
              ),
              imageUrl != null
              ? Image.network(
                imageUrl!,
              ) : CircularProgressIndicator(),
*/

/*
child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.pokemonName,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    color: Colors.orange,
                  ),
                ],
              ),
            ],
          ),
*/