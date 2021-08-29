import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shealth/UI/sizeconfig.dart';
import 'package:shealth/providers/auth.dart';
import 'package:shealth/providers/doctors.dart';

class DocId extends StatefulWidget {
  

  @override
  _DocIdState createState() => _DocIdState();
}

class _DocIdState extends State<DocId> {
  bool isInit = true;
  bool isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(isInit){
      setState(() {
              isLoading = true;
            });
      Provider.of<Doctors>(context,listen: false).getDocId(Provider.of<Auth>(context,listen: false).token).then((value) {
        setState(() {
                  isLoading = false;
                });
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Doctors>(context).docId;
    return Scaffold(
      body: SafeArea(
        child: isLoading? Center(child: CircularProgressIndicator(),) : Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: SizeConfig.safeBlockVertical*300,
                height: SizeConfig.safeBlockVertical*300,
                child: QrImage(
                  data: data ,
                  version: QrVersions.auto
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 20),
            child: Text(
              '$data',
              style: Theme.of(context).textTheme.headline2?.copyWith(
                fontSize: SizeConfig.safeBlockVertical * 20,
                color: Color(0xff49484b),
              ),
            ),
          ),
            ],
          ),
        ),
      ),
    );
  }
}
