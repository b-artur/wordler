import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/components/tile.dart';

import '../animations/bounce.dart';
import '../providers/controller.dart';

class Grid extends StatelessWidget {
  const Grid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.fromLTRB(36, 20, 36, 20),
        itemCount: 30,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          crossAxisCount: 5,
        ),
        itemBuilder: (context, index) {
          return Consumer<Controller>(
            builder: (_, notifier, __) {
              bool animate = false;
              if (index == notifier.currentTile - 1 &&
                  !notifier.isBackOrEnter) {
                print('index $index current ${notifier.currentTile}');
                animate = true;
              }
              return Bounce(
                  animate: animate,
                  child: Tile(
                    index: index,
                  ));
            },
          );
        });
  }
}
