part of 'shop_login_cubit.dart';

@immutable
abstract class ShopLoginStates {}

class ShopLoginInitialState extends ShopLoginStates {}
class ShopLoginLoadingState extends ShopLoginStates {}
class ShopLoginLoginSuccessState extends ShopLoginStates {}
class ShopLoginLoginFailState extends ShopLoginStates {}
class ShopLoginChangeIconState extends ShopLoginStates {}


