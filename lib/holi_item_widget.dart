import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:holi_app/holi.model.dart';

class HoliWidgetItem extends StatelessWidget {
  HoliModel holiModel;
  Function function;

  HoliWidgetItem(this.holiModel, this.function);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(holiModel.title),
      onTap: () {
        function(holiModel);
      },
    );
  }
}
