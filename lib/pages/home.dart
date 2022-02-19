import 'package:conversor_de_moedas/main.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();

  double dolar = 0;
  double euro = 0;

  void _clearAll(){
    realController.text = '';
    dolarController.text = '';
    euroController.text = '';
  }

  void _realChanged(String text){

    if (text.isEmpty) {
      _clearAll();
    }

    double real = double.parse(text);
    dolarController.text = (real/dolar).toStringAsFixed(2);
    euroController.text = (real/euro).toStringAsFixed(2);
  }

  void _dolarChanged(String text){

    if (text.isEmpty) {
      _clearAll();
    }

    double dolar = double.parse(text);
    realController.text = (dolar * this.dolar).toStringAsFixed(2);
    euroController.text = (dolar * this.dolar / euro).toStringAsFixed(2);
  }

  void _euroChanged(String text){

    if (text.isEmpty) {
      _clearAll();
    }

    double euro = double.parse(text);
    realController.text = (euro * this.euro).toStringAsFixed(2);
    dolarController.text = (euro * this.euro / dolar).toStringAsFixed(2);
  }

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
                      builderTextField('Reais', 'R\$ ', realController, _realChanged),
                      const Divider(),
                      builderTextField('Doláres', 'US\$ ', dolarController, _dolarChanged),
                      const Divider(),
                      builderTextField('Euros', '€ ', euroController, _euroChanged),
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

Widget builderTextField(
    String label, 
    String prefix, 
    TextEditingController controller,
    Function f
    ) {
  return TextField(
    keyboardType: TextInputType.numberWithOptions(decimal: true),
    controller: controller,
    style: const TextStyle(
      color: Colors.amber,
      fontSize: 25,
    ),
    decoration: InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(
        color: Colors.amber,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      prefixText: prefix,
    ),
    onChanged: (texto){
      f(texto);
    },
  );
}
