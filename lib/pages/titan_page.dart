import 'package:aot_scout/models/titan.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TitanPage extends StatefulWidget {
  static String page = '/TitanPage';

  const TitanPage({Key? key}) : super(key: key);

  @override
  State<TitanPage> createState() => _TitanPageState();
}

class _TitanPageState extends State<TitanPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Titan _titan;
  late String perviousForm;
  late String perviousName;
  @override
  void initState() {
    super.initState();
    _titan = context.read<Titan>();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    perviousForm = _titan.formImage;
    perviousName = _titan.formName;
  }

  void _changeForm() {
    setState(() {
      perviousForm = _titan.formImage;
      perviousName = _titan.formName;
      _titan.changeForm();
      _controller.reset();
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: AnimatedCrossFade(
              crossFadeState: _titan.form
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              secondChild: Text(
                _titan.inheritorName,
              ),
              duration: const Duration(seconds: 1),
              firstChild: Text(
                _titan.titanName,
              ),
            ),
          ),
        ),
      ),
      body: MediaQuery.of(context).orientation == Orientation.portrait
          ? Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    _titan.formName,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                Expanded(
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (_, child) {
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Opacity(
                              opacity: 1 - _controller.value,
                              child: Image.asset(
                                perviousForm,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Opacity(
                              opacity: _controller.value,
                              child: Hero(
                                tag: _titan.titanName,
                                child: Image.asset(
                                  _titan.formImage,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 20,
                    ),
                    child: Text(
                      _titan.formName,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (_, child) {
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Opacity(
                              opacity: 1 - _controller.value,
                              child: Image.asset(
                                perviousForm,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Opacity(
                              opacity: _controller.value,
                              child: Hero(
                                tag: _titan.titanName,
                                child: Image.asset(
                                  _titan.formImage,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
      floatingActionButtonLocation:
          MediaQuery.of(context).orientation == Orientation.portrait
              ? null
              : FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _changeForm,
        icon: const Icon(Icons.change_circle),
        label: const Text('Change Form'),
      ),
    );
  }
}
