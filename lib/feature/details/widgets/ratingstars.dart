import 'package:flutter/material.dart';

class StarRating extends StatefulWidget {
  final int maxRating;
  final Function(int) onChanged;

  StarRating({required this.maxRating, required this.onChanged});

  @override
  _StarRatingState createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  int _currentRating = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.maxRating, (index) {
        final starColor = index < _currentRating ? const Color.fromARGB(255, 255, 163, 83) : Colors.grey;
        return GestureDetector(
          onTap: () {
            setState(() {
              _currentRating = index + 1;
              widget.onChanged(_currentRating);
            });
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300), // Add animation duration
            curve: Curves.easeOut, // Add animation curve
            padding: EdgeInsets.all(8.0), // Adjust padding as needed
            child: Icon(
              Icons.star,
              color: starColor,
              size: 36.0, // Adjust star size as needed
            ),
          ),
        );
      }),
    );
  }
}
