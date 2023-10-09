import 'package:flutter/material.dart';

import '../../../../core/constants/colors_managers.dart';

class CategoryDialog extends StatefulWidget {
  final List<String> categoryList;
  final Function(String) onCategorySelected;
  final Size size; // Add the 'size' parameter

  const CategoryDialog({
    Key? key,
    required this.categoryList,
    required this.onCategorySelected,
    required this.size, // Include the 'size' parameter
  }) : super(key: key);

  @override
  _CategoryDialogState createState() => _CategoryDialogState();
}

class _CategoryDialogState extends State<CategoryDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Task category',
        style: TextStyle(color: MyColors.ddarkindego, fontSize: 20),
      ),
      content: SizedBox(
        width: widget.size.width * 0.9,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.categoryList.length,
          itemBuilder: (BuildContext context, int index) {
            if (index >= 0 && index < widget.categoryList.length) {
              // Check if the index is within bounds
              return InkWell(
                onTap: () {
                  widget.onCategorySelected(widget.categoryList[index]);
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle_rounded,
                      color: Colors.red[200],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.categoryList[index],
                        style: const TextStyle(
                          color: Color(0xFF00325A),
                          fontSize: 19,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const SizedBox.shrink(); // Return an empty widget if index is out of bounds
            }
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}