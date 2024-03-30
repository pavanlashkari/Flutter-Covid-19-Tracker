import 'package:covid_tracker/View/countries_List_screen.dart';
import 'package:covid_tracker/model/WorldStateModel.dart';
import 'package:covid_tracker/services/states_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStateScreen extends StatefulWidget {
  const WorldStateScreen({Key? key}) : super(key: key);

  @override
  State<WorldStateScreen> createState() => _WorldStateScreenState();
}

class _WorldStateScreenState extends State<WorldStateScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 4))
        ..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorlist = <Color>[
    const Color(0xff4d77be),
    const Color(0xff3d8d39),
    const Color(0xff963f46),
  ];

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Covid-19 Tracker'),
        automaticallyImplyLeading: false,
      ),
        body: SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .03,
          ),    
          FutureBuilder(
            future: statesServices.fetchWorldStatesRecords(),
            builder: (context, AsyncSnapshot<WorldStateModel> snapshot) {
              if (!snapshot.hasData) {
                return Expanded(
                  flex: 1,
                  child: SpinKitFadingCircle(
                    controller: _controller,
                    color: Colors.white,
                    size: 50,
                  ),
                );
              } else {
                return Column(
                  children: [
                    PieChart(
                      dataMap: {
                        "Total Cases": snapshot.data!.cases!.toDouble(),
                        "Recovered": snapshot.data!.recovered!.toDouble(),
                        "Deaths": snapshot.data!.deaths!.toDouble(),
                      },
                      chartValuesOptions: const ChartValuesOptions(
                          showChartValuesInPercentage: true),
                      animationDuration: const Duration(seconds: 2),
                      colorList: colorlist,
                      legendOptions: const LegendOptions(
                          legendPosition: LegendPosition.left),
                      chartType: ChartType.ring,
                      chartRadius: MediaQuery.of(context).size.width / 3.2,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              ReusableRow(
                                  title: 'Total',
                                  value: snapshot.data!.cases!
                                      .toDouble()
                                      .toString()),
                              ReusableRow(
                                  title: 'Recovered',
                                  value: snapshot.data!.recovered!
                                      .toDouble()
                                      .toString()),
                              ReusableRow(
                                  title: 'Death',
                                  value: snapshot.data!.deaths!
                                      .toDouble()
                                      .toString()),
                              ReusableRow(
                                  title: "Today's Case",
                                  value: snapshot.data!.todayCases!
                                      .toDouble()
                                      .toString()),
                              ReusableRow(
                                  title: "Today's Recovered",
                                  value: snapshot.data!.todayRecovered!
                                      .toDouble()
                                      .toString()),
                              ReusableRow(
                                  title: "Today's Death",
                                  value: snapshot.data!.todayDeaths!
                                      .toDouble()
                                      .toString()),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CountriesListScreen(),
                            )),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xff38d530),
                          ),
                          child: const Center(child: Text('Track Countries')),
                        ),
                      ),
                    )
                  ],
                );
              }
            },
          ),
        ],
      ),
    ));
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
