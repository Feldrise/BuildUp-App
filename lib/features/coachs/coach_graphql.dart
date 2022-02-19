const String qActiveCoachs = r'''
query ActiveBuilders {
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
    coach {
      description,
      situation
    }
  }
}
''';