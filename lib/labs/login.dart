import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
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

class _MyHomePageState extends State<MyHomePage> {

  var password = 'placeholder';
  late TextEditingController loginController;
  late TextEditingController passwordController;
  var imageSource = 'images/question-mark.png';
  var imageDescription = 'a bundle of question marks';

  late EncryptedSharedPreferences prefs;
  var snackBarAppeared = false;

  @override
  void initState() {
    super.initState();
    loginController = TextEditingController();
    passwordController = TextEditingController();

    prefs = EncryptedSharedPreferences();

    void displaySnackBar() {
      if (snackBarAppeared) return;
      snackBarAppeared = true;

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("User information successfully loaded!")
          )
      );
    }

    prefs.getString("username").then((loginName) {
      if (loginName.isNotEmpty) {
        loginController.text = loginName;
        displaySnackBar();
      }
    });

    prefs.getString("password").then((loginPass) {
      if (loginPass.isNotEmpty) {
        passwordController.text = loginPass;
        displaySnackBar();
      }
    });
  }

  @override
  void dispose() {
    loginController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void saveInfo () {
    prefs.setString("username", loginController.value.text);
    prefs.setString("password", passwordController.value.text);
    Navigator.pop(context);
  }

  void deleteInfo () {
    prefs.remove("username");
    prefs.remove("password");
    Navigator.pop(context);
  }

  void buttonClicked() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('IMPORTANT'),
        content: const Text('Do you wish to save your login information?'),
        actions: <Widget>[
          ElevatedButton( onPressed: saveInfo, child:  Text("Yes")  ),
          ElevatedButton( onPressed: deleteInfo, child:  Text("No")  )
        ],
      ),
    );

    setState(() {
      password = passwordController.value.text;
      if (password == 'ASDF') {
        imageSource = 'images/idea.png';
        imageDescription = 'a glowing lightbulb';
      } else {
        imageSource = 'images/stop.png';
        imageDescription = 'a stop sign';
      }
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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: .center,
          children: [
            TextField(controller: loginController,
                decoration: InputDecoration(
                    hintText:"John Smith",
                    border: OutlineInputBorder(),
                    labelText: "Login"
                )),
            TextField(controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Password"
                )),
            ElevatedButton( onPressed: buttonClicked, child:  Text("Login")  ),
            Semantics(label: imageDescription,
                child: Image.asset(imageSource, height:300.0, width:300.0)
            )
          ],
        ),
      ),
    );
  }
}
