import 'package:flutter/material.dart';
import 'package:flutter_rick_and_morty/data/models/characters_model.dart';


class CharacterDetailsScreen extends StatelessWidget {
  final CharactersModel character;
  const CharacterDetailsScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text("charachter details"),
    );
  }
}