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
  bool isLoading = false;
  
  @override
  void didChangeDependencies() {
    if (isInit) {
      setState(() {
        isLoading = true;
      });
      
      Provider.of<Prescription>(context)
          .getDocuments(Provider.of<Auth>(context, listen: false).token,
              Provider.of<Auth>(context).user.email)
          .then((value) {
        setState(() {
          isLoading = false;
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
            try{
              setState(() {
                isLoading = true;
                            });
              await Provider.of<Prescription>(context,listen: false).getPdfAndUpload(Provider.of<Auth>(context,listen: false).token);
            }catch(e){
              showDialog(context: context, builder: (_){
                            return AlertDialog(
                              title: Text('Error Occured'),
                              content: e.toString()=="Null check operator used on a null value"? Text('Cancelled Upload') : Text('$e'),
                              actions: [
                                TextButton(onPressed: (){Navigator.pop(context);}, child: Text('Ok'))
                              ],
                            );
                          });
            }finally{
              setState(() {
                              isLoading = false;
                            });
            }
            
            
          },
          child: Icon(Icons.add),
          backgroundColor: Color(0xffb793da),
        ),
      body: SafeArea(
        child: isLoading
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
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            margin: EdgeInsets.only(top: 20),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                              
                              height: SizeConfig.safeBlockVertical * 100,
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
                                          'https://www.seekpng.com/png/full/511-5118328_pdf-icon-clipart-pdf-adobe-acrobat-computer-icons.png')),
                                          SizedBox(width: 5,),
                                  Flexible(
                                   
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
                        ),
                      );
                }),
      ),
    );
  }
}
