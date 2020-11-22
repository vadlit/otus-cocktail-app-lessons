import 'dart:async';

import 'package:cocktail/core/models.dart';
import 'package:cocktail/ui/widgets/common/future_builder_wrapper.dart';
import 'package:cocktail/ui/widgets/common/infinite_progress_bar_painter.dart';
import 'package:cocktail/ui/widgets/search/view_model/selected_category_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'cocktail_tile.dart';

class ResultsGrid extends StatefulWidget {
  ResultsGrid({
    Key key,
  }) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<ResultsGrid> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: SelectedCategoryNotifier(),
        builder: (_, __) => FutureBuilderWrapper(
            future: fetchCocktailsByCategory(),
            inProgressBuilder: (BuildContext context) {
              return _InProgressWidget();
            },
            onErrorBuilder: (BuildContext context, Object error) {
              return _ErrorWidget(error.toString());
            },
            onDataBuilder:
                (BuildContext context, Iterable<CocktailDefinition> data) {
              return _TilesWidget(data);
            }));
  }

  Future<Iterable<CocktailDefinition>> fetchCocktailsByCategory() {
    return Future.delayed(
        Duration(seconds: 2), //stub
        () => AsyncCocktailRepository().fetchCocktailsByCocktailCategory(
            SelectedCategoryNotifier().category));
  }
}

class _InProgressWidget extends StatefulWidget {
  const _InProgressWidget({
    Key key,
  }) : super(key: key);

  @override
  _InProgressWidgetState createState() => _InProgressWidgetState();
}

class _InProgressWidgetState extends State<_InProgressWidget>
    with SingleTickerProviderStateMixin {
  double waveRadius = 0.0;
  final double waveGap = 5.0;
  Animation<double> _animation;
  AnimationController _progressController;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
        duration: Duration(milliseconds: 1500), vsync: this);

    _progressController.forward();

    _progressController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _progressController.reset();
      } else if (status == AnimationStatus.dismissed) {
        _progressController.forward();
      }
    });
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animation = Tween(begin: 0.0, end: waveGap).animate(_progressController)
      ..addListener(() {
        setState(() {
          waveRadius = _animation.value;
        });
      });

    return SliverFillRemaining(
        child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _ProgressBarWidget(waveRadius: waveRadius),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 24, 0, 0),
            child: Text("Поиск...",
                style: Theme.of(context).textTheme.headline6),
          ),
        ],
      ),
    ));
  }
}

class _ProgressBarWidget extends StatelessWidget {
  const _ProgressBarWidget({
    Key key,
    @required this.waveRadius,
  }) : super(key: key);

  final double waveRadius;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(36, 36),
      painter: InfiniteProgressBarPainter(
          color: Theme.of(context).textTheme.headline6.color,
          waveRadius: waveRadius),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  final String _error;

  const _ErrorWidget(
    this._error, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
        child: Container(
      alignment: Alignment.center,
      child:
          Text(_error.toString(), style: Theme.of(context).textTheme.headline6),
    ));
  }
}

class _TilesWidget extends StatelessWidget {
  final Iterable<CocktailDefinition> data;

  const _TilesWidget(
    this.data, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(23, 0, 23, 0),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 6, crossAxisSpacing: 6),
        delegate:
            SliverChildListDelegate(data.map((e) => CocktailTile(e)).toList()),
      ),
    );
  }
}
