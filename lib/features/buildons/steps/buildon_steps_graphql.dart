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