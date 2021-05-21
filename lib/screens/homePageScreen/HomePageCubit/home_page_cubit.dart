import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app2/models/AddFavoritesModel.dart';
import 'package:shop_app2/models/CategoryModel.dart';
import 'package:shop_app2/models/FavoritesModel.dart';
import 'package:shop_app2/models/HomeModel.dart';
import 'package:shop_app2/models/LoginModel.dart';
import 'package:shop_app2/my_info/services/cache_helper/cacheHelper.dart';
import 'package:shop_app2/my_info/utils/Utils.dart';
import 'package:shop_app2/screens/homePageScreen/categoriesScreen/categoriesScreen_imports.dart';
import 'package:shop_app2/screens/homePageScreen/favoritesScreen/favoritesScreen_imports.dart';
import 'package:shop_app2/screens/homePageScreen/productsScreen/productsScreen_imports.dart';
import 'package:shop_app2/screens/homePageScreen/settingsScreen/settingsScreen_imports.dart';
part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageStates> {
  HomePageCubit() : super(HomePageInitial());
  static HomePageCubit get(context)=>BlocProvider.of(context);
  int currentIndex=0;
  List <Widget>bottomScreens=[
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen()
  ];

  void changeBottom(int index){
    currentIndex=index;
    emit(HomePageChangeNavState());
  }
  HomeModel homeModel;
  Map<int,bool> favorites={};
  Future<void> getHomeData()async{
    emit(HomePageLoadingData());
    var response=await Utils().api().get(url:'home',headers: {
      'lang':'en',
      'Content-Type':'application/json',
      'Authorization':token
    } );
     homeModel=HomeModel.fromJson(response.data);
     if(homeModel.status ==true){
       homeModel.data.products.forEach((element) {
         favorites.addAll({
           element.id:element.inFavorites
         });
       });
       emit(HomePageSuccessData());
     }else if(homeModel.status==false){
       emit(HomePageErrorData());
     }
  }

  CategoryModel categoryModel;
  Future<void> getCategoryData()async{
    var response=await Utils().api().get(url:'categories',headers: {
      'lang':'en',
    } );
    categoryModel=CategoryModel.fromJson(response.data);
    if(categoryModel.status ==true){
      emit(CategorySuccessData());
    }else if(categoryModel.status==false){
      emit(CategoryErrorData());
    }
  }

  AddFavoritesModel addFavoritesModel;
  Future<void>changeFavorite(dynamic productId)async{
    favorites[productId]=!favorites[productId];
    emit(AddFavoritesSuccess());
    var response=await Utils().api().post(url:'favorites',headers: {
      'lang':'en',
      'Content-Type':'application/json',
      'Authorization':token
    },
    body: {
      'product_id':productId
    }
    );
    addFavoritesModel=AddFavoritesModel.fromJson(response.data);
    if(addFavoritesModel.status ==true){
      getFavoritesData();
      Utils().alert().showAlertMessage(title: addFavoritesModel.message,isSuccess: true);
      emit(AddFavoritesSuccess());
    }else if(addFavoritesModel.status==false){
      favorites[productId]=!favorites[productId];
      Utils().alert().showAlertMessage(title: addFavoritesModel.message,isSuccess: false);
      emit(AddFavoritesError());
    }
  }

  FavoritesModel favoritesModel;
  Future<void> getFavoritesData()async{

    emit(GetFavoritesLoadingSuccessData());
    var response=await Utils().api().get(url:'favorites',headers: {
      'lang':'en',
      'Content-Type':'application/json',
      'Authorization':token
    } );
    favoritesModel=FavoritesModel.fromJson(response.data);
    if(favoritesModel.status ==true){
      emit(GetFavoritesSuccessData());
    }else if(favoritesModel.status==false){
      emit(GetFavoritesErrorData());
    }
  }

  LoginModel userDataModel;
  Future<void> getUserData()async{
    emit(HomePageUserLoadingData());
    var response=await Utils().api().get(url:'profile',headers: {
      'lang':'en',
      'Content-Type':'application/json',
      'Authorization':token
    } );
    userDataModel=LoginModel.fromJson(response.data);
    if(userDataModel.status ==true){
      emit(HomePageUserSuccessData());
    }else if(userDataModel.status==false){
      emit(HomePageUserErrorData());
    }
  }
}
