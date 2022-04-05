import 'dart:math';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  String _theState = "0";
  int _actualWordType = 0;
  int _score = 0;
  var _colorState = Colors.blue;
  final _random = new Random();
  bool _isEnabled = true;

  int next(int min, int max) => min + _random.nextInt(max - min);

  @override
  void initState() {
    super.initState();
    setRandomWord();
  }

  void _enableButton() {
    setState(() {
      _isEnabled = true;
    });
  }

  void _disableButton() {
    setState(() {
      _isEnabled = false;
    });
  }

  void _changeword(String word) {
    setState(() {
      _theState = word;
    });
  }

  void _changeColorToRed() {
    setState(() {
      _colorState = Colors.red;
    });
  }

  void _changeColorToBlue() {
    setState(() {
      _colorState = Colors.blue;
    });
  }

  void _resetScore() {
    setState(() {
      _score = 0;
    });
  }

  void _incrementScore() {
    setState(() {
      _score++;
    });
  }

  void setRandomWord() {
    var option = next(0, 2);
    var randomItem = "";
    if (option == 0) {
      print("change to noun");
      randomItem = (nouns.toList()..shuffle()).first;
      _changeword(randomItem);
      _actualWordType = 1;
    } else {
      print("change to adjective");
      randomItem = (adjectives.toList()..shuffle()).first;
      _changeword(randomItem);
      _actualWordType = 2;
    }
  }

  Future<void> _onPressed(int type) async {
    if (type == _actualWordType) {
      _incrementScore();
      setRandomWord();
    } else {
      if (_score > 0) {
        _changeColorToRed();
        _disableButton();
        await Future.delayed(const Duration(seconds: 3));
        setState(() {
          _score--;
        });
        setRandomWord();
        _changeColorToBlue();
        _enableButton();
      } else {
        _changeColorToRed();
        _disableButton();
        await Future.delayed(const Duration(seconds: 3));
        setRandomWord();
        _changeColorToBlue();
        _enableButton();
      }
    }
  }

  void _onReset() {
    setRandomWord();
    _resetScore();
    _changeColorToBlue();
    _enableButton();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text("Random Words"),
        title:
            const Text('Random Words', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.yellow,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.end,
              //children: [Text("Score: $_score")]),
              children: [
                Text('Score: $_score',
                    style: TextStyle(color: Colors.blue, fontSize: 20))
              ]),
          new Text(
            '$_theState',
            style: TextStyle(
              color: _colorState,
              fontSize: 35,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: _isEnabled ? () => _onPressed(1) : null,
                child: Text('Noun'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.purple,
                  onPrimary: Colors.yellow,
                ),
              ),
              ElevatedButton(
                  onPressed: _isEnabled ? () => _onPressed(2) : null,
                  child: Text('Adjective'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
                    onPrimary: Colors.yellow,
                  )),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            IconButton(icon: Icon(Icons.refresh), onPressed: () => _onReset())
          ]),
        ],
      ),
    );
  }
}

