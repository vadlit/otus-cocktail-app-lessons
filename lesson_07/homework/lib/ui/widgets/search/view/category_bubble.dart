import 'dart:async';

import 'package:cocktail/core/models.dart';
import 'package:cocktail/ui/widgets/search/view_model/selected_category_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CategoryBubble extends StatefulWidget {
  const CategoryBubble(
    this._category, {
    Key key,
  }) : super(key: key);

  final CocktailCategory _category;

  @override
  _State createState() => _State(_category);
}

class _State extends State<CategoryBubble> {
  ValueNotifier<bool> _isSelectedNotifier;
  final CocktailCategory _category;
  StreamSubscription<CocktailCategory> _selectedCategoryUpdates;

  _State(this._category) {
    _isSelectedNotifier = ValueNotifier(SelectedCategoryProvider().category == _category);
    _selectedCategoryUpdates =
        SelectedCategoryProvider().updatesStream().listen((selectedCategory) {
      _isSelectedNotifier.value = selectedCategory == _category;
    });
  }

  @override
  void dispose() {
    _selectedCategoryUpdates.cancel();
    _isSelectedNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          SelectedCategoryProvider().category = _category;
        },
        child: ValueListenableBuilder(
            valueListenable: _isSelectedNotifier,
            builder: (_, isSelected, __) => Container(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 45, 44, 57)),
                    color: isSelected
                        ? const Color.fromARGB(255, 59, 57, 83)
                        : const Color.fromARGB(255, 32, 31, 44),
                    borderRadius:
                        const BorderRadius.all(const Radius.circular(30))),
                child: Text(_category.value,
                    style: Theme.of(context).textTheme.subtitle2))));
  }

  bool get isSelected => SelectedCategoryProvider().category == _category;
}
