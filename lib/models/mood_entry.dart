class MoodEntry {
  final int? id;
  final DateTime date;
  final int mood; // -3 to +3 scale
  final double hoursSlept;
  final bool hasAnxiety;
  final bool hasIrritability;
  final String medication;
  final bool hasAlcoholDrugs;
  final int exerciseMinutes;
  final String stressors;
  final String activities;
  final bool hasEaten;

  MoodEntry({
    this.id,
    required this.date,
    required this.mood,
    required this.hoursSlept,
    required this.hasAnxiety,
    required this.hasIrritability,
    required this.medication,
    required this.hasAlcoholDrugs,
    required this.exerciseMinutes,
    required this.stressors,
    required this.activities,
    required this.hasEaten,
  });

  // Convert MoodEntry to Map for database storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'mood': mood,
      'hoursSlept': hoursSlept,
      'hasAnxiety': hasAnxiety ? 1 : 0,
      'hasIrritability': hasIrritability ? 1 : 0,
      'medication': medication,
      'hasAlcoholDrugs': hasAlcoholDrugs ? 1 : 0,
      'exerciseMinutes': exerciseMinutes,
      'stressors': stressors,
      'activities': activities,
      'hasEaten': hasEaten ? 1 : 0,
    };
  }

  // Create MoodEntry from Map (database retrieval)
  factory MoodEntry.fromMap(Map<String, dynamic> map) {
    return MoodEntry(
      id: map['id'],
      date: DateTime.parse(map['date']),
      mood: map['mood'],
      hoursSlept: map['hoursSlept'],
      hasAnxiety: map['hasAnxiety'] == 1,
      hasIrritability: map['hasIrritability'] == 1,
      medication: map['medication'] ?? '',
      hasAlcoholDrugs: map['hasAlcoholDrugs'] == 1,
      exerciseMinutes: map['exerciseMinutes'],
      stressors: map['stressors'] ?? '',
      activities: map['activities'] ?? '',
      hasEaten: map['hasEaten'] == 1,
    );
  }

  // Helper method to get mood description
  String get moodDescription {
    switch (mood) {
      case 3: return 'Very High';
      case 2: return 'High';
      case 1: return 'Slightly High';
      case 0: return 'Normal';
      case -1: return 'Slightly Low';
      case -2: return 'Low';
      case -3: return 'Very Low';
      default: return 'Unknown';
    }
  }

  // Helper method to get mood color
  String get moodColorHex {
    if (mood >= 2) return '#4CAF50'; // Green
    if (mood >= 1) return '#8BC34A'; // Light Green
    if (mood == 0) return '#2196F3'; // Blue
    if (mood >= -1) return '#FF9800'; // Orange
    return '#F44336'; // Red
  }

  // Helper method to format sleep duration
  String get sleepDurationFormatted {
    int hours = hoursSlept.floor();
    int minutes = ((hoursSlept % 1) * 60).round();
    return '${hours}h ${minutes}m';
  }

  // Helper method to format exercise duration
  String get exerciseDurationFormatted {
    int hours = exerciseMinutes ~/ 60;
    int minutes = exerciseMinutes % 60;
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }

  // Helper method to check if this is a good day (subjective criteria)
  bool get isGoodDay {
    return mood >= 0 && 
           hoursSlept >= 6 && 
           hoursSlept <= 10 && 
           !hasAnxiety && 
           !hasIrritability && 
           hasEaten;
  }

  // Helper method to get warning flags
  List<String> get warningFlags {
    List<String> flags = [];
    
    if (mood <= -2) flags.add('Very low mood');
    if (hoursSlept < 6) flags.add('Insufficient sleep');
    if (hoursSlept > 10) flags.add('Excessive sleep');
    if (hasAnxiety) flags.add('Anxiety reported');
    if (hasIrritability) flags.add('Irritability reported');
    if (!hasEaten) flags.add('No food intake');
    if (hasAlcoholDrugs) flags.add('Substance use');
    if (exerciseMinutes == 0) flags.add('No exercise');
    
    return flags;
  }

  // Copy method for creating modified versions
  MoodEntry copyWith({
    int? id,
    DateTime? date,
    int? mood,
    double? hoursSlept,
    bool? hasAnxiety,
    bool? hasIrritability,
    String? medication,
    bool? hasAlcoholDrugs,
    int? exerciseMinutes,
    String? stressors,
    String? activities,
    bool? hasEaten,
  }) {
    return MoodEntry(
      id: id ?? this.id,
      date: date ?? this.date,
      mood: mood ?? this.mood,
      hoursSlept: hoursSlept ?? this.hoursSlept,
      hasAnxiety: hasAnxiety ?? this.hasAnxiety,
      hasIrritability: hasIrritability ?? this.hasIrritability,
      medication: medication ?? this.medication,
      hasAlcoholDrugs: hasAlcoholDrugs ?? this.hasAlcoholDrugs,
      exerciseMinutes: exerciseMinutes ?? this.exerciseMinutes,
      stressors: stressors ?? this.stressors,
      activities: activities ?? this.activities,
      hasEaten: hasEaten ?? this.hasEaten,
    );
  }

  @override
  String toString() {
    return 'MoodEntry{id: $id, date: $date, mood: $mood, hoursSlept: $hoursSlept, hasAnxiety: $hasAnxiety, hasIrritability: $hasIrritability, medication: $medication, hasAlcoholDrugs: $hasAlcoholDrugs, exerciseMinutes: $exerciseMinutes, stressors: $stressors, activities: $activities, hasEaten: $hasEaten}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MoodEntry &&
        other.id == id &&
        other.date == date &&
        other.mood == mood &&
        other.hoursSlept == hoursSlept &&
        other.hasAnxiety == hasAnxiety &&
        other.hasIrritability == hasIrritability &&
        other.medication == medication &&
        other.hasAlcoholDrugs == hasAlcoholDrugs &&
        other.exerciseMinutes == exerciseMinutes &&
        other.stressors == stressors &&
        other.activities == activities &&
        other.hasEaten == hasEaten;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      date,
      mood,
      hoursSlept,
      hasAnxiety,
      hasIrritability,
      medication,
      hasAlcoholDrugs,
      exerciseMinutes,
      stressors,
      activities,
      hasEaten,
    );
  }
}