import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:oficina/shared/style.dart';

class MainAppbarComponent extends StatelessWidget {
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
              'no-data',
              style: Style.shopNameText,
            )),
            Text(
              'no-data',
              style: Style.userNameText,
            ),
            SizedBox(
              width: 10,
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(
                  '${DotEnv().env['BASE_URL_IMG']}/user/default.png'),
            )
          ],
        ),
      ),
    );
  }
}
