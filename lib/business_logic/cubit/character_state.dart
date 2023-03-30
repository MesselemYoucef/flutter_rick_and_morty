part of 'character_cubit.dart';

@immutable
abstract class CharacterState {}

class CharacterInitial extends CharacterState {}

class CharacterLoaded extends CharacterState {
  final List<CharactersModel> characters;

  CharacterLoaded(this.characters);
}
