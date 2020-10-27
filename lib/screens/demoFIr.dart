import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:EPOLICE/Victim_block.dart';
import '../witness_block.dart';

class FirFormTab extends StatefulWidget {
  @override
  _FirFormTabState createState() => _FirFormTabState();
}

class _FirFormTabState extends State<FirFormTab> {
  Widget textBuilder(String text, BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 16,
          color: Colors.red[400],
          fontWeight: FontWeight.bold),
      textAlign: TextAlign.left,
    );
  }

  Widget numberBuilder(int number, String text, BuildContext context) {
    return ListTile(
      trailing: InkWell(
        onTap: () {
          launch('tel://$number');
        },
        borderRadius: BorderRadius.circular(30),
        child: const Icon(
          Icons.call,
          color: Colors.green,
          size: 30,
        ),
      ),
      title: Text(
        text,
        style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        number.toString(),
        style: const TextStyle(
            fontFamily: 'Montserrat',
            color: Colors.red,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            backgroundColor: Theme.of(context).backgroundColor,
            title: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                'FILE FIR',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
            ),
            centerTitle: true,
            bottom: TabBar(
              indicatorColor: Theme.of(context).primaryColor,
              labelColor: Theme.of(context).primaryColor,
              labelStyle: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  fontSize: 18),
              unselectedLabelColor: Color.fromRGBO(25, 74, 109, 120),
              unselectedLabelStyle: TextStyle(
                  fontFamily: 'Montserrat', fontWeight: FontWeight.w600),
              tabs: [
                const Tab(
                  text: "Victim's Detail",
                ),
                const Tab(
                  text: "Witness's Detail",
                ),
              ],
            ),
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.08), BlendMode.dstATop),
                fit: BoxFit.cover,
                image: AssetImage('assets/images/police_logo.png'),
              ),
            ),
            child: TabBarView(
              children: [
                Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                            Colors.white.withOpacity(.5), BlendMode.dstATop),
                        fit: BoxFit.cover,
                        image:
                            const AssetImage('assets/images/police_logo.png'),
                      ),
                    ),
                    child: VictimBlock()),
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                          Colors.white.withOpacity(.5), BlendMode.dstATop),
                      fit: BoxFit.cover,
                      image: const AssetImage('assets/images/police_logo.png'),
                    ),
                  ),
                  child: WitnessBlock(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
