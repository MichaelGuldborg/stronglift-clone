class Exercise {
  final String? id;
  final String name;
  final String? type;
  final int? index;
  final double weight;
  final int sets;
  final int reps;
  final double increments;
  Map<String, int?> completed;

  Exercise({
    required this.id,
    required this.name,
    this.type,
    this.index,
    this.weight = 0,
    this.increments = 0,
    this.sets = 3,
    this.reps = 8,
    this.completed = const {},
  });

  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise(
      id: map['id'],
      name: map['name'],
      type: map['type'],
      index: map['index'],
      weight: map['weight'],
      sets: map['sets'],
      reps: map['reps'],
      increments: map['increments'] ?? 0.0,
      completed: ((map['completed'] ?? {}) as Map).map((key, value) => MapEntry(key as String, value as int?)),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'index': index,
      'weight': weight,
      'sets': sets,
      'reps': reps,
      'increments': increments,
      'completed': completed,
    };
  }

  Exercise copyWith({
    String? name,
    double? weight,
    int? sets,
    int? reps,
    double? increments,
  }) {
    return Exercise.fromMap({
      ...toMap(),
      'name': name ?? this.name,
      'weight': weight ?? this.weight,
      'sets': sets ?? this.sets,
      'reps': reps ?? this.reps,
      'increments': increments ?? this.increments,
    });
  }
}
