import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String dropdownvalue1 = 'BIRR';
  String dropdownvalue2 = 'DOLLAR(US)';

  var items = [
    'BIRR',
    'DOLLAR(US)',
    'EURO',
  ];
  late final TextEditingController _value1;
  String answer = '';

  @override
  void initState() {
    super.initState();
    _value1 = TextEditingController()
      ..addListener(() {
        setState(() {
          answer = convert(
              dropdownvalue1, dropdownvalue2, double.parse(_value1.text));
        });
      });
  }

  String convert(String from, String to, double amount) {
    if (from == "BIRR") {
      if (to == "BIRR") {
        amount = amount;
      } else if (to == "DOLLAR(US)") {
        amount = amount / 53.67;
      } else if (to == "EURO") {
        amount = amount / 58.36;
      } else {}
    } else if (from == "DOLLAR(US)") {
      if (to == "BIRR") {
        amount = amount * 53.67;
      } else if (to == "DOLLAR(US)") {
        amount = amount;
      } else if (to == "EURO") {
        amount = amount * 1.09;
      } else {}
    } else if (from == "EURO") {
      if (to == "BIRR") {
        amount = amount * 58.36;
      } else if (to == "DOLLAR(US)") {
        amount = amount / 1.09;
      } else if (to == "EURO") {
        amount = amount;
      } else {}
    } else {}

    return amount.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Container(
                color: Colors.purple,
                width: MediaQuery.of(context).size.width,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Text(
                    "Currency Convector",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: Container(
                            color: Colors.purple,
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  height: 100,
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  // color: Colors.red,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    controller: _value1,
                                    style: const TextStyle(
                                        fontSize: 50,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                    decoration: const InputDecoration(
                                        hintText: "Amount",
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white)),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white))),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  // height: 100,
                                  // width:
                                  // MediaQuery.of(context).size.width * 0.4,
                                  child: DropdownButton(
                                    // Initial Value
                                    value: dropdownvalue1,

                                    // Down Arrow Icon
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down_outlined,
                                      color: Colors.black,
                                    ),

                                    // Array list of items
                                    items: items.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(
                                          items,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 20),
                                        ),
                                      );
                                    }).toList(),
                                    // After selecting the desired option,it will
                                    // change button value to selected value
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownvalue1 = newValue!;
                                        answer = convert(
                                            dropdownvalue1,
                                            dropdownvalue2,
                                            double.parse(_value1.text));
                                      });
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            color: Colors.white,
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  height: 100,
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  // color: Colors.red,
                                  child: SingleChildScrollView(
                                    child: Text(
                                      answer,
                                      style: const TextStyle(
                                          fontSize: 70,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.purple),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  // height: 100,
                                  // width:
                                  // MediaQuery.of(context).size.width * 0.4,
                                  child: DropdownButton(
                                    // Initial Value
                                    value: dropdownvalue2,

                                    // Down Arrow Icon
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down_outlined,
                                      color: Colors.black,
                                      size: 40,
                                    ),

                                    // Array list of items
                                    items: items.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(
                                          items,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 20),
                                        ),
                                      );
                                    }).toList(),
                                    // After selecting the desired option,it will
                                    // change button value to selected value
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownvalue2 = newValue!;
                                        answer = convert(
                                            dropdownvalue1,
                                            dropdownvalue2,
                                            double.parse(_value1.text));
                                      });
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const SizedBox(width: 30),
                        InkWell(
                          onTap: () {
                            setState(() {
                              String temp = dropdownvalue1;
                              dropdownvalue1 = dropdownvalue2;
                              dropdownvalue2 = temp;
                              answer = convert(dropdownvalue1, dropdownvalue2,
                                  double.parse(_value1.text));
                            });
                          },
                          child: const Card(
                            elevation: 10,
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: Icon(
                                Icons.currency_exchange_sharp,
                                color: Colors.purple,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
