import 'package:exhange_rates_flutter/json/rates.dart';
import 'package:exhange_rates_flutter/json/currencies.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(
    MaterialApp(
      title: 'Currency App',
      home: Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Center(
            child: Text(
              'Currency App',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: CurrencyConverter(),
      ),
    ),
  );
}

class CurrencyConverter extends StatefulWidget {
  const CurrencyConverter({Key? key}) : super(key: key);

  @override
  _CurrencyConverterState createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  //Initial Variables
  late Future<RatesModel> result;
  late Future<Map> allcurrencies;
  final formkey = GlobalKey<FormState>();
  String key = 'bff1adaa4fe64215b50d3ca5fc61c460';

  //initState Function
  @override
  void initState() {
    super.initState();
    setState(() {
      result = fetchrates();
      allcurrencies = fetchcurrencies();
    });
  }

  Future<RatesModel> fetchrates() async {
    var response = await http.get(Uri.parse(
        'https://openexchangerates.org/api/latest.json?base=USD&app_id=' +
            key));
    final result = ratesModelFromJson(response.body);
    return result;
  }

  Future<Map> fetchcurrencies() async {
    var response = await http.get(Uri.parse(
        'https://openexchangerates.org/api/currencies.json?app_id=' + key));
    final allCurrencies = allCurrenciesFromJson(response.body);
    return allCurrencies;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: FutureBuilder<RatesModel>(
            future: result,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              return Center(
                child: FutureBuilder<Map>(
                    future: allcurrencies,
                    builder: (context, currSnapshot) {
                      if (currSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 30),
                          CurrencyCard(
                            currencies: currSnapshot.data!,
                            rates: snapshot.data!.rates,
                          ),
                          SizedBox(height: 150),
                          Text(
                            "DESIGNED BY NUMAN AFZAL",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        ],
                      );
                    }),
              );
            },
          ),
        ),
      ),
    );
  }
}

class CurrencyCard extends StatefulWidget {
  final rates;
  final Map currencies;
  const CurrencyCard({Key? key, @required this.rates, required this.currencies})
      : super(key: key);

  @override
  _CurrencyCardState createState() => _CurrencyCardState();
}

class _CurrencyCardState extends State<CurrencyCard> {
  TextEditingController amountController = TextEditingController();

  String from = 'AUD';
  String to = 'AUD';
  String converted = '0.00';

//function
  String convertany(Map exchangeRates, String amount, String currencybase,
      String currencyfinal) {
    String output = (double.parse(amount) /
            exchangeRates[currencybase] *
            exchangeRates[currencyfinal])
        .toStringAsFixed(2)
        .toString();
    return output;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Exchange Rate',
              style: TextStyle(fontSize: 20, color: Colors.black45),
            ),
            SizedBox(height: 20),
            Container(
                child: Text(
              converted,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: Colors.blueGrey),
            )),
            SizedBox(height: 10),
            TextFormField(
              key: ValueKey('amount'),
              controller: amountController,
              decoration: InputDecoration(hintText: 'Please enter your amount'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'From',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                Expanded(
                  child: DropdownButton<String>(
                    value: from,
                    icon: const Icon(Icons.arrow_drop_down_rounded),
                    iconSize: 24,
                    elevation: 16,
                    isExpanded: true,
                    onChanged: (String? newValue) {
                      setState(() {
                        from = newValue!;
                      });
                    },
                    items: widget.currencies.keys
                        .toSet()
                        .toList()
                        .map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Text('To',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(
                  child: DropdownButton<String>(
                    value: to,
                    icon: const Icon(Icons.arrow_drop_down_rounded),
                    iconSize: 24,
                    elevation: 16,
                    isExpanded: true,
                    onChanged: (String? newValue) {
                      setState(() {
                        to = newValue!;
                      });
                    },
                    items: widget.currencies.keys
                        .toSet()
                        .toList()
                        .map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              child: SizedBox(
                width: 270,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      converted = amountController.text +
                          ' ' +
                          from +
                          ' = ' +
                          convertany(
                              widget.rates, amountController.text, from, to) +
                          ' ' +
                          to;
                    });
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
                  child: Text(
                    'Convert',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
