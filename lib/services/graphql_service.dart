import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:practiceapp/services/connection.dart';
import 'package:practiceapp/services/queries.dart';

class GraphQlService {
  GraphQLClient? _client;

  GraphQlService() {
    HttpLink link = HttpLink('https://backend.dev.bridgelinxpk.com/graphql');
    _client =
        GraphQLClient(link: link, cache: GraphQLCache(store: InMemoryStore()));
  }
  // final GraphQLClient _client = clientToQuery();


  Future<QueryResult> performQuery(
      /*String query, Map<String, dynamic> variables*/) async {
    QueryOptions options = QueryOptions(document: gql(getAllUsers));

    print('------- inside perform query ---------');

    final result = await _client!.query(options);
    print('---- result ----> $result \n');
    return result;
  }

  Future<QueryResult> performMutation(
      String query, Map<String, dynamic> variables) async {
    MutationOptions options =
        MutationOptions(document: gql(query), variables: variables);

    final result = await _client!.mutate(options);
    print('---- result ----> $result \n');
    return result;
  }

  Stream<QueryResult> userSubsciption(String query) {
    print('--- inside repo ------');
    SubscriptionOptions options = SubscriptionOptions(document: gql(query));

    final result = _client!.subscribe(options);
    print(result);
    return result;
  }
}
