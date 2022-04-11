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
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 40, 0),
                    child: Text(
                      "Discount",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Flexible(
                    child: TextField(
                      controller: TextEditingController(text: '70'),
                      decoration: const InputDecoration(
                        suffixText: '%',
                        isDense: true,
                        contentPadding: EdgeInsets.all(8),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide: BorderSide(color: Colors.teal)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    ElevatedButton(
                      child: Row(
                        children: const [
                          Icon(
                            Icons.arrow_drop_down_outlined,
                            color: Colors.black,
                          ),
                          Text(
                            'Person 1',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        primary: const Color(0xFFEEEDED),
                      ),
                      onPressed: () {},
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 20),
                      child: ListTile(
                        subtitle: const Text(
                            'Amount Purchased\nDiscount Price\nAmount Saved'),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: const [
                            Text(
                              '\$100.00',
                              style: TextStyle(
                                  decoration: TextDecoration.underline),
                              textAlign: TextAlign.end,
                            ),
                            Text(
                              '\$70.00',
                              textAlign: TextAlign.end,
                            ),
                            Text(
                              '-\$30.00',
                              style: TextStyle(color: Colors.green),
                              textAlign: TextAlign.end,
                            ),
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton(
                      child: Row(
                        children: const [
                          Icon(
                            Icons.arrow_right,
                            color: Colors.black,
                          ),
                          Text(
                            'Person 2',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        primary: const Color(0xFFEEEDED),
                      ),
                      onPressed: () {},
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Discount Price',
                            textAlign: TextAlign.start,
                            style: TextStyle(color: Color(0xFF7b7b7b)),
                          ),
                          Text(
                            '\$96.00',
                            textAlign: TextAlign.end,
                          )
                        ],
                      ),
                    ),
                    ElevatedButton(
                      child: Row(
                        children: const [
                          Icon(
                            Icons.arrow_right,
                            color: Colors.black,
                          ),
                          Text(
                            'Person 3',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        primary: const Color(0xFFEEEDED),
                      ),
                      onPressed: () {},
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Discount Price',
                              textAlign: TextAlign.start,
                              style: TextStyle(color: Color(0xFF7b7b7b)),
                            ),
                            Text(
                              '\$464.80',
                              textAlign: TextAlign.end,
                            )
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Total Discounted Price',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '\$640.80',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        primary: const Color(0xFFEEEDED),
                      ),
                      onPressed: () {},
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Amount Saved',
                            textAlign: TextAlign.start,
                            style: TextStyle(color: Color(0xFF7b7b7b)),
                          ),
                          Text(
                            '-\$160.20',
                            textAlign: TextAlign.end,
                            style: TextStyle(color: Colors.green),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
