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
    id,
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

const String qCandidatingCoachs = r'''
query CandidatingCoachs {
  users(filters: [
    {
      key: "role",
      value: "COACH"
    },
    {
      key: "status",
      value: "CANDIDATING"
    }
  ]) {
    id,
    email,
    createdAt,
    firstName,
    lastName,
    role,
    discord,
    status,
    step,
    description,
    situation
    coach {}
  }
}
''';