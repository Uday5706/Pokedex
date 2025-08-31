import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:pokepedia/screens/pokemon_detals.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    if (mounted) {
      fetchData();
    }
  }

  @override
  List pokepedia = [];
  var pokepediaApi =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

  Color giveColor(String type) {
    return type == 'Fire'
        ? Colors.redAccent
        : type == 'Grass'
        ? Colors.greenAccent
        : type == 'Water'
        ? Colors.blueAccent
        : type == 'Electric'
        ? Colors.yellow
        : type == 'Rock'
        ? Colors.grey
        : type == 'Ground'
        ? Colors.brown
        : type == 'Bug'
        ? Colors.lightGreen
        : type == 'Psychic'
        ? Colors.indigo
        : type == 'Fighting'
        ? Colors.orange
        : type == 'Ghost'
        ? Colors.deepPurple
        : type == 'Normal'
        ? Colors.grey
        : type == 'Flying'
        ? Colors.lightBlue
        : type == 'Poison'
        ? Colors.purple
        : type == 'Ice'
        ? Colors.lightBlue
        : type == 'Dragon'
        ? Colors.deepPurpleAccent
        : Colors.pinkAccent;
  }

  Future<void> fetchData() async {
    try {
      var url = Uri.parse(
        "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json",
      );
      print("⏳ Fetching data from: ${url}");
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        setState(() {
          pokepedia = jsonData['pokemon'];
        });
        print("✅ Data fetched: ${jsonData}");
      } else {
        print("❌ Failed to fetch data. Status: ${response.statusCode}");
      }
    } catch (e) {
      print("⚠️ Error: $e");
    }
  }

  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: -50,
            right: -60,
            child: Image.asset(
              'assets/images/pokeball.png',
              width: 250,
              fit: BoxFit.fitHeight,
            ),
          ),
          Positioned(
            top: 50,
            left: 20,
            child: Text(
              "Pokedex",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
            top: 140,
            bottom: 0,
            child: Container(
              height: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 5),
              width: width,
              // color: Colors.redAccent,
              child: pokepedia.isNotEmpty
                  ? Column(
                      children: [
                        Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1.4,
                                ),
                            itemCount: pokepedia.length,
                            itemBuilder: (context, index) {
                              var type = pokepedia[index]['type'][0];
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PokeDetails(
                                        tag: index,
                                        pokedetails: pokepedia[index],
                                        color: giveColor(type),
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 200,
                                  margin: EdgeInsets.all(5),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: giveColor(type),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        child: Text(
                                          pokepedia[index]['name'],
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: type == 'Electric'
                                                ? Colors.black
                                                : Colors.white,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 30,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 5,
                                            horizontal: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white24,
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                          child: Text(
                                            type,
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: type == 'Electric'
                                                  ? Colors.black
                                                  : Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: -10,
                                        right: -10,
                                        child: Image.asset(
                                          'assets/images/pokeball.png',
                                          width: 100,
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                      Positioned(
                                        right: 0,
                                        bottom: 0,
                                        child: CachedNetworkImage(
                                          imageUrl: pokepedia[index]['img'],
                                          height: 90,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  : Center(
                      child: Lottie.asset(
                        'assets/animations/PokeLoader.json',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
