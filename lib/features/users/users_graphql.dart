const String qGetDetailedUser = r'''
query GetDetailledUser($id: ID!) {
  user(id: $id) {
    id,
    email,
    firstName,
    lastName,
    role,
    status,
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

const mUserUpdateStepStatus = r'''
mutation updateUserStepStatus($id: ID!, $step: String, $status: String) {
  updateUser(
    id: $id,
    changes: {
      step: $step,
      status: $status,
    }
  ) {
    step,
    status
  }
}
''';