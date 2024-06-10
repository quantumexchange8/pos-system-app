import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:pos_system/const/constant.dart';
import 'package:pos_system/const/textStyle.dart';
import 'package:pos_system/splashScreenPages/FeatureSettings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _activePage = 0;
  final List<Widget> _pages = [
    const PageOne(),
    const PageTwo(),
    const PageThree(),
  ];

  void _onPageChanged(int page) {
    // If the user tries to scroll past Page 3, keep them on Page 3
    if (page >= _pages.length) {
      _pageController.jumpToPage(_pages.length - 1);
    } else {
      setState(() {
        _activePage = page;
      });
    }
  }

  void _nextPage() {
    if (_activePage < _pages.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context)=>const FeatureSettings(),
        ),
      );
      print('Done');
      
    }
  }

  void _previousPage() {
    if (_activePage > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemBuilder: (BuildContext context, int index){
              return _pages[index % _pages.length];
            },
            itemCount: _pages.length,
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 50,
            child: Column(
              children: [
                Divider(thickness: 1,color: Colors.grey.shade300),
                Container(
                  color: Colors.white70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List<Widget>.generate(
                      1, (index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: InkWell(
                          onTap: (){
                            _pageController.jumpToPage(index);
                          },
                          
                          child: DotsIndicator(
                            dotsCount: 3,
                            position: _activePage,
                            decorator: DotsDecorator(
                              color: Colors.grey.shade300,
                              activeColor: primaryBlue.shade900,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
           if (_activePage > 0) // Show BACK button only if not on the first page
            Positioned(
              bottom: 0,
              left: 0,
              height: 50,
              child: TextButton(
                onPressed: _previousPage,
                child: Text('< BACK', style: TextStyle(color: primaryBlue.shade900)),
              ),
            ),
          Positioned(
            bottom: 0,
            right: 0,
            height: 50,
            child: TextButton(
              onPressed: _nextPage,
              child: Text(
                _activePage == _pages.length - 1 ? 'DONE' : 'NEXT >',
                style: TextStyle(color: primaryBlue.shade900),
              ),
            ),
          ),

        ],
      ),
    );
  }
}


class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            Image.asset('assets/image/image1.png'),
            const SizedBox(height: 10),
            Text('Mobile Point of Sale', style: bodyMregular),
            const SizedBox(height: 5),
            Text('Sell from a smartphone or tablet, issue printed or electronic receipts, accepts multiple payment methods and more.',
            style: bodySregular, textAlign: TextAlign.center,),
          ],
        ),
      ),

      //bottom step progress
    );
  }
}


class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/image/image2.png'),
            const SizedBox(height: 10),
            Text('Back Office', style: bodyMregular),
            const SizedBox(height: 5),
            Text('Track your sales and inventory, manage employees and customers in a browser on any devide.',
            style: bodySregular, textAlign: TextAlign.center,),
          ],
        ),
      ),

      //bottom step progress
    );
  }
}

class PageThree extends StatelessWidget {
  const PageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/image/image3.png'),
            const SizedBox(height: 10),
            Text('Complementary Apps', style: bodyMregular),
            const SizedBox(height: 5),
            Text('Install Loyverse Dashboard, Loyverse Kitchen Display and Loyverse Customer Display apps for more efficient business management.',
            style: bodySregular, textAlign: TextAlign.center,),
          ],
        ),
      ),

      
    );
  }
}