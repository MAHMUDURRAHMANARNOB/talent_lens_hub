class SubscriptionPlan {
  final int id;
  final String name;
  final double price;
  final String duration;
  final String subsType;
  final int noOfCourse;
  final int noOfComments;
  final int noOfTickets;
  final String? imagePath;
  final String? subDesc;
  final double discountAmt;
  final double? multipleAmt;
  final DateTime createdDate;
  final String isActive;
  final double? dollarAmount;
  final double audioMinutes;
  final double audioMinutesUsed;

  SubscriptionPlan({
    required this.id,
    required this.name,
    required this.price,
    required this.duration,
    required this.subsType,
    required this.noOfCourse,
    required this.noOfComments,
    required this.noOfTickets,
    this.imagePath,
    this.subDesc,
    required this.discountAmt,
    this.multipleAmt,
    required this.createdDate,
    required this.isActive,
    this.dollarAmount,
    required this.audioMinutes,
    required this.audioMinutesUsed,
  });

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) {
    return SubscriptionPlan(
      id: json['id'],
      name: json['Name'],
      price: double.parse(json['Price']),
      duration: json['duration'],
      subsType: json['subsType'],
      noOfCourse: json['NoOfCourse'],
      noOfComments: json['NoOfComments'],
      noOfTickets: json['NoOfTickets'],
      imagePath: json['Imagepath'],
      subDesc: json['subDesc'],
      discountAmt: (json['discountAmt'] as num).toDouble(),
      multipleAmt: json['multipleAmt'] != null
          ? (json['multipleAmt'] as num).toDouble()
          : null,
      createdDate: DateTime.parse(json['CreatedDate']),
      isActive: json['isActive'],
      dollarAmount: json['DollarAmount'] != null
          ? (json['DollarAmount'] as num).toDouble()
          : null,
      audioMinutes: double.parse(json['audiominutes']),
      audioMinutesUsed: double.parse(json['audioMinutesUsed']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'Name': name,
      'Price': price.toStringAsFixed(2),
      'duration': duration,
      'subsType': subsType,
      'NoOfCourse': noOfCourse,
      'NoOfComments': noOfComments,
      'NoOfTickets': noOfTickets,
      'Imagepath': imagePath,
      'subDesc': subDesc,
      'discountAmt': discountAmt,
      'multipleAmt': multipleAmt,
      'CreatedDate': createdDate.toIso8601String(),
      'isActive': isActive,
      'DollarAmount': dollarAmount,
      'audiominutes': audioMinutes.toStringAsFixed(2),
      'audioMinutesUsed': audioMinutesUsed.toStringAsFixed(2),
    };
  }
}
