import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopism/Controllers/category_details_page_controller.dart';
import 'package:shopism/Core/Constants/Enums/getx_keys.dart';
import 'package:shopism/Core/Extensions/context_extensions.dart';
import 'package:shopism/Models/Category/category_model.dart';

import '../../Widgets/Home/popular_product_card.dart';

class CategoryDetailsView extends StatefulWidget {
  CategoryModel categoryModel;

  CategoryDetailsView({Key? key, required this.categoryModel}) : super(key: key);

  @override
  State<CategoryDetailsView> createState() => _CategoryDetailsViewState();
}

class _CategoryDetailsViewState extends State<CategoryDetailsView> {
  CategoryDetailsController _categoryDetailsController = Get.put(CategoryDetailsController(), tag: GetxKeys.CATEGORY_DETAILS_CONTOLLER.toString());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _categoryDetailsController.getCategoryItems(widget.categoryModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(
        "${widget.categoryModel.categoryName} Products",
        style: context.appTheme.textTheme.headline5,
      ),),
      body: SafeArea(
        child: Obx(
          () {
            if (_categoryDetailsController.isProductsLoading.isTrue) {
              return Padding(
                padding: EdgeInsets.all(12),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: Center(child: CircularProgressIndicator()))
                    ],
                  ),
                ),
              );
            } else {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: _categoryDetailsController.products.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 10, mainAxisExtent: 230),
                          itemBuilder: (context, index) {
                            return Container(
                              child: PopularProductCard(product: _categoryDetailsController.products[index]),
                            );
                          }),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
