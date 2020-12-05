import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:homework/core/models.dart';
import '../../../style/theme.dart';
import '../../../widgets/bubble.dart';
import 'details_subtitle.dart';

class CocktailClassification extends StatelessWidget {
  const CocktailClassification({
    Key key,
    @required this.cocktail,
  }) : super(key: key);

  final Cocktail cocktail;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.symmetric(horizontal: detailsHorizontalPadding),
      color: detailsBgColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DetailsSubtitle("Категория коктейля"),
          Bubble(cocktail.category.name),
          DetailsSubtitle("Тип коктейля"),
          Bubble(cocktail.cocktailType.name),
          DetailsSubtitle("Тип стекла"),
          Bubble(cocktail.glassType.name),
        ],
      ),
    );
  }
}