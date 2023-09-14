import 'package:company/core/constants/colors_managers.dart';
import 'package:company/features/presentation/pages/taskScreen.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/MyLists.dart';

class FilterDialog extends StatefulWidget {
  final BuildContext context;
  final Size size;

  FilterDialog({required this.context, required this.size});

  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
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
          itemCount: MyLists.taskcategorylist.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                setState(() {});
                Navigator.canPop(context) ? Navigator.pop(context) : null;
              },
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle_rounded,
                    color: MyColors.ddarkindego,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      MyLists.taskcategorylist[index],
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
            setState(() {});
            Navigator.canPop(context) ? Navigator.pop(context) : null;
          },
          child: const Text('Cancel filter'),
        ),
      ],
    );
  }
}


