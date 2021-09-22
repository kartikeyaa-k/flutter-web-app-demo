class Product {
  int? id;
  String? name;
  int? price;
  int? available;
  String? vendor;
  String? category;
  String? quantity;

  Product(this.id, this.name, this.price, this.available, this.vendor,
      this.category, this.quantity);

  Product.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    price = json['price'];
    available = json['available'];
    vendor = json['vendor'];
    category = json['category'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': this.id,
        'id': this.id,
        'price': this.price,
        'available': this.available,
        'vendor': this.vendor,
        'category': this.category,
        'quantity': this.quantity,
      };
}
