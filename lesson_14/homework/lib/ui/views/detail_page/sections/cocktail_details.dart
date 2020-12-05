import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:homework/core/src/model/cocktail_main_info.dart';
import '../../../style/theme.dart';
import '../../../widgets/shadowed_text.dart';

class CocktailDetails extends StatelessWidget {
  const CocktailDetails({
    Key key,
    @required this.cocktailMainInfo,
  }) : super(key: key);

  final CocktailMainInfo cocktailMainInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.fromLTRB(detailsHorizontalPadding, 33, detailsHorizontalPadding, 0),
      color: detailsBgColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DetailsTitle(cocktailMainInfo),
          ShadowedText(cocktailMainInfo.id),
        ],
      ),
    );
  }
}

class DetailsTitle extends StatelessWidget {
  const DetailsTitle(
      this.cocktail, {
        Key key,
      }) : super(key: key);

  final CocktailMainInfo cocktail;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          cocktail.name,
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
        ),
        SvgPicture.asset(
            "./assets/fav.svg",
            color: cocktail.isFavourite ? Colors.white : Color.fromARGB(255, 132, 131, 150),
            width: 20
        )
      ],
    );
  }
}