import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shealth/UI/sizeconfig.dart';
import 'package:shealth/providers/auth.dart';
import 'package:shealth/providers/precription.dart';
import 'package:open_file/open_file.dart';
import 'package:shealth/routers/RouteNames.dart';
class PrescriptionScreenForDoc extends StatefulWidget {
  final email;
  final name;
  PrescriptionScreenForDoc({this.email,this.name});
  @override
  _PrescriptionScreenForDocState createState() => _PrescriptionScreenForDocState();
}

class _PrescriptionScreenForDocState extends State<PrescriptionScreenForDoc> {
  bool isInit = true;
  bool loading = true;
  

  @override
  void didChangeDependencies() {
    if (isInit) {
      setState(() {
        loading = true;
      });
      
      Provider.of<Prescription>(context)
          .getDocuments(Provider.of<Auth>(context, listen: false).token,
              widget.email)
          .then((value) {
        setState(() {
          loading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final documents = Provider.of<Prescription>(context).documents;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('${widget.name}',
        style: Theme.of(context).textTheme.headline1?.copyWith(
              fontSize: SizeConfig.safeBlockVertical * 24,
              color: Color(0xffF3F1F5)
        ),
        ),
        backgroundColor: Color(0xffb793da),
      ) ,
      body: SafeArea(
        child: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: documents.length,
                itemBuilder: (ctx, index) {
                  return documents.length == 0
                      ? Center(
                          child: Text('Kuch daal bsdk'),
                        )
                      : GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, RouteNames.pdfView,arguments: 'https://shealthapi.servatom.com${documents[index]}');
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 20),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                            
                            height: SizeConfig.safeBlockVertical * 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xff7f7c82).withOpacity(.24),
                            ),
                            child: Row(
                              
                              children: [
                                Container(
                                  width: SizeConfig.safeBlockHorizontal * 100,
                                  height: SizeConfig.safeBlockVertical * 80,
                                  child: Image.network(
                                      'https://www.seekpng.com/png/full/511-5118328_pdf-icon-clipart-pdf-adobe-acrobat-computer-icons.png'),
                                ),
                                SizedBox(width: 8,),
                                Flexible(
                                  flex: 2,
                                  child: Container(
                                    child: Text(
                                      '${documents[index].split('/').last}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline1
                                          ?.copyWith(
                                            fontSize:
                                                SizeConfig.safeBlockVertical * 18,
                                            color: Color(0xff49484b),
                                          ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                      );
                }),
      ),
    );
  }
}
