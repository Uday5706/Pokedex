import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PokeDetails extends StatefulWidget {
  final tag;
  final pokedetails;
  final Color color;
  const PokeDetails({
    super.key,
    this.tag,
    this.pokedetails,
    required this.color,
  });

  @override
  State<PokeDetails> createState() => _PokeDetailsState();
}

class _PokeDetailsState extends State<PokeDetails> {
  @override
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

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.color,
      appBar: AppBar(
        backgroundColor: widget.color,
        title: Text(
          widget.pokedetails['name'],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: widget.pokedetails['type'][0] == 'Electric'
                ? Colors.black87
                : Colors.white,
          ),
        ),
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: widget.pokedetails['type'][0] == 'Electric'
                      ? Colors.black87
                      : Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context); // goes back
                },
              )
            : null, // no back arrow if it's the first screen
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 10,
            right: MediaQuery.of(context).size.width / 2 - 75,
            child: Image.asset(
              'assets/images/pokeball.png',
              width: 150,
              fit: BoxFit.fitHeight,
            ),
          ),
          Positioned(
            top: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRect(
                  child: Align(
                    alignment: Alignment.center, // focus on center part
                    heightFactor: 0.8,
                    child: CachedNetworkImage(
                      imageUrl: widget.pokedetails['img'],
                      height: 200,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 180,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.pokedetails['type'].length,
                (index) => Container(
                  width: 80,
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      widget.pokedetails['type'][index],
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 230,
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 90,
                        child: Text(
                          "Name",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      SizedBox(width: 50),
                      Text(
                        widget.pokedetails['name'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 90,
                        child: Text(
                          "Height",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      SizedBox(width: 50),
                      Text(
                        widget.pokedetails['height'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 90,
                        child: Text(
                          "Weight",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      SizedBox(width: 50),
                      Text(
                        widget.pokedetails['weight'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 90,
                        child: Text(
                          "Weakness",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      SizedBox(width: 50),
                      widget.pokedetails['weaknesses'] != null
                          ? SizedBox(
                              height: 35,
                              width: 200,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    widget.pokedetails['weaknesses'].length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: giveColor(
                                        widget.pokedetails['weaknesses'][index],
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        widget.pokedetails['weaknesses'][index],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : Text(
                              "No Weaknesses",
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                              ),
                            ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 90,

                        child: Text(
                          "Evolutions",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      SizedBox(width: 50),
                      widget.pokedetails['next_evolution'] != null
                          ? SizedBox(
                              height: 35,
                              width: 200,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    widget.pokedetails['next_evolution'].length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: widget.color.withAlpha(200),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      widget
                                          .pokedetails['next_evolution'][index]['name'],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : SizedBox(width: 200, child: Text("No Evolution")),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
