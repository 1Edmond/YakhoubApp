import 'dart:io';
import 'package:multishop_tchad/features/vault/review/domain/models/review_body.dart';
// import 'package:multishop_tchad/core/interfaces/repo_interface.dart';

abstract class ReviewRepositoryInterface {
  Future<dynamic> submitReview(ReviewBody reviewBody, List<File> files, bool update);
  
  Future<dynamic> get(String id, {int offset = 1, int limit = 10});

  Future<dynamic> getOrderWiseReview(String productID, String orderId);

  Future<dynamic> deleteOrderWiseReviewImage(String id, String name);

  Future<dynamic> getDeliveryManReview(String orderId);

  Future<dynamic> submitDeliveryManReview(String orderId, String comment, String rating);

}
