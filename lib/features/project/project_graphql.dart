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