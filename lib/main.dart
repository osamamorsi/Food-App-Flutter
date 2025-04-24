import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(475, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Food App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          ),
          home: child,
        );
      },
      child: const OnboardingScreen(),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final List<String> titles = [
    'Save Your\n Meals\n Ingredient',
    'Use Our App\n The Best\n Choice ',
    ' Our App\n Your Ultimate\n Choice',
  ];

  final List<String> descriptions = [
    'Add Your Meals and its Ingredients\n and we will save it for you',
    'the best choice for your kitchen\n do not hesitate',
    'All the best restaurants and their top\n menus are ready for you',
  ];

  double currentPage = 0.0;

  final CarouselSliderController controller =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/food.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 40.h,
            left: 36.w,
            right: 36.w,
            child: Container(
              width: 311.h,
              height: 500.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.orangeAccent.withOpacity(0.80),
              ),
              child: CarouselSlider(
                carouselController: controller,
                options: CarouselOptions(
                  height: 300.0,
                  viewportFraction: 0.99,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentPage = index.toDouble();
                      print('currentPage: $currentPage');
                    });
                  },
                ),
                items: List.generate(titles.length, (index) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            titles[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 40.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            descriptions[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 25.h),
                          DotsIndicator(
                            onTap: (index) {
                              controller.animateToPage(index);
                            },

                            dotsCount: 3,
                            position: currentPage,
                            decorator: DotsDecorator(
                              size: Size(40.w, 8.h),
                              activeSize: Size(40.w, 8.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              activeShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              color: Colors.grey,
                              activeColor: Colors.white,
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.sp),
                            child:
                                currentPage == 2
                                    ? CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 40.sp,
                                      child: Icon(
                                        Icons.arrow_forward,
                                        size: 30.sp,
                                      ),
                                    )
                                    : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            currentPage++;
                                            controller.nextPage();
                                          },
                                          child: Text(
                                            'Skip',
                                            style: TextStyle(
                                              fontSize: 22.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            controller.nextPage();
                                          },
                                          child: Text(
                                            'Next',
                                            style: TextStyle(
                                              fontSize: 22.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                          ),
                        ],
                      );
                    },
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
