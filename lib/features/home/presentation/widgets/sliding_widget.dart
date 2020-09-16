import 'package:flutter/material.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class SlidingWidget extends StatelessWidget {
  const SlidingWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlidingSheet(
      elevation: 8,
      cornerRadius: 16,
      snapSpec: const SnapSpec(
        // Enable snapping. This is true by default.
        snap: true,
        // Set custom snapping points.
        snappings: [0.9, 0.1, 1.0],
        // Define to what the snappings relate to. In this case,
        // the total available space that the sheet can expand to.
        positioning: SnapPositioning.relativeToAvailableSpace,
      ),
      // The body widget will be displayed under the SlidingSheet
      // and a parallax effect can be applied to it.
      // body: Center(
      //   child: Text('This widget is below the SlidingSheet'),
      // ),
      builder: (context, state) {
        // This is the content of the sheet that will get
        // scrolled, if the content is bigger than the available
        // height of the sheet.
        return Container(
          height: 500,
          child: Center(
            child: Text('This is the content of the sheet'),
          ),
        );
      },

      headerBuilder: (context, state) {
        // height of the sheet.
        return Container(
          color: Colors.blue,
          height: 30,
          child: Center(
            child: Text('Rutas'),
          ),
        );
      },
    );
  }
}
