import 'package:flutter/material.dart';
import 'package:flutter_tic_tac_toe/my_styles.dart';

void main() {

  runApp(const XOGame());
}

class XOGame extends StatelessWidget {
  const XOGame({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      title: 'Tic tac toe',
      home: const XOGamePage(title: 'X & O'),
    );
  }
}

class XOGamePage extends StatefulWidget {
  const XOGamePage({super.key, required this.title});

  final String title;

  @override
  State<XOGamePage> createState() => _XOGamePageState();
}

class _XOGamePageState extends State<XOGamePage> {
  bool isTurn = false;

  int oScore = 0;
  int xScore = 0;
  int count = 0;

  List<String> changeXO = ['', '', '', '', '', '', '', '', ''];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_circle_outline, color: Colors.amberAccent, size: 30),
            Icon(Icons.add_circle_outline, color: Colors.amberAccent, size: 30),
            Icon(Icons.add_circle_outline, color: Colors.amberAccent, size: 30),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const Text('Игрок X', style: txtStyle),
                        ),
                        Text(xScore.toString(), style: txtStyle)
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Игрок O',
                            style: txtStyle,
                          ),
                        ),
                        Text(oScore.toString(), style: txtStyle)
                      ],
                    )
                  ],
                ),
              )),
          Expanded(
              flex: 3,
              child: GridView.builder(
                  itemCount: changeXO.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (BuildContext ctx, int index) {
                    return GestureDetector(
                      onTap: () => _setXorO(index),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueGrey)),
                        child: Center(
                          child: Text(changeXO[index], style: txtStyle,),
                        ),
                      ),
                    );
                  }))
        ],
      ),
    );
  }

  void _setXorO(int index) {
    if (isTurn && changeXO[index] == '') {
      setState(() {
        changeXO[index] = 'o';
        isTurn = !isTurn;
        count++;
      });
    } else if (!isTurn && changeXO[index] == '') {
      setState(() {
        changeXO[index] = 'x';
        isTurn = !isTurn;
        count++;
      });
    }

    _checkWinner();
  }

  void _checkWinner() {
    //Горизонтали
    if (changeXO[0] != '' &&
        changeXO[0] == changeXO[1] &&
        changeXO[0] == changeXO[2]) {
      _showDialog(winner: changeXO[0]);
    }

    if (changeXO[3] != '' &&
        changeXO[3] == changeXO[4] &&
        changeXO[3] == changeXO[5]) {
      _showDialog(winner: changeXO[3]);
    }

    if (changeXO[6] != '' &&
        changeXO[6] == changeXO[7] &&
        changeXO[6] == changeXO[8]) {
      _showDialog(winner: changeXO[6]);
    }

    //Вертикали
    if (changeXO[0] != '' &&
        changeXO[0] == changeXO[3] &&
        changeXO[0] == changeXO[6]) {
      _showDialog(winner: changeXO[0]);
    }

    if (changeXO[1] != '' &&
        changeXO[1] == changeXO[4] &&
        changeXO[1] == changeXO[7]) {
      _showDialog(winner: changeXO[1]);
    }

    if (changeXO[2] != '' &&
        changeXO[2] == changeXO[5] &&
        changeXO[2] == changeXO[8]) {
      _showDialog(winner: changeXO[2]);
    }

    //Диагонали
    if (changeXO[0] != '' &&
        changeXO[0] == changeXO[4] &&
        changeXO[0] == changeXO[8]) {
      _showDialog(winner: changeXO[0]);
    }

    if (changeXO[2] != '' &&
        changeXO[2] == changeXO[4] &&
        changeXO[2] == changeXO[6]) {
      _showDialog(winner: changeXO[2]);
    }

    if (count == 9) {
      _clearBoard();
      _showDialog(winnerExists: false);
    }
  }

  void _showDialog({String winner = '', bool winnerExists = true}) {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        // title: Text('Итог', style: txtStyle,),
          content:  Text(winnerExists ? 'Победитель: $winner' : 'К сожалению ничья.', style: txtStyle),
          actions: [
          TextButton(
          onPressed: ()
      =>
          Navigator.of(context).pop()
      ,
      child: Text('Сыграть еще раз', style: TextStyle(fontSize: 16, color: Colors.orange),)
      )
      ],
      );
    }
    );

    if (winner == 'x') {
      setState(() {
        xScore++;
      });
    }

    if (winner == 'o') {
      setState(() {
        oScore++;
      });
    }

    _clearBoard();
  }

  void _clearBoard() {
    for (int i = 0; i < changeXO.length; i++) {
      changeXO[i] = '';
    }
    count = 0;
  }
}
