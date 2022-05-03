import 'dart:math';

import 'package:flutter/material.dart';
import 'package:graphview/graph_view.dart';

class LayeredGraphViewPage extends StatefulWidget {
  @override
  _LayeredGraphViewPageState createState() => _LayeredGraphViewPageState();
}

class _LayeredGraphViewPageState extends State<LayeredGraphViewPage> {
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
                initialValue: builder.nodeSeparation.toString(),
                decoration: InputDecoration(labelText: "Node Separation"),
                onChanged: (text) {
                  builder.nodeSeparation = int.tryParse(text) ?? 100;
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
                initialValue: builder.orientation.toString(),
                decoration: InputDecoration(labelText: "Orientation"),
                onChanged: (text) {
                  builder.orientation = orientationOf(int.tryParse(text) ?? 1);
                  this.setState(() {});
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final node12 = Node.widget(rectangleWidget(r.nextInt(100)));
                var edge = graph.getNodeAtPosition(r.nextInt(graph.nodeCount()));
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
              minScale: 0.0001,
              maxScale: 10.6,
              child: GraphView(
                graph: graph,
                algorithm: SugiyamaAlgorithm(builder),
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
    return Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(color: Colors.blue[100], spreadRadius: 1),
          ],
        ),
        child: Text("Node ${a}"));
  }

  final Graph graph = Graph();

  SugiyamaConfiguration builder = SugiyamaConfiguration();

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
    final node10 = Node.id(10);
    final node11 = Node.id(11);
    final node12 = Node.id(12);
    final node13 = Node.id(13);
    final node14 = Node.id(14);
    final node15 = Node.id(15);
    final node16 = Node.id(16);
    final node17 = Node.widget(rectangleWidget(17)); //using deprecated mechanism of directly placing the widget here
    final node18 = Node.widget(rectangleWidget(18));
    final node19 = Node.widget(rectangleWidget(19));
    final node20 = Node.widget(rectangleWidget(20));
    final node21 = Node.widget(rectangleWidget(21));
    final node22 = Node.widget(rectangleWidget(22));
    final node23 = Node.widget(rectangleWidget(23));

    graph.addEdge(node1, node13, paint: Paint()..color = Colors.red);
    graph.addEdge(node1, node21);
    graph.addEdge(node1, node4);
    graph.addEdge(node1, node3);
    graph.addEdge(node2, node3);
    graph.addEdge(node2, node20);
    graph.addEdge(node3, node4);
    graph.addEdge(node3, node5);
    graph.addEdge(node3, node23);
    graph.addEdge(node4, node6);
    graph.addEdge(node5, node7);
    graph.addEdge(node6, node8);
    graph.addEdge(node6, node16);
    graph.addEdge(node6, node23);
    graph.addEdge(node7, node9);
    graph.addEdge(node8, node10);
    graph.addEdge(node8, node11);
    graph.addEdge(node9, node12);
    graph.addEdge(node10, node13);
    graph.addEdge(node10, node14);
    graph.addEdge(node10, node15);
    graph.addEdge(node11, node15);
    graph.addEdge(node11, node16);
    graph.addEdge(node12, node20);
    graph.addEdge(node13, node17);
    graph.addEdge(node14, node17);
    graph.addEdge(node14, node18);
    graph.addEdge(node16, node18);
    graph.addEdge(node16, node19);
    graph.addEdge(node16, node20);
    graph.addEdge(node18, node21);
    graph.addEdge(node19, node22);
    graph.addEdge(node21, node23);
    graph.addEdge(node22, node23);

    builder
      ..nodeSeparation = (15)
      ..levelSeparation = (15)
      ..orientation = GraphOrientation.LeftRight;
  }
}
