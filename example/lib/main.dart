import 'package:sunny_graphview_example/LayerGraphView.dart';
import 'package:sunny_graphview_example/TreeViewPageFromJson.dart';
import 'package:flutter/material.dart';
import 'package:sunny_graphview/sunny_graphview.dart';

import 'GraphViewClusterPage.dart';
import 'TreeViewPage.dart';
import 'graph_cluster_animated.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Home());
  }
}

class Home extends StatelessWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(children: [
            TextButton(
                onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Scaffold(
                                appBar: AppBar(),
                                body: TreeViewPage(),
                              )),
                    ),
                child: Text(
                  "Tree View (BuchheimWalker)",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                )),
            TextButton(
                onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Scaffold(
                                appBar: AppBar(),
                                body: GraphClusterViewPage(),
                              )),
                    ),
                child: Text(
                  "Graph Cluster View (FruchtermanReingold)",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                )),
            TextButton(
                onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Scaffold(
                                appBar: AppBar(),
                                body: LayeredGraphViewPage(),
                              )),
                    ),
                child: Text(
                  "Layered View (Sugiyama)",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                )),
            TextButton(
                onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Scaffold(
                                appBar: AppBar(),
                                body: TreeViewPageFromJson(),
                              )),
                    ),
                child: Text(
                  "Tree View From Json(BuchheimWalker)",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                )),
            Center(
              child: MaterialButton(
                onPressed: () {
                  var graph = Graph();
                  var node1 = Node.widget(createNode("One"));
                  var node2 = Node.widget(createNode("Two"));
                  var node3 = Node.widget(createNode("Three"));
                  var node4 = Node.widget(createNode("Four"));
                  var node5 = Node.widget(createNode("Five"));
                  var node6 = Node.widget(createNode("Six"));
                  var node7 = Node.widget(createNode("Seven"));
                  var node8 = Node.widget(createNode("Eight"));
                  var node9 = Node.widget(createNode("Nine"));
                  var node10 = Node.widget(createNode("Ten"));
                  var node11 = Node.widget(createNode("Eleven"));
                  var node12 = Node.widget(createNode("Twelve"));
                  // ignore: unused_local_variable
                  var node13 = Node.widget(createNode("Thirteen"));

                  graph.addEdge(node1, node2);
                  graph.addEdge(node1, node3,
                      paint: Paint()..color = Colors.red);
                  graph.addEdge(node1, node4,
                      paint: Paint()..color = Colors.blue);
                  graph.addEdge(node2, node5);
                  graph.addEdge(node2, node6);
                  graph.addEdge(node6, node7,
                      paint: Paint()..color = Colors.red);
                  graph.addEdge(node6, node8,
                      paint: Paint()..color = Colors.red);
                  graph.addEdge(node4, node9);
                  graph.addEdge(node4, node10,
                      paint: Paint()..color = Colors.black);
                  graph.addEdge(node4, node11,
                      paint: Paint()..color = Colors.red);
                  graph.addEdge(node11, node12);

                  var builder1 = BuchheimWalkerConfiguration();
                  builder1
                    ..siblingSeparation = (100)
                    ..levelSeparation = (150)
                    ..subtreeSeparation = (150)
                    ..orientation = GraphOrientation.TopBottom;

                  var builder = BuchheimWalkerAlgorithm(
                      builder1, TreeEdgeRenderer(builder1));

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            GraphScreen(graph, builder, null)),
                  );
                },
                color: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  "Tree Graph",
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: MaterialButton(
                onPressed: () {
                  var graph = Graph();

                  var node1 = Node.widget(createNode("One"));
                  var node2 = Node.widget(createNode("Two"));
                  var node3 = Node.widget(createNode("Three"));
                  var node4 = Node.widget(createNode("Four"));
                  var node5 = Node.widget(createNode("Five"));
                  var node6 = Node.widget(createNode("Six"));
                  var node7 = Node.widget(createNode("Seven"));
                  var node8 = Node.widget(createNode("Eight"));
                  var node9 = Node.widget(createNode("Nine"));
                  graph.addEdge(node1, node2);
                  graph.addEdge(node1, node4);
                  graph.addEdge(node2, node3);
                  graph.addEdge(node2, node5);
                  graph.addEdge(node3, node6);
                  graph.addEdge(node4, node5);
                  graph.addEdge(node4, node7);
                  graph.addEdge(node5, node6);
                  graph.addEdge(node5, node8);
                  graph.addEdge(node6, node9);
                  graph.addEdge(node7, node8);
                  graph.addEdge(node8, node9);
                  var builder = FruchtermanReingoldAlgorithm();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            GraphScreen(graph, builder, null)),
                  );
                },
                color: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  "Square Grid",
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: MaterialButton(
                onPressed: () {
                  var graph = Graph();

                  var node1 = Node.widget(createNode("One"));
                  var node2 = Node.widget(createNode("Two"));
                  var node3 = Node.widget(createNode("Three"));
                  var node4 = Node.widget(createNode("Four"));
                  var node5 = Node.widget(createNode("Five"));
                  var node6 = Node.widget(createNode("Six"));
                  var node7 = Node.widget(createNode("Seven"));
                  var node8 = Node.widget(createNode("Eight"));
                  var node9 = Node.widget(createNode("Nine"));
                  var node10 = Node.widget(createNode("Ten"));

                  graph.addEdge(node1, node2);
                  graph.addEdge(node1, node3);
                  graph.addEdge(node2, node4);
                  graph.addEdge(node2, node5);
                  graph.addEdge(node2, node3);
                  graph.addEdge(node3, node5);
                  graph.addEdge(node3, node6);
                  graph.addEdge(node4, node7);
                  graph.addEdge(node4, node8);
                  graph.addEdge(node4, node5);
                  graph.addEdge(node5, node8);
                  graph.addEdge(node5, node9);
                  graph.addEdge(node5, node6);
                  graph.addEdge(node9, node6);
                  graph.addEdge(node10, node6);
                  graph.addEdge(node7, node8);
                  graph.addEdge(node8, node9);
                  graph.addEdge(node9, node10);

                  var builder = FruchtermanReingoldAlgorithm();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            GraphScreen(graph, builder, null)),
                  );
                },
                color: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  "Triangle Grid",
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: MaterialButton(
                onPressed: () {
                  var graph = Graph();

                  final a = Node.widget(createNode(1.toString()));
                  final b = Node.widget(createNode(2.toString()));
                  final c = Node.widget(createNode(3.toString()));
                  final d = Node.widget(createNode(4.toString()));
                  final e = Node.widget(createNode(5.toString()));
                  final f = Node.widget(createNode(6.toString()));
                  final g = Node.widget(createNode(7.toString()));
                  final h = Node.widget(createNode(8.toString()));

                  graph.addEdge(a, b, paint: Paint()..color = Colors.red);
                  graph.addEdge(a, c);
                  graph.addEdge(a, d);
                  graph.addEdge(c, e);
                  graph.addEdge(d, f);
                  graph.addEdge(f, c);
                  graph.addEdge(g, c);
                  graph.addEdge(h, g);

                  var builder = FruchtermanReingoldAlgorithm();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            GraphScreen(graph, builder, null)),
                  );
                },
                color: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  "Cluster",
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: MaterialButton(
                onPressed: () {
                  var graph = Graph();

                  var node1 = Node.widget(createNode("One"));
                  var node2 = Node.widget(createNode("Two"));
                  var node3 = Node.widget(createNode("Three"));
                  var node4 = Node.widget(createNode("Four"));
                  var node5 = Node.widget(createNode("Five"));
                  var node6 = Node.widget(createNode("Six"));
                  var node7 = Node.widget(createNode("Seven"));
                  var node8 = Node.widget(createNode("Eight"));
                  var node9 = Node.widget(createNode("Nine"));
                  var node10 = Node.widget(createNode("Ten"));
                  var node11 = Node.widget(createNode("Ten0"));

                  final node12 = Node.widget(createNode("Ten1"));
                  final node13 = Node.widget(createNode("Ten2"));
                  final node14 = Node.widget(createNode("Ten3"));
                  final node15 = Node.widget(createNode("Ten4"));
                  final node16 = Node.widget(createNode("Ten5"));
                  final node17 = Node.widget(createNode("Ten6"));
                  final node18 = Node.widget(createNode("Ten7"));
                  final node19 = Node.widget(createNode("Ten8"));
                  final node20 = Node.widget(createNode("Ten9"));
                  final node21 = Node.widget(createNode("Ten11"));
                  final node22 = Node.widget(createNode("Ten12"));
                  final node23 = Node.widget(createNode("Ten10"));

                  graph.addEdge(node1, node13,
                      paint: Paint()..color = Colors.red);
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

                  var builder1 = SugiyamaConfiguration();
                  builder1
                    ..nodeSeparation = (30)
                    ..levelSeparation = (50)
                    ..orientation = GraphOrientation.LeftRight;

                  var builder = SugiyamaAlgorithm(builder1);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            GraphScreen(graph, builder, null)),
                  );
                },
                color: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  "Sugiyama",
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget createNode(String nodeText) {
    // return Container(
    //   padding: EdgeInsets.all(10),
    //   decoration: BoxDecoration(
    //     color: Colors.red,
    //     border: Border.all(color: Colors.white, width: 1),
    //     borderRadius: BorderRadius.circular(30),
    //   ),
    //   child: Center(
    //     child: Text(
    //       nodeText,
    //       style: TextStyle(fontSize: 10),
    //     ),
    //   ),
    // );

    return Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(color: Colors.blue[100]!, spreadRadius: 1),
          ],
        ),
        child: Text(nodeText));
  }
}
