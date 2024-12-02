class CategoryModel {
  final String id;
  final DateTime createdAt;
  final String name;
  final String description;

  CategoryModel({required this.id, required this.createdAt, required this.name, required this.description});

   Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt,
      'name': name,
      'description': description,
    };
  }

  static CategoryModel fromMap(Map<String, dynamic> data) {
    return CategoryModel(
      id: data['id'] as String,
      createdAt: data['created_at'] as DateTime,
      name: data['name'] as String,
      description: data['description'] as String,
    );
  }
  
}
