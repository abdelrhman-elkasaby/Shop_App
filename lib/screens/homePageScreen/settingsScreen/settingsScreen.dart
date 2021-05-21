part of 'settingsScreen_imports.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with SettingsScreenData{

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageCubit, HomePageStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit=HomePageCubit.get(context);
        nameController.text=cubit.userDataModel.data.name;
        emailController.text=cubit.userDataModel.data.email;
        phoneController.text=cubit.userDataModel.data.phone;
        return Scaffold(
          body: state is HomePageUserLoadingData?Center(child: CircularProgressIndicator(),):Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                WidgetsHelper().buildTextFormField(
                  prefIcon: Icon(Icons.person),
                  controller: nameController,
                  type: TextInputType.name,
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
                  hint: 'Name',
                ),
                const SizedBox(height: 15,),
                WidgetsHelper().buildTextFormField(
                  prefIcon: Icon(Icons.email_outlined),
                  controller: emailController,
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
                  hint: 'Name',
                ),
                const SizedBox(height: 15,),
                WidgetsHelper().buildTextFormField(
                  prefIcon: Icon(Icons.phone),
                  controller: phoneController,
                  type: TextInputType.number,
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
                  hint: 'Name',
                ),
                const SizedBox(height: 15,),

                ElevatedButton(
                  onPressed: (){
                    CacheHelper.removeData(key: 'token').then((value) {
                      if (value) {
                        HomePageCubit.get(context).currentIndex=0;
                        Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) => ShopLoginScreen()));
                      }
                    });
                  },
                  child: Text('LogOut',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                  style: ElevatedButton.styleFrom(
                      elevation: 0.0,
                      padding: const EdgeInsets.symmetric(horizontal:75,vertical: 12),
                      shape: RoundedRectangleBorder(
                          side: BorderSide.none,
                          borderRadius: BorderRadius.circular(40)
                      )
                  ),
                ),

              ],
            ),
          ),
        );
      },
    );
  }
}
