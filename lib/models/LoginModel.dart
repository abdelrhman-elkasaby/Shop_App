class LoginModel {
  String message;
  bool status;
  DataBean data;

  LoginModel({this.message, this.status, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {    
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
  String name;
  String email;
  String phone;
  String image;
  String token;
  int id;
  int points;
  int credit;

  DataBean({this.name, this.email, this.phone, this.image, this.token, this.id, this.points, this.credit});

  DataBean.fromJson(Map<String, dynamic> json) {    
    this.name = json['name'];
    this.email = json['email'];
    this.phone = json['phone'];
    this.image = json['image'];
    this.token = json['token'];
    this.id = json['id'];
    this.points = json['points'];
    this.credit = json['credit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['image'] = this.image;
    data['token'] = this.token;
    data['id'] = this.id;
    data['points'] = this.points;
    data['credit'] = this.credit;
    return data;
  }
}
