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

const String qMutCreateBuildOnStep = r'''
mutation createBuildOnStep(
  $buildOnID: ID!,
  $name: String!,
  $description: String!,
  $index: Int!,
  $proofType: String!,
  $proofDescription: String!
) {
  createBuildOnStep(buildOnID: $buildOnID, input: {
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

const String qMutUpdateBuildOnStep = r'''
mutation updateBuildOnStep(
  $id: ID!,
  $name: String!,
  $description: String!,
  $index: Int!,
  $proofType: String!,
  $proofDescription: String!
) {
  updateBuildOnStep(id: $id, changes: {
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