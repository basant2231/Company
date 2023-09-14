

import 'package:company/core/constants/colors_managers.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/images_manager.dart';

class AllWorkersWidget extends StatefulWidget {
  final String userID;
  final String userName;
  final String userEmail;
  final String positionInCompany;
  final String phoneNumber;
  final String userImageUrl;

  const AllWorkersWidget(
      {super.key, required this.userID,
      required this.userName,
      required this.userEmail,
      required this.positionInCompany,
      required this.phoneNumber,
      required this.userImageUrl});
  @override
  _AllWorkersWidgetState createState() => _AllWorkersWidgetState();
}

class _AllWorkersWidgetState extends State<AllWorkersWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: ListTile(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => ProfileScreen(
            //       userID: widget.userID,
            //     ),
            //   ),
            // );
          },
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          leading: Container(
            padding: const EdgeInsets.only(right: 12.0),
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(width: 1.0),
              ),
            ),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 20,
              /*
              Image.asset(
                      isDone ? MyImages.checkmark : MyImages.clock,
                      fit: BoxFit.contain,
                    ),*/ 
              child: Image.asset(widget.userImageUrl == null
                  ? MyImages.checkmark 
                  :  MyImages.clock),
            ),
          ),
          title: Text(
            widget.userName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.linear_scale,
                color: MyColors.ddarkindego,
              ),
              Text(
                '${widget.positionInCompany}/${widget.phoneNumber}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.mail_outline_outlined,
              size: 30,
              color: MyColors.ddarkindego,
            ),
            onPressed: (){},
          )),
    );
  }

}