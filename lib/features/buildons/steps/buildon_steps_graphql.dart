const String qBuildOnSteps = r'''
query buildOnSteps($buildOnID: ID!) {
  buildon(id: $buildOnID) {
    id,
    name,
    index,
    steps {
      id,
      name,
      index,
      description,
      proofType,
      proofDescription
    }
  }
}
''';


const String qMutUpdateBuildOnStep = r'''
mutation updateBuildOnStep(
  $id: ID!,
  $name: String!,
  $description: String!,
  $index: Int!,
  $proofType: String!,
  $proofDescription: String!
) {
  updateBuildOn(id: $id, changes: {
    name: $name,
    description: $description,
    index: $index,
    proofType: $proofType
    proofDescription: $proofDescription
  }) {
    id,
    name,
    index
  }
}
''';