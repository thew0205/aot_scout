import 'package:aot_scout/models/scout.dart';
import 'package:flutter/material.dart';

import 'package:aot_scout/utilities/typedefs.dart';

class ScoutWidget extends StatelessWidget {
  const ScoutWidget(
      {Key? key, required Scout scout, required BoolCallback onPressed})
      : _scout = scout,
        _onPressed = onPressed,
        super(key: key);

  final Scout _scout;
  final BoolCallback _onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                // Padding(
                //   padding: const EdgeInsets.only(left: 20.0),
                //   child: FloatingActionButton(
                //     backgroundColor: Colors.green[900],
                //     foregroundColor: Colors.white,
                //     child: const Icon(
                //       Icons.arrow_back_ios_new_rounded,
                //     ),
                //     onPressed: _onPressed(false),
                //   ),
                // ),
                Expanded(
                  child: Center(
                    child: Text(
                      '#${_scout.position}',
                      style: TextStyle(
                        color: Colors.green[900],
                        fontSize: 40,
                        fontFamily: 'CabinSketch',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: FloatingActionButton(
                    backgroundColor: Colors.green[900],
                    foregroundColor: Colors.white,
                    child: const Icon(
                      Icons.arrow_forward_ios_rounded,
                    ),
                    onPressed: _onPressed(true),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset(_scout.image, fit: BoxFit.contain),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _scout.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
