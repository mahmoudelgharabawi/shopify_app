import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flexible_grid_view/flexible_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopify_app/pages/product_details.page.dart';
import 'package:shopify_app/providers/app_auth.provider.dart';
import 'package:shopify_app/providers/category.provider.dart';
import 'package:shopify_app/providers/product.provider.dart';
import 'package:shopify_app/widgets/headline.widget.dart';
import 'package:shopify_app/widgets/home/categories_row.home.widget.dart';
import 'package:shopify_app/widgets/product.widget.dart';

import 'package:http/http.dart' as http;

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

            Consumer<CategoryProvider>(
              builder: (__, caegoryProvider, _) {
                return FutureBuilder(
                    future: caegoryProvider.getCategories(context, limit: 3),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        if (snapshot.hasError) {
                          return Text('Error While Get Data');
                        } else if (snapshot.hasData) {
                          return CategoriesRowHome(
                            categories: snapshot.data ?? [],
                          );
                        } else {
                          return Text('No Data Found');
                        }
                      } else {
                        return Text(
                            'Connection Statue ${snapshot.connectionState}');
                      }
                    });
              },
            ),
            const SizedBox(
              height: 20,
            ),

            const HeadlineWidget(title: 'Latest'),
            const SizedBox(
              height: 10,
            ),

            const HeadlineWidget(title: 'Products'),
            const SizedBox(
              height: 10,
            ),
            Consumer<ProductProvider>(
              builder: (__, productProvider, _) {
                return FutureBuilder(
                    future: productProvider.getProducts(context, limit: 3),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        if (snapshot.hasError) {
                          return Text('Error While Get Data');
                        } else if (snapshot.hasData) {
                          return FlexibleGridView(
                            axisCount: GridLayoutEnum.threeElementsInRow,
                            shrinkWrap: true,
                            children: snapshot.data
                                    ?.map((e) => ProductWidget(
                                          product: e,
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        ProductDetailsPage(
                                                          product: e,
                                                        )));
                                          },
                                        ))
                                    .toList() ??
                                [],
                          );
                        } else {
                          return Text('No Data Found');
                        }
                      } else {
                        return Text(
                            'Connection Statue ${snapshot.connectionState}');
                      }
                    });
              },
            ),

            ElevatedButton(
                onPressed: () async {
                  try {
                    var result = await http.post(
                        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
                        body: jsonEncode({
                          "userId": 15,
                          "title":
                              "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
                          "body":
                              "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
                        }));

                    if (result.statusCode == 200 || result.statusCode == 201) {
                      print('result : ${result.body.runtimeType}');
                      print('result : ${result.body}');
                    } else {
                      print('error in get data : ${result.statusCode}');
                    }
                  } catch (e) {
                    print('Exception: $e');
                  }
                },
                child: Text('make http call')),
            ElevatedButton(
                onPressed: () =>
                    Provider.of<AppAuthProvider>(context, listen: false)
                        .onLogout(context),
                child: Text('LogOut')),
            ElevatedButton(
                onPressed: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    withData: true,
                    type: FileType.image,
                  );
                  var refrence = FirebaseStorage.instance
                      .ref('products/${result?.files.first.name}');

                  if (result?.files.first.bytes != null) {
                    var uploadResult = await refrence.putData(
                        result!.files.first.bytes!,
                        SettableMetadata(contentType: 'image/png'));

                    if (uploadResult.state == TaskState.success) {
                      print(
                          '>>>>>>>>>>>>>>>>${await refrence.getDownloadURL()}');
                    }
                  }
                },
                child: Text('upload image')),
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
