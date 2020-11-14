import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:homework/models/models.dart';
import 'package:homework/views/common/animated_svg_widget.dart';
import '../../../widgets/shadowed_text.dart';
import '../../../widgets/bubble.dart';

class CocktailDetails extends StatelessWidget {
  const CocktailDetails({
    Key key,
    @required this.cocktail,
  }) : super(key: key);

  final Cocktail cocktail;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.fromLTRB(32, 33, 32, 0),
      color: Color.fromARGB(255, 26, 25, 39),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DetailsTitle(cocktail),
          ShadowedText(cocktail.id),
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

class DetailsTitle extends StatefulWidget {
  const DetailsTitle(
    this.cocktail, {
    Key key,
  }) : super(key: key);

  final Cocktail cocktail;

  @override
  _DetailsTitleState createState() => _DetailsTitleState();
}

class _DetailsTitleState extends State<DetailsTitle>
    with TickerProviderStateMixin {
  AnimationController _favController;

  @override
  void initState() {
    super.initState();
    _favController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _favController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Animation favAnimation = CurvedAnimation(parent: _favController, curve: Curves.easeOutCubic);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.cocktail.name,
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
        ),
        AnimatedSvgWidget(
          controller: Tween<double>(begin: 0, end: 1).animate(favAnimation),
          builder: (ctx) => SvgPicture.asset("./assets/fav.svg",
              color: widget.cocktail.isFavourite
                  ? Colors.white
                  : Color.fromARGB(255, 132, 131, 150),
              width: 20),
        )
      ],
    );
  }
}

class DetailsSubtitle extends StatelessWidget {
  final String caption;

  const DetailsSubtitle(
    this.caption, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 8),
      child: Text(
        caption,
        style: TextStyle(
            color: Color.fromARGB(255, 234, 234, 234),
            fontSize: 14,
            fontWeight: FontWeight.w400),
      ),
    );
  }
}
