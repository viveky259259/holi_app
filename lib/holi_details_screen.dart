import 'package:flutter/material.dart';
import 'package:holi_app/holi.model.dart';

class HoliDetails extends StatelessWidget {
  HoliModel model;
  HoliDetails(this.model);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(model.title),
      ),
      body: Text(model.description),
    );
  }
}
