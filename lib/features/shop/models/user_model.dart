// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app1/ultis/fomatters/formatters.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../personalization/models/address_model.dart';

class UserModel {
  final String id;
  final String email;
  String firstName;
  String lastName;
  String userName;
  String phoneNumber;
  String profilePicture;
  // List<AddressModel> address;
  UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.phoneNumber,
    required this.profilePicture,
    // required this.address,
  });
  String get fullName => TFormatter.formatFullName(firstName, lastName);
  String get formatPhoneNumber => TFormatter.formatPhoneNumber(phoneNumber);
  static List<String> nameParts(String fullName) {
    return fullName.split(' ');
  }

  static String generateUserName(String fullName) {
    List<String> parts = fullName.split(' ');
    String firstName = parts[0].toLowerCase();
    String lastName = parts.length > 1 ? parts.last.toLowerCase() : '';
    String camelCaseUserName = '$firstName.$lastName';
    String usernameWithPrefix = 'cwt_$camelCaseUserName';
    return usernameWithPrefix;
  }

  static UserModel empty() => UserModel(
        id: '',
        email: '',
        firstName: '',
        lastName: '',
        userName: '',
        phoneNumber: '',
        profilePicture: '',
        // address: [],
      );
  Map<String, dynamic> toJson() => {
        'Id': id,
        'Email': email,
        'FirstName': firstName,
        'LastName': lastName,
        'UserName': userName,
        'PhoneNumber': phoneNumber,
        'ProfilePicture': profilePicture,
        //   'Address': address.map((addr) => addr.toJson()).toList(),
      };
  factory UserModel.fromSnapshot(DocumentSnapshot document) {
    final data = document.data() as Map<String, dynamic>;
    // ignore: unused_local_variable
    List<AddressModel> addressList = [];
    if (data['Address'] != null) {
      addressList = List<AddressModel>.from((data['Address'] as List)
          .map((addr) => AddressModel.fromJson(addr as Map<String, dynamic>)));
    }
    return UserModel(
      id: data['Id'] ?? '',
      email: data['Email'] ?? '',
      firstName: data['FirstName'] ?? '',
      lastName: data['LastName'] ?? '',
      userName: data['UserName'] ?? '',
      phoneNumber: data['PhoneNumber'] ?? '',
      profilePicture: data['ProfilePicture'] ?? '',
      // address: addressList,
    );
  }

  UserModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? userName,
    String? email,
    String? phoneNumber,
    String? profilePicture,
    List<AddressModel>? address,
  }) {
    return UserModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePicture: profilePicture ?? this.profilePicture,
      //  address: address ?? this.address,
    );
  }
}
