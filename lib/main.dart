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

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const TextField(
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
          ),
        ),
      ),
      body: NotificationListener<OverscrollNotification>(
        onNotification: (OverscrollNotification notification) {
          print(notification.overscroll);
          // print('====dragDetails ${event.dragDetails}');
          // print('====dragDetails ${event.metrics.pixels}');
          // if true is event is intercept no need to pop
          //false is just read continue to pop event
          return true;
        },
        child: ListView.builder(
          //default keyboardDismissBehavior is manual
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          itemBuilder: (context, index) {
            return Container(
              color: Colors.blue[index % 9 * 100],
              height: 50,
              child: Center(child: Text('$index')),
            );
          },
          itemCount: 100,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.arrow_downward),
      ),
    );
  }
}
