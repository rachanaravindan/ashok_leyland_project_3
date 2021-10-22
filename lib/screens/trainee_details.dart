import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class TraineeDetails extends StatelessWidget {
  List<String> items=["sharan","sneha","shrinithi"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CircleAvatar(
            child: Icon(Icons.person),
          ),
          ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(items[index]),
              );
            },
          ),
        ],
      ),
    );
  }
}