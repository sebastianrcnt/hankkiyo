import 'package:flutter/material.dart';

class HActionButton extends StatefulWidget {
  final String innerText;
  bool isLoading;

  HActionButton({Key key, this.innerText}) : super(key: key) {
    this.isLoading = false;
  }

  @override
  _HActionButtonState createState() => _HActionButtonState();
}

class _HActionButtonState extends State<HActionButton> {
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
