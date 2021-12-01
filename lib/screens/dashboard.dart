import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:practiceapp/DTO/user.dart';
import 'package:practiceapp/cubit/dashboardcubit_cubit.dart';
import 'package:practiceapp/screens/new_user.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  DashboardcubitCubit dashboardCubit = DashboardcubitCubit();
  List<User> allUsersList = [];
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, boxConstrant) {
      return Container(
          padding: const EdgeInsets.all(10),
          height: boxConstrant.maxHeight,
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder(
                  future: dashboardCubit.getAllUsers(),//dashboardCubit.userStream(),
                  builder: (context, snapshot) {
                    print('\n\n---- snpshot.data ----> ${snapshot.data} \n\n');
                    if (snapshot.hasData) {
                      QueryResult result = snapshot.data as QueryResult;
                      print('\n\n---- result.data ----> ${result.data} \n\n');
                      if (result.data != null) {
                        allUsersList = [];
                        result.data!['getAllUsers'].forEach((element) {
                          User user = User();
                          try {
                            user = User.fromJson(element);
                          } catch (e, s) {
                            print(e);
                            print(s);
                          }
                          if (user.id != null) {
                            allUsersList.add(user);
                          }
                        });
                        print('\n\n --- all users -----> $allUsersList');
                        return ListView.builder(
                            itemCount: allUsersList.length,
                            itemBuilder: (context, index) {
                              User user = allUsersList[index];
                              return Dismissible(
                                key: UniqueKey(),
                                background: Container(
                                  color: Colors.blue,
                                ),
                                onDismissed: (direction) async {
                                  var response = await dashboardCubit
                                      .deleteExistingUser({"userId": user.id});
                                  setState(() {
                                    allUsersList.removeAt(index);
                                  });
                                  
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  width: boxConstrant.maxWidth,
                                  child: InkWell(
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => NewUserForm(
                                                  user: user,
                                                ))),
                                    child: Card(
                                      child: Container(
                                        margin: const EdgeInsets.all(5),
                                        child: Column(
                                          children: [
                                            Text(user.firstName!),
                                            Text(user.lastName!),
                                            Text(user.phoneNumber!),
                                            Text(user.email!),
                                            Text(user.cnic!),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                      } else if (result.hasException) {
                        print(result.exception);
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              CircularProgressIndicator(
                                color: Colors.blue,
                              ),
                              Text('Exception')
                            ],
                          ),
                        );
                      } else {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              CircularProgressIndicator(
                                color: Colors.blue,
                              ),
                              Text('Error')
                            ],
                          ),
                        );
                      }
                    } else {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            CircularProgressIndicator(
                              color: Colors.blue,
                            ),
                            Text('Error')
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (contex) => NewUserForm())),
                    child: const Center(
                      child: Text('Add new user'),
                    )),
              )
            ],
          ));
    });
  }
}
