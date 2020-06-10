import 'package:flutter/material.dart';

class LoginButton extends StatefulWidget {
  final String innerText;
  bool isLoading;

  LoginButton({Key key, this.innerText}) : super(key: key) {
    this.isLoading = false;
  }

  @override
  _LoginButtonState createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.isLoading = !widget.isLoading;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: widget.isLoading ? Theme.of(context).accentColor : null,
          border: Border.all(color: Theme.of(context).accentColor),
        ),
        width: 325.0,
        height: 41.0,
        child: Center(
          child: !widget.isLoading
              ? Text(
                  widget.innerText,
                  style: TextStyle(
                    fontSize: 17.0,
                    color: Theme.of(context).accentColor,
                  ),
                )
              : SizedBox(
                  width: 20.0,
                  height: 20.0,
                  child: CircularProgressIndicator(
                    strokeWidth: 3.0,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
        ),
      ),
    );
  }
}
