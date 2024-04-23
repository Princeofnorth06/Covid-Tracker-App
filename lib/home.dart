import 'package:covid_tracker/Model/Services/states_services.dart';
import 'package:covid_tracker/Model/Services/utilities/world_states_model.dart';
import 'package:covid_tracker/Model/Services/countrylist.dart';
import 'package:covid_tracker/main.dart';
import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late final AnimationController animationController =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(mq.height * 0.013),
          child: Column(
            children: [
              SizedBox(height: mq.height * 0.01),
              FutureBuilder(
                future: statesServices.fetchWorldStatesRecords(),
                builder: (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                  if (!snapshot.hasData) {
                    return SpinKitFadingCircle(
                      color: Colors.white,
                      size: 50,
                      controller: animationController,
                    );
                  } else {
                    return Column(
                      children: [
                        SizedBox(
                          height: mq.width / 1.6, // Fixed height for PieChart
                          child: PieChart(
                            ringStrokeWidth: 15,
                            dataMap: {
                              'Total Test':
                                  double.parse(snapshot.data!.tests.toString()),
                              "Total Cases":
                                  double.parse(snapshot.data!.cases.toString()),
                              'Recovered': double.parse(
                                  snapshot.data!.recovered.toString()),
                              "Total Death": double.parse(
                                  snapshot.data!.deaths.toString()),
                            },
                            chartValuesOptions: const ChartValuesOptions(
                                showChartValuesInPercentage: true),
                            legendOptions: const LegendOptions(
                              showLegendsInRow: false,
                              legendTextStyle: TextStyle(color: Colors.white),
                            ),
                            chartRadius: mq.width / 3.2,
                            animationDuration:
                                const Duration(milliseconds: 1200),
                            chartType: ChartType.ring,
                            colorList: const [
                              Colors.red,
                              Colors.orange,
                              Colors.green,
                              Colors.blue,
                            ],
                          ),
                        ),
                        Card(
                          color: Color.fromARGB(255, 136, 135, 135),
                          child: Column(
                            children: [
                              ReRow(
                                  title: 'Population',
                                  value: snapshot.data!.population.toString()),
                              ReRow(
                                  title: 'Total Test',
                                  value: snapshot.data!.tests.toString()),
                              ReRow(
                                  title: 'Total Cases',
                                  value: snapshot.data!.cases.toString()),
                              ReRow(
                                  title: 'Recovered',
                                  value: snapshot.data!.recovered.toString()),
                              ReRow(
                                  title: 'Total Deaths',
                                  value: snapshot.data!.deaths.toString()),
                              ReRow(
                                  title: 'Active Cases',
                                  value: snapshot.data!.active.toString()),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: mq.height * 0.02,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CountriesList()));
                          },
                          style: ElevatedButton.styleFrom(
                            side: const BorderSide(color: Colors.white),
                            backgroundColor:
                                const Color.fromARGB(255, 43, 44, 44),
                          ),
                          child: const Text(
                            'Track Countries',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReRow extends StatelessWidget {
  final String title, value;
  const ReRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Text(value,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 31, 32, 32),
                      fontWeight: FontWeight.bold))
            ],
          ),
          const Divider()
        ],
      ),
    );
  }
}
