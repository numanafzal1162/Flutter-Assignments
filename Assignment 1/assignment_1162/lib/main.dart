import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      //theme
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Color(0xFF212330),
      ),
      home: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              width: 390,
              padding: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('asset/images/logo.png'),
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Text(
                            "eWalle",
                            style:
                                TextStyle(fontFamily: 'ubuntu', fontSize: 25),
                          ),
                        ],
                      ),
                      Container(
                          height: 25,
                          width: 25,
                          child: const Image(
                            image: AssetImage("asset/images/menu.png"),
                          ))
                    ],
                  ),
                  SizedBox(height: 15),
                  const Text(
                    "Account Overview",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'avenir',
                        color: Color(0xFF2D356C)),
                  ),
                  SizedBox(height: 15),
                  AccountCard(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Send Money",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'avenir',
                            color: Color(0xFF2D356C)),
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        child: const Image(
                          image: AssetImage("asset/images/scanqr.png"),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xffffac30)),
                                child: const Icon(
                                  Icons.add,
                                  size: 25,
                                ),
                              )
                            ],
                          ),
                          SendMoneyCard(
                            'asset/images/avatar1.png',
                            'Mike',
                          ),
                          SendMoneyCard(
                            'asset/images/avatar2.png',
                            'Jospeh',
                          ),
                          SendMoneyCard(
                            'asset/images/avatar3.png',
                            'Ashlela',
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Services",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'avenir',
                            color: Color(0xFF2D356C)),
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        child: Icon(Icons.dialpad),
                      ),
                    ],
                  ),
                  Container(
                    child: Row(
                      children: [
                        ServiceCard(
                          'asset/images/sendMoney.png',
                          "Send Money",
                        ),
                        ServiceCard(
                          'asset/images/receiveMoney.png',
                          "Receive Money",
                        ),
                        ServiceCard(
                          'asset/images/phone.png',
                          "Mobile Prepaid",
                        ),
                        ServiceCard(
                          'asset/images/electricity.png',
                          "Electricity Bill",
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        ServiceCard(
                          'asset/images/tag.png',
                          "Cashback Offer",
                        ),
                        ServiceCard(
                          'asset/images/movie.png',
                          "Movie Tickets",
                        ),
                        ServiceCard(
                          'asset/images/flight.png',
                          "Flight Tickets",
                        ),
                        ServiceCard(
                          'asset/images/more.png',
                          "More Options",
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

class AccountCard extends StatefulWidget {
  const AccountCard({Key? key}) : super(key: key);

  @override
  State<AccountCard> createState() => _AccountCardState();
}

class _AccountCardState extends State<AccountCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        //color: Color(0xFFF1F3F6),
        color: Theme.of(context).primaryColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                ("20,600"),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                ("Current Balance"),
                style: TextStyle(
                    fontSize: 10,
                    fontFamily: 'ubuntu',
                    color: Color(0xFF989DB8)),
              ),
            ],
          ),
          Container(
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Color(0xffffac30)),
            child: const Icon(
              Icons.add,
              size: 25,
            ),
          )
        ],
      ),
    );
  }
}

class SendMoneyCard extends StatelessWidget {
  final String cardimage;
  final String cardtext;

  SendMoneyCard(this.cardimage, this.cardtext);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 90,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        //color: Color(0xFFF1F3F6),
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage(cardimage), height: 30, width: 30),
            const SizedBox(height: 20),
            Text(
              cardtext,
              style: const TextStyle(
                fontSize: 12,
                fontFamily: 'ubuntu',
                color: Color(0xFF989DB8),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String ServiceImage;
  final String ServiceText;

  ServiceCard(this.ServiceImage, this.ServiceText);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      width: 75,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        //color: Color(0xFFFF1F3F6),
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(ServiceImage),
              height: 25,
              width: 25,
            ),
            const SizedBox(height: 5),
            Text(ServiceText,
                style: const TextStyle(
                    fontSize: 6,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'ubuntu',
                    color: Color(0xFF989DB8)))
          ],
        ),
      ),
    );
  }
}
