part of sunny_graphview;

class SugiyamaConfiguration {
  static const DEFAULT_ORIENTATION = GraphOrientation.TopBottom;

  static const int X_SEPARATION = 100;
  static const int Y_SEPARATION = 100;

  int levelSeparation = Y_SEPARATION;
  int nodeSeparation = X_SEPARATION;
  GraphOrientation orientation = DEFAULT_ORIENTATION;

  int getLevelSeparation() {
    return levelSeparation;
  }

  int getNodeSeparation() {
    return nodeSeparation;
  }

  GraphOrientation getOrientation() {
    return orientation;
  }
}
