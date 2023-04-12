import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rick_and_morty/business_logic/cubit/character_cubit.dart';
import 'package:flutter_rick_and_morty/constants/colors.dart';

import '../../data/models/characters_model.dart';
import '../widgets/character_item.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<CharactersModel> allCharacters;
  late List<CharactersModel> searchedForCharacters;
  bool isSearching = false;
  final _searchTextController = TextEditingController();

  Widget _buildSearchField() {
    return TextField(
      controller: _searchTextController,
      cursorColor: MyColor.myGrey,
      decoration: const InputDecoration(
          hintText: 'Find a Character',
          border: InputBorder.none,
          hintStyle: TextStyle(color: MyColor.myGrey, fontSize: 18)),
      style: const TextStyle(color: MyColor.myGrey, fontSize: 18),
      onChanged: (searchedCharacter) {
        addSearchedForItemsToSearchedList(searchedCharacter);
      },
    );
  }

  void addSearchedForItemsToSearchedList(String searchedCharacter) {
    print(searchedCharacter);
    searchedForCharacters = allCharacters
        .where((character) =>
            character.name.toLowerCase().contains(searchedCharacter))
        .toList();
    setState(() {});
  }

  List<Widget> _buildAppBarActions() {
    if (isSearching) {
      return [
        IconButton(
          onPressed: () {
            _clearSearch();
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.clear,
            color: MyColor.myGrey,
          ),
        )
      ];
    } else {
      return [
        IconButton(
            onPressed: _startSearch,
            icon: const Icon(
              Icons.search,
              color: MyColor.myGrey,
            ))
      ];
    }
  }

  // the add historyentry method below will add the back arrow to the widget
  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();
    setState(() {
      isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchTextController.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharacterCubit>(context).getAllCharacters();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharacterCubit, CharacterState>(
        builder: (context, state) {
      if (state is CharacterLoaded) {
        allCharacters = (state).characters;
        return buildLoadedListWidgets();
      } else {
        return showProgressIndicator();
      }
    });
  }

  Widget showProgressIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: MyColor.myYellow,
      ),
    );
  }

  Widget buildLoadedListWidgets() {
    return SingleChildScrollView(
      child: Container(
        color: MyColor.myGrey,
        child: Column(
          children: [
            buildCharactersList(),
          ],
        ),
      ),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount:
          _searchTextController.text.isEmpty ?  allCharacters.length : searchedForCharacters.length,
      itemBuilder: (ctx, index) {
        return CharacterItem(
          character:
              _searchTextController.text.isEmpty ? allCharacters[index] : searchedForCharacters[index] ,
        );
      },
    );
  }

  Widget _buildAppBarTitle() {
    return const Text(
      "Characters",
      style: TextStyle(
        color: MyColor.myGrey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColor.myYellow,
        leading: isSearching
            ? const BackButton(
                color: MyColor.myGrey,
              )
            : Container(),
        title: isSearching ? _buildSearchField() : _buildAppBarTitle(),
        actions: _buildAppBarActions(),
      ),
      body: buildBlocWidget(),
    );
  }
}
