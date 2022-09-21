import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';



class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final topBar = MediaQuery.of(context).padding.top;
    final bottomBar = MediaQuery.of(context).padding.bottom;
   // final height = MediaQuery.of(context).size.height - topBar;
    final height = 100.h - topBar;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            // crossAxisAlignment: CrossAxisAlignment.end,
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height:  height * 0.25,
                width: 50.w,
                color: Colors.black,
              ),
              Container(
                height:  height * 0.25,
                width: width,
                color: Colors.blue,
              ),
              Container(
                height:  height * 0.25,
                width: 90.w,
                color: Colors.pink,
                child: LayoutBuilder(
                  builder: (c , constraints ) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: constraints.maxHeight * 0.5,
                          width: constraints.maxWidth * 0.5,
                          color: Colors.greenAccent,
                          child: Text('hello world',style: TextStyle(fontSize: 17.sp),),
                        ),
                      ],
                    );
                  }
                ),
              ),

              Container(
                height:  height * 0.25,
                width:width,
                color: Colors.amberAccent,
              ),


            ],
          ),
        )
    );
  }
}
