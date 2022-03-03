const String qActiveBuilders = r'''
query ActiveBuilders {
  users(filters: [
    {
      key: "role",
      value: "BUILDER"
    },
    {
      key: "status",
      value: "VALIDATED"
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

const String qCandidatingBuilder = r'''
query CandidatingBuilders {
  users(filters: [
    {
      key: "role",
      value: "BUILDER"
    },
    {
      key: "status",
      value: "CANDIDATING"
    }
  ]) {
    id,
    createdAt,
    email,
    firstName,
    lastName,
    role,
    status,
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