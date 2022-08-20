import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared/components/mytext.dart';
import '../../shared/enum/game_enum/game_enum.dart';
import '../../shared/enum/result_enum/result_enum.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GameEnum? userChoice;
  GameEnum? computerChoice;
  ResultEnum? finalResult;
  late int userPoints;
  late int cpuPoints;
int x=0,y=0;

  initState()  {
    super.initState();
    userPoints=0;
    cpuPoints=0;

  }
  List cpuSelections = [
    GameEnum.rock,
    GameEnum.paper,
    GameEnum.scissor,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1b2b4c),
    body: userChoice==null?Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyText('Rock'),
        MyText('Paper'),
        MyText('Scissors'),
        SizedBox(
          height: 15,
        ),
        Text(
          'Pick your weapon',
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(
          height: 15,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              userChoice = GameEnum.rock;
            });
            makeComputerSelect();
            calculations();
          },
          child: Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage("assets/rock.png"),



                opacity: userChoice == GameEnum.rock ? 1.0 : 0.5,
              ),
            ),
          )
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              userChoice = GameEnum.paper;
            });
            makeComputerSelect();
            calculations();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage("assets/paper.png"),
                  opacity: userChoice == GameEnum.paper ? 1.0 : 0.5,
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              userChoice = GameEnum.scissor;
            });
            makeComputerSelect();
            calculations();
          },
          child: Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage("assets/scissor.png"),
                opacity: userChoice == GameEnum.scissor ? 1.0 : 0.5,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 45,
        ),
        Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'Player',
                    style: TextStyle(color: Colors.white),
                  ),
                  MyText('${x}')
                ],
              ),
              Column(
                children: [
                  Text(
                    'CPU',
                    style: TextStyle(color: Colors.white),
                  ),
                  MyText('${y}')
                ],
              )
            ],
          ),
        )
      ],
    ):Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyText(finalResult!.name),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      'User',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),

                    Image.asset( "assets/${userChoice?.name}.png",height: 100,width: 100,),


                  ],
                ),
                Column(
                  children: [
                    Text(
                      'CPU',
                      style: TextStyle(color: Colors.white),
                    ),
                    Image.asset( "assets/${computerChoice?.name}.png",height: 100,width: 100,),



                  ],
                )
              ],
            ),
            SizedBox(height: 30,),
            MaterialButton(

              onPressed: ()async{
                x=await getUserPoints();
                y=await getCpuPoints();
              setState(()  {
                userChoice=null;
                computerChoice=null;
                finalResult=null;


              });

            },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(14),
                ),

                  width: 180,
                  height: 40,
                  alignment: Alignment.center,
                  child: Text('Play Again',style: TextStyle(color: Colors.white,fontSize: 18),)),
            )


          ],
        )),

    );
  }
Future<int> getUserPoints() async {
    final prefs = await SharedPreferences.getInstance();
int x;
      return x=(await prefs.getInt('user'))! ;

  }
Future<int>  getCpuPoints() async {
    final prefs = await SharedPreferences.getInstance();
int y;
    y=(await prefs.getInt('cpu'))! ;
    return y;

  }
  calculations() {
    // if user select rock
    if (userChoice == GameEnum.rock && computerChoice == GameEnum.paper) {
      setState(() {
        finalResult = ResultEnum.lose;
        cpuPoints++;
      });
      print(finalResult);
    }
    if (userChoice == GameEnum.rock && computerChoice == GameEnum.rock) {
      setState(() {
        finalResult = ResultEnum.draw;
      });
    }
    if (userChoice == GameEnum.rock && computerChoice == GameEnum.scissor) {
      setState(() {
        finalResult = ResultEnum.win;
        userPoints++;
      });
    }

    // if user select paper

    if (userChoice == GameEnum.paper && computerChoice == GameEnum.paper) {
      setState(() {
        finalResult = ResultEnum.draw;
      });
    }
    if (userChoice == GameEnum.paper && computerChoice == GameEnum.scissor) {
      setState(() {
        finalResult = ResultEnum.lose;
        cpuPoints++;
      });
    }
    if (userChoice == GameEnum.paper && computerChoice == GameEnum.rock) {
      setState(() {
        finalResult = ResultEnum.win;
        userPoints++;
      });
    }

    // if user select scissor
    if (userChoice == GameEnum.scissor && computerChoice == GameEnum.paper) {
      setState(() {
        finalResult = ResultEnum.win;
        userPoints++;
      });
    }

    if (userChoice == GameEnum.scissor && computerChoice == GameEnum.rock) {
      setState(() {
        finalResult = ResultEnum.lose;
        cpuPoints++;
      });
    }

    if (userChoice == GameEnum.scissor && computerChoice == GameEnum.scissor) {
      setState(() {
        finalResult = ResultEnum.draw;
      });
    }
    setState(() async {
      final prefs = await SharedPreferences.getInstance();
     await prefs.setInt('cpu', cpuPoints);
     await prefs.setInt('user', userPoints);
    });
  }

  makeComputerSelect() {
    setState(() {
      Random random = Random();
      int selected = random.nextInt(3);
      computerChoice = cpuSelections[selected];
    });
  }
}
