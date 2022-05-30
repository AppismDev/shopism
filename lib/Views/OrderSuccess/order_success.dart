import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shopism/Core/Constants/Enums/page_keys.dart';
import 'package:shopism/Views/Tab/View/tab_page_view.dart';
import 'package:shopism/main.dart';

class OrderSuccess extends StatelessWidget {
  const OrderSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Make a successful page with an icon in center and button at bottom
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Sipariş Başarılı'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/lottie/success_lottie.json', repeat: false),
              Text(
                'Siparişiniz başarıyla alındı.',
                style: context.textTheme.headline4,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          // child: Icon(
          //   Icons.check_circle,
          //   size: 100,
          //   color: Colors.green,
          // ),
        ),
        bottomNavigationBar: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  child: Text('Sepetime Dön'),
                  onPressed: () {
                    Navigator.popUntil(
                      context,
                      (route) {
                        bool shouldPop = false;
                        if (route.settings.name == PageKeys.CART_PAGE.toString()) {
                          shouldPop = true;
                        }
                        return shouldPop;
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
