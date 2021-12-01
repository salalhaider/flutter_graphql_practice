import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, boxContraint) {
      return Container(
        padding: const EdgeInsets.all(20),
        color: Colors.white,
        height: boxContraint.maxHeight,
        width: boxContraint.maxWidth,
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter mobile number'
                  ),
                ),
                const SizedBox(height: 10,),
                ElevatedButton(
                  onPressed: (){}, 
                  child: const Center(
                    child: Text('Log in'),
                  )
                ),
                const SizedBox(height: 10,),
                InkWell(
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    child: const Text('Create new user',
                    style: TextStyle(
                      color: Colors.blue
                    ),),
                  ),
                )
              ],
            )
          ),
        ),
      );
    });
  }
}
