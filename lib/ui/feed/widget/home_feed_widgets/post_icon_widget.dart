import 'package:flutter/material.dart';

class PostIconWidget extends StatelessWidget {
  const PostIconWidget({
    @required this.icon,
    // @required this.postOperationType,
  });

  // final PostOperationType postOperationType;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      child: InkWell(
        onTap: () {},
        child: Icon(icon, color: Colors.grey[700]),
      ),
    );
  }
}
