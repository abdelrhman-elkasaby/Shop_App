part of 'productsScreen_imports.dart';

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    HomePageCubit.get(context).getHomeData();
    HomePageCubit.get(context).getFavoritesData();
    HomePageCubit.get(context).getUserData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var cubit=HomePageCubit.get(context);
    return BlocConsumer<HomePageCubit, HomePageStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: cubit.homeModel ==null||cubit.categoryModel==null?Center(child: CircularProgressIndicator()):productsBuilder(cubit.homeModel,cubit.categoryModel)
        );
      },
    );
  }
  Widget productsBuilder(HomeModel homeModel,CategoryModel categoryModel)=>SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
            items: homeModel.data.banners.map((e) => Image(
              image: NetworkImage(e.image),
              width: double.infinity,
              fit: BoxFit.cover,
            )).toList(),
            options: CarouselOptions(
              height: 250,
              autoPlay: true,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
              viewportFraction: 1.0
            )),
        const SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Categories',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              const SizedBox(height: 10,),
              Container(
                height: 100,
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index)=>categoriesStackBuilder(categoryModel.data.data[index]),
                    separatorBuilder: (context,index)=>SizedBox(width: 10,),
                    itemCount: categoryModel.data.data.length,
                ),
              ),
              const SizedBox(height: 20,),
              Text('New Products',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            ],
          ),
        ),
        const SizedBox(height: 20,),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1,
            childAspectRatio: 1.0/1.51,
            crossAxisCount: 2,
            children:List.generate(homeModel.data.products.length, (index) => productsGridViewBuilder(homeModel, index)),
          ),
        )
      ],
    ),
  );

  Widget productsGridViewBuilder(HomeModel model,int index){
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.data.products[index].image),
                height: 200,
                width: double.infinity,
              ),
              if(model.data.products[index].discount!=0)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                color: Colors.red,
                child: Text('DISCOUNT',style: TextStyle(color: Colors.white,fontSize: 10),),
              )
            ],
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(model.data.products[index].name,maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 14),),
                const SizedBox(height: 5,),
                Row(
                  children: [
                    Text('${model.data.products[index].price} EGP',style: TextStyle(color: Colors.blue,fontSize: 12),),
                    SizedBox(width: 5,),
                    if(model.data.products[index].discount!=0)
                      Text('${model.data.products[index].oldPrice} EGP',style: TextStyle(color: Colors.grey,decoration: TextDecoration.lineThrough,fontSize: 11),),
                    Spacer(),
                    IconButton(
                        icon: CircleAvatar(
                            backgroundColor:HomePageCubit.get(context).favorites[model.data.products[index].id]?Colors.blue :Colors.grey,
                            child: Icon(
                              Icons.favorite_border,color: Colors.white,)),
                              onPressed: (){
                                HomePageCubit.get(context).changeFavorite(model.data.products[index].id);
                              },
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
  Widget categoriesStackBuilder(DataListBean categoryModel){
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          image: NetworkImage(categoryModel.image),
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
        Container(
            height: 20,
            width: 100,
            color: Colors.black.withOpacity(0.8),
            child: Center(child: Text(categoryModel.name,overflow:TextOverflow.ellipsis,style: TextStyle(color: Colors.white),),)
        ),
      ],
    );
  }
}
