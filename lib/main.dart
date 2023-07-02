import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:hive_database_example/model/transaction.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'model/temple_model.dart';
// import 'package:hive_database_example/page/transaction_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(MandirAdapter());
  await Hive.openBox<Mandir>('templeBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.green),
        home: const MyHomePage(),
      );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Box<Mandir>? _templeBox;

  @override
  void initState() {
    super.initState();
    _templeBox = Hive.box<Mandir>('templeBox');
    // fetchDataFromApi();
  }

  Future<void> fetchDataFromApi() async {
    final response = await http.get(Uri.parse(
        'http://103.90.86.54:1010/api/services/app/Android/GetAllTemples'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> mandirData = data['result']['items'];

      //save instances to hive
      for (var item in mandirData) {
        _templeBox?.add(Mandir.fromJson(item));
      }

      setState(() {});
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final temples = _templeBox?.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hive Flutter Demo'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: temples != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        fetchDataFromApi();

                        // _templeBox?.clear();
                      },
                      child: const Text('Test'),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          print("pressed 1");
                          _templeBox?.clear().then((value) {
                            setState(() {});
                          });
                        },
                        child: const Text('clear')),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: temples.length,
                      itemBuilder: (context, index) {
                        final temple = temples[index];
                        return ListTile(
                          title: Text(temple.name),
                          subtitle: Text(temple.priest),
                          trailing: const Icon(Icons.arrow_forward),
                          onTap: () {
                            // Handle onTap event
                          },
                        );
                      },
                    ),
                  ],
                )
              : const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
