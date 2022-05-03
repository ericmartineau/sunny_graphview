part of graphview;

class Graph {
  Graph({this.isTree = false});
  Graph.tree() : isTree = true;

  final List<Node> _nodes = [];
  final List<Edge> _edges = [];
  final Map<ValueKey, Node> _nodesById = {};
  final bool isTree;
  final List<GraphObserver> graphObserver = [];

  List<Edge> get edges => [..._edges];
  List<Node> get nodes => [..._nodes];

  int nodeCount() => _nodes.length;

  void addNode(Node node, {bool notify = true}) {
    _nodes.add(node);
    _nodesById[node.key] = node;
    if (notify) notifyGraphObserver();
  }

  void addNodes(List<Node> nodes) {
    nodes.forEach((it) => addNode(it, notify: false));
    notifyGraphObserver();
  }

  void removeNode(Node? node) {
    if (isTree) {
      successorsOf(node).forEach((element) => removeNode(element));
    }

    _nodes.remove(node);
    _nodesById.remove(node?.key);

    _edges
        .removeWhere((edge) => edge.source == node || edge.destination == node);

    notifyGraphObserver();
  }

  void removeNodeById(dynamic id) {
    var valueKey = id is ValueKey ? id : ValueKey(id);
    var node = _nodesById[valueKey];
    this.removeNode(node);
    notifyGraphObserver();
  }

  void removeNodes(List<Node> nodes) => nodes.forEach((it) => removeNode(it));

  Edge addEdge(Node source, Node destination, {Paint? paint}) {
    final edge = Edge(source, destination, paint: paint);
    addEdgeS(edge);

    return edge;
  }

  void addEdgeS(Edge edge, {bool notify = true}) {
    var changed = false;
    if (_nodesById.containsKey(edge.source.key)) {
      edge.source = _nodesById[edge.source.key]!;
    } else {
      changed = true;
      addNode(edge.source, notify: false);
    }
    if (_nodesById.containsKey(edge.destination.key)) {
      edge.destination = _nodesById[edge.destination.key]!;
    } else {
      changed = true;
      addNode(edge.destination, notify: false);
    }

    if (!_edges.contains(edge)) {
      _edges.add(edge);
      changed = true;
    }
    if (changed && notify) notifyGraphObserver();
  }

  void addEdges(List<Edge> edges) {
    edges.forEach((it) => addEdgeS(it, notify: false));
    notifyGraphObserver();
  }

  void removeEdge(Edge edge, {bool notify = true}) {
    _edges.remove(edge);
    if (notify) notifyGraphObserver();
  }

  void removeEdges(List<Edge> edges) {
    edges.forEach((it) => removeEdge(it, notify: false));
    notifyGraphObserver();
  }

  void clear() {
    _edges.clear();
    _nodes.clear();
    _nodesById.clear();
    notifyGraphObserver();
  }

  void removeEdgeFromPredecessor(Node? predecessor, Node? current) {
    _edges.removeWhere(
        (edge) => edge.source == predecessor && edge.destination == current);
    notifyGraphObserver();
  }

  bool hasNodes() => _nodes.isNotEmpty;

  Edge? getEdgeBetween(Node source, Node? destination) =>
      _edges.firstWhereOrNull((element) =>
          element.source == source && element.destination == destination);

  bool hasSuccessor(Node? node) =>
      _edges.any((element) => element.source == node);

  List<Node> successorsOf(Node? node) => _edges
      .where((element) => element.source == node)
      .map((e) => e.destination)
      .toList();

  bool hasPredecessor(Node node) =>
      _edges.any((element) => element.destination == node);

  List<Node> predecessorsOf(Node? node) => _edges
      .where((element) => element.destination == node)
      .map((edge) => edge.source)
      .toList();

  bool containsKey(value) {
    return value is ValueKey
        ? _nodesById[value] != null
        : _nodesById[ValueKey(value)] != null;
  }

  bool contains({Node? node, Edge? edge}) =>
      _nodesById.containsKey(node?.key) ||
      (edge != null && _edges.contains(edge));

  bool containsData(data) => _nodes.any((element) => element.data == data);

  Node getNodeAtPosition(int position) {
    assert(position >= 0);
    return _nodes[position];
  }

  @Deprecated('Please use the builder and id mechanism to build the widgets')
  Node getNodeAtUsingData(Widget data) =>
      _nodes.firstWhere((element) => element.data == data);

  Node getNodeUsingKey(ValueKey valueKey) => _nodesById[valueKey]!;

  Node getNodeUsingId(int id) => _nodesById[ValueKey(id)]!;

  List<Edge> getOutEdges(Node node) =>
      _edges.where((element) => element.source == node).toList();

  List<Edge> getInEdges(Node node) => [
        for (var e in _edges)
          if (e.destination == node) e,
      ];

  void notifyGraphObserver() => graphObserver.forEach((element) {
        element.notifyGraphInvalidated();
      });
}

class Node {
  final ValueKey key;
  final dynamic data;

  Size size = Size(0, 0);
  Offset position = Offset(0, 0);

  Node._({required this.key, this.data});

  Node.widget(Widget widget, {ValueKey? key})
      : this._(key: key ?? ValueKey(widget.hashCode), data: widget);

  Node.id(dynamic id, [this.data]) : key = ValueKey(id);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Node && key == other.key;

  @override
  int get hashCode => key.hashCode;

  @override
  String toString() {
    return 'Node{position: $position, key: $key, _size: $size}';
  }
}

extension NodeExt on Node {
  double get height => size.height;
  double get width => size.width;
  double get x => position.dx;
  double get y => position.dy;

  Widget? get widget => data is Widget ? data as Widget : null;

  set y(double value) {
    position = Offset(position.dx, value);
  }

  set x(double value) {
    position = Offset(value, position.dy);
  }
}

class Edge {
  Node source;
  Node destination;

  Key? key;
  Paint? paint;

  Edge(this.source, this.destination, {this.key, this.paint});

  @override
  bool operator ==(Object? other) =>
      identical(this, other) || other is Edge && hashCode == other.hashCode;

  @override
  int get hashCode => key?.hashCode ?? source.hashCode ^ destination.hashCode;
}

abstract class GraphObserver {
  void notifyGraphInvalidated();
}
