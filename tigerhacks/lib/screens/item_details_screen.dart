import 'package:flutter/material.dart';
import 'package:tigerhacks/components/constants.dart';
import 'package:tigerhacks/components/details.dart';
import 'package:tigerhacks/components/expandable.dart';
import 'package:tigerhacks/components/header.dart';
import 'package:tigerhacks/screens/button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../globaldata.dart';

class ItemDetailsSreen extends StatelessWidget {
  static const routeName = 'item-details-screen/';
  final Map item;

  static bool added = true;

  const ItemDetailsSreen({Key ?key, required this.item}) : super(key: key);
  static void navigateTo(double lat, double lng) async {
    var uri = Uri.parse("google.navigation:q=$lat,$lng&mode=d");
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      throw 'Could not launch ${uri.toString()}';
    }
  }

  @override
  Widget build(BuildContext context) {
    print(item['foodID']);
    if (item['foodID'] == 'c2579d8d-c8a6-4ef9-a2be-78c296da0930' || item['foodID'] == '907ffae9-c2c9-45ea-ae61-08efa49b3d37') {
      finals.add(item);
      total = total + item['price'];
    }
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Header(item: item),
              Details(item: item),
              SizedBox(height: 15),
              Divider(color: kBorderColor),
              Expandable(title: 'Distance', description: '', trailing: TextButton(
                onPressed: () {
                  navigateTo((item['location']).latitude, (item['location']).longitude);
                },
                child: Text(item['storeID'] == 6 ? '1.8 Miles' : item['storeID'] == 1 ? '0.8 Miles' : item['storeID'] == 8 ?
                    '4.2 Miles':'1.6 Miles', style:
                kTitleStyle,),
              ),),
              // Divider(color: kBorderColor, indent: 15, endIndent: 15),
              // Expandable(
              //   title: 'Nutrition',
              //   trailing: Container(
              //     padding: const EdgeInsets.all(4),
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(10),
              //       color: kSecondaryColor,
              //     ),
              //     child: Text('100gr'),
              //   ), description: '',
              // ),
              Divider(color: kBorderColor, indent: 15, endIndent: 15),
              Expandable(
                title: 'Yelp Reviews',
                trailing: Row(
                  children: List.generate(
                      item['storeID'] == 6 ? 4 : 3,
                          (index) => Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 20,
                      )),
                ), description: '',
              ),
              SizedBox(height: 30),
              FavoriteWidget(),
            ],
          ),
        ),
      ),
    );
  }
}