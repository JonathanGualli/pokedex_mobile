import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pokedex_mobile/providers/category_provider.dart';
import 'package:provider/provider.dart';

class CategoryListWidget extends StatefulWidget {
  const CategoryListWidget({super.key});

  @override
  State<CategoryListWidget> createState() => _CategoryListWidgetState();
}

class _CategoryListWidgetState extends State<CategoryListWidget> {
  @override
  Widget build(BuildContext context) {
    //Escucha eventos asociado a este estado
    return Consumer<CategoryProvider>(
        builder: (context, categoryProvider, child) {
      return ListView.builder(
        itemBuilder: (context, index) {
          return Slidable(
            endActionPane: ActionPane(motion: ScrollMotion(), children: [
              SlidableAction(
                onPressed: (context) {
                  final id = categoryProvider.categoriesGetter[index].id;
                  Provider.of<CategoryProvider>(context, listen: false)
                      .deleCategory(id);
                },
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Borrar',
              ),
            ]),
            child: Card(
              elevation: 10.0,
              child: ListTile(
                leading: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Image(
                      image: NetworkImage(
                          'https://i.pinimg.com/564x/07/ee/80/07ee8085ddf885764544a3fc7d7e1df2.jpg')),
                ),
                title: Text(categoryProvider.categoriesGetter[index].name),
              ),
            ),
          );
        },
        itemCount: categoryProvider.totalCategories,
      );
    });
  }
}
