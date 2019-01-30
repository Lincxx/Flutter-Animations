import 'package:flutter/material.dart';
import '../widgets/cat.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  //just declaring a variable
  Animation<double> catAnimation;
  AnimationController catController;

  //initialize variable
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    catController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this, //this refers to the current class
    );

    catAnimation = Tween(begin: 0.0, end: 100.0).animate(
      CurvedAnimation(
        parent: catController,
        curve: Curves.easeIn,
      ),
    );

    //catController.forward();
  }

  onTap() {
    //The animation is stopped at the end
    if (catController.status == AnimationStatus.completed) {
      catController.reverse();
      //The animation is stopped at the beginning
    } else if (catController.status == AnimationStatus.dismissed) {
      catController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Animation!'),
        ),
        body: GestureDetector(
          child: Stack(
            children: <Widget>[
              buildCatAnimation(),
              buildBox()
            ],  
          ),          
          onTap: onTap,
        ));
  }

  Widget buildCatAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (context, child) {
        return Container(
          child: child,
          margin: EdgeInsets.only(top: catAnimation.value),
        );
      },
      child: Cat(),
    );
  }

  Widget buildBox(){
    return Container(
      height: 200.0,
      width: 200.0,
      color: Colors.brown
    );
  }
}
