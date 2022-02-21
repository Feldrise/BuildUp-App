const String qGetDetailedUser = r'''
query GetDetailledUser($id: ID!) {
  user(id: $id) {
    id,
    email,
    firstName,
    lastName,
    role,
    step,
    situation,
    description,
    birthdate,
    address,
    discord, 
    linkedin,
    builder {
      coach {
        firstName,
        lastName,
      },
      project {
        name,
        description,
        categorie,
        keywords,
        team,
        launchDate,
        isLucrative,
        isOfficialyRegistered
      }
    }
  }
}
''';