import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app2/screens/homePageScreen/HomePageCubit/home_page_cubit.dart';



class BlocProviders {
  static List<BlocProvider> providers(BuildContext context) => [
    BlocProvider<HomePageCubit>(create: (BuildContext context)=>HomePageCubit()..getHomeData()..getCategoryData()..getFavoritesData()..getUserData())
      ];

}
