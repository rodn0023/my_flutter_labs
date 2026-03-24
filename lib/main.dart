import 'package:flutter/material.dart';
import 'package:my_flutter_labs/ShoppingListItemDAO.dart';
import 'ShoppingListItem.dart';
import 'database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = await $FloorAppDatabase
  .databaseBuilder('app_database.db')
  .build();

  final dao = database.shoppingListItemDAO;

  runApp(MyApp(dao));
}

class MyApp extends StatelessWidget {
  final ShoppingListItemDAO dao;

  const MyApp(this.dao, {super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MyHomePage(title: 'Home', dao: dao),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.dao});

  final String title;
  final ShoppingListItemDAO dao;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late TextEditingController itemController;
  late TextEditingController quantityController;

  List<ShoppingListItem> myList = [];

  @override
  void initState() {
    super.initState();

    //get all list items from dao, insert into empty array and update
    widget.dao.findAllShoppingListItems().then(
            (list) {
          setState((){myList = list;
          } );
        });

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
            onPressed: () async {
              final item = myList[index];
              await widget.dao.deleteShoppingListItem(item);
              setState(() {
                myList.removeAt(index);
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
              onPressed: () async {
                final shoppingListItem = ShoppingListItem(ShoppingListItem.ID++, itemController.text, int.parse(quantityController.text));
                await widget.dao.insertShoppingListItem(shoppingListItem);
                setState(() {
                  myList.add(shoppingListItem);
                  itemController.clear();
                  quantityController.clear();
                });
              },
              child: const Text("Click here"),
            ),
          ],
        ),
        if (myList.isEmpty)
          Text("There are no items in the list."),
        Expanded(
          child: ListView.builder(
            itemCount: myList.length,
            itemBuilder: (context, rowNum) {
                return GestureDetector(child:
                  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("${rowNum + 1}. ${myList[rowNum].name}"),
                    Text(" quantity: ${myList[rowNum].quantity}")
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
