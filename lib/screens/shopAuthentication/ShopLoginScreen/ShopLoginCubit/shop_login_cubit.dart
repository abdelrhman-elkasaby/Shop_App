import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app2/models/LoginModel.dart';
import 'package:shop_app2/my_info/services/cache_helper/cacheHelper.dart';
import 'package:shop_app2/my_info/utils/Utils.dart';
import 'package:shop_app2/screens/homePageScreen/Home/homePageScreen_imports.dart';

part 'shop_login_state.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context)=>BlocProvider.of(context);
  Future<void> onUserLogin({@required String email,@required String password,BuildContext context}) async {
    emit(ShopLoginLoadingState());
    FocusScope.of(context).unfocus();
    Map<String,dynamic> body={
      'email':email,
      'password':password
    };
    var response = await Utils().api().post(
      url: 'login',
      body: body,
    );
    LoginModel loginModel=LoginModel.fromJson(response.data);
    print(response.toString());
    if(loginModel.status==true){
      Utils().alert().showAlertMessage(title: loginModel.message,isSuccess: true);
      CacheHelper.saveData(key: 'token', value: loginModel.data.token);
      token=loginModel.data.token;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePageScreen()));
      emit(ShopLoginLoginSuccessState());
    }else if(loginModel.status==false){
      Utils().alert().showAlertMessage(title: loginModel.message,isSuccess: false);
      emit(ShopLoginLoginFailState());
    }

  }

  Future<void> onUserSignUp({@required String name,@required String phone,@required String email,@required String password,BuildContext context}) async {
    emit(ShopLoginLoadingState());
    FocusScope.of(context).unfocus();
    Map<String,dynamic> body={
      'phone':phone,
      'name':name,
      'email':email,
      'password':password
    };
    var response = await Utils().api().post(
      url: 'register',
      body: body,
    );
    LoginModel loginModel=LoginModel.fromJson(response.data);
    print(response.toString());
    if(loginModel.status==true){
      Utils().alert().showAlertMessage(title: loginModel.message,isSuccess: true);
      CacheHelper.saveData(key: 'token', value: loginModel.data.token);
      token=loginModel.data.token;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePageScreen()));
      emit(ShopLoginLoginSuccessState());
    }else if(loginModel.status==false){
      Utils().alert().showAlertMessage(title: loginModel.message,isSuccess: false);
      emit(ShopLoginLoginFailState());
    }

  }

  IconData suffixIcon=Icons.visibility_outlined;
  bool isPassword=true;
  void onChangePasswordVisibility(){
    isPassword=!isPassword;
    suffixIcon=isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(ShopLoginChangeIconState());
  }
}
