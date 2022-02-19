const String qMutAuthenticationLogin = r'''
mutation Login($email: String!, $password: String!) {
  login(input: {
    email: $email,
    password: $password,
  })
}
''';

const String qGetLoggedUser = r'''
query GetLoggedUser {
  user {
    email,
    firstName,
    lastName,
    role,
    step,
  }
}
''';