import 'package:flutter/material.dart';

class ConsumerRating extends StatelessWidget {
  final double rating;
  final ValueChanged<double> onChanged;

  const ConsumerRating({
    Key? key,
    required this.rating,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return IconButton(
          onPressed: () {
            onChanged(index + 1.0);
          },
          icon: Icon(
            Icons.star,
            color: index < rating ? Colors.amber : Colors.grey,
          ),
        );
      }),
    );
  }
}
