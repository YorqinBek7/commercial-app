const String tableName = "cached_products";

class SelectedProductsRows {
  static const String image = "image";
  static const String title = "title";
  static const String rate = "rate";
  static const String price = "price";
  static const String count = "count";
  static const String id = "_id";
  static const String countSelect = "count_select";
}

class SelectedProducts {
  final int id;
  final String image;
  final String title;
  final int rate;
  final int price;
  final int count;
  final int countSelect;

  SelectedProducts({
    required this.count,
    required this.image,
    required this.price,
    required this.rate,
    required this.title,
    required this.id,
    required this.countSelect,
  });
  SelectedProducts copyWith({
    String? image,
    String? title,
    int? rate,
    int? price,
    int? count,
    int? id,
    int? countSelect,
  }) =>
      SelectedProducts(
        count: count ?? this.count,
        image: image ?? this.image,
        price: price ?? this.price,
        rate: rate ?? this.rate,
        title: title ?? this.title,
        id: id ?? this.id,
        countSelect: countSelect ?? this.countSelect,
      );
  static SelectedProducts fromJson(Map<String, Object?> json) {
    return SelectedProducts(
      count: json[SelectedProductsRows.count] as int,
      image: json[SelectedProductsRows.image] as String,
      price: json[SelectedProductsRows.price] as int,
      rate: json[SelectedProductsRows.rate] as int,
      title: json[SelectedProductsRows.title] as String,
      id: json[SelectedProductsRows.id] as int,
      countSelect: json[SelectedProductsRows.countSelect] as int,
    );
  }

  Map<String, Object?> toJson() {
    return {
      SelectedProductsRows.count: count,
      SelectedProductsRows.image: image,
      SelectedProductsRows.price: price,
      SelectedProductsRows.rate: rate,
      SelectedProductsRows.title: title,
      SelectedProductsRows.countSelect: countSelect,
    };
  }

  @override
  String toString() {
    return "count:$count title: $title rate: $rate image:$image price:$price id:$id countSelect: $countSelect";
  }
}
