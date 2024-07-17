import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/detailScreen.dart';
import 'package:flutter_application_1/utilities/api.dart';

class track extends StatefulWidget {
  track({super.key});

  @override
  State<track> createState() => _trackState();
}

class _trackState extends State<track> {
  Service services = Service();

  TextEditingController text = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Country"),
      ),
      body: SafeArea(
          child: Column(
        children: [
          TextFormField(
            controller: text,
            autofocus: true,
            onChanged: (value) {
              setState(() {
                value == text.text;
              });
            },
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                hintText: 'Search for Country',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
              child: FutureBuilder(
            future: services.country(),
            builder: (context, AsyncSnapshot<List<dynamic>> Snapshot) {
              if (Snapshot.hasData) {
                return ListView.builder(
                  itemCount: Snapshot.data?.length,
                  itemBuilder: (context, index) {
                    String name = Snapshot.data![index]['country'];
                    if (text.text.isEmpty) {
                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(
                              image: Snapshot.data![index]['countryInfo']
                                  ['flag'],
                              name: Snapshot.data![index]['country'],
                              totalCases: Snapshot.data![index]['cases'],
                              totalRecovered: Snapshot.data![index]
                                  ['recovered'],
                              totalDeaths: Snapshot.data![index]['deaths'],
                              active: Snapshot.data![index]['active'],
                              test: Snapshot.data![index]['tests'],
                              todayRecovered: Snapshot.data![index]
                                  ['todayRecovered'],
                              critical: Snapshot.data![index]['critical'],
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(Snapshot.data![index]['country']),
                              leading: Image(
                                height: 69,
                                width: 69,
                                image: NetworkImage(Snapshot.data![index]
                                    ['countryInfo']['flag']),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (name
                        .toLowerCase()
                        .contains(text.text.toLowerCase())) {
                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(
                              image: Snapshot.data![index]['countryInfo']
                                  ['flag'],
                              name: Snapshot.data![index]['country'],
                              totalCases: Snapshot.data![index]['cases'],
                              totalRecovered: Snapshot.data![index]
                                  ['recovered'],
                              totalDeaths: Snapshot.data![index]['deaths'],
                              active: Snapshot.data![index]['active'],
                              test: Snapshot.data![index]['tests'],
                              todayRecovered: Snapshot.data![index]
                                  ['todayRecovered'],
                              critical: Snapshot.data![index]['critical'],
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(Snapshot.data![index]['country']),
                              leading: Image(
                                height: 69,
                                width: 69,
                                image: NetworkImage(Snapshot.data![index]
                                    ['countryInfo']['flag']),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                );
              } else {
                return Text('Loading');
              }
            },
          ))
        ],
      )),
    );
  }
}
