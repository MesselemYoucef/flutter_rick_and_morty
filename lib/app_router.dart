import 'package:flutter/material.dart';
import 'package:flutter_rick_and_morty/constants/strings.dart';
import 'presentation/screens/characters_screen.dart';
import 'presentation/screens/character_details_screen.dart';

class AppRouter{
  Route? onGenerateRoute(RouteSettings routeSettings){
    switch (routeSettings.name) {
      case charactersScreen:
        return MaterialPageRoute(builder: (_)=> const CharactersScreen());
      case characterDetailsScreen:
        return MaterialPageRoute(builder: (_)=> const CharacterDetailsScreen());
    }
  
  }
}