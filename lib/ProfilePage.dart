import 'package:flutter/material.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:my_flutter_labs/DataRepository.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {

  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();

    firstNameController = TextEditingController(text: DataRepository.firstName);
    lastNameController = TextEditingController(text: DataRepository.lastName);
    phoneController = TextEditingController(text: DataRepository.phoneNumber);
    emailController = TextEditingController(text: DataRepository.email);

    firstNameController.addListener(() {
      DataRepository.firstName = firstNameController.text;
      DataRepository.saveData();
    });
    lastNameController.addListener(() {
      DataRepository.lastName = lastNameController.text;
      DataRepository.saveData();
    });
    phoneController.addListener(() {
      DataRepository.phoneNumber = phoneController.text;
      DataRepository.saveData();
    });
    emailController.addListener(() {
      DataRepository.email = emailController.text;
      DataRepository.saveData();
    });

    Future.delayed(Duration.zero, () {
      final snackBar = SnackBar( content: Text("Welcome back ${DataRepository.loginName}") );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }  );
    }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile Information')),
      body: Column(children: [
        Text('Profile Page'),
        Text('Welcome back ${DataRepository.loginName}.'),
        TextField(controller: firstNameController,
            decoration: InputDecoration(
                hintText:"John",
                border: OutlineInputBorder(),
                labelText: "First Name"
            )),
        TextField(controller: lastNameController,
            decoration: InputDecoration(
                hintText:"Smith",
                border: OutlineInputBorder(),
                labelText: "Last Name"
            )),
        Row(children: [
          Flexible(child:
          TextField(controller: phoneController,
              decoration: InputDecoration(
                  hintText:"XXX XXX XXXX",
                  border: OutlineInputBorder(),
                  labelText: "Phone Number"
              ))
          ),
          IconButton(onPressed: (){
            //launch("tel:${phoneController.text}");
            canLaunch("tel:${phoneController.text}").then(
                    (itCan) {

                  if(itCan)
                  {
                    launch("tel:${phoneController.text}");
                  }
                  else
                  {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Action not supported"),
                        content: Text("Your device cannot make phone calls."),
                        actions: [
                          ElevatedButton(
                            child: Text("OK"),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      ),
                    );
                  }
                }
            );
          }, icon: Icon(Icons.phone)),
          IconButton(onPressed: (){
            //launch("sms:${phoneController.text}");
            canLaunch("sms:${phoneController.text}").then(
                    (itCan) {

                  if(itCan)
                  {
                    launch("sms:${phoneController.text}");
                  }
                  else
                  {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Action not supported"),
                        content: Text("Your device cannot send text messages."),
                        actions: [
                          ElevatedButton(
                            child: Text("OK"),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      ),
                    );
                  }
                }
            );
          }, icon: Icon(Icons.sms))
        ],),
        Row(children: [
          Flexible(child:
          TextField(controller: emailController,
              decoration: InputDecoration(
                  hintText:"someperson@email.com",
                  border: OutlineInputBorder(),
                  labelText: "Email"
              ))
          ),
          IconButton(onPressed: (){
            //launch("mailto:${emailController.text}");
            canLaunch("mailto:${emailController.text}").then(
                    (itCan) {

                  if(itCan)
                  {
                    launch("mailto:${emailController.text}");
                  }
                  else
                  {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Action not supported"),
                        content: Text("Your device cannot send emails."),
                        actions: [
                          ElevatedButton(
                            child: Text("OK"),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      ),
                    );
                  }
                }
            );
          }, icon: Icon(Icons.email))
        ],),
      ]),
    );
  }
}
