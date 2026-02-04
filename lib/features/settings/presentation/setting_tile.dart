import 'package:flutter/material.dart';

class MySettingsTile extends StatelessWidget {
  final String title;
  final Widget action;

  const MySettingsTile({
    super.key, 
    required this.title,
     required this.action,
     });

  @override
  Widget build(BuildContext context) {
    //container
    return Container(
      decoration: BoxDecoration(
        //colors
        color: Theme.of(context).colorScheme.secondary,
        
        // curved corners
        borderRadius: BorderRadius.circular(12),

      ),
      //padding inside
      padding: EdgeInsets.all(25),

      //padding outside
      margin: const EdgeInsets.only(left: 25, right: 25, top: 10),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          action
        ],
      ),
    );
  }
}
