import 'package:cloud_firestore/cloud_firestore.dart';

class BannerModel {
  final bool active;
  String imageURL;
  final String targetScreen;
  BannerModel({
    required this.active,
    required this.imageURL,
    required this.targetScreen,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'active': active,
      'imageURL': imageURL,
      'targetScreen': targetScreen,
    };
  }

  factory BannerModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return BannerModel(
      active: snapshot['active'] ?? false,
      imageURL: snapshot['imageURL'] ?? "",
      targetScreen: snapshot['targetScreen'] ?? "",
    );
  }
}
