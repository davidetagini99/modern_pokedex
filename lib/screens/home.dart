// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'package:custom_pokedex/classes/DrawerItem.dart';
import 'package:custom_pokedex/components/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:custom_pokedex/components/AppBar.dart';
import 'package:custom_pokedex/screens/settings.dart';
import 'package:custom_pokedex/screens/pokemons.dart';

class Home extends StatefulWidget {
  final Function(ThemeMode) updateTheme;

  Home({required this.updateTheme});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<String> generations = [];

  Future<void> fetchGenerations() async {
    final response =
        await http.get(Uri.parse('https://pokeapi.co/api/v2/generation'));
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
  void initState() {
    super.initState();
    fetchGenerations();
  }

  @override
  Widget build(BuildContext context) {
    List<DrawerItem> drawerItems = [
      DrawerItem(
        title: "settings",
        leadingIcon: Icons.settings,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Settings(updateTheme: widget.updateTheme)),
          );
        },
      ),
    ];

    return Scaffold(
      drawer: CustomDrawer(
        drawerItems: drawerItems,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: "",
        actions: [],
        elevation: 0,
        shadowColor: Theme.of(context).colorScheme.secondary,
      ),
      body: generations.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: generations.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                  textColor: Theme.of(context).colorScheme.secondary,
                  title: Text(generations[index]),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PokemonList(generation: generations[index])),
                    );
                  },
                );
              },
            ),
    );
  }
}