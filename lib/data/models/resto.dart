import 'dart:convert';

Restos restosFromJson(String str) => Restos.fromJson(json.decode(str));
Restos restosFromSearchJson(String str) => Restos.fromSearchJson(
      json.decode(str),
    );

class Restos {
  bool? error;
  String? message;
  int? founded;
  int? count;
  List<Item>? items;
  Restos({
    this.error,
    this.message,
    this.founded,
    this.count,
    this.items,
  });

  factory Restos.fromJson(Map<String, dynamic> json) {
    return Restos(
      error: json["error"],
      message: json["message"],
      count: json["count"],
      items: List<Item>.from(
        json["restaurants"].map(
          (x) => Item.fromJsonMinimal(x),
        ),
      ),
    );
  }

  factory Restos.fromSearchJson(Map<String, dynamic> json) {
    return Restos(
      error: json["error"],
      founded: json["founded"],
      count: json["count"],
      items: List<Item>.from(
        json["restaurants"].map(
          (x) => Item.fromJsonMinimal(x),
        ),
      ),
    );
  }
}

Resto restoFromJson(String str) => Resto.fromJson(json.decode(str));

class Resto {
  bool? error;
  String? message;
  Item? item;
  Resto({this.error, this.message, this.item});

  factory Resto.fromJson(Map<String, dynamic> json) {
    return Resto(
      error: json["error"],
      message: json["message"],
      item: Item.fromJsonDetail(json["restaurant"]),
    );
  }
}

class Item {
  String? id;
  String? name;
  String? description;
  String? city;
  String? address;
  String? pictureId;
  List<Category>? categories;
  Menus? menus;
  double? rating;
  List<CustomerReview>? customerReviews;
  Item({
    this.id,
    this.name,
    this.description,
    this.city,
    this.address,
    this.pictureId,
    this.categories,
    this.menus,
    this.rating,
    this.customerReviews,
  });

  factory Item.fromJsonDetail(Map<String, dynamic> json) {
    return Item(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      city: json["city"],
      address: json["address"],
      pictureId: json["pictureId"],
      categories: List<Category>.from(
        json["categories"].map(
          (x) => Category.fromJson(x),
        ),
      ),
      menus: Menus.fromJson(json["menus"]),
      rating: json["rating"].toDouble(),
      customerReviews: List<CustomerReview>.from(
        json["customerReviews"].map(
          (x) => CustomerReview.fromJson(x),
        ),
      ),
    );
  }

  factory Item.fromJsonMinimal(Map<String, dynamic> json) {
    return Item(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      city: json["city"],
      address: json["address"],
      pictureId: json["pictureId"],
      rating: json["rating"].toDouble(),
    );
  }
}

class Category {
  String? name;
  Category({this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'],
    );
  }
}

class Menus {
  List<Category>? foods;
  List<Category>? drinks;
  Menus({this.foods, this.drinks});

  factory Menus.fromJson(Map<String, dynamic> json) {
    return Menus(
      foods: List<Category>.from(
        json['foods'].map(
          (x) => Category.fromJson(x),
        ),
      ),
      drinks: List<Category>.from(
        json['drinks'].map(
          (x) => Category.fromJson(x),
        ),
      ),
    );
  }
}

String reviewToJson(CustomerReview review) => json.encode(review.toJson());

class CustomerReview {
  String? id;
  String? name;
  String? review;
  String? date;
  CustomerReview({this.id, this.name, this.review, this.date});

  factory CustomerReview.fromJson(Map<String, dynamic> json) {
    return CustomerReview(
      name: json['name'],
      review: json['review'],
      date: json['date'],
    );
  }

  Map<String, String> toJson() {
    return {
      'id': id!,
      'name': name!,
      'review': review!,
    };
  }
}
