class JoinedHabit {
  final String id;
  final String name;
  final String frequencyType;
  final int? targetCount;
  final String? targetPeriod;

  const JoinedHabit({
    required this.id,
    required this.name,
    required this.frequencyType,
    this.targetCount,
    this.targetPeriod,
  });

  factory JoinedHabit.fromMap(Map<String, dynamic> map) {
    return JoinedHabit(
      id: map['id'] as String,
      name: map['name'] as String,
      frequencyType: map['frequency_type'] as String? ?? 'custom',
      targetCount: (map['target_count'] as num?)?.toInt(),
      targetPeriod: map['target_period'] as String?,
    );
  }

  String get frequencyLabel {
    const digits = '۰۱۲۳۴۵۶۷۸۹';

    String toPersianDigits(int number) {
      return number.toString().split('').map((digit) {
        final index = int.tryParse(digit);
        return index == null ? digit : digits[index];
      }).join();
    }

    if (targetCount != null &&
        targetCount! > 0 &&
        targetPeriod != null &&
        targetPeriod!.isNotEmpty) {
      final period = switch (targetPeriod) {
        'day' => 'روز',
        'week' => 'هفته',
        'month' => 'ماه',
        _ => targetPeriod!,
      };

      return '${toPersianDigits(targetCount!)} بار در $period';
    }

    return switch (frequencyType) {
      'daily' => 'روزانه',
      'weekly' => 'هفتگی',
      'monthly' => 'ماهانه',
      _ => 'بر اساس برنامه شخصی',
    };
  }
}
