import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/review_entity.dart';

class ReviewModel {
  final String reviewId;
  final String productId;
  final String userId;
  final String userName;
  final String? userAvatar;
  final int rating;
  final String comment;
  final DateTime createdAt;

  const ReviewModel({
    required this.reviewId,
    required this.productId,
    required this.userId,
    required this.userName,
    this.userAvatar,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      reviewId: map['reviewId']?.toString() ?? '',
      productId: map['productId']?.toString() ?? '',
      userId: map['userId']?.toString() ?? '',
      userName: map['userName']?.toString() ?? '',
      userAvatar: map['userAvatar']?.toString(),
      rating: map['rating'] is num ? (map['rating'] as num).toInt() : int.tryParse(map['rating']?.toString() ?? '') ?? 0,
      comment: map['comment']?.toString() ?? '',
      createdAt: map['createdAt'] is Timestamp 
          ? (map['createdAt'] as Timestamp).toDate() 
          : (DateTime.tryParse(map['createdAt']?.toString() ?? '') ?? DateTime.now()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'reviewId': reviewId,
      'productId': productId,
      'userId': userId,
      'userName': userName,
      'userAvatar': userAvatar,
      'rating': rating,
      'comment': comment,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  factory ReviewModel.fromEntity(ReviewEntity entity) {
    return ReviewModel(
      reviewId: entity.reviewId,
      productId: entity.productId,
      userId: entity.userId,
      userName: entity.userName,
      userAvatar: entity.userAvatar,
      rating: entity.rating,
      comment: entity.comment,
      createdAt: entity.createdAt,
    );
  }

  ReviewEntity toEntity() {
    return ReviewEntity(
      reviewId: reviewId,
      productId: productId,
      userId: userId,
      userName: userName,
      userAvatar: userAvatar,
      rating: rating,
      comment: comment,
      createdAt: createdAt,
    );
  }

  ReviewModel copyWith({
    String? reviewId,
    String? productId,
    String? userId,
    String? userName,
    String? userAvatar,
    int? rating,
    String? comment,
    DateTime? createdAt,
  }) {
    return ReviewModel(
      reviewId: reviewId ?? this.reviewId,
      productId: productId ?? this.productId,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userAvatar: userAvatar ?? this.userAvatar,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
