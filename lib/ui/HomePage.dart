import 'dart:io';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../models/stickerPacks.dart';
import '../models/stickers.dart';
import '../models/model.dart';
import 'dart:async';
import 'dart:convert';
import 'StickerDetails.dart';
import 'package:dio/dio.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const MethodChannel stickerMethodChannel = const MethodChannel(
      'com.viztushar.flutter.flutter_stickers_internet/sharedata');
      //url del jsnon
  final String url =
      'https://gist.githubusercontent.com/Georsh24/9653a587c3836ea8ef35d4470df6a861/raw/56427b20a21e06fd26e1068e695d293172082337/stickers_p.json';
  StickerPacks stickerPack = StickerPacks();
  List<StickerPacks> st = List<StickerPacks>();
  bool isLoading, isDownloading = true;
  int iD = -1;
  List<String> downloadList = List<String>();
  List<String> stickerImageList = List<String>();
  @override
  void initState() {
    super.initState();
    isLoading = true;
    isDownloading = true;
    iD = -1;
    this.getJsonData();
  }
  Future getJsonData() async {
    var response = await http.get(
      Uri.encodeFull(url),
      headers: {"Accept": "application/json"},
    );
    setState(() {
      Map datas = jsonDecode(response.body);
      Model m = Model.formJson(datas);
      for (Map<String, dynamic> json in m.stickerPac) {
        List<Stickers> s = List<Stickers>();
        for (Map<String, dynamic> stickers in json['stickers']) {
          s.add(Stickers(
              imagefile: stickers['image_file'], emojis: stickers['emojis']));
        }
        print(json['publisher_email'] +
            " " +
            json['publisher_website'] +
            " " +
            json['privacy_policy_website'] +
            " " +
            json['license_agreement_website'] +
            " ");
        st.add(StickerPacks(
            identifier: json['identifier'],
            name: json['name'],
            publisher: json['publisher'],
            trayimagefile: json['tray_image_file'],
            publisheremail: json['publisher_email'],
            publisherwebsite: json['publisher_website'],
            privacypolicywebsite: json['privacy_policy_website'],
            licenseagreementwebsite: json['license_agreement_website'],
            stickers: s));
      }
      isLoading = false;
    });
    
  }
  navigateToDetailsScreen(id, context) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return MyStickerDetails(
        stickerPacks: st[id],
      );
    }));
  }
 
  @override
  Widget build(BuildContext context) {
//delcaracion al cambiar el brignes a dark cambia el logo en logoimge
      final logoimg = Theme.of(context).brightness == Brightness.dark
    ? 'assets/logoblack.png'
    : 'assets/logowhite.png'; 
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        toolbarHeight: 100,
        automaticallyImplyLeading: false,
        centerTitle: true,
        //title:  Image.asset('assets/logowhite.png', fit: BoxFit.contain, height: 50,), se usa esta para asssets estatico
        title:  Image.asset('$logoimg', fit: BoxFit.contain, height: 50,),
      flexibleSpace: Container(
         decoration: BoxDecoration( 
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end:  Alignment.topRight,
                stops: [
                  0.1,
                  0.80,
                ],
                colors:[
                  HexColor('00ff00'),
                HexColor('05d0ae'),
              ] ),
              border: Border.all(
                  color: Colors.transparent,
                  width: 0,
                ),
            ),
      ),
       elevation: 0.0,
      ),
      body: Container(
        child: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : ListView.builder(
                  itemCount: st.length,
                  itemBuilder: (context, i) {
                    return Card(
                      //color: Colors.yellow,
                      child: Container(
                    
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          
                          children: <Widget>[
                            
                            Container(
                             // color: Colors.red,
                              child: GestureDetector(
                                
                                onTap: () {
                                  navigateToDetailsScreen(i, context);
                                },
                                child: Column(
                                  
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Row(
                                      
                                      children: <Widget>[
                                        
                                        Text(
                                          st[i].name,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          ' • ',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        Text(
                                          st[i].publisher,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Wrap(
                                      alignment: WrapAlignment.start,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      direction: Axis.horizontal,
                                      spacing: 8.0,
                                      runSpacing: 4.0,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Image.network(
                                              st[i].sticker[0].imagefile,
                                              height: 70.0,
                                              width: 70.0,
                                            ),
                                            Image.network(
                                              st[i].sticker[1].imageFile,
                                              height: 70.0,
                                              width: 70.0,
                                            ),
                                            Image.network(
                                              st[i].sticker[2].imageFile,
                                              height: 70.0,
                                              width: 70.0,
                                            ),
                                            st[i].sticker.length > 3
                                                ? Image.network(
                                                    st[i].sticker[3].imageFile,
                                                    height: 70.0,
                                                    width: 70.0,
                                                  )
                                                : SizedBox(
                                                    width: 70.0,
                                                    height: 70.0,
                                                  ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    
                                  ],
                                  
                                ),
                                
                              ),
                            ),

                           
                              Container(
                                width: size.width *0.2,
                              //color: Colors.blue,
                              child: IconButton(
                                iconSize: size.width *0.07,
                                alignment: Alignment.centerRight,
                                icon: Icon(Icons.favorite_border_outlined),
                                onPressed: (){

                                },
                               ),
                            ),
                            
                          ],
                          
                        ),


                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
// si ya funciona no le mueva a partir de aqui se hace la descarga y añaade sticker to whatssap algun problema ir mainactivity.kt
  Future<void> addToWhatsapp(StickerPacks s) async {
    try {
      stickerMethodChannel.invokeMapMethod("addStickerPackToWhatsApp",
          {"identifier": s.identiFier, "name": s.name});
    } on PlatformException catch (e) {
      print(e.details);
    }
  }

  Future<void> downloadSticker(StickerPacks s) async {
    if (s.publisherEmail == null) s.publisherEmail = "0";
    print((s.publisherEmail == null).toString() +
        s.identiFier +
        " " +
        s.name +
        " " +
        s.publisher +
        " " +
        s.trayImageFile +
        " " +
        s.publisherEmail +
        " " +
        s.publisherWebsite +
        " " +
        s.privacyPolicyWebsite +
        " " +
        s.licenseAgreementWebsite.contains("").toString() +
        " ");

    stickerImageList.clear();
    if (!downloadList.contains(s.identiFier)) {
      await Permission.storage.request();
      Dio dio = Dio();
      var dirToSave = await getApplicationDocumentsDirectory();
      var path = await Directory(dirToSave.path +
              "/" +
              "stickers_asset" +
              "/" +
              s.identiFier +
              "/")
          .create(recursive: true);
      var trypath = await Directory(dirToSave.path +
              "/" +
              "stickers_asset" +
              "/" +
              s.identiFier +
              "/try/")
          .create(recursive: true);
      print(path.path + "\n" + trypath.path);

      String tryFilePath = trypath.path + basename(s.trayImageFile);
      print(tryFilePath);
      await dio.download(s.trayImageFile, tryFilePath,
          onReceiveProgress: (rec, total) {
        print((rec / total) * 100);
        print("try image downloaded");
      });

      for (int i = 0; i < s.sticker.length; i++) {
        String imageFilePath = path.path + basename(s.sticker[i].imageFile);
        stickerImageList.add(basename(s.sticker[i].imageFile));
        await dio.download(s.sticker[i].imageFile, imageFilePath,
            onReceiveProgress: (rec, total) {
          print((rec / total) * 100);
        });
      }

      try {
        stickerMethodChannel.invokeMapMethod("addTOJson", {
          "identiFier": s.identiFier,
          "name": s.name,
          "publisher": s.publisher,
          "trayimagefile": basename(s.trayImageFile),
          "publisheremail": s.publisherEmail,
          "publisherwebsite": s.publisherWebsite,
          "privacypolicywebsite": s.privacyPolicyWebsite,
          "licenseagreementwebsite": s.licenseAgreementWebsite,
          "sticker_image": stickerImageList,
        });
      } on PlatformException catch (e) {
        print(e.details);
      }
      setState(() {
        isDownloading = true;
        if (!downloadList.contains(s.identiFier)) {
          downloadList.add(s.identiFier);
        }
      });
    } else {
      print("not");
    }
  }

  Future<void> showDialogs(context) {
    AlertDialog s = AlertDialog(
      content: Row(
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(
            width: 10,
          ),
          Text("Downloading..."),
        ],
      ),
    );
    return showDialog(
      context: context,
      builder: (context) {
        return s;
      },
    );
  }
}
