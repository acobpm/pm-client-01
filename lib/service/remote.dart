import 'dart:convert';
import 'dart:io';
import 'dart:async';
import '../util.dart';
import '../model/data.dart';

//const apiUrl = 'http://192.168.1.17:3000/api/';
const apiUrl = 'http://192.168.1.13:3000/api/';
const nsPM = 'com.acob.promiseme.';
const pCouple = "Couple";
const aPromise = "PromiseMe";
const aPromiseStatus = "PromiseStatus";
const cResource = "resource";
const tNegociate = "NegotiatePromise";

Future<String> getRESTJsonString(String url) async {
var httpClient = new HttpClient();

    String result;
    
    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      
      var response = await request.close();
      
      if (response.statusCode == HttpStatus.OK) {
        
        var json = await response.transform(UTF8.decoder).join();
        //var data = JSON.decode(json);
        result = json; 
      } else {
        result =
            'Error';
            
      }
    } catch (exception) {
      
      result = 'Error';
    }
    
    return new Future.value(result) ; 
}
Future<String> getConnection() async {
  var url = 'http://192.168.1.17:3000/api/com.acob.promiseme.Couple/Mason';
    var httpClient = new HttpClient();

    String result;
    
    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      
      var response = await request.close();
      
      if (response.statusCode == HttpStatus.OK) {
        
        var json = await response.transform(UTF8.decoder).join();
        var data = JSON.decode(json);
        result = data['gender'];
      } else {
        result =
            'Error getting IP address:\nHttp status ${response.statusCode}';
            
      }
    } catch (exception) {
      
      result = 'Failed getting IP address';
    }
    
    return new Future.value(result) ; 
}
Future<List> getCoupleList() async{
  final _url = apiUrl + nsPM + pCouple;
  var _retList = new List(); 
  try {
  var str = await getRESTJsonString(_url);
  if (str !='Error'){
    var jsonList = toList(str);
     for (var map in jsonList) {
      _retList.add(map["personId"]);
    } 
  } else {
    _retList.add(" ");
  }
  } catch(exception){
    print(exception.toString());
  }
  return _retList; 
}

Future<List<Promise>> getPMList(String personId) async{
  //get status list
  final _statusUrl= apiUrl + nsPM + aPromiseStatus;
  Map<String,String> statusMap ;
  var strStatus = await getRESTJsonString(_statusUrl);
  if (strStatus !='Error'){
    final List<Map> jsonStatusList = toList(strStatus);
    statusMap = new Map<String,String>.fromIterable(jsonStatusList, 
      key:(Map m) => m['promiseId'].toString(),
      value: (Map m) => m['status'].toString());
    print(statusMap.toString());
  }


  //get promise list 
  final _url = apiUrl + nsPM + aPromise;
  var _retList = new List();
  var str = await getRESTJsonString(_url);
  if (str !='Error'){
    var jsonList = toList(str); 
     for (var map in jsonList) {
       var promise = new Promise.fromJson(map);
       promise.status = statusMap[promise.promiseId];
       _retList.add(promise);
     // _retList.add(_getPersonIdByResource(map["promiseFrom"]));
    }
  }
  return _retList; 
}
Future<List<PromiseHistory>> getTxHistoryList(String pmId, String currenStatus) async{
  var _txhisUrl = apiUrl + nsPM + tNegociate;
  var _retList = [];
  final _filter = "?filter=%7B%22where%22%3A%7B%22promiseId%22%3A%22"+pmId+"%22%7D%7D";
  var strHistory = await getRESTJsonString(_txhisUrl+_filter);
  if (strHistory !='Error'){
    final List<Map> jsonHistoryList = toList(strHistory);
    for (var map in jsonHistoryList) {
      _retList.add(new PromiseHistory.fromJson(map,"Negociating"));
    }
  }
  return _retList ; 
}
Future<List<Promise>> getTxList(String pmId,String status) async{
  //get status list
  final _statusUrl= apiUrl + nsPM + aPromiseStatus;
  Map<String,String> statusMap ;
  var strStatus = await getRESTJsonString(_statusUrl);
  if (strStatus !='Error'){
    final List<Map> jsonStatusList = toList(strStatus);
    statusMap = new Map<String,String>.fromIterable(jsonStatusList, 
      key:(Map m) => m['promiseId'].toString(),
      value: (Map m) => m['status'].toString());
    print(statusMap.toString());
  }
}