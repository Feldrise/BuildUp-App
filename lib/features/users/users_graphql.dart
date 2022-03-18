const String qGetDetailedUser = r'''
query GetDetailledUser($id: ID) {
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

const String qGetCoachUser = r'''
query coachUser {
  user {
    id,
    email,
    firstName,
    lastName,
    role,
    description,
    coach {
      builders {
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
  }
}
''';

const qGetUserWithProofs = r'''
query userWithProof($id: ID) {
  user(id: $id) {
    id,
    email,
    firstName,
    lastName,
    role,
    description,
    builder {
      project {
        id,
        name,
        description,
        proofs {
          id,
          stepID,
          type,
          comment,
          file {
            name,
          }
          status,
        }
      }
    }
  }
}
''';

const String qMutUpdateUser = r'''
mutation updateUser(
  $id: ID!,
  $email: String,
  $firstName: String,
  $lastName: String,
  $description: String,
  $situation: String,
  $discord: String,
  $linkedin: String
) {
  updateUser(
    id: $id,
    changes: {
      firstName: $firstName,
      lastName: $lastName,
      email: $email,
      description: $description,
      situation: $situation,
      discord: $discord,
      linkedin: $linkedin
    }
  ) {
    id,
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

const String qProofWithFile = r'''
query proofWithFile($id: ID!) {
  proof(id: $id) {
    stepID,
    type,
    status,
    file {
      name,
      content
    }
  }
}
''';