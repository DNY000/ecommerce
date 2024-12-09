// ignore_for_file: public_member_api_docs, sort_constructors_first

class ProductAttributeModel {
  final List<String>? values;
  String? name;

  ProductAttributeModel({this.values, this.name});

  Map<String, dynamic> toJson() {
    return {
      'Values': values,
      'Name': name,
    };
  }

  static ProductAttributeModel empty() =>
      ProductAttributeModel(name: 'Colors', values: ['màu', 'xanh']);

  // factory ProductAttributeModel.fromSnapshot(
  //     DocumentSnapshot<Map<String, dynamic>> document) {
  //   final data = document.data()!;
  //   return ProductAttributeModel(
  //     name: data['Name'] ?? "",
  //     values: (data['Values'] as List<dynamic>?)
  //             ?.map((e) => e.toString())
  //             .toList() ??
  //         [],
  //   );
  // }

  factory ProductAttributeModel.fromJson(Map<String, dynamic> map) {
    final data = map;
    if (data.isEmpty) return ProductAttributeModel();
    return ProductAttributeModel(
        values: List<String>.from((map['Values'])),
        name: data.containsKey("Name") ? data['Name'] : '');
  }
}
