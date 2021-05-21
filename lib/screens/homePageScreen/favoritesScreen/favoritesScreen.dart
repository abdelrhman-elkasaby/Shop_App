part of 'favoritesScreen_imports.dart';
class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageCubit, HomePageStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body:state is GetFavoritesLoadingSuccessData?Center(child: CircularProgressIndicator(),) :ListView.separated(
            physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) => buildFavoritesItem(HomePageCubit.get(context).favoritesModel.data.data[index]),
              separatorBuilder: (context, index) => Divider(),
              itemCount: HomePageCubit.get(context).favoritesModel.data.data.length),
        );
      },
    );
  }
  Widget buildFavoritesItem(DataListBean model){
    return Container(
      height: 120,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.product.image),
                  height: 120,
                  width: 120,
                ),
                if(model.product.discount!=0)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    color: Colors.red,
                    child: Text('DISCOUNT',style: TextStyle(color: Colors.white,fontSize: 10),),
                  )
              ],
            ),
            SizedBox(height: 10,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(model.product.name,maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 14),),
                  Spacer(),
                  Row(
                    children: [
                      Text('${model.product.price} EGP',style: TextStyle(color: Colors.blue,fontSize: 12),),
                      SizedBox(width: 5,),
                      if(model.product.discount!=0)
                        Text('${model.product.oldPrice} EGP',style: TextStyle(color: Colors.grey,decoration: TextDecoration.lineThrough,fontSize: 11),),
                      Spacer(),
                      IconButton(
                        icon: CircleAvatar(
                            backgroundColor:HomePageCubit.get(context).favorites[model.product.id]?Colors.blue :Colors.grey,
                            child: Icon(
                              Icons.favorite_border,color: Colors.white,)),
                        onPressed: (){
                          HomePageCubit.get(context).changeFavorite(model.product.id);
                        },
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
