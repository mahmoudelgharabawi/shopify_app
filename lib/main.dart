import 'package:flutter/material.dart';
import 'package:shopify_app/services/prefrences.service.dart';
import 'package:shopify_app/utils/theme.utils.dart';

void main() async {
  await PrefrencesService.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopify Application',
      theme: ThemeUtils.themeData,
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

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () {
                  PrefrencesService.prefs
                      ?.setString('userName', 'mahmoud Ahmed');
                  setState(() {});
                },
                child: Text('add name to prefrences')),
            Text(
              '${PrefrencesService.prefs?.getString('userName') ?? 'No Name'}',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            Text(
              '${PrefrencesService.prefs?.getString('userName') ?? 'No Name'}',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ],
        ),
      ),
    );
  }
}
