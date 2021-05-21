part of 'home_page_cubit.dart';

@immutable
abstract class HomePageStates {}

class HomePageInitial extends HomePageStates {}

class HomePageChangeNavState extends HomePageStates {}

class HomePageLoadingData extends HomePageStates {}

class HomePageSuccessData extends HomePageStates {}

class HomePageErrorData extends HomePageStates {}

class CategorySuccessData extends HomePageStates {}

class CategoryErrorData extends HomePageStates {}

class AddFavoritesSuccess extends HomePageStates {}

class AddFavoritesError extends HomePageStates {}

class GetFavoritesLoadingSuccessData extends HomePageStates {}

class GetFavoritesSuccessData extends HomePageStates {}

class GetFavoritesErrorData extends HomePageStates {}

class HomePageUserLoadingData extends HomePageStates {}

class HomePageUserSuccessData extends HomePageStates {}

class HomePageUserErrorData extends HomePageStates {}



