import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  List<Widget> _pages = [
    OnboardingPage(
      title: 'Welcome to HOME',
      description: 'An app that makes managing your home simple and efficient.',
      imageUrl: 'assets/onboarding/welcome.png',
    ),
    OnboardingPage(
      title: 'Stay Organized',
      description: 'Track your tasks and projects with ease.',
      imageUrl: 'assets/onboarding/organized.png',
    ),
    OnboardingPage(
      title: 'Achieve More',
      description: 'Get things done quickly with less effort.',
      imageUrl: 'assets/onboarding/achieve.png',
    ),
  ];

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: _pages,
      ),
      bottomSheet: _currentPage == _pages.length - 1
          ? ElevatedButton(
              child: Text('Get Started'),
              onPressed: () {
                // Navigate to the main part of the app
              },
            )
          : Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(onPressed: () {
                    _pageController.animateToPage(0, duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
                  }, child: Text('Skip')),
                  Row(
                    children: List<Widget>.generate(_pages.length, (index) => _buildDot(index, context)),
                  ),
                  TextButton(onPressed: () {
                    _pageController.nextPage(duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
                  }, child: Text('Next')),
                ],
              ),
            ),
    );
  }

  Widget _buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: _currentPage == index ? 30 : 10,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: _currentPage == index ? Theme.of(context).primaryColor : Colors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;

  const OnboardingPage({Key? key, required this.title, required this.description, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(imageUrl),
        Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        SizedBox(height: 20),
        Text(description, textAlign: TextAlign.center),
      ],
    );
  }
}