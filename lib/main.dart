import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'ListView demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<String> data = List.generate(60, (index) => '$index item');

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemBuilder: _buildItems,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.arrow_downward),
      ),
    );
  }

  Widget _buildItems(BuildContext context, int index) {
    return Dismissible(
      key: ValueKey<String>(data[index]),
      background: buildBackground(),
      secondaryBackground: buildSecondaryBackground(),
      child: ItemBox(
        info: data[index],
      ),
      onDismissed: (direction) => _onDismissed(direction, index),
      confirmDismiss: _confirmDismiss,
    );
  }

  Widget buildBackground() {
    return Container(
      color: Colors.green,
      alignment: const Alignment(-0.9, 0),
      child: const Icon(
        Icons.check,
        color: Colors.white,
      ),
    );
  }

  Widget buildSecondaryBackground() {
    return Container(
      color: Colors.red,
      alignment: const Alignment(0.9, 0),
      child: const Icon(
        Icons.close,
        color: Colors.white,
      ),
    );
  }

  void _onDismissed(DismissDirection direction, int index) {
    setState(() {
      data.removeAt(index);
    });
  }

  Future<bool?> _confirmDismiss(DismissDirection direction) async {
    await Future.delayed(const Duration(seconds: 2));
    print('_confirmDismiss: $direction');
    //if end to start will remove
    return direction != DismissDirection.startToEnd;
  }
}

class ItemBox extends StatelessWidget {
  const ItemBox({Key? key, required this.info}) : super(key: key);
  final String info;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 56,
      child: Text(
        info,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
