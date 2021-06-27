import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/slip_list/slip_list_controller.dart';
import 'package:payflow/shared/widgets/slip_list/slip_list_widget.dart';

class ExtractPage extends StatefulWidget {
  const ExtractPage({ Key? key }) : super(key: key);

  @override
  _ExtractPageState createState() => _ExtractPageState();
}

class _ExtractPageState extends State<ExtractPage> {
  final controller = SlipListController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children:[
            Padding(
              padding: const EdgeInsets.only(top: 24, left: 24, right: 24 ),
              child: Row(
                children: [
                  Text(
                    "My extracts",
                    style: TextStyles.titleBoldHeading
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
              child: Divider(
                color: AppColors.stroke,
                height: 1,
                thickness: 1
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SlipListWidget(
                controller: controller
              ),
            )
          ]
        ),
      ),
    );
  }
}