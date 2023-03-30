import 'package:bloc/bloc.dart';
import 'package:flutter_rick_and_morty/data/models/characters_model.dart';
import 'package:meta/meta.dart';
import '../../data/repositories/characters_repository.dart';

part 'character_state.dart';

class CharacterCubit extends Cubit<CharacterState> {
  final CharactersRepository charactersRepository;
  List<CharactersModel> characters = [];
  CharacterCubit(this.charactersRepository) : super(CharacterInitial());

  List<CharactersModel> getAllCharacters() {
    charactersRepository.getAllCharacters().then((characters) {
      emit(CharacterLoaded(characters));
      this.characters = characters;
    });
    return characters;
  }
}
