import 'package:flutter/material.dart';
import 'package:payflow/modules/barcode_scanner/barcode_scanner_controller.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/bottom_sheet/bottom_sheet_widget.dart';
import 'package:payflow/shared/widgets/set_label_buttons/set_label_buttons.dart';

import 'barcode_scanner_status.dart';

class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({ Key? key }) : super(key: key);

  @override
  _BarcodeScannerPageState createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  final controller = BarcodeScannerController();
  @override
  void initState() {
    controller.getAvailableCameras();
    controller.statusNotifier.addListener(() { 
      if(controller.status.hasBarcode){
        Navigator.pushReplacementNamed(context, "/insert_boleto");
      }
    });
    super.initState();
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      left: true,
      right: true,
      child: Stack(
        children: [
            RotatedBox(
            quarterTurns: 1,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.black,
                title: Text(
                  "Scan the slip's barcode",
                  style: TextStyles.buttonBackground
                ),
                centerTitle: true, 
                leading: BackButton(
                  color: AppColors.background
                )
              ),
              body: Column(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.black.withOpacity(0.6)
                    )
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.transparent
                    )
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.black
                    )
                  )
                ]
              ),
              bottomNavigationBar: SetLabelButtons(
                primaryLabel: "Insert slip code",
                primaryOnPressed: (){},
                secondaryLabel: "Add from gallery",
                secondaryOnPressed: (){},
              )
            ),
          ),
           ValueListenableBuilder<BarcodeScannerStatus>(
            valueListenable: controller.statusNotifier, builder: (_,status,__){
              if(status.hasError){
                return BottomSheetWidget(
                  title: "Could not identify a slip code.",
                  subtitle: "Try scanning again or enter your slip code.",
                  primaryLabel: "Scan again",
                  primaryOnPressed: (){
                    controller.getAvailableCameras();
                  },
                  secondaryLabel: "Enter code",
                  secondaryOnPressed: (){}
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}