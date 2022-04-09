import 'package:flutter/material.dart';

class Calculator extends StatelessWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: const [
            Text("Discount Calculator"),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        debugPrint('Received click');
                      },
                      style: ButtonStyle(
                        // padding: MaterialStateProperty.all<EdgeInsets>(
                        //     const EdgeInsets.symmetric(horizontal: 40)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                            side: BorderSide(color: Color(0xFF737373)),
                          ),
                        ),
                        backgroundColor: MaterialStateColor.resolveWith(
                          (states) => const Color(0xFFC4C4C4),
                        ),
                      ),
                      child: const Text(
                        'Discount by %',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: OutlinedButton(
                      onPressed: () {
                        debugPrint('Received click');
                      },
                      style: ButtonStyle(
                        // padding: MaterialStateProperty.all<EdgeInsets>(
                        //     const EdgeInsets.symmetric(horizontal: 40)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                            side: BorderSide(color: Color(0xFF737373)),
                          ),
                        ),
                      ),
                      child: const Text(
                        'Discount by Piece',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF6A6A6A)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: const [
                Text("Discount"),
                // TextField(
                //   decoration: InputDecoration(
                //     // border: InputBorder.none,
                //     hintText: "Remarks",
                //   ),
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
