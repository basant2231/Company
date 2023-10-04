import 'package:company/core/constants/colors_managers.dart';
import 'package:company/features/presentation/views/eachWorker.dart';
import 'package:flutter/material.dart';

import '../../../../core/helpingFunctions.dart';

class AllWorkersWidget extends StatefulWidget {
  final String employeeName;
  final String employeeEmail;
  final String positionInCompany;
  final String phoneNumber;
  final String employeeImageUrl;

  const AllWorkersWidget(
      {super.key,
      required this.employeeName,
      required this.employeeEmail,
      required this.positionInCompany,
      required this.phoneNumber,
      required this.employeeImageUrl});
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
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return EachWorkerScreen(email: widget.employeeEmail,
                    name: widget.employeeName,
                    employeimage: widget.employeeImageUrl,
                    position: widget.positionInCompany,
                  
                    number: widget.phoneNumber);
              },
            ));
          },
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
              child: Image.network(widget.employeeImageUrl),
            ),
          ),
          title: Text(
            widget.employeeName,
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
                '${widget.positionInCompany}\n${widget.phoneNumber}',
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
            onPressed: () {
               LaunchUtilsFunctions.mailTo(widget.employeeEmail, context);
            },
          )),
    );
  }
}
