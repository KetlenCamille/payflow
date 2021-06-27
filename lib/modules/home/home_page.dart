import 'package:flutter/material.dart';
import 'package:payflow/modules/extract/extract_page.dart';
import 'package:payflow/modules/my_slips/my_slips_page.dart';
import 'package:payflow/shared/models/user_model.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';

import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final UserModel user;
  const HomePage({ Key? key, required this.user }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(152), 
        child: Container(
          height: 52,
          color: AppColors.primary,
          child: Center(
            child: ListTile(
              title: Text.rich(
                TextSpan(text: "Hi, ", style: TextStyles.titleRegular,
                  children: [
                    TextSpan(text: "${widget.user.name}", style: TextStyles.titleBoldBackground),
                  ]
                ),
              ),
              subtitle: Text(
                "Keep your bill up to date",
                style: TextStyles.captionShape,
                ),
              trailing: Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(image:NetworkImage(widget.user.photoURL!))
                )
              )
            ),
          )
        ),
      ),
      body: [
        MySlipsPage(
          key: UniqueKey()
        ),
        ExtractPage(
          key: UniqueKey()
        )
      ][controller.currentPage],
      bottomNavigationBar: Container(
        height: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed:(){
                controller.setPage(0);
                setState((){

                });
              },
              icon: Icon(
                Icons.home,
                color: controller.currentPage == 0 ? AppColors.background : AppColors.body
              )
            ),
            GestureDetector(
              onTap: () async {
               await Navigator.pushNamed(context, "/barcode_scanner");
               setState((){

               });
              },
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Icon(
                  Icons.add_box_outlined,
                  color: controller.currentPage == 1 ? AppColors.background : AppColors.body
                ) 
              ),
            ),
            IconButton(
              onPressed:(){
                controller.setPage(1);
                setState((){
                  
                });
              }, 
              icon: Icon(
                Icons.description_outlined,
                color: AppColors.body
              )
            ),  
          ]
        )
      )
    );
  }
}