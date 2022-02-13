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
  bool isEmpty = false;
  final ScrollController _controller =
      ScrollController(initialScrollOffset: 0.0);

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  //cache based on your device  height maybe have height 1/3

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            _controller.animateTo(-20.0,
                duration: const Duration(seconds: 1), curve: Curves.bounceOut);
          },
          child: Text(widget.title),
        ),
      ),
      body: isEmpty
          ? const Center(
              child: Text("Hooray, no spam here!!"),
            )
          //scrollbar widget there are show scrollbar in screen
          : Scrollbar(
              controller: _controller,
              child: Padding(
                padding: const EdgeInsets.all(0.0), // viewport add padding
                child: ListView.builder(
                  //android scroll physical is ClampingScrollPhysics
                  //ios scroll physical is BouncingScrollPhysics
                  physics: const NeverScrollableScrollPhysics(), // change scroll physics or effects
                  controller: _controller,
                  padding: const EdgeInsets.only(bottom: 128),
                  // when list is start or list is end will have spacing. but when scroll is middle the padding will missing
                  itemCount: 30,
                  itemExtent: 60,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text("Name"),
                      subtitle: const Text("Subtitle"),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.delete_outline),
                      ),
                    );
                  },
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final offset = _controller.offset;
          _controller.animateTo(
            offset + 200,
            duration: const Duration(milliseconds: 500),
            curve: Curves.linear,
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.arrow_downward),
      ),
    );
  }
}
