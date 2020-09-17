import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hexcolor/hexcolor.dart';

class InformationScreen extends StatelessWidget {
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
          launch('tel://${number}');
        },
        borderRadius: BorderRadius.circular(30),
        child: Icon(
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
        style: TextStyle(
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
                'IMPORTANT INFORMATION',
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
                Tab(
                  text: 'Laws and Rules',
                ),
                Tab(
                  text: 'Helpline Numbers',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ListView(
                padding: EdgeInsets.all(10),
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.all(3),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.grey[350],
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      '18 Laws and rules every indian must know !',
                      style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  textBuilder(
                      '1. Motor Vehicle Act 1988, section -185, 202:- At the time of driving if your 100ml. blood contains more than 30mg. of alcohol then the police can arrest you without a warrant.',
                      context),
                  SizedBox(
                    height: 20,
                  ),
                  textBuilder(
                      '2. Criminal Procedure Code, Section 46:- No woman cannot be arrested before 6 A.M. and after 6 P.M.',
                      context),
                  SizedBox(
                    height: 20,
                  ),
                  textBuilder(
                      '3. Indian Penal Code, 166 A:- A Police officer can’t refuse to lodge an FIR if he/she does so they could be jailed for up to 6 months to 1 year.',
                      context),
                  SizedBox(
                    height: 20,
                  ),
                  textBuilder(
                      '4. Indian Sarais Act, 1887:- Even any 5-star hotel can’t prohibit you from drinking potable water and using its washrooms.',
                      context),
                  SizedBox(
                    height: 20,
                  ),
                  textBuilder(
                      '5. Motor Vehicle Act, 1988:- As per Section 129 of the Indian Motor Vehicle Act, wearing the helmet is a must for two-wheeler riders. Section 128 of this Motor Vehicle Act limits the maximum two riders on the bikes.This law also says that if the traffic police officer snatches the key from the car or motorcycle, it is illegal. You have the full right to launch a Legal proceeding against the officer.',
                      context),
                  SizedBox(
                    height: 20,
                  ),
                  textBuilder(
                      '6. Domestic Violence Act, 2005:- If a young boy and a girl want to live together in a “live-in relationship”, they can do so because it is not illegal. Even the newborn from this relationship is also a legal son or daughter and this newborn have the full right in the assets of his/her father.',
                      context),
                  SizedBox(
                    height: 20,
                  ),
                  textBuilder(
                      '7. Police Act, 1861:- A police officer is always on duty whether he/she wearing a uniform or not. If a person makes a complaint to the officer, he/she could not say that he can’t help the victim because he/ she is not on duty.',
                      context),
                  SizedBox(
                    height: 20,
                  ),
                  textBuilder(
                      '8. Income Tax Act, 1961:-  In the case of tax violations, the tax collection officer has the power to arrest you but before arresting you, he/she will have to send a notice to you. Only Tax Commissioner decides how long you will stay in the custody.',
                      context),
                  SizedBox(
                    height: 20,
                  ),
                  textBuilder(
                      '9. Maternity Benefit Act, 1961:- No company can fire a pregnant woman. It may be punishable by a maximum of 3 years of imprisonment.If the company (Government or private) has more than 10 employees then the pregnant women employee is eligible to get 84 days paid maternity leave.',
                      context),
                  SizedBox(
                    height: 20,
                  ),
                  textBuilder(
                      '10.  Hindu Marriage Act, Section -13: As per the Hindu Marriage Act, 1955 (any husband or wife) may apply for divorce in the court on the basis of Adultery (physical relationship outside of marriage), physical and mental abuse, impotency, to leave home without information, to change Hindu religion and adopt other religion, insanity, incurable disease and no information about husband or wife for seven-year.',
                      context),
                  SizedBox(
                    height: 20,
                  ),
                  textBuilder(
                      '11. Code of Criminal Procedure, 1973:- Only women police constable can arrest women.  Male constable doesn’t have the right to arrest women. Women have the right to deny going to police stations after the 6 P.M. and before the 6 A.M. In the case of a serious crime only after receipt of the written order from the magistrate, a male policeman can arrest a woman.',
                      context),
                  SizedBox(
                    height: 20,
                  ),
                  textBuilder(
                      '12. As per the Citizen Charter (Indian Oil Corporation website):- There are very few people who know that if their gas cylinder blasts during the cooking of food then the gas agency is liable to pay Rs. 50 lakh to the victim as compensation. To claim this compensation consumers need to lodge an FIR to the nearest police station and submit it to the concerned gas agency.',
                      context),
                  SizedBox(
                    height: 20,
                  ),
                  textBuilder(
                      '13.  Automotive (Amendment) Bill, 2016,:- If you are fined for a crime (like riding without a helmet or any other reason) then you will not be fined for the same reason in the same day.',
                      context),
                  SizedBox(
                    height: 20,
                  ),
                  textBuilder(
                      '14. Maximum Retail Price Act, 2014:- Any Shop keeper can’t charge more than the printed price of any commodity but a consumer has the right to bargain for less than the printed price of a commodity.',
                      context),
                  SizedBox(
                    height: 20,
                  ),
                  textBuilder(
                      '15. Limitation Act, 1963:-  If your office does not pay you then you have the power to file an FIR against it within 3 years. But if you report after 3 years, you will not get anything for the due.',
                      context),
                  SizedBox(
                    height: 20,
                  ),
                  textBuilder(
                      '16.  Section 294 of the Indian Penal Code:- If you are found involved in “obscene activity" at a public place, you can be imprisoned for 3 months. But in the absence of an exact definition of obscene activity police have always misused this act.',
                      context),
                  SizedBox(
                    height: 20,
                  ),
                  textBuilder(
                      '17.  Hindu Adoption and Maintenance Act, 1956:- If somebody belongs to the Hindu religion and has a son or grandson then he can’t adopt a second child. There must be a gap of at least 21 years between you (the adopter) and your adopted son.',
                      context),
                  SizedBox(
                    height: 20,
                  ),
                  textBuilder(
                      '18.  Delhi Rent Control Act, 1958, Section 14:- If you are living in Delhi then your landlord does not have the right to forcefully vacate your house without giving prior notice to you.',
                      context),
                ],
              ),
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    numberBuilder(112, 'NATIONAL EMERGENCY NUMBER', context),
                    numberBuilder(100, 'POLICE', context),
                    numberBuilder(101, 'FIRE', context),
                    numberBuilder(102, 'AMBULANCE', context),
                    numberBuilder(1091, 'WOMEN HELPLINE', context),
                    numberBuilder(108, 'DISASTER MANAGEMENT SERVICES', context),
                    numberBuilder(9540161344, 'AIR AMBULANCE', context),
                    numberBuilder(139, 'RAILWAY ENQUIRY', context),
                    numberBuilder(1091, 'SENIOR CITIZEN HELPLINE', context),
                    numberBuilder(1098, 'CHILDREN HELPLINE', context),
                    numberBuilder(1368, 'TOURIST HELPLINE', context),
                    numberBuilder(1906, 'LPG LEAK HELPLINE', context),
                    numberBuilder(1551, 'KISAN CALL CENTRE', context),
                    numberBuilder(
                        1073, 'ROAD ACCIDENT EMERGENCY SERVICE', context),
                    numberBuilder(1094, 'DCP - MISSING CHILD & WOMEN', context),
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
