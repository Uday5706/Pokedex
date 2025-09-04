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

  // ✅ Helper function for spacing between table rows
  TableRow _tableGap() {
    return const TableRow(
      children: [SizedBox(height: 10), SizedBox(height: 10)],
    );
  }

  @override
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
                onPressed: () => Navigator.pop(context),
              )
            : null,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Pokeball background
          Positioned(
            top: 10,
            right: MediaQuery.of(context).size.width / 2 - 75,
            child: Image.asset(
              'assets/images/pokeball.png',
              width: 150,
              fit: BoxFit.fitHeight,
            ),
          ),

          // Pokémon Image
          Positioned(
            top: 0,
            child: ClipRect(
              child: Align(
                alignment: Alignment.center,
                heightFactor: 0.8,
                child: CachedNetworkImage(
                  imageUrl: widget.pokedetails['img'],
                  height: 200,
                ),
              ),
            ),
          ),

          // Pokémon types
          Positioned(
            top: 180,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.pokedetails['type'].length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      widget.pokedetails['type'][index],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // White Info Card
          Positioned(
            top: 230,
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Table(
                columnWidths: const {
                  0: FixedColumnWidth(120),
                  1: FlexColumnWidth(),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment
                    .middle, // 👈 Align vertically center
                children: [
                  // Name
                  TableRow(
                    children: [
                      _labelText("Name"),
                      _valueText(widget.pokedetails['name']),
                    ],
                  ),
                  _tableGap(),

                  // Height
                  TableRow(
                    children: [
                      _labelText("Height"),
                      _valueText(widget.pokedetails['height']),
                    ],
                  ),
                  _tableGap(),

                  // Weight
                  TableRow(
                    children: [
                      _labelText("Weight"),
                      _valueText(widget.pokedetails['weight']),
                    ],
                  ),
                  _tableGap(),

                  // Weaknesses
                  TableRow(
                    children: [
                      _labelText("Weakness"),
                      SizedBox(
                        height: 35,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              widget.pokedetails['weaknesses']?.length ?? 0,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(right: 5),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: giveColor(
                                  widget.pokedetails['weaknesses'][index],
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                widget.pokedetails['weaknesses'][index],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  _tableGap(),

                  // Evolutions
                  TableRow(
                    children: [
                      _labelText("Evolutions"),
                      widget.pokedetails['next_evolution'] == null
                          ? _valueText("No Evolutions")
                          : SizedBox(
                              height: 35,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    widget
                                        .pokedetails['next_evolution']
                                        ?.length ??
                                    0,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.only(right: 5),
                                    padding: const EdgeInsets.symmetric(
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
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
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

  // ✅ Reusable label widget
  Widget _labelText(String text) => Text(
    text,
    style: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.black54,
    ),
  );

  // ✅ Reusable value widget
  Widget _valueText(String text) => Text(
    text,
    style: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
  );
}
