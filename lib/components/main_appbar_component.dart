import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:oficina/model/get_user_data_model.dart';
import 'package:oficina/shared/style.dart';

class MainAppbarComponent extends StatelessWidget {
  final GetUserDataModel user;

  MainAppbarComponent({@required this.user});
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 10, top: 10, bottom: 10),
        height: 60,
        color: Style.secondaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
                child: Text(
              user.data.data.shop.name,
              style: Style.shopNameText,
            )),
            Text(
              user.data.data.name,
              style: Style.userNameText,
            ),
            SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/profile', arguments: user);
              },
              child: CircleAvatar(
                backgroundColor: Style.primaryColor,
                backgroundImage: AssetImage('assets/img/user-black.png'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
