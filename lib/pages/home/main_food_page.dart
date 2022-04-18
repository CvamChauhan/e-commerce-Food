import 'package:flutter/material.dart';
import 'package:food_delivery/pages/home/food_page_body.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  _MainFoodPageState createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          color: Colors.grey.withOpacity(.05),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: Dimensions.width20,
                    vertical: Dimensions.height10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BigText(text: "India"),
                        Row(
                          children: [
                            SmallText(
                              text: "Faridabad",
                              color: Colors.black54,
                            ),
                            Icon(Icons.arrow_drop_down)
                          ],
                        )
                      ],
                    ),
                    RawMaterialButton(
                      onPressed: () {},
                      constraints: BoxConstraints(
                          maxHeight: Dimensions.height45,
                          maxWidth: Dimensions.height45),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius15)),
                      fillColor: AppColors.mainColor,
                      child: const Center(
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: FoodPageBody(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
