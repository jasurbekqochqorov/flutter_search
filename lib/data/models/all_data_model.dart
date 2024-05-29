class DataModel {
  final int id;
  final String name;
  final int regionId;

  DataModel({required this.id, required this.name, required this.regionId});

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? "",
      regionId: json['region_id'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'region_id': regionId,
    };
  }
}
