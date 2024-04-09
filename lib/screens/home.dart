// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'dart:convert';
import 'package:custom_pokedex/components/AppBar.dart';
import 'package:custom_pokedex/screens/settings.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:custom_pokedex/screens/pokemons.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<String> generations = [];

  @override
  void initState() {
    super.initState();
    fetchGenerations();
  }

  Future<void> fetchGenerations() async {
    final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/generation'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['results'];
      setState(() {
        generations = data.map((e) => e['name']).cast<String>().toList();
      });
    } else {
      throw Exception('Failed to load generations');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "modern pokedex",
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Settings()),
              );
            },
          ),
        ],
      ),
      body: generations.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: generations.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(generations[index]),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PokemonList(generation: generations[index])),
                    );
                  },
                );
              },
            ),
    );
  }
}