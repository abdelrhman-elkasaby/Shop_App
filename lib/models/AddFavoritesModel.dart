class AddFavoritesModel {
  String message;
  bool status;
  DataBean data;

  AddFavoritesModel({this.message, this.status, this.data});

  AddFavoritesModel.fromJson(Map<String, dynamic> json) {    
    this.message = json['message'];
    this.status = json['status'];
    this.data = json['data'] != null ? DataBean.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }

}

class DataBean {
  int id;
  ProductBean product;

  DataBean({this.id, this.product});

  DataBean.fromJson(Map<String, dynamic> json) {    
    this.id = json['id'];
    this.product = json['product'] != null ? ProductBean.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    return data;
  }
}

class ProductBean {
  String image;
  dynamic oldPrice;
  int id;
  dynamic price;
  int discount;

  ProductBean({this.image, this.oldPrice, this.id, this.price, this.discount});

  ProductBean.fromJson(Map<String, dynamic> json) {    
    this.image = json['image'];
    this.oldPrice = json['old_price'];
    this.id = json['id'];
    this.price = json['price'];
    this.discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['old_price'] = this.oldPrice;
    data['id'] = this.id;
    data['price'] = this.price;
    data['discount'] = this.discount;
    return data;
  }
}
