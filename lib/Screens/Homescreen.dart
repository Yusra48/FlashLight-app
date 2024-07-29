import 'package:flutter/material.dart';
import 'package:torch_controller/torch_controller.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  Color color = Colors.white;
  double fontSize = 20;
  bool isClicked = false;
  final Controller = TorchController();

  final DecorationTween decorationTween = DecorationTween(
    begin: BoxDecoration(
      color: Colors.white,
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
            color: Colors.white,
            spreadRadius: 5,
            blurRadius: 20,
            offset: Offset(0, 0)),
      ],
      border: Border.all(color: Colors.black),
    ),
    end: BoxDecoration(
      color: Colors.white,
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
            color: Colors.red,
            spreadRadius: 50,
            blurRadius: 15,
            offset: Offset(0, 0)),
      ],
      border: Border.all(color: Colors.black),
    ),
  );

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleFlashlight() async {
    setState(() {
      isClicked = !isClicked;
      if (isClicked) {
        _animationController.forward();
        fontSize = 40;
        color = Colors.red;
      } else {
        _animationController.reverse();
        fontSize = 20;
        color = Colors.white;
      }
      Controller.toggle();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      body: Stack(
        children: [
          GestureDetector(
            onTap: _toggleFlashlight,
            child: Center(
              child: DecoratedBoxTransition(
                position: DecorationPosition.background,
                decoration: decorationTween.animate(_animationController),
                child: SizedBox(
                  width: 120,
                  height: 120,
                  child: Center(
                    child: Icon(
                      Icons.settings_power_outlined,
                      color: isClicked ? Colors.black : Colors.red,
                      size: 60,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 1.4,
            alignment: Alignment.bottomCenter,
            child: AnimatedDefaultTextStyle(
              child: Text(isClicked ? 'FlashLight ON' : 'FlashLight OFF'),
              style: TextStyle(
                color: color,
                fontSize: fontSize,
                letterSpacing: 0.5,
                fontWeight: FontWeight.bold,
              ),
              duration: const Duration(milliseconds: 200),
            ),
          ),
        ],
      ),
    );
  }
}
