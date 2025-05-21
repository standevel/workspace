import 'package:flutter/material.dart';

import '../model/user.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    // Define a mapping of colors based on the first letter
    print('user for avatar ${user.firstName}');
    Map<String, Color> letterColorMap = {
      'A': Colors.blue,
      'B': Colors.green,
      'C': Colors.orange,
      'D': Colors.purple,
      'E': Colors.red,
      'F': Colors.teal,
      'G': Colors.pink,
      'H': Colors.indigo,
      'I': Colors.lightBlue,
      'J': Colors.amber,
      'K': Colors.deepOrange,
      'L': Colors.cyan,
      'M': Colors.deepPurple,
      'N': Colors.brown,
      'O': Colors.blueGrey,
      'P': Colors.lime,
      'Q': Colors.lightGreen,
      'R': Colors.yellow,
      'S': Colors.grey,
      'T': Colors.greenAccent,
      'U': Colors.pinkAccent,
      'V': Colors.deepOrangeAccent,
      'W': Colors.cyanAccent,
      'X': Colors.amberAccent,
      'Y': Colors.blueAccent,
      'Z': Colors.redAccent,
    };

    // Get the first letter of the firstName
    String firstLetter = user.firstName.isNotEmpty ? user.firstName[0] : 'G';

    // Use the letterColorMap to select a color based on the first letter
    Color backgroundColor =
        letterColorMap[firstLetter.toUpperCase()] ?? Colors.grey;

    return CircleAvatar(
      radius: 20.0,
      backgroundColor: backgroundColor,
      backgroundImage:
          user.profileImageUrl != null && user.profileImageUrl!.isNotEmpty
              ? NetworkImage(user.profileImageUrl!)
              : null,
      child: user.profileImageUrl == null || user.profileImageUrl!.isEmpty
          ? Text(
              firstLetter,
              style: const TextStyle(fontSize: 22.0, color: Colors.white),
            ) // Display initials if no profile picture
          : null,
    );
  }
}
