import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:shopism/Core/Extensions/context_extensions.dart';
import 'package:shopism/Views/HomeDetails/View/home_page_details.dart';
import 'package:shopism/Widgets/Drawings/DiscountIconClipper.dart';

class PopularProductCard extends StatelessWidget {
  const PopularProductCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => HomePageDetails(),
            ));
      },
      child: Container(
        width: context.dynamicWidth(0.4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade400),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: context.dynamicHeight(0.15),
                  color: Colors.blue,
                  child: Image.network(
                    "https://gaziantepetyemekleri.com/wp-content/uploads/2021/04/mevsim-salatasi-tarifi.jpg",
                    fit: BoxFit.fill,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 50,
                      height: 20,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [Color(0xffF25D50), Color(0xffF2BB77)],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.favorite_outline,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
              ],
            ),
            Padding(
              padding: context.paddingAllLow,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Vegetable",
                      style: context.theme.textTheme.subtitle2!.copyWith(
                        color: Colors.grey,
                      )),
                  Text(
                    "Salad With Herbs Spices 50g",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.theme.textTheme.subtitle2!
                        .copyWith(fontSize: 18),
                  ),
                  Padding(
                    padding: context.paddingVerticalLow,
                    child: Row(
                      children: [
                        Text("\$7.50",
                            style: context.theme.textTheme.headline6!
                                .copyWith(color: context.theme.primaryColor)),
                        Padding(
                          padding: context.paddingOnlyLeftLow,
                          child: Text(
                            "\$10.00",
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
