part of 'main_imports.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await setupLocator();
  await CacheHelper.init();
  bool onBoarding=CacheHelper.getData(key: 'OnBoarding')??false;
  token =CacheHelper.getData(key: 'token');
  runApp(MyApp(onBoarding,token));
}
class MyApp extends StatelessWidget {
  final bool onBoarding;
  final String token;

  const MyApp(this.onBoarding,this.token);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: BlocProviders.providers(context),
      child: MaterialApp(
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: MyColors.themeData,
        home: token!=null?HomePageScreen():onBoarding?ShopLoginScreen():OnBoardingScreen(),
      ),
    );
  }
}
