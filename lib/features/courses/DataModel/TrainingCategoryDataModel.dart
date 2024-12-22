class TrainingCategoryDataModel {
  final int id;
  final String name;

  TrainingCategoryDataModel({required this.id, required this.name});

  // Factory method to create an instance from JSON
  factory TrainingCategoryDataModel.fromJson(Map<String, dynamic> json) {
    return TrainingCategoryDataModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
