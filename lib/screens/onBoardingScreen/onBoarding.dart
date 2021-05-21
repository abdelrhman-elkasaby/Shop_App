part of 'onBoarding_imports.dart';
class BoardingModel{
  final String image,title,body;
  BoardingModel({@required this.image, @required this.title, @required this.body});
}
class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding=[
    BoardingModel(image:'assets/images/onBoarding.jpg',title:'EveryThing around the world', body:'Screen body'),
    BoardingModel(image:'assets/images/onBoarding.jpg',title:'EveryThing around the world 2', body:'Screen body 2'),
    BoardingModel(image:'assets/images/onBoarding.jpg',title:'EveryThing around the world 3', body:'Screen body 3'),
  ];
  var boardingController=PageController();
  bool isLast=false;
  void submit(){
    CacheHelper.saveData(key: 'OnBoarding', value: true).then((value) =>Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=> ShopLoginScreen())));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: submit,
              child: Text('SKIP')
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              onPageChanged: (index){
                if(index == boarding.length -1){
                  setState(() {
                    isLast=true;
                  });
                }else{
                  setState(() {
                    isLast=false;
                  });
                }
              },
              controller: boardingController,
              physics: BouncingScrollPhysics(),
                itemBuilder:(context,index)=> buildOnBoardingItem(boarding[index]),
              itemCount: boarding.length,
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                SmoothPageIndicator(
                  controller: boardingController,
                  effect: ExpandingDotsEffect(
                    activeDotColor: Colors.blue,
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      expansionFactor: 4,
                      dotWidth: 10,
                      spacing: 5.0
                  ),
                  count: boarding.length,
                ),
                Spacer(),
                FloatingActionButton(onPressed: (){
                  if(isLast==true){
                    submit();
                  }else{
                    boardingController.nextPage(duration: Duration(milliseconds: 750), curve: Curves.fastLinearToSlowEaseIn);
                  }
                },child: Icon(Icons.arrow_forward_ios),)
              ],
            ),
          )
        ],
      ),
    );
  }
  Widget buildOnBoardingItem(BoardingModel model){
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image.asset(model.image,)),

          Text(model.title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          const SizedBox(height: 50,),
          Text(model.body,style: TextStyle(fontSize: 18),),
          const SizedBox(height: 100,),
        ],
      ),
    );
  }
}
