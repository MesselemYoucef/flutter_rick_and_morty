import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rick_and_morty/business_logic/cubit/character_cubit.dart';
import 'package:flutter_rick_and_morty/constants/strings.dart';
import 'package:flutter_rick_and_morty/data/models/characters_model.dart';
import 'package:flutter_rick_and_morty/data/repositories/characters_repository.dart';
import 'package:flutter_rick_and_morty/data/web_services/characters_web_services.dart';
import 'presentation/screens/characters_screen.dart';
import 'presentation/screens/character_details_screen.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharacterCubit characterCubit;

  AppRouter() {
    charactersRepository = CharactersRepository(CharactersWebServices());
    characterCubit = CharacterCubit(charactersRepository);
  }
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => characterCubit,
            child: const CharactersScreen(),
          ),
        );
      case characterDetailsScreen:
        final character = settings.arguments as CharactersModel;
        return MaterialPageRoute(
            builder: (_) => CharacterDetailsScreen(character: character,));
    }
  }
}
