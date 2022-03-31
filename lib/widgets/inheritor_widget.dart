import 'package:aot_scout/models/titan.dart';
import 'package:flutter/material.dart';
import 'package:aot_scout/utilities/typedefs.dart';

class InheritorWidget extends StatelessWidget {
  const InheritorWidget(
      {Key? key,
      required this.changeForm,
      required this.changeScout,
      required this.titan})
      : super(key: key);

  final VoidCallback changeForm;
  final BoolCallback changeScout;
  final Titan titan;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatingActionButton(
                backgroundColor: Colors.green.shade900,
                foregroundColor: Colors.white,
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                ),
                onPressed: changeScout(false),
              ),
              TextButton(
                style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    backgroundColor: Colors.green[900],
                    primary: Colors.white,
                    fixedSize: const Size(double.infinity, 50)),
                onPressed: changeForm,
                child: const Text(
                  'Inheritor',
                ),
              ),
              FloatingActionButton(
                backgroundColor: Colors.green.shade900,
                foregroundColor: Colors.white,
                child: const Icon(
                  Icons.arrow_forward_ios_rounded,
                ),
                onPressed: changeScout(true),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Image.asset(
              titan.inheritorImage,
              fit: BoxFit.contain,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            titan.inheritorName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
