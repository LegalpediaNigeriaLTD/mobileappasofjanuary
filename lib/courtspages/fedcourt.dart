import 'package:flutter/material.dart';

import 'package:legalpedia/judgementdetails.dart';
import 'package:legalpedia/models/summarymodel.dart';

class FederalCourt extends StatefulWidget{

  final List<SummaryModel> summary;
  List<SummaryModel> summary2 = List();
  List<SummaryModel> filteredsummary = List();

  FederalCourt(this.summary);


  @override
  _FederalCourt createState()=> _FederalCourt(this.summary);

}

class _FederalCourt extends State<FederalCourt>{

  final List<SummaryModel> summary;
  List<SummaryModel> summary2 = List();
  List<SummaryModel> filteredsummary = List();

  _FederalCourt(this.summary);

  @override
  void initState() {
    super.initState();

    setState(() {

      summary2 = summary.where((u)=>
      (u.court.toLowerCase().contains('In the Federal High Court'.toLowerCase()))).toList();

      filteredsummary = summary2;
    });


  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(

        body:
        Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  hintText: 'Search Judgements (Federal High Court)'
              ),
              onChanged: (string){
                setState(() {
                  filteredsummary = summary2.where((u)=>
                  (u.title.toLowerCase().contains(string.toLowerCase()) ||
                      u.judgementDate.toLowerCase().contains(string.toLowerCase()) ||
                      u.suitNo.toLowerCase().contains(string.toLowerCase()))).toList();
                });
              },
            ),
            Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemCount: filteredsummary.length,
                  itemBuilder: (BuildContext context, int index){
                    return InkWell(
                        splashColor: Colors.redAccent,
                        borderRadius: BorderRadius.circular(10.0),
                    onTap: (){
                    setState(() {
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return JudgementDetail(filteredsummary, filteredsummary[index].suitNo);
                      }));
                    });
                    },
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(filteredsummary[index].title==null ||  filteredsummary[index].title.toString().toUpperCase()=='NIL|'? 'None': filteredsummary[index].title, style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: 'Monseratti'

                            ),),
                            SizedBox(height: 10.0),
                            Text(filteredsummary[index].suitNo==null ||  filteredsummary[index].suitNo.toString().toUpperCase()=='NIL|'? 'None': filteredsummary[index].suitNo, style: TextStyle(
                                fontSize: 10.0,
                                fontFamily: 'Monseratti',
                                color: Colors.grey

                            ),),
                          ],
                        ),
                      ),
                    ));
                  }),
            )
          ],
        )
    );
  }


}