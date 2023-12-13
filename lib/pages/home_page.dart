import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:shopify_app/seeder/data.seeder.dart';
import 'package:shopify_app/widgets/carousel_slider_ex.dart';
import 'package:shopify_app/widgets/headline.widget.dart';
import 'package:shopify_app/widgets/home/categories_row.home.widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = true;

  ValueNotifier<List<int>> listNotifier = ValueNotifier<List<int>>([]);
  late PageController controller;
  void addValueToList() {
    listNotifier.value.add(Random().nextInt(100));
    listNotifier.notifyListeners();
    setState(() {});
  }

  @override
  void dispose() {
    listNotifier.dispose();
    super.dispose();
  }

  @override
  void initState() {
    controller = PageController(initialPage: 1);
    getData();
    super.initState();
  }

  void getData() async {
    await DataSeeder.loadData();
    setState(() {});
    _isLoading = false;
  }

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

            SizedBox(
              width: 200,
              height: 500,
              child: PageView(
                scrollDirection: Axis.vertical,
                // physics: const NeverScrollableScrollPhysics(),
                controller: controller,
                children: [
                  Container(
                    height: 20,
                    width: 20,
                    color: Colors.blue,
                    child: const Center(
                      child: Text('First Page'),
                    ),
                  ),
                  Container(
                    height: 20,
                    width: 20,
                    color: Colors.green,
                    child: const Center(
                      child: Text('Second Page'),
                    ),
                  ),
                  Container(
                    height: 20,
                    width: 20,
                    color: Colors.yellow,
                    child: const Center(
                      child: Text('Third Page'),
                    ),
                  ),
                ],
              ),
            ),

            ElevatedButton(
                onPressed: () {
                  controller.animateToPage(2,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.fastOutSlowIn);
                },
                child: const Text('Move To Next Page')),
            ElevatedButton(
                onPressed: () {
                  controller.animateToPage(2,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.fastOutSlowIn);
                },
                child: const Text('Move To Next Page')),
            ElevatedButton(
                onPressed: () {
                  controller.animateToPage(2,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.fastOutSlowIn);
                },
                child: const Text('Move To Next Page')),
          ],
        ),
      ),
    );
  }
}
