part of 'shopLoginScreen_imports.dart';
class ShopLoginScreen extends StatefulWidget {
  @override
  _ShopLoginScreenState createState() => _ShopLoginScreenState();
}

class _ShopLoginScreenState extends State<ShopLoginScreen> with ShopLoginScreenData{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ShopLoginCubit(),
        child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
          listener: (context,state){},
          builder: (context,state){
            return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Login',style: Theme.of(context).textTheme.headline2.copyWith(color: Colors.black),),
                          const SizedBox(height: 25,),
                          Text('Login now to browse our hot offers',style: Theme.of(context).textTheme.bodyText2,),
                          const SizedBox(height: 70,),
                          WidgetsHelper().buildTextFormField(
                            prefIcon:Icon(Icons.email_outlined),
                            controller: emailController,
                            hint: 'Email Address',
                            type: TextInputType.emailAddress,
                            validatorFunction: (value){
                              if(value.isEmpty){
                                return 'Please enter your email address';
                              }else if(!value.contains('@')){
                                return 'Please enter correct email';
                              }
                            },
                            onSavedFunction: (val){
                              val=emailController.text;
                            },
                          ),
                          const SizedBox(height: 35,),
                          WidgetsHelper().buildTextFormField(
                            prefIcon:Icon(Icons.lock_open_outlined),
                            suffixIcon: IconButton(icon: Icon(ShopLoginCubit.get(context).suffixIcon),
                              onPressed: (){
                                ShopLoginCubit.get(context).onChangePasswordVisibility();
                            },),
                            controller: passwordController,
                            visible: ShopLoginCubit.get(context).isPassword,
                            hint: 'Password',
                            type: TextInputType.visiblePassword,
                            validatorFunction: (value){
                              if(value.isEmpty){
                                return 'Please enter your password';
                              }else if(value.length<6){
                                return 'Password is too short';
                              }
                            },
                            onSavedFunction: (val){
                              val=passwordController.text;
                            },
                          ),
                          const SizedBox(height: 35,),
                          Center(
                            child: ElevatedButton(
                              onPressed: (){
                                if(formKey.currentState.validate()){
                                  ShopLoginCubit.get(context).onUserLogin(email: emailController.text, password: passwordController.text,context: context);
                                }
                              },
                              child: state is ShopLoginLoadingState?CircularProgressIndicator(backgroundColor: Colors.white,) :Text('Login'),
                              style: ElevatedButton.styleFrom(
                                  elevation: 0.0,
                                  padding: const EdgeInsets.symmetric(horizontal:75,vertical: 12),
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide.none,
                                      borderRadius: BorderRadius.circular(40)
                                  )
                              ),
                            ),
                          ),
                          const SizedBox(height: 25,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Don\'t have an account ?',style: Theme.of(context).textTheme.bodyText1,),
                              const SizedBox(width: 5,),
                              InkWell(
                                onTap: (){
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>ShopSignUpScreen()));
                                },
                                child: Text('Register',style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.blue),))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        )
    );
  }
}
