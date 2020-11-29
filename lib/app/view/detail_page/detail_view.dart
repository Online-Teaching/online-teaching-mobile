import 'package:flutter/material.dart';
import 'package:online_teaching_mobile/app/view_model/detail_view_model.dart';

class DetailView extends DetailViewModel {
  String metin = """
  Access'in önceki sürümlerinde, Not veri türü metin büyük miktarlardaki depolamak için kullandık ve daha kısa dizeleri (en çok 255 karakter) depolamak için metin verileri yazın. Access 2013 ve Access 2016, bu iki veri türleri sırasıyla "Uzun metin" ve "Kısa metin" olarak yeniden olmuştur ve farklı özellikleri ve Masaüstü veritabanındaki veya Access web uygulaması kullanmakta olduğunuz bağlı olarak boyutu sınırları sahiptir. Ayrıntılar şöyledir:
  Access'in önceki sürümlerinde, Not veri türü metin büyük miktarlardaki depolamak için kullandık ve daha kısa dizeleri (en çok 255 karakter) depolamak için metin verileri yazın. Access 2013 ve Access 2016, bu iki veri türleri sırasıyla "Uzun metin" ve "Kısa metin" olarak yeniden olmuştur ve farklı özellikleri ve Masaüstü veritabanındaki veya Access web uygulaması kullanmakta olduğunuz bağlı olarak boyutu sınırları sahiptir. Ayrıntılar şöyledir:
  Access'in önceki sürümlerinde, Not veri türü metin büyük miktarlardaki depolamak için kullandık ve daha kısa dizeleri (en çok 255 karakter) depolamak için metin verileri yazın. Access 2013 ve Access 2016, bu iki veri türleri sırasıyla "Uzun metin" ve "Kısa metin" olarak yeniden olmuştur ve farklı özellikleri ve Masaüstü veritabanındaki veya Access web uygulaması kullanmakta olduğunuz bağlı olarak boyutu sınırları sahiptir. Ayrıntılar şöyledir:
  """;
  Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [appbar(size, context), body()],
      ),
    );
  }

  Expanded appbar(Size size, BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(
          top: 30,
          left: 20,
          right: 20,
        ),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              //offset: Offset(0, 1),
              blurRadius: 10,
              //  color: Colors.blue.withOpacity(0.23),
            ),
          ],
        ),
        child: Text(
          "Türev",
          style: Theme.of(context)
              .textTheme
              .headline5
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Expanded body() {
    return Expanded(
      flex: 11,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(20),
            height: size.height,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  //offset: Offset(0, 1),
                  blurRadius: 20,
                  //  color: Colors.blue.withOpacity(0.23),
                ),
              ],
            ),
            child: Container(
              child: Text(
                metin,
                style: TextStyle(fontSize: 20),
              ),
            )),
      ),
    );
  }
}
