import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shealth/UI/sizeconfig.dart';
import 'package:shealth/providers/auth.dart';
import 'package:shealth/providers/precription.dart';
import 'package:open_file/open_file.dart';
import 'package:shealth/routers/RouteNames.dart';
class PrescriptionScreen extends StatefulWidget {
  @override
  _PrescriptionScreenState createState() => _PrescriptionScreenState();
}

class _PrescriptionScreenState extends State<PrescriptionScreen> {
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
              Provider.of<Auth>(context).user.email)
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
      floatingActionButton: FloatingActionButton(
          onPressed: ()async{
            await Provider.of<Prescription>(context,listen: false).getPdfAndUpload(Provider.of<Auth>(context,listen: false).token);
          },
          child: Icon(Icons.add),
          backgroundColor: Color(0xffb793da),
        ),
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
                            width: SizeConfig.safeBlockHorizontal * 200,
                            height: SizeConfig.safeBlockVertical * 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xffe7cdf8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  flex: 1,
                                    child: Image.network(
                                        'https://www.seekpng.com/png/full/511-5118328_pdf-icon-clipart-pdf-adobe-acrobat-computer-icons.png')),
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
                                                SizeConfig.safeBlockVertical * 24,
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
