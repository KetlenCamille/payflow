import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/input_text/input_text_widget.dart';
import 'package:payflow/shared/widgets/set_label_buttons/set_label_buttons.dart';

import 'insert_boleto_controller.dart';

class InsertBoletoPage extends StatefulWidget {
  final String? barcode;
  const InsertBoletoPage({ Key? key, this.barcode }) : super(key: key);

  @override
  _InsertBoletoPageState createState() => _InsertBoletoPageState();
}

class _InsertBoletoPageState extends State<InsertBoletoPage> {
  final controller = InsertBoletoController();
  final moneyInputTextController = MoneyMaskedTextController(leftSymbol: "R\$", decimalSeparator: ",");
  final dueDateInputTextController = MaskedTextController(mask: "00/00/0000");
  final barcodeInputTextController = TextEditingController();

  @override
  void initState() {
    if(widget.barcode != null){
      barcodeInputTextController.text = widget.barcode!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: BackButton(
          color: AppColors.input,
        )
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 93),
                child: Text(
                  "Fill in the slip data",
                  style: TextStyles.titleBoldHeading,
                  textAlign: TextAlign.center
                )
              ),
              SizedBox(
                height: 24
              ),
              Form(
                key: controller.formKey,
                child: Column(
                  children:[
                    InputTextWidget(
                      label: "Slip name",
                      icon: Icons.description_outlined,
                      validator: controller.validateName,
                      onChanged: (value){
                        controller.onChange(name: value);
                      }
                    ),
                    InputTextWidget(
                      controller: dueDateInputTextController,
                      label: "Due date",
                      icon: FontAwesomeIcons.timesCircle,
                      validator: controller.validateDueDate,
                      onChanged: (value){
                        controller.onChange(dueDate: value);
                      }
                    ),
                    InputTextWidget(
                      controller: moneyInputTextController,
                      label: "Value",
                      icon: FontAwesomeIcons.wallet,
                      validator: (_) => controller.validateValue(moneyInputTextController.numberValue),
                      onChanged: (value){
                        controller.onChange(value: moneyInputTextController.numberValue);
                      }
                    ),
                    InputTextWidget(
                      controller: barcodeInputTextController,
                      label: "Slip code",
                      icon: FontAwesomeIcons.barcode,
                      validator: controller.validateSlipCode,
                      onChanged: (value){
                        controller.onChange(barcode: value);
                      }
                    ),
                  ]
                )
              )
            ]
          ),
        ),
      ),
      bottomNavigationBar: SetLabelButtons(
        enableSecondaryColor: true,
        primaryLabel: "Cancel",
        primaryOnPressed: (){
          Navigator.pop(context);
        },
        secondaryLabel: "Insert",
        secondaryOnPressed: () async {
          await controller.createSlip();
          Navigator.pop(context);
        },
      )
    );
  }
}