import 'package:flutter/cupertino.dart';

class PostModel {

  final UserModel user;
  final String content;
  final String image_url;
  List<CommentModel> comments = [];
  bool isLike = false;
  var input_comment = TextEditingController();
  PostModel({
    required this.user,
    required this.image_url,
    required this.content,
  });

}
class CommentModel {
  final String comment;
  final UserModel ownerComment;

  CommentModel({
    required this.comment,
    required this.ownerComment,
  });
}
class UserModel {
  final String firstname;
  final String lastname;
  final String owner_icon_url;


  UserModel({
    required this.firstname,
    required this.lastname,
    required this.owner_icon_url,
  });

}