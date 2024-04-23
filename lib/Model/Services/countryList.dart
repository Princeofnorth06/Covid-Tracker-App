import 'package:covid_tracker/Model/Services/states_services.dart';
import 'package:covid_tracker/view/detailscreen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:covid_tracker/main.dart';
import 'package:flutter/material.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      backgroundColor: const Color.fromARGB(115, 65, 65, 65),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 152, 150, 150),
      ),
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: mq.height * 0.02,
          ),
          Padding(
            padding: EdgeInsets.all(mq.height * 0.02),
            child: TextFormField(
              style: const TextStyle(color: Colors.white),
              controller: searchController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                  hintText: 'Search Countries',
                  hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 202, 199, 199)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50))),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: statesServices.countriesListAPi(),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (!snapshot.hasData) {
                  return ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                            // Shimmer effect for loading state
                            baseColor: Colors.grey.shade700,
                            highlightColor: Colors.grey.shade100,
                            child: Column(
                              children: [
                                ListTile(
                                  title: Container(
                                    height: mq.height * 0.01,
                                    width: mq.width * 0.8,
                                    color: Colors.white,
                                  ),
                                  subtitle: Container(
                                    height: mq.height * 0.01,
                                    width: mq.width * 0.8,
                                    color: Colors.white,
                                  ),
                                  leading: Container(
                                    height: mq.height * 0.18,
                                    width: mq.width * 0.18,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ));
                      });
                } else {
                  final filteredCountries = snapshot.data!.where((countryData) {
                    final countryName = countryData['country'] as String;
                    return countryName
                        .toLowerCase()
                        .contains(searchController.text.toLowerCase());
                  }).toList();

                  return ListView.builder(
                    itemCount: filteredCountries.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailScreen(
                                            name: filteredCountries[index]
                                                ['country'],
                                            image: filteredCountries[index]
                                                    ['countryInfo']['flag']
                                                as String,
                                            totalDeaths:
                                                filteredCountries[index]
                                                    ['deaths'],
                                            totalCases: filteredCountries[index]
                                                ['cases'],
                                            active: filteredCountries[index]
                                                ['active'],
                                            critical: filteredCountries[index]
                                                ['critical'],
                                            tests: filteredCountries[index]
                                                ['tests'],
                                          )));
                            },
                            title: Text(
                              filteredCountries[index]['country'],
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              filteredCountries[index]['cases'].toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                            leading: Image(
                              height: mq.width * 0.18,
                              width: mq.width * 0.18,
                              image: NetworkImage(filteredCountries[index]
                                  ['countryInfo']['flag'] as String),
                            ),
                          ),
                          const Divider(color: Colors.grey),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      )),
    );
  }
}
