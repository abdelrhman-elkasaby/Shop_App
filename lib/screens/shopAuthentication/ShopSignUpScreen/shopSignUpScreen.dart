part of 'shopSignUpScreen_imports.dart';

class ShopSignUpScreen extends StatefulWidget {
  @override
  _ShopSignUpScreenState createState() => _ShopSignUpScreenState();
}

class _ShopSignUpScreenState extends State<ShopSignUpScreen> with ShopSignUpData{
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
                          Text('Register',style: Theme.of(context).textTheme.headline2.copyWith(color: Colors.black),),
                          const SizedBox(height: 25,),
                          Text('Register now to browse our hot offers',style: Theme.of(context).textTheme.bodyText2,),
                          const SizedBox(height: 70,),
                          WidgetsHelper().buildTextFormField(
                            prefIcon:Icon(Icons.person),
                            controller: nameController,
                            hint: 'Name',
                            type: TextInputType.text,
                            validatorFunction: (value){
                              if(value.isEmpty){
                                return 'Please enter your Name';
                              }else if(value.length<3){
                                return 'Please enter correct name';
                              }
                            },
                            onSavedFunction: (val){
                              val=nameController.text;
                            },
                          ),
                          const SizedBox(height: 35,),
                          WidgetsHelper().buildTextFormField(
                            prefIcon:Icon(Icons.phone),
                            controller:phoneController,
                            hint: 'phone',
                            type: TextInputType.emailAddress,
                            validatorFunction: (value){
                              if(value.isEmpty){
                                return 'Please enter your phone';
                              }else if(value.length<11){
                                return 'phone number can\'t be less than 11 number';
                              }
                            },
                            onSavedFunction: (val){
                              val=phoneController.text;
                            },
                          ),
                          const SizedBox(height: 35,),
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
                                  ShopLoginCubit.get(context).onUserSignUp(name: nameController.text,phone: phoneController.text,email: emailController.text, password: passwordController.text,context: context);
                                }
                              },
                              child: state is ShopLoginLoadingState?CircularProgressIndicator(backgroundColor: Colors.white,) :Text('Register'),
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
                              Text('already have an account ?',style: Theme.of(context).textTheme.bodyText1,),
                              const SizedBox(width: 5,),
                              InkWell(
                                  onTap: (){
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>ShopLoginScreen()));
                                  },
                                  child: Text('Login',style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.blue),))
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
