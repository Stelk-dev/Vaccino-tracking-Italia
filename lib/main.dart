import 'package:flutter/material.dart';
import 'Getx_api.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
    debugShowMaterialGrid: false,
    darkTheme: ThemeData.dark(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int index = 0;
  bool _refresh = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vaccino tracking'),
        actions: [
          Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  'ITA',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      letterSpacing: 1),
                ),
              ))
        ],
      ),
      body: _refresh
          ? Container()
          : RefreshIndicator(
              onRefresh: () async {
                setState(() => _refresh = true);
                await Future.delayed(Duration(milliseconds: 1));
                setState(() => _refresh = false);
              },
              child: index == 0
                  ? ListView.builder(
                      padding: EdgeInsets.all(2),
                      itemCount: 3,
                      itemBuilder: (_, index) {
                        if (index == 0)
                          return totalVaxWG();
                        else if (index == 1)
                          return maleFemaleVaxWG();
                        else
                          return ageVaxWG();
                      },
                    )
                  : regionVaxWG(),
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        selectedItemColor: Colors.lightBlueAccent,
        backgroundColor: Color.fromRGBO(32, 32, 32, 1),
        unselectedItemColor: Colors.grey,
        iconSize: 30,
        onTap: (value) => setState(() => index = value),
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              title: Container()),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.gps_fixed,
              ),
              title: Container()),
        ],
      ),
    );
  }
}

Widget totalVaxWG() {
  return FutureBuilder(
      future: totalVax(),
      builder: (context, snapshot) {
        if (snapshot.hasData)
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  TextSpan(
                    text: 'Vaccini totali\n',
                    style: TextStyle(
                        fontSize: 23,
                        color: Colors.white70,
                        fontWeight: FontWeight.w800),
                  ),
                  TextSpan(
                    text:
                        '${MoneyMaskedTextController(initialValue: snapshot.data.toDouble(), decimalSeparator: '', thousandSeparator: '.', precision: 0).text}',
                    style: TextStyle(
                        fontSize: 28,
                        color: Colors.greenAccent,
                        fontWeight: FontWeight.bold),
                  )
                ]),
              ),
            ),
          );
        else
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(child: CircularProgressIndicator()),
          );
      });
}

Widget maleFemaleVaxWG() {
  Widget cardStyle(String sex, String data, Color color) {
    return Card(
      child: Center(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(children: [
            TextSpan(
              text: '$sex\n',
              style: TextStyle(
                  fontSize: 23,
                  color: Colors.white70,
                  fontWeight: FontWeight.w800),
            ),
            TextSpan(
              text: data,
              style: TextStyle(
                  fontSize: 35, color: color, fontWeight: FontWeight.bold),
            )
          ]),
        ),
      ),
    );
  }

  return FutureBuilder(
      future: genderVax(),
      builder: (context, snapshot) {
        return GridView.count(
          crossAxisCount: 2,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            snapshot.hasData
                ? cardStyle(
                    'Maschi',
                    MoneyMaskedTextController(
                            initialValue: snapshot.data[0].toDouble(),
                            decimalSeparator: '',
                            thousandSeparator: '.',
                            precision: 0)
                        .text,
                    Colors.redAccent)
                : Center(child: CircularProgressIndicator()),
            snapshot.hasData
                ? cardStyle(
                    'Femmine',
                    MoneyMaskedTextController(
                            initialValue: snapshot.data[1].toDouble(),
                            decimalSeparator: '',
                            thousandSeparator: '.',
                            precision: 0)
                        .text,
                    Colors.purpleAccent)
                : Center(child: CircularProgressIndicator()),
          ],
        );
      });
}

Widget ageVaxWG() {
  return FutureBuilder(
    future: ageVaxCount(),
    builder: (_, snapshot) {
      if (snapshot.hasData)
        return Column(
          children: [
            Card(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Vaccinazioni per età',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white70,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            for (var item in snapshot.data)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${item['C'][0]}:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '${MoneyMaskedTextController(initialValue: item['C'][1].toDouble(), decimalSeparator: '', thousandSeparator: '.', precision: 0).text}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      )
                    ],
                  ),
                ),
              )
          ],
        );
      else
        return Center(
          child: CircularProgressIndicator(),
        );
    },
  );
}

Widget regionVaxWG() {
  return FutureBuilder(
      future: regionVaxCount(),
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                padding: EdgeInsets.all(2),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) => Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          snapshot.data[index]['C'][0].toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 17),
                        ),
                        Text(
                          MoneyMaskedTextController(
                                  initialValue:
                                      snapshot.data[index]['C'][1].toDouble(),
                                  decimalSeparator: '',
                                  thousandSeparator: '.',
                                  precision: 0)
                              .text,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              );
      });
}
