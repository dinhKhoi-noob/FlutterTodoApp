import 'dart:io';

import 'package:flutter/material.dart';
import './login_page.dart';
import '../animation/new_screen_navigator_route.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: const Scaffold(body: OnboardingBuilder()),
        onWillPop: () async {
          exit(0);
        });
  }
}

// ignore: camel_case_types
class OnboardingBuilder extends StatefulWidget {
  const OnboardingBuilder({Key? key}) : super(key: key);

  @override
  State<OnboardingBuilder> createState() {
    return _OnboardingBuilder();
  }
}

class _OnboardingBuilder extends State<OnboardingBuilder> {
  int _currentPage = 0;
  final String _firstOnBoardDesc = "Develop by Dinh Khoi";
  final String _secondOnBoardDesc =
      "Plan your work just by a click, easy to manage, hard to miss out";
  final String _thirdOnBoardDesc =
      "Work with your team members, make it efficently and flexible";
  final PageController _pageController =
      PageController(initialPage: 0, keepPage: true);
  AnimatedContainer getIndicator(int page) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      height: 10,
      width: (_currentPage == page) ? 20 : 10,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: (_currentPage == page) ? Colors.black : Colors.grey),
    );
  }

  Column onBoardingPage(String img, String title, String desc) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              image:
                  DecorationImage(image: AssetImage('asset/image/$img.png'))),
        ),
        const SizedBox(
          height: 50,
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            title,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Text(
            desc,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }

  void _setCurrentPage(int value) {
    setState(() {
      _currentPage = value;
    });
  }

  void _openLoginPage() {
    Navigator.push(
        context, NewScreenNavigatorRoute(child: const LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: PageView(
                controller: _pageController,
                children: <Widget>[
                  onBoardingPage(
                      'onboard1', "Welcome to Todo App", _firstOnBoardDesc),
                  onBoardingPage(
                      'onboard2', "Manage your works", _secondOnBoardDesc),
                  onBoardingPage(
                      'onboard3', "Assign team members", _thirdOnBoardDesc),
                ],
                onPageChanged: (value) => _setCurrentPage(value),
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) => getIndicator(index))),
            Positioned(
                bottom: 0,
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  height: MediaQuery.of(context).size.height * 0.4 - 30,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('asset/image/path1.png')),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          _openLoginPage();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 100),
                          decoration:
                              BoxDecoration(color: Colors.white, boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              offset: const Offset(0, 9),
                              blurRadius: 20,
                              spreadRadius: 3,
                            )
                          ]),
                          child: const Text("Get Started",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      const Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ],
    );
  }
}
