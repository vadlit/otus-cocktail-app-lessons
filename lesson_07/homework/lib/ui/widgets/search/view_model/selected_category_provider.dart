import 'dart:async';

import 'package:cocktail/core/models.dart';

class SelectedCategoryProvider {
  static final SelectedCategoryProvider _instance = SelectedCategoryProvider._();

  CocktailCategory _category = CocktailCategory.values.first;
  final StreamController<CocktailCategory> _notifier = StreamController.broadcast();

  void dispose() {
    _notifier.close();
  }

  set category(CocktailCategory value) {
    _category = value;
    _notifier.add(value);
  }

  CocktailCategory get category => _category;

  Stream<CocktailCategory> updatesStream() => _notifier.stream;

  SelectedCategoryProvider._();

  factory SelectedCategoryProvider() {
    return _instance;
  }
}