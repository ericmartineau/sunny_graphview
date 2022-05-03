part of graphview;

enum GraphOrientation { TopBottom, BottomTop, LeftRight, RightLeft }

extension GraphOrientationExt on GraphOrientation {
  bool get isForward => this == GraphOrientation.TopBottom || this == GraphOrientation.LeftRight;
  bool get isReverse => !isForward;
  bool get isVertical => this == GraphOrientation.TopBottom || this == GraphOrientation.BottomTop;
  bool get isHorizontal => !isVertical;
}

GraphOrientation orientationOf(int orientation) {
  return GraphOrientation.values.firstWhere((element) => element.index == orientation);
}

class BuchheimWalkerConfiguration {
  int siblingSeparation = DEFAULT_SIBLING_SEPARATION;
  int levelSeparation = DEFAULT_LEVEL_SEPARATION;
  int subtreeSeparation = DEFAULT_SUBTREE_SEPARATION;
  GraphOrientation orientation = GraphOrientation.TopBottom;

  static const DEFAULT_SIBLING_SEPARATION = 100;
  static const DEFAULT_SUBTREE_SEPARATION = 100;
  static const DEFAULT_LEVEL_SEPARATION = 100;
  static const DEFAULT_ORIENTATION = GraphOrientation.TopBottom;

  int getSiblingSeparation() {
    return siblingSeparation;
  }

  int getLevelSeparation() {
    return levelSeparation;
  }

  int getSubtreeSeparation() {
    return subtreeSeparation;
  }
}
