import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopify_app/providers/app_auth.provider.dart';
import 'package:shopify_app/widgets/headline.widget.dart';
import 'package:shopify_app/widgets/home/categories_row.home.widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            HeadlineWidget(title: 'Categories'),
            CategoriesRowHome(),
            ElevatedButton(
                onPressed: () =>
                    Provider.of<AppAuthProvider>(context, listen: false)
                        .onLogout(context),
                child: Text('LogOut'))
            // CarouselSlider.builder(
            //   itemBuilder: (ctx, index, _) {
            //     return Container(
            //         width: 500,
            //         margin: EdgeInsets.symmetric(horizontal: 5.0),
            //         decoration: BoxDecoration(color: Colors.amber),
            //         child: Image.network(DataSeeder.ads[index].picture!));
            //   },
            //   itemCount: DataSeeder.ads.length,

            //   options: CarouselOptions(height: 200.0),
            //   // items: DataSeeder.ads.map((ad) {
            //   //   return Container(
            //   //       width: 500,
            //   //       margin: EdgeInsets.symmetric(horizontal: 5.0),
            //   //       decoration: BoxDecoration(color: Colors.amber),
            //   //       child: Image.network(ad.picture!));
            //   // }).toList(),
            // ),
          ],
        ),
      ),
    );
  }
}
