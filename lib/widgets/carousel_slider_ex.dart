import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shopify_app/widgets/custom_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselSliderEx extends StatefulWidget {
  const CarouselSliderEx(
      {required this.imageUrls, required this.onBtnPressed, super.key});

  final List<String> imageUrls;
  final void Function() onBtnPressed;

  @override
  State<CarouselSliderEx> createState() => _CarouselSliderExState();
}

class _CarouselSliderExState extends State<CarouselSliderEx> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
            itemCount: widget.imageUrls.length,
            itemBuilder: (BuildContext context, int index, int pageViewIndex) =>
                buildSliderImage(index),
            options: CarouselOptions(
              height: 200,
              viewportFraction: .9,
              padEnds: false,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.15,
              onPageChanged: (index, _) {
                index = index;
                setState(() {});
              },
              scrollDirection: Axis.horizontal,
            )),
        const SizedBox(
          height: 5,
        ),
        AnimatedSmoothIndicator(
          activeIndex: index,
          count: widget.imageUrls.length,
          effect: const ExpandingDotsEffect(
            activeDotColor: Colors.orange,
          ),
        )
      ],
    );
  }

  Widget buildSliderImage(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          // border: Border.all(color: Colors.black)
        ),
        child: Stack(
          children: [
            Image.network(
              widget.imageUrls[index],
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const Positioned(
                left: 20,
                top: 40,
                child: Text(
                  'New Offers',
                  style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                  // maxLines: 3,
                  // textDirection: TextDirection.rtl,
                  //  textAlign: TextAlign.justify,  overflow: TextOverflow.clip,
                )),
            Positioned(
              left: 20,
              bottom: 20,
              child: CustomButton(
                text: "SEE MORE",
                onBtnPressed: widget.onBtnPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
