import 'package:flutter/material.dart';

class ContainerButton extends StatelessWidget {
  const ContainerButton({super.key, this.onTap, this.title});
  final String? title;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 380,
        height: 60,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Text(
            title!,
            style: const TextStyle(color: Color(0xff274460), fontSize: 18),
          ),
        ),
      ),
    );
  }
}
