import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hw_10/models.dart';

import 'covid_model.dart';
import 'game.dart';

void main() {
  const app = MyApp();
  runApp(app);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // callback method
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
          headline6: TextStyle(
            fontSize: 22.0,
            //fontWeight: FontWeight.bold,
          ),
          bodyText2: TextStyle(
            fontSize: 14.0,
          ),
        ),
      ),
      home: MyWidget(),
    );
  }
}
class MyWidget extends StatefulWidget { // immutable Widget
  @override
  Test createState() => Test()._initializeDemo();
// creating State Object of MyWidget
}
class Test extends State<MyWidget> {



  final List<PostModel> postList = [];

  final UserModel user_demo1 = UserModel(firstname: 'Easy', lastname: 'Cat', owner_icon_url: 'https://i.imgur.com/AD3MbBi.jpeg');
  final UserModel user_demo2 = UserModel(firstname: "Pop", lastname: 'Cat', owner_icon_url: 'https://i.imgur.com/gMDNvl3.gif');
  final UserModel user_demo3 = UserModel(firstname: 'Morty', lastname: 'Smith', owner_icon_url: 'https://i.imgur.com/pxC7FNp.jpeg');



  Test _initializeDemo() {

    var p1 = PostModel(user: user_demo1, image_url: 'https://i.imgur.com/XlxLpeH.jpeg',
        content: 'Just Happy Valentine Day!');
    var p2 = PostModel(user: user_demo2, image_url: 'https://i.imgur.com/NSkPnMy.jpeg',
        content: "Nice flower! good dog. \nit's only 99.9 THB per 1 rose\n#popcat #CheapRose #valentineDay");
    var p3 = PostModel(user: user_demo3, image_url: 'https://i.imgur.com/ebly4oy.jpeg',
    content: "Thanks for valentine day #stranger #universe #earth");


    postList.add(p2);

    postList.add(p3);
    postList.add(p1);
    UserModel test_user = UserModel(firstname: 'Prayut', lastname: 'O-Chan', owner_icon_url: 'https://i.imgur.com/RLbgqpY.jpeg');


    p2.comments.add(CommentModel(comment: 'ส่งมาที่สภาด้วยหนู', ownerComment: test_user));
    p2.comments.add(CommentModel(comment: '<3 ข้าวของแพง หมด จริงๆ', ownerComment: user_demo3));
    p2.comments.add(CommentModel(comment: 'F ส่งหน้าศิลปากร', ownerComment: user_demo1));
    p2.comments.add(CommentModel(comment: 'ติดต่อหลังไมค์ได้ ลดราคาพิเศษ', ownerComment: user_demo2));


    p1.comments.add(CommentModel(comment: '<3', ownerComment: user_demo2));
    p1.comments.add(CommentModel(comment: '<3', ownerComment: user_demo2));
    p1.comments.add(CommentModel(comment: '<3', ownerComment: user_demo2));
    p1.comments.add(CommentModel(comment: '<3', ownerComment: user_demo2));

    p3.comments.add(CommentModel(comment: 'แฮปปี้จริง', ownerComment: user_demo3));
    p3.comments.add(CommentModel(comment: '....', ownerComment: user_demo1));
    p3.comments.add(CommentModel(comment: 'Pop Pop Pop!', ownerComment: user_demo2));
    return this;
  }

  Test _instance() { return this; }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('InstaValentine')),
      body: ListView.builder(
          itemCount: postList.length,
          itemBuilder: (context, index) =>
              MyCard(post: postList[index], testPage: _instance()),
    ));
  }
  void update(Function fn) {
    setState(() {
        fn();
    });
  }
}
class MyCommentWidget extends StatefulWidget {
  final CommentModel comment;

  const MyCommentWidget({
    Key? key,
    required this.comment,
  }) : super(key: key);

  @override
  State<MyCommentWidget> createState() => MyComment(comment);
}
class MyComment extends State<MyCommentWidget> {

  final CommentModel comment;

  MyComment(this.comment);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: Row(

        children: [
          CircleAvatar(
            radius: 15.0,

            backgroundImage:
            NetworkImage(comment.ownerComment.owner_icon_url),
            backgroundColor: Colors.transparent,

          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Row(
              children: [
                Text('${comment.ownerComment.firstname} ${comment.ownerComment.lastname}',

                  style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.secondary)),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(' ${comment.comment}'),
                ),
              ]
            ),
          )
        ],
      ),
    );
  }


}

class MyCard extends StatelessWidget {


  final PostModel post;
  final Test testPage;
  MyCard({
    Key? key,

    required this.post,
    required this.testPage,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(post.user.owner_icon_url),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('${post.user.firstname} ${post.user.lastname}', style: TextStyle(fontWeight: FontWeight.bold)),
                ),

                Expanded(

                  child: Container(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: const Icon(Icons.more_vert),
                      color: Colors.grey,
                      onPressed: () {},
                    ),
                  )
                ),
              ],

            ),

            Container(
              margin: const EdgeInsets.only(top: 5, bottom: 5),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(post.image_url),
                ),
                ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(post.content, style: TextStyle(fontSize: 20),),
            ),

            ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: post.comments.length,
              itemBuilder: (context, index) =>
                  MyCommentWidget(comment: post.comments[index]),
            ),

            Row(
              children: [
                IconButton(
                  icon: Icon(post.isLike?Icons.favorite:Icons.favorite_border),
                  color: post.isLike?Theme.of(context).colorScheme.secondary:Colors.grey,
                  onPressed: () {
                    testPage.update(() {
                      post.isLike = !post.isLike;
                    });
                  },
                ),
                Flexible(child: TextField(
                  controller: post.input_comment,
                  decoration: InputDecoration(
                      hintText: 'Add a comment...',
                    hintStyle: TextStyle(fontSize: 15.0, color: Theme.of(context).colorScheme.secondary),
                  ),
                  onSubmitted: (value) {

                    testPage.update(() {
                      UserModel test_user = UserModel(firstname: 'Prayut', lastname: 'O-Chan', owner_icon_url: 'https://i.imgur.com/RLbgqpY.jpeg');

                      post.comments.add(CommentModel(comment: value, ownerComment: test_user));
                      post.input_comment.clear();
                    });



                },
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  late Game _game;

  HomePage({Key? key}) : super(key: key) {
    _game = Game(maxRandom: 100);
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _input = '';
  var _feedbackText = 'ทายเลข 1 ถึง 100';

  void _showOkDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GUESS THE NUMBER'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.purple.shade50,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.purple.shade100,
                offset: Offset(5.0, 5.0),
                spreadRadius: 2.0,
                blurRadius: 5.0,
              )
            ],
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/guess_logo.png', width: 90.0),
                    SizedBox(width: 8.0),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('GUESS',
                            style: TextStyle(
                                fontSize: 36.0, color: Colors.purple.shade200)),
                        Text(
                          'THE NUMBER',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.purple.shade600,
                            //fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text(_input, style: TextStyle(fontSize: 50.0)),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(_feedbackText, style: TextStyle(fontSize: 20.0)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 1; i <= 3; i++) _buildButton(num: i),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 4; i <= 6; i++) _buildButton(num: i),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 7; i <= 9; i++) _buildButton(num: i),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildButton(num: -2),
                  _buildButton(num: 0),
                  _buildButton(num: -1),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  child: Text('GUESS'),
                  onPressed: () {
                    var guess = int.tryParse(_input);

                    if (guess == null) {
                      _showOkDialog(context, 'ERROR', 'กรุณากรอกตัวเลข');
                      return;
                    }

                    late String message;
                    var guessResult = widget._game.doGuess(guess);
                    if (guessResult > 0) {
                      setState(() {
                        _feedbackText = '$guess : มากเกินไป';
                        _input = '';
                      });
                    } else if (guessResult < 0) {
                      setState(() {
                        _feedbackText = '$guess : น้อยเกินไป';
                        _input = '';
                      });
                    } else {
                      setState(() {
                        _feedbackText =
                            '$guess : ถูกต้อง 🎉 (ทาย ${widget._game.guessCount} ครั้ง)';
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton({int? num}) {
    Widget child = Text('$num', style: TextStyle(fontSize: 20.0));
    if (num == -2) {
      child = Icon(Icons.close);
    } else if (num == -1) {
      child = Icon(Icons.backspace_outlined);
    }

    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            if (num == -2) {
              setState(() {
                _input = '';
              });
            } else if (num == -1) {
              if (_input.length > 0) {
                setState(() {
                  _input = _input.substring(0, _input.length - 1);
                });
              }
            } else {
              if (_input.length >= 3) return;

              setState(() {
                _input = '$_input$num';
              });
            }
          });
        },
        child: child,
      ),
    );
  }
}
