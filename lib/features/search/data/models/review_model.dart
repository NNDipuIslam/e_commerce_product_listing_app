import 'package:hive/hive.dart';

part 'review_model.g.dart';

@HiveType(typeId: 2)
class ReviewModel {
  @HiveField(0)
  final double? rating;

  @HiveField(1)
  final String? comment;

  @HiveField(2)
  final DateTime? date;

  @HiveField(3)
  final String? reviewerName;

  ReviewModel({
    this.rating,
    this.comment,
    this.date,
    this.reviewerName,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
        rating: (json["rating"] as num?)?.toDouble(),
        comment: json["comment"] as String?,
        date: json["date"] != null ? DateTime.tryParse(json["date"]) : null,
        reviewerName: json["reviewerName"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "rating": rating,
        "comment": comment,
        "date": date?.toIso8601String(),
        "reviewerName": reviewerName,
      };
}
