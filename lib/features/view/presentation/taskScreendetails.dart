import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company/features/view/presentation/taskScreen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:company/core/constants/colors_managers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/textstyle_manager.dart';
import '../../../core/helpingFunctions.dart';
import '../../models/Registermodel.dart';
import '../../models/commentModel.dart';
import '../theBloc/taskbloc/bloc/task_bloc.dart';
import '../widgets/Dialogs/errorsuccessDialog.dart';
import '../widgets/Others/comments.dart';

class TaskDetails extends StatefulWidget {
  String? taskTitle;
  String? authorname;
  String? authorposition;
  String? taskdescritoon;
  String? deadlinedate;
  String? category;
  String? imagee;
  String? beginningdate;
  String? taskId;

  TaskDetails({
    Key? key,
    this.taskTitle,
    this.authorname,
    this.authorposition,
    this.taskdescritoon,
    this.deadlinedate,
    this.category,
    this.imagee,
    this.beginningdate,
    this.taskId,
  }) : super(key: key);

  @override
  _TaskDetailsState createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  bool _isCommenting = false;
  bool _isTaskDone = false;
  List<Comment> _allcomments2 = [];
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _commentController.dispose();
  }

  @override
  void initState() {
    context.read<TaskBloc>().add(FetchCommentsEvent(widget.taskId!));
  }

  RegistrationModel? registerationmodel;

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
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Back',
                        style: Mytextstyle.detailsTextStyle1
                            .copyWith(fontStyle: FontStyle.italic),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          showDeleteDialog(context, () {
                            Navigator.pop(context);
                            context
                                .read<TaskBloc>()
                                .add(DeleteTaskEvent(widget.taskId!));
                          });
                        });
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 35,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                widget.taskTitle!,
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
            Text(widget.category!, style: Mytextstyle.detailsTextStyle1),
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
                              image: DecorationImage(
                                image: NetworkImage(widget.imagee!),
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
                                widget.authorname!,
                                style: Mytextstyle.contactdetailsTextStyle2,
                              ),
                              Text(
                                widget.authorposition!,
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
                          Text(widget.beginningdate!,
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
                          Text(widget.deadlinedate!,
                              style: Mytextstyle.contactdetailsTextStyle2
                                  .copyWith(color: MyColors.rred)),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            calculateTimeLeft(widget.deadlinedate!),
                            style: TextStyle(
                              color: calculateTimeLeft(widget.deadlinedate!) ==
                                      'No time left!'
                                  ? Colors.red
                                  : Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 21,
                            ),
                          ),
                        ),
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
                      Text('Done state:',
                          style: Mytextstyle.detailsTextStyle1.copyWith(
                              fontWeight: FontWeight.bold, fontSize: 25)),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: TextButton(
                              child: Text('Done',
                                  style: Mytextstyle.contactdetailsTextStyle2
                                      .copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    decoration: _isTaskDone
                                        ? TextDecoration.underline
                                        : TextDecoration.none,
                                    color: _isTaskDone
                                        ? Colors.green
                                        : Colors.black,
                                  )),
                              onPressed: () {
                                setState(() {
                                  _isTaskDone = true;
                                });

                                context.read<TaskBloc>().add(
                                      UpdateTaskStatusEvent(
                                        taskId: widget.taskId!,
                                        isDone: true,
                                      ),
                                    );
                              },
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          decoration: !_isTaskDone
                                              ? TextDecoration.underline
                                              : TextDecoration.none,
                                          color: !_isTaskDone
                                              ? Colors.red
                                              : Colors.black)),
                              onPressed: () {
                                setState(() {
                                  _isTaskDone = false;
                                });

                                context.read<TaskBloc>().add(
                                      UpdateTaskStatusEvent(
                                        taskId: widget.taskId!,
                                        isDone: false,
                                      ),
                                    );
                              },
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
                      Text(widget.taskdescritoon!,
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
                                          BlocListener<TaskBloc, TaskState>(
                                            listener: (context, state) {
                                              if (state is CommentLoading) {
                                                const CircularProgressIndicator();
                                              } else if (state
                                                  is CommentError) {
                                                Fluttertoast.showToast(
                                                  msg: state.error,
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0,
                                                );
                                                print(state.error);
                                              } else if (state
                                                  is CommentAdded) {}
                                            },
                                            child: MaterialButton(
                                              onPressed: () {
                                                context.read<TaskBloc>().add(
                                                      AddCommentEvent(
                                                        comment: Comment(
                                                          commentId:
                                                              widget.taskId!,
                                                          commentBody:
                                                              _commentController
                                                                  .text,
                                                          commenterImageUrl:
                                                              commenterurl,
                                                          commenterName:
                                                              commentername,
                                                          timestamp: DateFormat(
                                                                  'yyyy-MM-dd HH:mm:ss')
                                                              .format(DateTime
                                                                  .now()),
                                                        ),
                                                        taskId: widget.taskId!,
                                                      ),
                                                    );
                                                //true

                                                context.read<TaskBloc>().add(
                                                    FetchCommentsEvent(
                                                        widget.taskId!));
                                                _commentController.clear();
                                              },
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
                    ],
                  ),
                ),
              ),
            ),
            BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                if (state is FetchingCommentsLoadedState) {
                  _allcomments2 = state.comments;
                  context
                      .read<TaskBloc>()
                      .add(FetchCommentsEvent(widget.taskId!));
                  return Container();
                } else if (state is FetchingCommentsErrorState) {
                  Fluttertoast.showToast(
                    msg: '@@@@@@@@@@@@@@${state.error}',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                  print(state.error);
                  return Container();
                } else {
                  return Container();
                }
              },
            ),
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('comments')
                  .where('commentId', isEqualTo: widget.taskId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  List<Comment> commentsList = [];
                  for (var doc in snapshot.data!.docs) {
                    final comment = Comment(
                      commentId: doc.id,
                      commentBody: doc['commentBody'] ?? "",
                      commenterId: doc['commenterId'] ?? "",
                      commenterName: doc['commenterName'] ?? "",
                      commenterImageUrl: doc['commenterImageUrl'] ?? "",
                      timestamp: DateTime.parse(
                          doc['timestamp']), // Convert timestamp to DateTime
                    );
                    commentsList.add(comment);
                  }

                  // Sort the commentsList based on timestamps
                  commentsList
                      .sort((a, b) => b.timestamp.compareTo(a.timestamp));

                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (ctx, index) {
                      Comment comment = commentsList[index];

                      return CommentWidget(
                        time: comment.timestamp,
                        commentId: comment.commentId!,
                        commentBody: comment.commentBody!,
                        commenterId: comment.commenterId!,
                        commenterName: comment.commenterName!,
                        commenterImageUrl: comment.commenterImageUrl!,
                      );
                    },
                    separatorBuilder: (ctx, index) {
                      return const Divider(
                        thickness: 1,
                      );
                    },
                    itemCount: commentsList.length,
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
