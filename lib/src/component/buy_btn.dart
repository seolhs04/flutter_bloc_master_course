import 'package:flutter/material.dart';

class BuyBtn extends StatelessWidget {
  const BuyBtn({super.key, required this.onTap});

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ElevatedButton(
        onPressed: onTap,
        child: const Padding(
          padding: EdgeInsets.all(30.0),
          child: Text('라이선스 구매'),
        ),
      ),
    );
  }
}
