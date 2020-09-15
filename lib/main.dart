import 'package:flutter/material.dart';
import 'package:flutter_demo/model/count_model.dart';

import "package:provider/provider.dart";
import 'package:tuple/tuple.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CountModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ChildWidget1(),
              SizedBox(height: 24),
              ChildWidget2(),
            ],
          ),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}

class ChildWidget1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPrint("=========== child1 ===========  build");

    var style = TextStyle(color: Colors.white);

    // return Selector<CountModel, int>(
    //   selector: (context, value) => value.count,
    //   builder: (context, value, child) {
    //     return Container(
    //       color: Colors.redAccent,
    //       height: 48,
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //         children: <Widget>[
    //           Text('Child1', style: style),
    //           Text('Model data: $value', style: style),
    //           RaisedButton(
    //             onPressed: () => context.read<CountModel>().addCount(10),
    //             child: child,
    //           ),
    //         ],
    //       ),
    //     );
    //   },
    //   child: Text('add'),
    // );

    return Container(
      color: Colors.redAccent,
      height: 48,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text('Child1', style: style),
          Builder(
            builder: (BuildContext context) {
              return Text(
                  'Model data: ${context.select((CountModel value) => value.count)}',
                  style: style);
            },
          ),
          RaisedButton(
            onPressed: () => context.read<CountModel>().addCount(10),
            child: Text('add'),
          ),
        ],
      ),
    );
  }
}

class ChildWidget2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPrint("=========== child2 ===========  build");

    var style = TextStyle(color: Colors.white);

    return Selector<CountModel, Tuple2<int, int>>(
      selector: (context, value) => Tuple2(value.sum, value.num),
      builder: (context, value, child) {
        return Container(
          color: Colors.blueAccent,
          height: 48,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('Child2', style: style),
              Text('Model data: ${value.item1} ====  ${value.item2}',
                  style: style),
              RaisedButton(
                onPressed: () {
                  context.read<CountModel>().addSum();
                  context.read<CountModel>().addNum();
                },
                child: child,
              ),
            ],
          ),
        );
      },
      child: Text('add'),
    );
  }
}
