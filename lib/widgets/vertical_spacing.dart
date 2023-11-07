import 'package:flutter/material.dart';

class VerticalSapcing extends StatelessWidget {
  const VerticalSapcing({super.key, this.height});
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}
