import 'package:flutter/material.dart';

class LikesSettings extends StatefulWidget {
  @override
  _LikesSettingsState createState() => _LikesSettingsState();
}

class _LikesSettingsState extends State<LikesSettings> with SingleTickerProviderStateMixin{

  late AnimationController _arrowAnimationController;
  late Animation _colorAnimation;
  late Animation _sizeAnimation;

  @override
  void initState() {
    super.initState();
    _arrowAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _sizeAnimation=
        Tween(begin: 0.0, end: 270).animate(_arrowAnimationController);


    // Defining both color and size animations
    _colorAnimation = ColorTween(begin: Colors.purple, end: Colors.red).animate(_arrowAnimationController);

    // Rebuilding the screen when animation goes ahead
    _arrowAnimationController.addListener(() {
      setState(() {});
    });

    // Repeat the animation after finish
    _arrowAnimationController.repeat();

    //For single time
    //controller.forward()

    //Reverses the animation instead of starting it again and repeats
    //controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Likes animation"),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: ()=> Navigator.pushNamed(context, '/')
        ),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _arrowAnimationController,
          builder: (context, child) {
            return Center(
              child: Container(
                child: Center(
                  child: Icon(
                    Icons.favorite,
                    color: _colorAnimation.value,
                    size: _sizeAnimation.value,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}