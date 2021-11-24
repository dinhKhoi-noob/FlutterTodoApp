import 'package:flutter/material.dart';

class NewScreenNavigatorRoute extends PageRouteBuilder {
  final Widget child;
  NewScreenNavigatorRoute({required this.child})
      : super(
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (context, animation, secondaryAnimation) {
          return child;
    });
  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child){
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1,0),
        end: Offset.zero
      ).animate(animation),
      child: child,
    );
  }
}
