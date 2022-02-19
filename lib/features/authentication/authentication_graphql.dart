const String qMutAuthenticationLogin = r'''
mutation Login($email: String!, $password: String!) {
  login(input: {
    email: $email,
    password: $password,
  })
}
''';