import 'package:covid_tracker/View/country_detail_screen.dart';
import 'package:covid_tracker/services/states_services.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({Key? key}) : super(key: key);

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  StatesServices statesServices = StatesServices();
  TextEditingController searchWord = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: SearchBar(
              padding: const MaterialStatePropertyAll(
                EdgeInsets.symmetric(horizontal: 20),
              ),
              onChanged: (value) {
                setState(() {});
              },
              leading: const Icon(Icons.search),
              controller: searchWord,
              hintText: 'search Country name Here'.toUpperCase(),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: statesServices.fetchCountryWiseRecord(),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (!snapshot.hasData) {
                  return ListView.builder(
                    itemCount: 18,
                    itemBuilder: (context, index) => Shimmer.fromColors(
                      baseColor: Colors.grey.shade700,
                      highlightColor: Colors.grey.shade100,
                      child: ListTile(
                        leading: Container(
                          height: 80,
                          width: 80,
                          color: Colors.white,
                        ),
                        title: Center(
                            child: Container(
                          height: 10,
                          width: 200,
                          color: Colors.white,
                        )),
                        subtitle: Center(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            height: 10,
                            width: 170,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      String countryname = snapshot.data![index]['country'];
                      if (searchWord.text.isEmpty) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsScreen(
                                    name: snapshot.data![index]['country'].toString(),
                                    countryImage: snapshot.data![index]
                                    ['countryInfo']['flag'],
                                    cases: snapshot.data![index]['cases'].toString(),
                                    recovered: snapshot.data![index]['recovered'].toString(),
                                    deaths: snapshot.data![index]['deaths'].toString(),
                                    todayCases: snapshot.data![index]['todayCases'].toString(),
                                    activeCases: snapshot.data![index]['active'].toString(),
                                    population: snapshot.data![index]['population'].toString(),
                                    continent: snapshot.data![index]['continent'].toString()),
                              ),
                            );
                          },
                          child: Card(
                            shape: Border.all(
                                style: BorderStyle.solid,
                                width: 2,
                                strokeAlign: 10),
                            child: ListTile(
                              leading: Image(
                                height: 80,
                                width: 80,
                                image: NetworkImage(snapshot.data![index]
                                    ['countryInfo']['flag']),
                              ),
                              title: Text(snapshot.data![index]['country']),
                              subtitle: Text(
                                  snapshot.data![index]['cases'].toString()),
                            ),
                          ),
                        );
                      } else if (countryname.toLowerCase().contains(
                            searchWord.text.toLowerCase(),
                          )) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsScreen(
                                    name: snapshot.data![index]['country'].toString(),
                                    countryImage: snapshot.data![index]
                                    ['countryInfo']['flag'],
                                    cases: snapshot.data![index]['cases'].toString(),
                                    recovered: snapshot.data![index]['recovered'].toString(),
                                    deaths: snapshot.data![index]['deaths'].toString(),
                                    todayCases: snapshot.data![index]['todayCases'].toString(),
                                    activeCases: snapshot.data![index]['active'].toString(),
                                    population: snapshot.data![index]['population'].toString(),
                                    continent: snapshot.data![index]['continent'].toString()),
                              ),
                            );
                          },
                          child: Card(
                            shape: Border.all(
                                style: BorderStyle.solid,
                                width: 2,
                                strokeAlign: 10),
                            child: ListTile(
                              leading: Image(
                                height: 80,
                                width: 80,
                                image: NetworkImage(snapshot.data![index]
                                ['countryInfo']['flag']),
                              ),
                              title: Text(snapshot.data![index]['country']),
                              subtitle: Text(
                                  snapshot.data![index]['cases'].toString()),
                            ),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
