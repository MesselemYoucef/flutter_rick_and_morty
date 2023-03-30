import 'package:flutter/material.dart';

import '../web_services/characters_web_services.dart';
import '../models/characters_model.dart';

class CharactersRepository {
  final CharactersWebServices charactersWebServices;

  CharactersRepository(this.charactersWebServices);

  Future<List<CharactersModel>> getAllCharacters() async {
    final characters = await charactersWebServices.getAllCharacters();
    return characters
        .map((character) => CharactersModel.fromJson(character))
        .toList();
  }
}
