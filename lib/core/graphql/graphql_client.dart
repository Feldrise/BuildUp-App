import 'package:buildup/core/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final _graphQLApiLink = HttpLink(kApiBaseUrl);

ValueNotifier<GraphQLClient> graphQLClient(String? token) {
  final Link link = token != null
    ? AuthLink(getToken: () => "Bearer $token").concat(_graphQLApiLink)
    : _graphQLApiLink;

  return ValueNotifier(
    GraphQLClient(
      cache: GraphQLCache(store: HiveStore()),
      link: link
    )
  );

}