class CategoryModel {
  final String id;
  final String name;
  final String icon;
  final String section;
  final List<String> bannerUrls;
  final List<String> descriptions;

  CategoryModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.section,
    required this.bannerUrls,
    required this.descriptions,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      name: map['name'],
      icon: map['icon'],
      section: map['section'],
      bannerUrls: List<String>.from(map['banner_urls'] ?? []),
      descriptions: List<String>.from(map['descriptions'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'section': section,
      'banner_urls': bannerUrls,
      'descriptions': descriptions,
    };
  }
}
