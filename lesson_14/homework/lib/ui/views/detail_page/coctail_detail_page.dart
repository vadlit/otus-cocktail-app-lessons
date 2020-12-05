import 'package:flutter/material.dart';
import 'package:homework/core/models.dart';
import '../../style/theme.dart';
import 'sections/cocktail_classification.dart';
import 'sections/cocktail_details.dart';
import 'sections/cocktail_ingredients.dart';
import 'sections/cocktail_instruction.dart';
import 'sections/cocktail_picture.dart';
import 'sections/cocktail_rating_bar.dart';

class CocktailDetailPage extends StatefulWidget {
  const CocktailDetailPage(
    this.cocktailDefinition, {
    Key key,
  }) : super(key: key);

  final CocktailDefinition cocktailDefinition;

  @override
  _CocktailDetailPageState createState() => _CocktailDetailPageState();
}

class _CocktailDetailPageState extends State<CocktailDetailPage> {
  Future<Cocktail> cocktail;

  @override
  void initState() {
    cocktail = AsyncCocktailRepository()
        .fetchCocktailDetails(widget.cocktailDefinition.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: cocktail,
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            final Cocktail cocktail = snapshot.data;
            return SingleChildScrollView(
                child: Column(
              children: [
                CocktailPicture(cocktail: cocktail),
                CocktailDetails(cocktailMainInfo: cocktail),
                CocktailClassification(cocktail: cocktail),
                CocktailIngredients(cocktail: cocktail),
                CocktailInstruction(cocktail: cocktail),
                CocktailRatingBar(rating: 3),
              ],
            ));
          }
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: CocktailPicture(cocktail: widget.cocktailDefinition)),
              SliverToBoxAdapter(child: CocktailDetails(cocktailMainInfo: widget.cocktailDefinition)),
              SliverFillRemaining(child: Container(color: detailsBgColor,))
            ],
          );
        });
  }
}
