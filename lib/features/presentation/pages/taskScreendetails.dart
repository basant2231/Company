import 'package:company/core/constants/colors_managers.dart';
import 'package:company/core/constants/images_manager.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/textstyle_manager.dart';
import '../widgets/Others/comments.dart';

class TaskDetails extends StatefulWidget {
  const TaskDetails({super.key});

  @override
  _TaskDetailsState createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  bool _isCommenting = false;

  final TextEditingController _commentController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _commentController.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              padding: const EdgeInsets.all(8.0),
              child: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor:
                    Colors.transparent, // Make the AppBar transparent
                elevation: 0, // Remove the elevation (shadow)
                title: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Back',
                    style: Mytextstyle.detailsTextStyle1
                        .copyWith(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                'TaskTitle',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: MyColors.ddarkindego,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('uploaded by',
                              style: Mytextstyle.contactdetailsTextStyle2),
                          const Spacer(),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 3,
                                color: MyColors.llightblue,
                              ),
                              shape: BoxShape.circle,
                              image: const DecorationImage(
                                // Replace 'MyImages.clock' with the actual asset path of your image
                                image: AssetImage(
                                    MyImages.checkmark), // Example asset path
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'authorname',
                                style: Mytextstyle.contactdetailsTextStyle2,
                              ),
                              Text(
                                'authorposition',
                                style: Mytextstyle.contactdetailsTextStyle2,
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Uploaded on:',
                              style: Mytextstyle.detailsTextStyle1),
                          Text('date',
                              style: Mytextstyle.contactdetailsTextStyle2
                                  .copyWith(fontStyle: FontStyle.normal)),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Deadline date:',
                              style: Mytextstyle.detailsTextStyle1),
                          Text('deadlinedate',
                              style: Mytextstyle.contactdetailsTextStyle2
                                  .copyWith(color: MyColors.rred)),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                            true ? 'Still have enough time' : "No time left",
                            style: Mytextstyle.contactdetailsTextStyle2
                                .copyWith(color: Colors.green)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('Done state:', style: Mytextstyle.detailsTextStyle1),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: TextButton(
                              child: Text('Done',
                                  style: Mytextstyle.contactdetailsTextStyle2),
                              onPressed: () {},
                            ),
                          ),
                          const Opacity(
                            opacity: 0,
                            child: Icon(
                              Icons.check_box,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          Flexible(
                            child: TextButton(
                              child: Text('Not done',
                                  style: Mytextstyle.contactdetailsTextStyle2
                                      .copyWith(
                                          decoration:
                                              TextDecoration.underline)),
                              onPressed: () {},
                            ),
                          ),
                          const Opacity(
                            opacity: 0,
                            child: Icon(
                              Icons.check_box,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('Task description:',
                          style: Mytextstyle.detailsTextStyle1),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('taskdescritoon',
                          style: Mytextstyle.contactdetailsTextStyle2),
                      const SizedBox(
                        height: 20,
                      ),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 700),
                        child: _isCommenting
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Flexible(
                                    flex: 3,
                                    child: TextField(
                                      maxLength: 200,
                                      controller: _commentController,
                                      style: TextStyle(
                                        color: MyColors.ddarkindego,
                                      ),
                                      keyboardType: TextInputType.text,
                                      maxLines: 6,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        enabledBorder:
                                            const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                          ),
                                        ),
                                        errorBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.red,
                                          ),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: MyColors.llightblue,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          MaterialButton(
                                            onPressed: () async {},
                                            color: MyColors.llightblue,
                                            elevation: 10,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(13),
                                              side: BorderSide.none,
                                            ),
                                            child: const Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 14,
                                              ),
                                              child: Text(
                                                'Post',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              setState(() {
                                                _isCommenting = !_isCommenting;
                                              });
                                            },
                                            child: const Text('Cancel'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Center(
                                child: MaterialButton(
                                  onPressed: () {
                                    setState(() {
                                      _isCommenting = !_isCommenting;
                                    });
                                  },
                                  color: MyColors.llightblue,
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(13),
                                    side: BorderSide.none,
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                    child: Text(
                                      'Add a comment',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ),
                     
                      ListView.separated(
                        reverse: true,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (ctx, index) {
                          return CommentWidget(
                            commentId: 'yay',
                            commentBody: 'yay',
                            commenterId: 'yay',
                            commenterName: 'yay',
                            commenterImageUrl: 'yay',
                          );
                        },
                        separatorBuilder: (ctx, index) {
                          return const Divider(
                            thickness: 1,
                          );
                        },
                        itemCount: 4,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
