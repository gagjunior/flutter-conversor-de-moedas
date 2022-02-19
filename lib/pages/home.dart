import 'package:conversor_de_moedas/main.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double? dolar;
  double? euro;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          '\$ Conversor \$',
        ),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                  child: Text(
                'Carregando dados...',
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 25.0,
                ),
                textAlign: TextAlign.center,
              ));
            default:
              if (snapshot.hasError) {
                return const Center(
                    child: Text(
                  'Carregando dados...',
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 25.0,
                  ),
                  textAlign: TextAlign.center,
                ));
              } else {
                dolar =
                    snapshot.data!["results"]["currencies"]["USD"]["buy"] ?? 0;
                euro =
                    snapshot.data!["results"]["currencies"]["EUR"]["buy"] ?? 0;
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Icon(
                        Icons.monetization_on,
                        size: 150,
                        color: Colors.amber,
                        
                      ),
                      TextField(
                        style: const TextStyle(
                          color: Colors.amber,
                          fontSize: 25,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Reais',
                          labelStyle: const TextStyle(
                            color: Colors.amber,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          prefixText: 'R\$ ',
                        ),
                      ),
                      const Divider(),
                      TextField(
                        style: const TextStyle(
                          color: Colors.amber,
                          fontSize: 25,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Doláres',
                          labelStyle: const TextStyle(
                            color: Colors.amber,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          prefixText: 'US\$ ',
                        ),
                      ),
                      const Divider(),
                      TextField(
                        style: const TextStyle(
                          color: Colors.amber,
                          fontSize: 25,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Euros',
                          labelStyle: const TextStyle(
                            color: Colors.amber,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          prefixText: '€ ',
                        ),
                      )
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }
}
