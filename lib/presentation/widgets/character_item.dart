import 'package:flutter/material.dart';

import '../../data/models/characters_model.dart';

class CharacterItem extends StatelessWidget {
  final CharactersModel character;
  const CharacterItem({required this.character, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      color: Colors.red,
      child: Text(character.name),
    ) ;
  }
}