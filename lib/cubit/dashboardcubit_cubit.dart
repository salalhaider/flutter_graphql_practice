import 'package:bloc/bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:meta/meta.dart';
import 'package:practiceapp/services/graphql_service.dart';
import 'package:practiceapp/services/queries.dart';

part 'dashboardcubit_state.dart';

class DashboardcubitCubit extends Cubit<DashboardcubitState> {
  DashboardcubitCubit() : super(DashboardcubitInitial());

  GraphQlService service = GraphQlService();

  Stream userStream() {
    return service.userSubsciption(updatedUserStream);
  }

  Future<QueryResult> getAllUsers() async{
    return await service.performQuery(/*getAllUsers, null*/);
  }
  Future<QueryResult> addNewUser(Map<String,dynamic> variable) async {
    return await service.performMutation(addUser,variable);
  }
  Future<QueryResult> updateExistingUser(Map<String,dynamic> variable) async {
    return await service.performMutation(updateUser,variable);
  }
  Future<QueryResult> deleteExistingUser(Map<String,dynamic> variable) async {
    return await service.performMutation(deleteUser,variable);
  }
  
}
