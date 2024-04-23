import 'package:covid_tracker/home.dart';
import 'package:covid_tracker/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DetailScreen extends StatefulWidget {
  final String name, image;
  final int totalCases, totalDeaths, active, critical, tests;
  const DetailScreen(
      {super.key,
      required this.name,
      required this.image,
      required this.totalCases,
      required this.totalDeaths,
      required this.active,
      required this.critical,
      required this.tests});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(115, 65, 65, 65),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 152, 150, 150),
        title: Text(
          widget.name,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              widget.image,
              height: mq.width * 0.3,
              width: mq.width * 0.3,
            ),
            SizedBox(
              height: mq.height * 0.1,
            ),
            Card(
              color: const Color.fromARGB(255, 136, 135, 135),
              child: Column(
                children: [
                  ReRow(
                      title: 'Total Case', value: widget.totalCases.toString()),
                  ReRow(
                      title: 'Total Deaths',
                      value: widget.totalDeaths.toString()),
                  ReRow(title: 'Active', value: widget.active.toString()),
                  ReRow(title: 'Critical', value: widget.critical.toString()),
                  ReRow(title: 'Test Done', value: widget.tests.toString()),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
