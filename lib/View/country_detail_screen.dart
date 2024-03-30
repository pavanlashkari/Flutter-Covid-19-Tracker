import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  String name;
  String countryImage;
  String cases;
  String deaths;
  String recovered;
  String todayCases;
  String activeCases;
  String population;
  String continent;

  DetailsScreen({
    Key? key,
    required this.name,
    required this.countryImage,
    required this.cases,
    required this.recovered,
    required this.deaths,
    required this.todayCases,
    required this.activeCases,
    required this.population,
    required this.continent,
  }) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          const SizedBox(
            height: 30,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 80.0,
                backgroundImage: NetworkImage(widget.countryImage),
                backgroundColor: Colors.transparent,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.name.toUpperCase(),
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          ReusableRow(title: 'TOTAL CASES', value: widget.cases),
          ReusableRow(title: 'TOTAL RECOVERED', value: widget.recovered),
          ReusableRow(title: 'TOTAL DEATHS', value: widget.deaths),
          ReusableRow(title: 'ACTIVE CASES', value: widget.activeCases),
          ReusableRow(title: 'TODAY CASES', value: widget.todayCases),
          ReusableRow(title: 'COUNTRY POPULATION', value: widget.population),
          ReusableRow(title: 'CONTINENT', value: widget.continent),
        ],
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;

  ReusableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title),
                Text(value),
              ],
            )
          ],
        ),
      ),
    );
  }
}
