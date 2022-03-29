import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:shopism/Core/Extensions/context_extensions.dart';

class HomePageDetails extends StatefulWidget {
  const HomePageDetails({Key? key}) : super(key: key);

  @override
  State<HomePageDetails> createState() => _HomePageDetailsState();
}

class _HomePageDetailsState extends State<HomePageDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        bottomNavigationBar: buildBottomNavBar(context),
        appBar: buildAppBar(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildImageContainer(context),
              buildTitleContent(context),
              Divider(),
              buildProductCountRow(context),
              Divider(),
              buildDescriptionColumn(context)
              // Text()
            ],
          ),
        ),
      ),
    );
  }

  Padding buildDescriptionColumn(BuildContext context) {
    return Padding(
      padding: context.paddingAllLow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Description",
            style: context.theme.textTheme.headline6,
          ),
          Padding(
            padding: context.paddingVerticalLow,
            child: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam suscipit massa quis lobortis aliquet. Aliquam erat tortor, lacinia sit amet volutpat vitae, sollicitudin non nisl. In scelerisque laoreet turpis vehicula fermentum.",
              style: context.theme.textTheme.subtitle1!
                  .copyWith(color: Colors.grey.shade600),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Text(
              "Read more",
              style: context.theme.textTheme.subtitle1!.copyWith(
                  color: context.theme.primaryColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Padding buildProductCountRow(BuildContext context) {
    return Padding(
      padding: context.paddingVerticalLow,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  context.paddingAllLow),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              shape: MaterialStateProperty.all<OutlinedBorder>(CircleBorder()),
            ),
            onPressed: () {},
            child: Icon(
              Icons.remove,
              color: context.theme.primaryColor,
            ),
          ),
          Padding(
            padding: context.paddingHorizontalLow,
            child: Text(
              "0",
              style: context.theme.textTheme.headline5!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  context.paddingAllLow),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              shape: MaterialStateProperty.all<OutlinedBorder>(CircleBorder()),
            ),
            onPressed: () {},
            child: Icon(
              Icons.add,
              color: context.theme.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Padding buildTitleContent(BuildContext context) {
    return Padding(
      padding: context.paddingAllLow,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Vegetable",
                  style: context.theme.textTheme.subtitle1!.copyWith(
                      color: Colors.grey.shade500, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: context.paddingOnlyTopVeryLow,
                  child: Text("Sainsbury's Broccoli Florets 160g",
                      style: context.theme.textTheme.headline5!
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 26)),
                ),
                Padding(
                  padding: context.paddingOnlyTopLow,
                  child: Row(
                    children: [
                      Text(
                        "\$10.50",
                        style: context.theme.textTheme.headline5!.copyWith(
                            color: context.theme.primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: context.paddingOnlyLeftLow,
                        child: Text(
                          "\$15.00",
                          style: context.theme.textTheme.subtitle1!.copyWith(
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.lineThrough),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        context.paddingAllLow),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      CircleBorder(),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white)),
                onPressed: () {},
                child: Icon(
                  Icons.favorite,
                  color: Colors.red,
                  // color: Colors.grey.shade400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildImageContainer(BuildContext context) {
    return Container(
      color: Colors.red,
      height: context.dynamicHeight(0.35),
      child: Image.network(
        "https://gaziantepetyemekleri.com/wp-content/uploads/2021/04/mevsim-salatasi-tarifi.jpg",
        fit: BoxFit.fill,
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.grey.shade500),
      elevation: 0,
      actions: [
        IconButton(
          icon: Icon(
            Icons.more_vert_rounded,
          ),
          onPressed: () {},
        )
      ],
    );
  }

  Container buildBottomNavBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: context.theme.scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ]),
      child: Padding(
        padding: EdgeInsets.all(context.dynamicHeight(0.02)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "\$30.50",
                  style: context.theme.textTheme.headline5!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  "2 items",
                  style: context.theme.textTheme.subtitle1!
                      .copyWith(color: Colors.grey.shade700),
                ),
              ],
            ),
            Padding(
              padding: context.paddingOnlyRightLow,
              child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                  ),
                  onPressed: () {},
                  child: Container(
                    padding: context.paddingAllLow,
                    margin: context.paddingAllVeryLow,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Add to Basket",
                          style: context.theme.textTheme.subtitle1!
                              .copyWith(color: Colors.white),
                        ),
                        Padding(
                          padding: context.paddingOnlyLeftLow,
                          child: Icon(MaterialCommunityIcons.basket),
                        ),
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
