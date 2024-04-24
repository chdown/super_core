import 'package:flutter/material.dart';
import 'package:super_core/super_core.dart';

void main() {
  SuperNetConfig.baseUrl = () => 'http://192.168.31.200:1883/';
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with StatefulLifecycle, SuperCore {
  @override
  void initState() {
    Map<String, dynamic> values = {
      "1": "1",
      "2": "1",
      "3": "1",
      "4": "",
      "5": "1",
      "6": "1",
    };
    LogUtil.d((values.where((k, v) => ObjUtil.isNotEmpty(v))));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('You have pushed the button this many times:'),
            // CustomPaint(painter: Pager()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          request(
            request: () async {
              return {};
            },
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void onPause() {}

  @override
  void onResume() {
    // TODO: implement onResume
  }

  @override
  void onStart() {
    // TODO: implement onStart
  }

  @override
  void onStop() {
    // TODO: implement onStop
  }

  @override
  void showLoadingState(LoadConfig loadConfig, LoadState loadState, String errorMsg) {
    LogUtil.d(loadState);
  }

  @override
  void showPageState(LoadConfig loadConfig, LoadState loadState, String errorMsg) {
    LogUtil.d(loadState);
  }

  @override
  void showRefreshState(LoadConfig loadConfig, LoadState loadState, String errorMsg) {
    LogUtil.d(loadState);
  }

  @override
  void showToast(String? message) {
    // TODO: implement showToast
  }
}

class Kk {}
