import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:holi_app/holi.model.dart';
import 'package:holi_app/holi_details_screen.dart';
import 'package:holi_app/holi_item_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Holi App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: HoliApp(),
    );
  }
}

class HoliApp extends StatefulWidget {
  @override
  HoliAppState createState() => HoliAppState();
}

class HoliAppState extends State<HoliApp> {
  List<HoliModel> holiModels;

  @override
  void initState() {
    super.initState();
    holiModels = List();
    holiModels.add(HoliModel(" Apply Coconut and Mustard Oil",
        "Since dry skin easily allows chemicals to penetrate the body, always apply coconut oil(preferably) on your entire body and apply mustard oil on your hair, at least an hour before playing. Note: It is very important to oil between fingertips, near fingernails and behind the ear."));

    holiModels.add(HoliModel(" Don't Forget Sunscreen",
        "SDon’t forget to apply sunscreen after oiling your body, and make sure it is gel based, waterproof and of SPF 25. If you’re in the sun for more than 3 hours, remember to re-apply the sunscreen."));

    holiModels.add(HoliModel("Apply Nail Paint",
        "Apply a thick coat of dark nail paint, preferable the darkest colour possible, and remove it after playing Holi."));
  }

  void navigateToDetails(model) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (cotext) => HoliDetails(model)));
  }

  Future<List<HoliModel>> getdata() async {
    List<HoliModel> holi = [];

    await Firestore.instance
        .collection("details")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((DocumentSnapshot doc) {
        HoliModel holi_model = HoliModel(doc["title"], doc["description"]);
        holi.add(holi_model);
      });
    });
    return holi;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Holi App"),
        ),
        body: FutureBuilder(
            future: getdata(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: CircularProgressIndicator(),
                );
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
//
//                  HoliModel h = HoliModel(snapshot.data[index]['title'],
//                      snapshot.data[index]['description']);
                  return HoliWidgetItem(snapshot.data[index], navigateToDetails);
                },
              );
            }));
  }
}
