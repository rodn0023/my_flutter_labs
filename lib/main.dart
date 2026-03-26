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
  ShoppingListItem? selectedItem;

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

  Widget reactiveLayout(){

    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    if( (width>height) && (width > 720)) {
      return Row(
          children:[
            Expanded(flex: 1,
                child: ListPage()),
            Expanded(flex: 1,
                child: Container(color: Colors.lightBlueAccent, child: DetailsPage()))
          ]);
    }
    else{
      if(selectedItem == null){
        return ListPage();
      }
      else
      {
        return Container(color: Colors.lightBlueAccent, child: DetailsPage());
      }
    }
  }

  Widget DetailsPage() {
    if (selectedItem != null) {
      return Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Item: ${selectedItem!.name}"),
          Text("Quantity: ${selectedItem!.quantity}"),
          Text("Database ID: ${selectedItem!.id}"),

          ElevatedButton(
            child: Text("Delete Item"),
            onPressed: () async {
              await widget.dao.deleteShoppingListItem(selectedItem!);
              setState(() {
                myList.remove(selectedItem);
                selectedItem = null;
              });
            },
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                selectedItem = null;
              });
            },
            child: Text("Close"),
          ),
        ],
      ));
    } else {
      return Center(child: Text("Nothing Selected!"));
    }
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
                onTap: () {
                  setState(() {
                    selectedItem = myList[rowNum];
                  });
                  },
                );
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
      body: reactiveLayout()
    );
  }
}
