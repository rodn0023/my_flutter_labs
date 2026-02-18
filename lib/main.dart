import 'package:flutter/material.dart';
import 'package:my_flutter_labs/DataRepository.dart';
import 'ProfilePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(title: 'Home'),
        '/profilePage': (context) => ProfilePage()
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
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

  late TextEditingController itemController;
  late TextEditingController quantityController;

  List<String> words =  [];
  List<String> quantities =  [];

  @override
  void initState() {
    super.initState();

    itemController = TextEditingController();
    quantityController = TextEditingController();
  }

  @override
  void dispose() {
    itemController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  void deleteAlert(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Remove an Item"),
        content: Text("Do you wish to delete this item?"),
        actions: [
          ElevatedButton(
            child: Text("NO"),
            onPressed: () => Navigator.of(context).pop(),
          ),
          ElevatedButton(
            child: Text("YES"),
            onPressed: () {
              setState(() {
                words.removeAt(index);
                quantities.removeAt(index);
                Navigator.of(context).pop();
              });
            },
          )
        ],
      ),
    );
  }


  Widget ListPage() {
    return Column(
      children: [
        Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: itemController,
                decoration: const InputDecoration(
                  hintText: "Type an item here",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Expanded(
              child: TextField(
                controller: quantityController,
                decoration: const InputDecoration(
                  hintText: "Type the quantity here",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  words.add(itemController.text);
                  quantities.add(quantityController.text);
                  itemController.clear();
                  quantityController.clear();
                });
              },
              child: const Text("Click here"),
            ),
          ],
        ),
        if (words.isEmpty)
          Text("There are no items in the list."),
        Expanded(
          child: ListView.builder(
            itemCount: words.length,
            itemBuilder: (context, rowNum) {
                return GestureDetector(child:
                  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("${rowNum + 1}. ${words[rowNum]}"),
                    Text(" quantity: ${quantities[rowNum]}")
                  ],
                ),
                onLongPress: () {deleteAlert(rowNum);});
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListPage()
    );
  }
}
