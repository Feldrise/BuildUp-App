const String qBuildOns = r'''
query buildons {
  buildons { 
    id,
    name, 
    description,
    index,
    annexeUrl,
    rewards,
    steps {
      id,
      name,
      description,
      proofDescription,
      proofType,
      index
    }
  }
}
''';

const String qMutCreateBuildOn = r'''
mutation createBuildOn(
  $name: String!,
  $description: String!,
  $index: Int!,
  $annexeUrl: String!,
  $rewards: String!
) {
  createBuildOn(input: {
    name: $name,
    description: $description,
    index: $index,
    annexeUrl: $annexeUrl,
    rewards: $rewards
  }) {
    id,
    name,
    index
  }
}
''';

const String qMutUpdateBuildOn = r'''
mutation updateBuildOn(
  $id: ID!,
  $name: String!,
  $description: String!,
  $index: Int!,
  $annexeUrl: String!,
  $rewards: String!
) {
  updateBuildOn(id: $id, changes: {
    name: $name,
    description: $description,
    index: $index,
    annexeUrl: $annexeUrl,
    rewards: $rewards
  }) {
    id,
    name,
    index
  }
}
''';