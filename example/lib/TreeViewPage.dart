import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sunny_graphview/sunny_graphview.dart';

class TreeViewPage extends StatefulWidget {
  @override
  _TreeViewPageState createState() => _TreeViewPageState();
}

class _TreeViewPageState extends State<TreeViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Wrap(
          children: [
            Container(
              width: 100,
              child: TextFormField(
                initialValue: builder.siblingSeparation.toString(),
                decoration: InputDecoration(labelText: "Sibling Separation"),
                onChanged: (text) {
                  builder.siblingSeparation = int.tryParse(text) ?? 100;
                  this.setState(() {});
                },
              ),
            ),
            Container(
              width: 100,
              child: TextFormField(
                initialValue: builder.levelSeparation.toString(),
                decoration: InputDecoration(labelText: "Level Separation"),
                onChanged: (text) {
                  builder.levelSeparation = int.tryParse(text) ?? 100;
                  this.setState(() {});
                },
              ),
            ),
            Container(
              width: 100,
              child: TextFormField(
                initialValue: builder.subtreeSeparation.toString(),
                decoration: InputDecoration(labelText: "Subtree separation"),
                onChanged: (text) {
                  builder.subtreeSeparation = int.tryParse(text) ?? 100;
                  this.setState(() {});
                },
              ),
            ),
            Container(
              width: 100,
              child: TextFormField(
                initialValue: builder.orientation.toString(),
                decoration: InputDecoration(labelText: "Orientation"),
                onChanged: (text) {
                  var orientation = int.tryParse(text);
                  var picked = GraphOrientation.values.firstWhere(
                      (element) => element.index == orientation,
                      orElse: () => GraphOrientation.TopBottom);
                  builder.orientation = picked;
                  this.setState(() {});
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final node12 = Node.widget(rectangleWidget(r.nextInt(100)));
                var edge =
                    graph.getNodeAtPosition(r.nextInt(graph.nodeCount()));
                print(edge);
                graph.addEdge(edge, node12);
                setState(() {});
              },
              child: Text("Add"),
            )
          ],
        ),
        Expanded(
          child: InteractiveViewer(
              constrained: false,
              boundaryMargin: EdgeInsets.all(100),
              minScale: 0.01,
              maxScale: 5.6,
              child: GraphView(
                graph: graph,
                algorithm:
                    BuchheimWalkerAlgorithm(builder, TreeEdgeRenderer(builder)),
                paint: Paint()
                  ..color = Colors.green
                  ..strokeWidth = 1
                  ..style = PaintingStyle.stroke,
                builder: (Node node) {
                  // I can decide what widget should be shown here based on the id
                  var a = node.key.value as int;
                  return rectangleWidget(a);
                },
              )),
        ),
      ],
    ));
  }

  Random r = Random();

  Widget rectangleWidget(int a) {
    return InkWell(
      onTap: () {
        print('clicked');
      },
      child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(color: Colors.blue[100]!, spreadRadius: 1),
            ],
          ),
          child: Text('Node ${a}')),
    );
  }

  final Graph graph = Graph.tree();
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();

  @override
  void initState() {
    super.initState();
    final node1 = Node.id(1);
    final node2 = Node.id(2);
    final node3 = Node.id(3);
    final node4 = Node.id(4);
    final node5 = Node.id(5);
    final node6 = Node.id(6);
    final node8 = Node.id(7);
    final node7 = Node.id(8);
    final node9 = Node.id(9);
    final node10 = Node.widget(rectangleWidget(
        10)); //using deprecated mechanism of directly placing the widget here
    final node11 = Node.widget(rectangleWidget(11));
    final node12 = Node.widget(rectangleWidget(12));
    graph.addEdge(node1, node2);
    graph.addEdge(node1, node3, paint: Paint()..color = Colors.red);
    graph.addEdge(node1, node4, paint: Paint()..color = Colors.blue);
    graph.addEdge(node2, node5);
    graph.addEdge(node2, node6);
    graph.addEdge(node6, node7, paint: Paint()..color = Colors.red);
    graph.addEdge(node6, node8, paint: Paint()..color = Colors.red);
    graph.addEdge(node4, node9);
    graph.addEdge(node4, node10, paint: Paint()..color = Colors.black);
    graph.addEdge(node4, node11, paint: Paint()..color = Colors.red);
    graph.addEdge(node11, node12);

    builder
      ..siblingSeparation = (100)
      ..levelSeparation = (150)
      ..subtreeSeparation = (150)
      ..orientation = GraphOrientation.TopBottom;
  }
}
