import  'dart:convert' ;
import  'package:flutter/widgets.dart' ;
import  "package:get/get.dart" ;
import  'dart:js'  as js;

class  TelegramController  extends  GetxController  {
  static Map < String , dynamic >? telegramData;

  @override
  void onInit() {
    super.onInit();
    getTelegramData();
  }

  void getTelegramData() {
    telegramData = initTelegramWebApp();
    if (telegramData != null ) {
      debugPrint( 'Telegram Data: $telegramData ' );
    } else {
      debugPrint( 'Telegram data is null. Это приложение открыто вне telegram' );
    }
    update();
  }

  // Функция для инициализации Telegram WebApp
  static  Map < String , dynamic > initTelegramWebApp() {
    final result = js.context.callMethod( 'initTelegramWebApp' );
    debugPrint( "result: $result " );
    if (result != null ) {
      // Преобразуем JsObject в строку JSON, а затем преобразуем ее в строку Map
      String jsonString = js.context[ 'JSON' ].callMethod( 'stringify' , [result]);
      return jsonDecode(jsonString);
    }
    return  {"username":"пидор"};
  }

  // Функция для отправки данных обратно в Telegram
  static  void sendTelegramData( String data) {
    js.context.callMethod( 'sendTelegramData' , [data]);
  }

  // Функция для отправки данных обратно в Telegram
  static  String ph(String data) {
    var pic = js.context.callMethod( 'photo_url' , [data]);
    if(pic!=null){
      return(pic);
    }
    else{
      return " ";
    }

  }

  // Функция для управления MainButton в Telegram
  static  void setMainButton( String text, bool isVisible) {
    js.context.callMethod( 'setMainButton' , [text, isVisible]);
  }
}