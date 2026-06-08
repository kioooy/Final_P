import 'package:equatable/equatable.dart';

class ReviewEntity extends Equatable {
  final String reviewId;
  final String productId;
  final String userId;
  final String userName;
  final String? userAvatar;
  final int rating;
  final String comment;
  final DateTime createdAt;

  const ReviewEntity({
    required this.reviewId,
    required this.productId,
    required this.userId,
    required this.userName,
    this.userAvatar,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  ReviewEntity copyWith({
    String? reviewId,
    String? productId,
    String? userId,
    String? userName,
    String? userAvatar,
    int? rating,
    String? comment,
    DateTime? createdAt,
  }) {
    return ReviewEntity(
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

  @override
  List<Object?> get props => [
        reviewId,
        productId,
        userId,
        userName,
        userAvatar,
        rating,
        comment,
        createdAt,
      ];
}
