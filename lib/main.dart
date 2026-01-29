import 'package:flutter/material.dart';
import 'labs/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _counter = 0.0;
  var myFontSize = 30.0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      if (_counter < 99.0) _counter++;
    });
  }

  void setNewValue(double value) {
    setState(() {
      _counter = value;
      myFontSize = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
        margin: const EdgeInsets.all(14.0),
        child: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: SingleChildScrollView(child:
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "BROWSE CATEGORIES",
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: Text(
                  "Not sure about exactly which recipe you're looking for? Do a search, or dive into our most popular categories.",
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
              Text(
                "BY MEAT",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.center,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: AssetImage('images/lab3/beef.jpg'),
                          radius: 40.0,
                        ),
                        Text(
                          "BEEF",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.035,
                            shadows: [
                              Shadow(
                                color: Colors.black,
                                offset: Offset(0.0, 3.0),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      alignment: AlignmentDirectional.center,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: AssetImage(
                            'images/lab3/chicken.jpg',
                          ),
                          radius: 40.0,
                        ),
                        Text(
                          "CHICKEN",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.035,
                            shadows: [
                              Shadow(
                                color: Colors.black,
                                offset: Offset(0.0, 3.0),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      alignment: AlignmentDirectional.center,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: AssetImage('images/lab3/pork.jpg'),
                          radius: 40.0,
                        ),
                        Text(
                          "PORK",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.035,
                            shadows: [
                              Shadow(
                                color: Colors.black,
                                offset: Offset(0.0, 3.0),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      alignment: AlignmentDirectional.center,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: AssetImage(
                            'images/lab3/seafood.jpg',
                          ),
                          radius: 40.0,
                        ),
                        Text(
                          "SEAFOOD",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.035,
                            shadows: [
                              Shadow(
                                color: Colors.black,
                                offset: Offset(0.0, 3.0),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                "BY COURSE",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(
                            'images/lab3/main-dishes.jpg',
                          ),
                          radius: 40.0,
                        ),
                        SizedBox(height: 8),
                        Text("Main Dishes", textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12.0),),
                      ],
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(
                            'images/lab3/salad-recipes.jpg',
                          ),
                          radius: 40.0,
                        ),
                        SizedBox(height: 8),
                        Text("Salad Recipes", textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12.0),),
                      ],
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(
                            'images/lab3/side-dishes.jpg',
                          ),
                          radius: 40.0,
                        ),
                        SizedBox(height: 8),
                        Text("Side Dishes", textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12.0),),
                      ],
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(
                            'images/lab3/crockpot.jpg',
                          ),
                          radius: 40.0,
                        ),
                        SizedBox(height: 8),
                        Text("Crockpot", textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12.0),),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                "BY DESSERT",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(
                            'images/lab3/icecream.jpg',
                          ),
                          radius: 40.0,
                        ),
                        SizedBox(height: 8),
                        Text("Ice Cream", textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12.0),),
                      ],
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(
                            'images/lab3/brownies.jpg',
                          ),
                          radius: 40.0,
                        ),
                        SizedBox(height: 8),
                        Text("Brownies", textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12.0),),
                      ],
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('images/lab3/pies.jpg'),
                          radius: 40.0,
                        ),
                        SizedBox(height: 8),
                        Text("Pies", textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12.0),),
                      ],
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(
                            'images/lab3/cookies.jpg',
                          ),
                          radius: 40.0,
                        ),
                        SizedBox(height: 8),
                        Text("Cookies", textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12.0),),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          )
        ),
      ),
    );
  }
}
