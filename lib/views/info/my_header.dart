import 'package:covid_19/helper/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

// ignore: must_be_immutable
class MyHeader extends StatefulWidget {
  final String image;
  final bool imageDecoration;
  final double width;
  final double height;
  final String textTop;
  final String textBottom;
  final double offset;
  auth.User loggedInUser;
  MyHeader({Key key, this.image, this.imageDecoration, this.width, this.height, this.textTop, this.textBottom, this.offset, this.loggedInUser})
      : super(key: key);

  @override
  _MyHeaderState createState() => _MyHeaderState();
}

class _MyHeaderState extends State<MyHeader> {
  // auth.User loggedInUser;
  final _auth = auth.FirebaseAuth.instance;

  Future<void> _signOut() async {
    try {
      await _auth.signOut();
      widget.loggedInUser = _auth.currentUser;

      Phoenix.rebirth(context);
    } catch (e) {
      showToast(e.toString());
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        padding: EdgeInsets.only(left: 0, top: 30, right: 0),
        height: widget.height != null ? widget.height : 350,
        width: double.infinity,
        decoration: widget.imageDecoration
            ? BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xFF3383CD),
                    Color(0xFF11249F),
                  ],
                ),
                image: DecorationImage(
                  image: AssetImage("assets/images/virus.png"),
                ),
              )
            : BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xFF3383CD),
                    Color(0xFF11249F),
                  ],
                ),
              ),
        child: widget.loggedInUser != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Center(
                    child: Container(
                      height: 28.0,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        textDirection: TextDirection.rtl,
                        children: [
                          FlatButton(
                            child: Icon(
                              Icons.exit_to_app,
                              color: kBackgroundColor,
                              size: 25.0,
                            ),
                            onPressed: _signOut,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.loggedInUser.email != null ? widget.loggedInUser.email : '',
                                style: TextStyle(fontSize: 15, color: kBackgroundColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(color: kPrimaryColor),
                  Expanded(
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: (widget.offset < 0) ? 0 : widget.offset,
                          child: SvgPicture.asset(
                            widget.image,
                            width: widget.width != null ? widget.width : 230,
                            fit: BoxFit.fitWidth,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                        Positioned(
                          top: 20 - widget.offset / 2,
                          left: 195,
                          child: Text(
                            "${widget.textTop} \n${widget.textBottom}",
                            style: kHeadingTextStyle.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(),
                      ],
                    ),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  SizedBox(height: 20),
                  Expanded(
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: (widget.offset < 0) ? 0 : widget.offset,
                          child: SvgPicture.asset(
                            widget.image,
                            width: widget.width != null ? widget.width : 230,
                            fit: BoxFit.fitWidth,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                        Positioned(
                          top: 20 - widget.offset / 2,
                          left: 195,
                          child: Text(
                            "${widget.textTop} \n${widget.textBottom}",
                            style: kHeadingTextStyle.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
