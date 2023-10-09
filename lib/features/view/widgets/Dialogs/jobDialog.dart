



import 'package:company/core/constants/MyLists.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/colors_managers.dart';

class JobsDialog extends StatefulWidget {
  final BuildContext context;
  final Size size;
  final TextEditingController positionController;

  JobsDialog({required this.context, required this.size, required this.positionController});

  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<JobsDialog> {
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Task category',
        style: TextStyle(color: MyColors.blue, fontSize: 20),
      ),
      content: SizedBox(
        width: widget.size.width * 0.9,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: MyLists.jobcategorylist.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                setState(() {
                  selectedCategory = MyLists.jobcategorylist[index];
                  widget.positionController.text = selectedCategory ?? '';
                });
                Navigator.canPop(context) ? Navigator.pop(context) : null;
              },
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle_rounded,
                    color: selectedCategory == MyLists.jobcategorylist[index] ? MyColors.ddarkindego : Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      MyLists.jobcategorylist[index],
                      style: TextStyle(
                        color: selectedCategory == MyLists.jobcategorylist[index] ? MyColors.ddarkindego : Color(0xFF00325A),
                        fontSize: 19,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.canPop(context) ? Navigator.pop(context) : null;
          },
          child: const Text('Close'),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              selectedCategory = null;
              widget.positionController.text = '';
            });
            Navigator.canPop(context) ? Navigator.pop(context) : null;
          },
          child: const Text('Cancel filter'),
        ),
      ],
    );
  }
}
