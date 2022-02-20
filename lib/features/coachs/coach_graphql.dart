const String qActiveCoachs = r'''
query ActiveCoachs {
  users(filters: [
    {
      key: "role",
      value: "COACH"
    },
    {
      key: "step",
      value: "ACTIVE"
    }
  ]) {
    email,
    firstName,
    lastName,
    role,
    step,
    description,
    situation
    coach {}
  }
}
''';