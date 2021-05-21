part of 'categoriesScreen_imports.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageCubit, HomePageStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: ListView.separated(
              itemBuilder: (context, index) => buildCategoryItem(HomePageCubit.get(context).categoryModel.data.data[index]),
              separatorBuilder: (context, index) => Divider(),
              itemCount: 10),
        );
      },
    );
  }

  Widget buildCategoryItem(DataListBean model) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage(model.image),
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 20,),
          Text(model.name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          Spacer(),
          Icon(Icons.arrow_forward_ios),
        ],
      ),
    );
  }
}
