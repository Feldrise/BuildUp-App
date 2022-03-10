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