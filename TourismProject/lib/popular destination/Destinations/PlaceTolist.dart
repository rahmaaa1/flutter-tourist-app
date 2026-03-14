import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'place.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PlaceListItem extends StatefulWidget {
  final Place place;
  final int activeIndex;
  final List<String> imagePaths;

  PlaceListItem(this.place, this.activeIndex, this.imagePaths);

  @override
  _PlaceListItemState createState() => _PlaceListItemState();
}

class _PlaceListItemState extends State<PlaceListItem> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.activeIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          items: widget.place.imagePaths
              .map((imagePath) => Container(
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(imagePath),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                  ))
              .toList(),
          options: CarouselOptions(
            height: 180.h,
            aspectRatio: 16 / 9,
            viewportFraction: 0.8,
            autoPlay: false,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        SizedBox(height: 10.h),
        buildIndicator(_currentIndex, widget.imagePaths.length),
        SizedBox(height: 10.h),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                SizedBox(width: 8.w),
                Text(
                  widget.place.name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'MadimiOne',
                    color: Color.fromARGB(255, 83, 137, 182),
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(width: 8.w),
                Icon(
                  Icons.location_on,
                  color: Color.fromARGB(255, 5, 59, 107),
                ),
                
              ],
            )),
        SizedBox(height: 5.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            widget.place.description,
            style: TextStyle(
              fontSize: 16,
              color: Color.fromARGB(255, 36, 108, 163),
              fontFamily: 'MadimiOne',
            ),
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(height: 5.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              if (widget.place.price != 0)
                Text(
                  widget.place.price.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 5, 59, 107),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              if (widget.place.price != 0) SizedBox(width: 8.w),
              if (widget.place.price != 0)
                Text(
                  "EGP",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 5, 59, 107),
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }

  Widget buildIndicator(int activeIndex, int length) {
    return Center(
      child: AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: length,
        effect: WormEffect(
          dotWidth: 18.w,
          dotHeight: 18.h,
          activeDotColor: Colors.blue,
          dotColor: Color.fromARGB(255, 16, 65, 106),
        ),
      ),
    );
  }
}
