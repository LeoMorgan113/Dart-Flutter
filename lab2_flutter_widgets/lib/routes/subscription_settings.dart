import 'package:flutter/material.dart';

class SubscriptionSettings extends StatefulWidget {
  const SubscriptionSettings({Key? key}) : super(key: key);

  @override
  _SubscriptionSettingsState createState() => _SubscriptionSettingsState();
}

class _SubscriptionSettingsState extends State<SubscriptionSettings> with SingleTickerProviderStateMixin{

  late AnimationController _containerAnimationController;
  late Animation _containerRadiusAnimation,
      _containerSizeAnimation,
      _containerColorAnimation;

  @override
  void initState() {
    super.initState();
    _containerAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));

    _containerSizeAnimation = Tween(begin: 0.0, end: 2.0).animate(
        CurvedAnimation(
            curve: Curves.easeInToLinear, parent: _containerAnimationController));

    // Defining both color and size animations
    _containerColorAnimation =
        ColorTween(begin: Colors.grey, end: Colors.red).animate(
            CurvedAnimation(
                curve: Curves.ease, parent: _containerAnimationController));
    // Rebuilding the screen when animation goes ahead
    _containerAnimationController.addListener(() {
      setState(() {});
    });

    // Repeat the animation after finish
    _containerAnimationController.repeat();

    //For single time
    //controller.forward()

    //Reverses the animation instead of starting it again and repeats
    //controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Subscription Animation"),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: ()=> Navigator.pushNamed(context, '/')
        ),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _containerAnimationController,
          builder: (context, child) {
            return Center(
              child: Container(
                transform: Matrix4.translationValues(
                    _containerSizeAnimation.value * 700.0 - 300, 0.0, 0.0),
                child: Icon(Icons.subscriptions_outlined,
                  color: _containerColorAnimation.value,
                  size: _containerSizeAnimation.value * 200,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}