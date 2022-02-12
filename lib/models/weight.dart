class Weight {
  final String? id;
  final int value;
  final String timeStamp;

  Weight({
    this.id,
    required this.value,
    required this.timeStamp,
  });

  factory Weight.fromJson(Map<String, dynamic> json) {
    return Weight(
      id: json['_id'] as String,
      value: int.parse(json['value']) as int,
      timeStamp: json['timeStamp'] as String,
    );
  }

  @override
  String toString() {
    return 'weights{id: $id, value: $value, timeStamp: $timeStamp}';
  }
}
