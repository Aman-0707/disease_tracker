import 'package:flutter_application_1/models/c19model.dart';
import 'package:flutter_application_1/screens/trackcountry.dart';
import 'package:flutter_application_1/utilities/api.dart';
import 'package:pie_chart/pie_chart.dart';

import 'package:flutter/material.dart';

class Myhpp extends StatefulWidget {
  const Myhpp({super.key});

  @override
  State<Myhpp> createState() => _MyhppState();
}

class _MyhppState extends State<Myhpp> {
  Service services = Service();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                FutureBuilder(
                  future: services.fetch(),
                  builder: (context, AsyncSnapshot<Covid> snapshot) {
                    if (!snapshot.hasData) {
                      return Text("loading");
                    } else {
                      return Column(
                        children: [
                          PieChart(
                            dataMap: {
                              'TotalCases': double.parse(
                                  snapshot.data!.cases!.toString()),
                              'Recovered': double.parse(
                                  snapshot.data!.recovered!.toString()),
                              'Deaths': double.parse(
                                  snapshot.data!.deaths!.toString()),
                            },
                            chartValuesOptions: ChartValuesOptions(
                                showChartValuesInPercentage: true),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Card(
                            child: Column(
                              children: [
                                reuse(
                                    title: 'Total Cases',
                                    Value: snapshot.data!.cases!.toString()),
                                reuse(
                                    title: 'Total Recovered',
                                    Value:
                                        snapshot.data!.recovered!.toString()),
                                reuse(
                                    title: 'Total Deaths',
                                    Value: snapshot.data!.deaths!.toString()),
                                reuse(
                                    title: 'Active Cases',
                                    Value: snapshot.data!.active!.toString()),
                                reuse(
                                    title: 'Todays Case',
                                    Value:
                                        snapshot.data!.todayCases!.toString()),
                                reuse(
                                    title: 'Todays Death',
                                    Value:
                                        snapshot.data!.todayDeaths!.toString()),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
                Container(
                  height: 50,
                  width: 1000,
                  color: Colors.blue[100],
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => track(),
                          ));
                    },
                    child: Center(
                      child: Text(
                        'Track Country',
                        style: TextStyle(color: Colors.black, fontSize: 17),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class reuse extends StatelessWidget {
  String title;
  String Value;

  reuse({super.key, required this.title, required this.Value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(color: Colors.black, fontSize: 17),
              ),
              Text(
                Value,
                style: TextStyle(color: Colors.blueAccent),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Divider(),
        ],
      ),
    );
  }
}
