import 'package:flutter/material.dart';
import 'package:unibank/consts/consts.dart';

class FeatureScreen extends StatefulWidget {
  const FeatureScreen({super.key});

  @override
  State<FeatureScreen> createState() => _FeatureScreenState();
}

class _FeatureScreenState extends State<FeatureScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0, title: "UniBank".text.bold.make(), centerTitle: true),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/bg.png",
              fit: BoxFit.cover,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              "Feature Screen will be available soon"
                  .text
                  .fontFamily(semibold)
                  .makeCentered()
            ],
          ),
        ],
      ),
    );
  }
}
