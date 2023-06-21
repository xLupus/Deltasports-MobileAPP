import 'package:deltasports_app/utilis/global_colors.dart';
import 'package:flutter/material.dart';

Future<void> dialog(BuildContext context, String txt, String btn1, String btn2, dynamic route1, dynamic route2) async {
  double screenWidth = MediaQuery.of(context).size.width;

  showDialog(
      context: context,
      builder: (BuildContext context) => GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => route1),
              );
            },
            child: Dialog(
              elevation: 20.0,
              shadowColor: const Color(0xD2000000),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0)),
              child: Container(
                decoration: BoxDecoration(
                  color: GlobalColors.white,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                height: 470,
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Icon(
                              Icons.check_circle,
                              color: GlobalColors.blue,
                              size: 106,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 40),
                    const Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text('Sucesso!',
                                style: TextStyle(
                                    color: Color(0xFF3A3A3A),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24)),
                          ),
                        )
                      ],
                    ),
                     Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                                txt,
                                style: const TextStyle(
                                    color: Color(0xFF3A3A3A),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16)),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: GlobalColors.blue,
                                  foregroundColor: GlobalColors.white,
                                  padding: const EdgeInsets.all(10.0),
                                  fixedSize: Size(screenWidth * 0.60, 45.0),
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  elevation: 20.0,
                                  shadowColor: const Color(0xD2000000),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0))),
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          route1),
                                );
                              },
                              child: Text(btn1),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: GlobalColors.blue,
                                  foregroundColor: GlobalColors.white,
                                  padding: const EdgeInsets.all(10.0),
                                  fixedSize: Size(screenWidth * 0.60, 45.0),
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  elevation: 20.0,
                                  shadowColor: const Color(0xD2000000),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0))),
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          route2
                                    ),
                                );
                              },
                              child: Text(btn2),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ));
}
