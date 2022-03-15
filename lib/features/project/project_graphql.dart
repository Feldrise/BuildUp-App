const String qMutSubmitProof = r'''
mutation submitProof(
  $projectID: ID!, 
  $stepID: ID!,
  $type: String!,
  $comment: String
) {
  submitProof(
    projectID: $projectID, 
    input: {type: $type, stepID: $stepID, comment: $comment}) {
    id
  }
}
''';

const String qMutUpdateProject = r'''
mutation updateUserProject(
  $userID: ID!,
  $name: String,
  $description: String,
  $team: String,
  $category: String,
  $keywords: String,
  $isLucrative: Boolean,
  $isOfficialyRegistered: Boolean
) {
  updateUser(
    id: $userID,
    changes: {
      builder: {
        project: {
          name: $name,
          description: $description,
          team: $team,
          categorie: $category,
          keywords: $keywords,
          isLucrative: $isLucrative,
          isOfficialyRegistered: $isOfficialyRegistered
        }
      }
    } 
  ) {
    id,
    builder {
      project {
        id,
        name
      }
    }
  }
}
''';

const String qMutValidateProof = r'''
mutation validateProof($proofID: ID!) {
  validateProof(proofID: $proofID) {
    id
  }
}
''';

const String qMutRefuseProof = r'''
mutation refuseProof($proofID: ID!) {
  refuseProof(proofID: $proofID) {
    id
  }
}
''';