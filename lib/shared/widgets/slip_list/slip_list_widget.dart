import 'package:flutter/material.dart';
import 'package:payflow/shared/models/slip_model.dart';
import 'package:payflow/shared/widgets/boleto_tile/boleto_tile_widget.dart';
import 'package:payflow/shared/widgets/slip_list/slip_list_controller.dart';

class SlipListWidget extends StatefulWidget {
  final SlipListController controller;
  const SlipListWidget({ Key? key, required this.controller }) : super(key: key);

  @override
  _SlipListWidgetState createState() => _SlipListWidgetState();
}

class _SlipListWidgetState extends State<SlipListWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<SlipModel>>(
      valueListenable: widget.controller.slipsNotifier,
      builder:(_, slips, __) => Column(
        children: slips
          .map((e) => BoletoTileWidget(data: e))
          .toList(),
      )
    );
  }
}