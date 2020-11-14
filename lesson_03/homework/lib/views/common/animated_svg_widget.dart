import 'package:flutter/widgets.dart';

class AnimatedSvgWidget extends AnimatedWidget {
  final WidgetBuilder builder;

  const AnimatedSvgWidget({Key key, @required Animation<double> controller, @required this.builder})
      : super(key: key, listenable: controller);

  Animation<double> get _progress => listenable;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: (1 + _progress.value),
      child: builder(context),
    );
  }
}