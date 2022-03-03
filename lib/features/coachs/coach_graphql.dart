const String qActiveCoachs = r'''
query ActiveCoachs {
  users(filters: [
    {
      key: "role",
      value: "COACH"
    },
    {
      key: "status",
      value: "ACTIVE"
    }
  ]) {
    email,
    firstName,
    lastName,
    role,
    status,
    step,
    description,
    situation
    coach {}
  }
}
''';