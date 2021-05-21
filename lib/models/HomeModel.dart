class HomeModel {
  String message;
  bool status;
  DataBean data;

  HomeModel({this.message, this.status, this.data});

  HomeModel.fromJson(Map<String, dynamic> json) {    
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
  String ad;
  List<BannersListBean> banners;
  List<ProductsListBean> products;

  DataBean({this.ad, this.banners, this.products});

  DataBean.fromJson(Map<String, dynamic> json) {    
    this.ad = json['ad'];
    this.banners = (json['banners'] as List)!=null?(json['banners'] as List).map((i) => BannersListBean.fromJson(i)).toList():null;
    this.products = (json['products'] as List)!=null?(json['products'] as List).map((i) => ProductsListBean.fromJson(i)).toList():null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ad'] = this.ad;
    data['banners'] = this.banners != null?this.banners.map((i) => i.toJson()).toList():null;
    data['products'] = this.products != null?this.products.map((i) => i.toJson()).toList():null;
    return data;
  }
}

class BannersListBean {
  String image;
  String product;
  int id;
  CategoryBean category;

  BannersListBean({this.image, this.product, this.id, this.category});

  BannersListBean.fromJson(Map<String, dynamic> json) {    
    this.image = json['image'];
    this.product = json['product'];
    this.id = json['id'];
    this.category = json['category'] != null ? CategoryBean.fromJson(json['category']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['product'] = this.product;
    data['id'] = this.id;
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    return data;
  }
}

class ProductsListBean {
  String image;
  String name;
  String description;
  bool inFavorites;
  bool inCart;
  int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  List<String> images;

  ProductsListBean({this.image, this.name, this.description, this.inFavorites, this.inCart, this.id, this.price, this.oldPrice, this.discount, this.images});

  ProductsListBean.fromJson(Map<String, dynamic> json) {    
    this.image = json['image'];
    this.name = json['name'];
    this.description = json['description'];
    this.inFavorites = json['in_favorites'];
    this.inCart = json['in_cart'];
    this.id = json['id'];
    this.price = json['price'];
    this.oldPrice = json['old_price'];
    this.discount = json['discount'];

    List<dynamic> imagesList = json['images'];
    this.images = new List();
    this.images.addAll(imagesList.map((o) => o.toString()));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['name'] = this.name;
    data['description'] = this.description;
    data['in_favorites'] = this.inFavorites;
    data['in_cart'] = this.inCart;
    data['id'] = this.id;
    data['price'] = this.price;
    data['old_price'] = this.oldPrice;
    data['discount'] = this.discount;
    data['images'] = this.images;
    return data;
  }
}

class CategoryBean {
  String image;
  String name;
  int id;

  CategoryBean({this.image, this.name, this.id});

  CategoryBean.fromJson(Map<String, dynamic> json) {    
    this.image = json['image'];
    this.name = json['name'];
    this.id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}
