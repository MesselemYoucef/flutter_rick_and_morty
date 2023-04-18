import 'package:flutter/material.dart';
import 'package:flutter_rick_and_morty/constants/colors.dart';
import 'package:flutter_rick_and_morty/data/models/characters_model.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final CharactersModel character;
  const CharacterDetailsScreen({super.key, required this.character});

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColor.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          character.name,
          style: const TextStyle(
            color: MyColor.myWhite,
          ),
          // textAlign: TextAlign.start,
        ),
        background: Hero(
          tag: character.charId,
          child: Image.network(
            character.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              color: MyColor.myWhite,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              color: MyColor.myWhite,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      color: MyColor.myYellow,
      height: 30.0,
      endIndent: endIndent,
      thickness: 2,
    );
  }

  Size calcTextSize(String text) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          color: MyColor.myWhite,
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
        ),
      ),
      textDirection: TextDirection.ltr,
      textScaleFactor: WidgetsBinding.instance.window.textScaleFactor,
    )..layout();
    return textPainter.size;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    characterInfo("Gender: ", character.gender),
                    buildDivider(300),
                    characterInfo("Species: ", character.species),
                    buildDivider(300),
                    characterInfo(
                        "Dead/Alive: ", character.statusIdDeadOrAlive),
                    buildDivider(300),
                    characterInfo("Episodes: ", character.episodes.join("/")),
                    buildDivider(300),
                    characterInfo("Character ID: ", character.created),
                    buildDivider(300),
                  ],
                ),
              )
            ]),
          )
        ],
      ),
    );
  }
}
