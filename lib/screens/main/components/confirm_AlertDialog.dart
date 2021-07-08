import 'dart:ui';

import 'package:flutter/material.dart';

confirmAlertDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Are you sure",style: Theme.of(context).textTheme.body1,),
      content: Text("Do you want to change state",style: Theme.of(context).textTheme.body1,),
      actions: [
        FlatButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text("NO",style: TextStyle(color: Theme.of(context).errorColor),),
          textColor: Theme.of(context).accentColor,
        ),
        FlatButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text("YES",style: TextStyle(color: Theme.of(context).accentColor),),
          textColor: Theme.of(context).accentColor,
        ),
      ],
    ),
  );
}