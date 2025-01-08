class MealPlan {
  int? id;
  String mealType; 
  String title;
  String imagePath;
  int servings;
  DateTime date;

  MealPlan({
    this.id,
    required this.mealType,
    required this.title,
    required this.imagePath,
    required this.servings,
    required this.date,
  });

  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'mealType': mealType,
      'title': title,
      'imagePath': imagePath,
      'servings': servings,
      'date': date.toIso8601String(),
    };
  }

  
  factory MealPlan.fromMap(Map<String, dynamic> map) {
    return MealPlan(
      id: map['id'],
      mealType: map['mealType'],
      title: map['title'],
      imagePath: map['imagePath'],
      servings: map['servings'],
      date: DateTime.parse(map['date']),
    );
  }
}
