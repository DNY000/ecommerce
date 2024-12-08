// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class AddressModel {
  String id;

  final String name;
  final String phoneNumber;
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final DateTime dateTime;
  bool selectedAddress;
  AddressModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    required this.dateTime,
    required this.selectedAddress,
  });
  static AddressModel get empty => AddressModel(
        id: '',
        name: '',
        phoneNumber: '',
        street: '',
        city: '',
        state: '',
        postalCode: '',
        country: '',
        dateTime: DateTime.now(),
        selectedAddress: false,
      );
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'phoneNumber': phoneNumber,
        'street': street,
        'city': city,
        'state': state,
        'postalCode': postalCode,
        'country': country,
        'dateTime': dateTime.toIso8601String(),
        'selectedAddress': selectedAddress,
      };
  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        phoneNumber: json['phoneNumber'] ?? '',
        street: json['street'] ?? '',
        city: json['city'] ?? '',
        state: json['state'] ?? '',
        postalCode: json['postalCode'] ?? '',
        country: json['country'] ?? '',
        dateTime: DateTime.parse(
            json['dateTime'] ?? DateTime.now().toIso8601String()),
        selectedAddress: json['selectedAddress'] ?? false,
      );

  factory AddressModel.fromSnapshot(DocumentSnapshot snapshot) =>
      AddressModel.fromJson(snapshot.data() as Map<String, dynamic>);

  @override
  String toString() => ' $street,  $city,  $state,  $postalCode, $country, ';
}
