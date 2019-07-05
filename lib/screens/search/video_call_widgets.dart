import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Video view wrapper
Widget videoView(view) {
  return Expanded(child: Container(child: view));
}

/// Video view row wrapper
Widget expandedVideoRow(List<Widget> views) {
  List<Widget> wrappedViews =
      views.map((Widget view) => videoView(view)).toList();
  return Expanded(
      child: Row(
    children: wrappedViews,
  ));
}

/// Video layout wrapper
Widget viewRows(List<Widget> views) {
  // List<Widget> views = _getRenderViews();
  switch (views.length) {
    case 1:
      return Container(
          child: Column(
        children: <Widget>[videoView(views[0])],
      ));
    case 2:
      return Container(
          child: Column(
        children: <Widget>[
          expandedVideoRow([views[0]]),
          expandedVideoRow([views[1]])
        ],
      ));
    case 3:
      return Container(
          child: Column(
        children: <Widget>[
          expandedVideoRow(views.sublist(0, 2)),
          expandedVideoRow(views.sublist(2, 3))
        ],
      ));
    case 4:
      return Container(
          child: Column(
        children: <Widget>[
          expandedVideoRow(views.sublist(0, 2)),
          expandedVideoRow(views.sublist(2, 4))
        ],
      ));
    default:
  }
  return Container();
}

/// Info panel to show logs
Widget panel(List<String> infoStrings) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 48),
    alignment: Alignment.bottomCenter,
    child: FractionallySizedBox(
      heightFactor: 0.5,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 48),
        child: ListView.builder(
          reverse: true,
          itemCount: infoStrings.length,
          itemBuilder: (BuildContext context, int index) {
            if (infoStrings.length == 0) {
              return null;
            }
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                      decoration: BoxDecoration(
                        color: Colors.yellowAccent,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        infoStrings[index],
                        style: TextStyle(color: Colors.blueGrey),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    ),
  );
}

/// Toolbar layout
Widget toolbar(bool muted, BuildContext context, Function onToggleMute,
    Function onCallEnd, Function onSwitchCamera) {
  return Container(
    alignment: Alignment.bottomCenter,
    padding: EdgeInsets.symmetric(vertical: 48),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RawMaterialButton(
          onPressed: onToggleMute,
          child: new Icon(
            muted ? Icons.mic : Icons.mic_off,
            color: muted ? Colors.white : Colors.blueAccent,
            size: 20.0,
          ),
          shape: new CircleBorder(),
          elevation: 2.0,
          fillColor: muted ? Colors.blueAccent : Colors.white,
          padding: const EdgeInsets.all(12.0),
        ),
        RawMaterialButton(
          // onPressed: _onCallEnd(context),
          onPressed: () => onCallEnd(context),
          child: new Icon(
            Icons.call_end,
            color: Colors.white,
            size: 35.0,
          ),
          shape: new CircleBorder(),
          elevation: 2.0,
          fillColor: Colors.redAccent,
          padding: const EdgeInsets.all(15.0),
        ),
        RawMaterialButton(
          onPressed: onSwitchCamera,
          child: new Icon(
            Icons.switch_camera,
            color: Colors.blueAccent,
            size: 20.0,
          ),
          shape: new CircleBorder(),
          elevation: 2.0,
          fillColor: Colors.white,
          padding: const EdgeInsets.all(12.0),
        )
      ],
    ),
  );
}
