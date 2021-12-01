import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:practiceapp/DTO/user.dart';
import 'package:practiceapp/cubit/dashboardcubit_cubit.dart';

class NewUserForm extends StatefulWidget {
  final User? user;
  const NewUserForm({Key? key, this.user}) : super(key: key);

  @override
  _NewUserFormState createState() => _NewUserFormState();
}

class _NewUserFormState extends State<NewUserForm> {
  GlobalKey<FormState> newUserFormKey = GlobalKey();
  String? fname, lname, phoneNumber, email, cnic;
  DashboardcubitCubit dashboardcubitCubit = DashboardcubitCubit();
  bool loading = false;
  User? _user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add new User')),
      body: LayoutBuilder(builder: (context, boxContraint) {
        return Container(
          padding: const EdgeInsets.all(20),
          color: Colors.white,
          height: boxContraint.maxHeight,
          width: boxContraint.maxWidth,
          child: Center(
            child: Form(
                key: newUserFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            initialValue: _user?.firstName ?? '',
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text('First name'),
                            ),
                            onSaved: (v) {
                              if (_user != null) {
                                _user!.firstName = v;
                              } else {
                                fname = v;
                              }
                            },
                            validator: (v) {
                              if (v != null && v.isNotEmpty) {
                                return null;
                              } else {
                                return 'First name required';
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            initialValue: _user?.lastName ?? '',
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text('Last name'),
                            ),
                            onSaved: (v) {
                              if (_user != null) {
                                _user!.lastName = v;
                              } else {
                                lname = v;
                              }
                            },
                            validator: (v) {
                              if (v != null && v.isNotEmpty) {
                                return null;
                              } else {
                                return 'Last name required';
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      initialValue: _user?.phoneNumber ?? '',
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('Phone number'),
                      ),
                      onSaved: (v) {
                        if (_user != null) {
                          _user!.phoneNumber = v;
                        } else {
                          phoneNumber = v;
                        }
                      },
                      validator: (v) {
                        if (v != null && v.isNotEmpty) {
                          return null;
                        } else {
                          return 'Phone number required';
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      initialValue: _user?.email ?? '',
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('Email'),
                      ),
                      onSaved: (v) {
                        if (_user != null) {
                          _user!.email = v;
                        } else {
                          email = v;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      initialValue: _user?.cnic ?? '',
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Cnic',
                      ),
                      onSaved: (v) {
                        if (_user != null) {
                          _user!.cnic = v;
                        } else {
                          cnic = v;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    StatefulBuilder(
                      builder: (contex, setInState) {
                        return ElevatedButton(
                            onPressed: () async {
                              setInState(() {
                                loading = true;
                              });
                              var form = newUserFormKey.currentState;
                              if (form!.validate()) {
                                form.save();
                                //-- add new user query
                                Map<String, dynamic>? xx = _user?.toJson();
                                xx?['id'] = _user?.id;
                                Map<String, dynamic> variables = {
                                  "createUserInput": {
                                    "firstName": fname,
                                    "lastName": lname,
                                    "phoneNumber": phoneNumber,
                                    "email": email,
                                    "cnic": cnic
                                  }
                                };
                                QueryResult response = _user != null
                                    ? await dashboardcubitCubit
                                        .updateExistingUser(
                                            {"updateUserInput": xx!})
                                    : await dashboardcubitCubit
                                        .addNewUser(variables);
                                if (response.data != null) {
                                  print(response.data);
                                  Navigator.pop(context);
                                  setInState(() {
                                    loading = false;
                                  });
                                }
                                setInState(() {
                                  loading = false;
                                });
                              }
                            },
                            child: Center(
                              child: loading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : const Text('Sign up'),
                            ));
                      },
                    ),
                  ],
                )),
          ),
        );
      }),
    );
  }
}
