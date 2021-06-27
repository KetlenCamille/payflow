import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:payflow/shared/models/slip_model.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/slip_info/slip_info_widget.dart';
import 'package:payflow/shared/widgets/slip_list/slip_list_controller.dart';
import 'package:payflow/shared/widgets/slip_list/slip_list_widget.dart';

class MySlipsPage extends StatefulWidget {
  const MySlipsPage({ Key? key }) : super(key: key);

  @override
  _MySlipsPageState createState() => _MySlipsPageState();
}

class _MySlipsPageState extends State<MySlipsPage> {
  final controller = SlipListController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children:[
            Stack(
              children: [
                Container(
                  color: AppColors.primary,
                  height: 40, 
                  width: double.maxFinite
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ValueListenableBuilder<List<SlipModel>>(
                    valueListenable: controller.slipsNotifier,
                    builder: (_, slips, __) => 
                      AnimatedCard(
                        direction: AnimatedCardDirection.top,
                        child: SlipInfoWidget(size: slips.length)))
                )  
              ]
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24, left: 24, right: 24 ),
              child: Row(
                children: [
                  Text(
                    "My slips",
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