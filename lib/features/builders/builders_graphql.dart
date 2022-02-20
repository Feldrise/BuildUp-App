const String qActiveBuilders = r'''
query ActiveBuilders {
  users(filters: [
    {
      key: "role",
      value: "BUILDER"
    },
    {
      key: "step",
      value: "ACTIVE"
    }
  ]) {
    id,
    email,
    firstName,
    lastName,
    role,
    step,
    situation,
    description,
    builder {
      project {
        name,
        description
      }
    }
  }
}
''';