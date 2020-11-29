import 'package:flutter/material.dart';
import 'package:online_teaching_mobile/app/view_model/profile_view_model.dart';

class ProfileView extends ProfileViewModel {
  Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [appbar(size, context), body()],
      ),
    );
  }

  Expanded appbar(Size size, BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        margin: EdgeInsets.only(bottom: 4),

        /// searchin altındaki margin
        // It will cover 20% of our total height
        height: size.height * 0.2,
        child: Stack(
          overflow: Overflow.visible,
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              height: size.height,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36),
                ),
                boxShadow: [
                  BoxShadow(
                    //offset: Offset(0, 1),
                    blurRadius: 20,
                    //  color: Colors.blue.withOpacity(0.23),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: -100,
              child: Container(
                  width: 190,
                  height: 190,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(
                        'https://image.freepik.com/vecteurs-libre/robot-mignon-prendre-selfie-photo-icone-isole-fond-bleu-intelligence-artificielle-technologie-moderne_48369-13410.jpg'),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Expanded body() {
    return Expanded(
        flex: 5,
        child: Container(
          margin: EdgeInsets.only(top: 110),
          //padding: EdgeInsets.all(10),

          child: Column(
            children: [
              Text(
                "Hello !",
                style: TextStyle(fontSize: 40),
              ),
              Container(
                margin: EdgeInsets.all(10),
                //padding: EdgeInsets.all(10),

                child: SizedBox(
                  width: size.width * 0.8,
                  height: size.height * 0.08,
                  child: FlatButton(
                    color: Colors.red,
                    child: Text(
                      "Testlerim",
                      style: TextStyle(color: Colors.white),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    onPressed: () {},
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
