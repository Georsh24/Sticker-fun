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
  //'http://10.0.2.2:8000/api/tasks';

  //StickerPacks stickerPack = StickerPacks();
  List<StickerPacks> st = [];
  bool isLoading = false, isDownloading = true;
  int iD = -1;
  List<String> downloadList = [];
  List<String> stickerImageList = [];
  @override
  void initState() {
    super.initState();
    isLoading = true;
    isDownloading = true;
    iD = -1;
    this.getJsonData();
    getCompras();
  }

  Future getJsonData() async {
    var response = await http.get(
      Uri.parse(url),
      headers: {"Accept": "application/json"},
    );
    setState(() {
      Map datas = jsonDecode(response.body);
      Model m = Model.formJson(datas);
      for (Map<String, dynamic> json in m.stickerPac) {
        List<Stickers> s = [];
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
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        toolbarHeight: 100,
        automaticallyImplyLeading: false,
        centerTitle: true,
        //title:  Image.asset('assets/logowhite.png', fit: BoxFit.contain, height: 50,), se usa esta para asssets estatico
        title: Image.asset(
          '$logoimg',
          fit: BoxFit.contain,
          height: 50,
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                stops: [
                  0.1,
                  0.80,
                ],
                colors: [
                  HexColor('00ff00'),
                  HexColor('05d0ae'),
                ]),
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
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 1, vertical: 7),
                        child: GestureDetector(
                          onTap: () {
                            navigateToDetailsScreen(i, context);
                          },
                          child: Row(
                            children: [
                              Container(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(200),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.white,
                                              blurRadius: 5,
                                              spreadRadius: -8),
                                        ],
                                        image: DecorationImage(
                                          image:
                                              NetworkImage(st[i].trayimagefile),
                                          // image:
                                          //     AssetImage('assets/Sticker7.png'),
                                          fit: BoxFit.cover,
                                        )),
                                    // children: [
                                    //   Image.asset('assets/Sticker7.png', height: 85,)
                                    // ],
                                  ),
                                  height: 100,
                                  width: size.width * 0.20,
                                  color: Colors.transparent,
                                  margin: EdgeInsets.only(right: 5, left: 7)),
                              Flexible(
                                child: Column(
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 25,
                                            child: Text(
                                              st[i].name,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                              overflow: TextOverflow.clip,
                                              maxLines: 1,
                                              softWrap: true,
                                            ),
                                            margin: EdgeInsets.only(right: 10),
                                          ),
                                          Container(
                                            height: 25,
                                            child: Text('*'),
                                            margin: EdgeInsets.only(right: 10),
                                          ),
                                          Container(
                                            height: 25,
                                            child: Text(
                                              st[i].publisherEmail,
                                              overflow: TextOverflow.clip,
                                              maxLines: 1,
                                              softWrap: true,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        'Este es el texto de prueba jhbedwu euhduwih dbewduwebdebf hedueiu iudhedhu iuehded uihufwefb uihefu hjedwr hwhfb  ',
                                        overflow: TextOverflow.clip,
                                        maxLines: 3,
                                        softWrap: true,
                                      ),
                                      width: size.width * 0.55,
                                      margin: EdgeInsets.only(right: 5),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  Container(
                                    child: IconButton(
                                      iconSize: size.width * 0.1,
                                      icon:
                                          Icon(Icons.favorite_border_outlined),
                                      onPressed: () {},
                                    ),
                                    height: 60,
                                    width: size.width * 0.18,
                                  ),
                                  Container(
                                    child: Text(
                                      st[i].publisher,
                                      style: TextStyle(fontSize: 9),
                                      overflow: TextOverflow.clip,
                                      maxLines: 3,
                                      softWrap: true,
                                    ),
                                    width: size.width * 0.1,
                                    margin: EdgeInsets.only(right: 5),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        height: 100,
                        color: Colors.black12,
                        width: double.infinity,
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
