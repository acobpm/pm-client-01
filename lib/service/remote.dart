import 'dart:convert';
import 'dart:io';
import 'dart:async';
import '../util.dart';
import '../model/data.dart';

//const apiUrl = 'http://192.168.1.17:3000/api/';
//const apiUrl = 'http://192.168.1.8:3000/api/';
const apiUrl = 'http://ec2-18-221-194-119.us-east-2.compute.amazonaws.com:3000/api/';
const nsPM = 'com.acob.promiseme.';
const pCouple = "Couple";
const aPromise = "PromiseMe";
const aPromiseStatus = "PromiseStatus";
const cResource = "resource";
const tConfirmPromise = "ConfirmPromise";
const tMakePromise = "MakePromise";
const tNegotiatePromise = "NegotiatePromise";
const tFulfillPromise  = "FulfillPromise";
const tCompletePromise  = "CompletePromise";
Future<String> getRESTJsonString(String url) async {
var httpClient = new HttpClient();

    String result;
    
    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      
      var response = await request.close();
      
      if (response.statusCode == HttpStatus.OK) {
        
        var json = await response.transform(utf8.decoder).join();
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
        
        var json = await response.transform(utf8.decoder).join();
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
Future<List<String>> getCoupleList() async{
  final _url = apiUrl + nsPM + pCouple; 
  var _retList = new List<String>(); 
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
Future<Couple> getCouple(String personName) async{
  final _url = apiUrl + nsPM + pCouple + "/"  + personName; 
  Couple person ; 
  try {
  var str = await getRESTJsonString(_url);
  if (str !='Error'){ 
    var map = toMap(str);
    if (map!=null){
      person = Couple.fromJson(map);
    }
  } else {
    return null;
  }
  } catch(exception){
    print(exception.toString());
    return null;
  }
  return person; 
}

Future<List<Promise>> getPMList(String personId) async{
  //get status list


var _filter = '{"where":{"or":[{"promiseFrom":"resource:com.acob.promiseme.Couple#$personId"},{"promiseTo":"resource:com.acob.promiseme.Couple#$personId"}]}}';
  final _statusUrl= apiUrl + nsPM + aPromiseStatus;
  Map<String,String> statusMap ;
  var strStatus = await getRESTJsonString(_statusUrl);
  if (strStatus !='Error'){
    final jsonStatusList = toList(strStatus);
    statusMap = new Map.fromIterable(jsonStatusList, 
      key:(var m) => m['promiseId'].toString(),
      value: (var m) => m['status'].toString());
    print(statusMap.toString());
  }



  //get promise list 
  final _url = apiUrl + nsPM + aPromise + '?filter=' +Uri.encodeQueryComponent(_filter);
  
  //final _url =apiUrl + nsPM + aPromise + _filter;
  var _retList = new List<Promise>();
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

Future<Promise> getPromiseById(String pmId) async{
  
  //var _filter = '?filter={"where":{"promiseId": "$pmId"}}';
  var _url = Uri.encodeFull(apiUrl + nsPM + aPromiseStatus+"/"+pmId);
  var strStatus = await getRESTJsonString(_url);
  if (strStatus!='Error'){
      Map map = toMap(strStatus);
      return new Promise.fromJson(map);
  } else {
    return null;
  }
}
Future<PromiseStatus> getPromiseStatus(String pmId) async{
  
  //var _filter = '?filter={"where":{"promiseId": "$pmId"}}';
  var _url = Uri.encodeFull(apiUrl + nsPM + aPromiseStatus+"/"+pmId);
  var strStatus = await getRESTJsonString(_url);
  if (strStatus!='Error'){
      Map map = toMap(strStatus);
      return new PromiseStatus.fromJson(map);
  } else {
    return null;
  }
  


}
Future<List<PromiseHistory>> getTxHistoryList(String pmId, String currenStatus) async{
  var _txhisUrl = apiUrl + nsPM + tNegotiatePromise;
  //final _filter = "?filter=%7B%22where%22%3A%7B%22promiseId%22%3A%22"+pmId+"%22%7D%7D";
  //final _filter = '?filter={"where":{"promiseId":"'+pmId+'"}}"';
  
  var _filter = '?filter={"where":{"promiseId": "$pmId"}}';
  var _url ="";
  List<PromiseHistory> combinedList = [];
List<PromiseHistory> currentList = [];
  switch (currenStatus) {
    case "CLOSED":
      _txhisUrl = apiUrl + nsPM + tCompletePromise;
      _url = Uri.encodeFull(_txhisUrl+_filter);
      currentList = await getPromiseHistoryListByUrl(_url,"CLOSED");
      if (currentList!=null && currentList.length>0){
        combinedList.insertAll(combinedList.length, currentList);
      }
      continue COMPLETED;
    COMPLETED:
    case "COMPLETED":
      _txhisUrl = apiUrl + nsPM + tFulfillPromise;
      _url = Uri.encodeFull(_txhisUrl+_filter);
      currentList = await getPromiseHistoryListByUrl(_url,"COMPLETED");
      if (currentList!=null && currentList.length>0){
        combinedList.insertAll(combinedList.length, currentList);
      }
      continue FULFILLING;
    FULFILLING:  
    case "FULFILLING":
      _txhisUrl = apiUrl + nsPM + tConfirmPromise;
      _url = Uri.encodeFull(_txhisUrl+_filter);
      currentList = await getPromiseHistoryListByUrl(_url,"FULFILLING");
      if (currentList!=null && currentList.length>0){
        combinedList.insertAll(combinedList.length, currentList);
      }
      continue NEGOTIATION;
    NEGOTIATION:
    case "NEGOTIATING":
      
      _txhisUrl = apiUrl + nsPM + tNegotiatePromise;
      _url = Uri.encodeFull(_txhisUrl+_filter);
      currentList = await getPromiseHistoryListByUrl(_url,"NEGOTIATING");
      if (currentList!=null && currentList.length>0){
        combinedList.insertAll(combinedList.length, currentList);
      }
      break;
        
    default:
    
  }
  
  return combinedList;
  
}
Future<List<PromiseHistory>> getPromiseHistoryListByUrl(String url, String historyStatus) async{
  List<PromiseHistory>  _retList = [];
  var strHistory = await getRESTJsonString(url);
  
  if (strHistory !='Error'){
    var jsonHistoryList = toList(strHistory);
    for (var map in jsonHistoryList) {
      _retList.add(new PromiseHistory.fromJson(map,historyStatus));
    }
  } 
  if (_retList!=null && _retList.length>1){
    _retList = _retList.reversed.toList();
  }
  return _retList ; 
}

void addNewPromise(Map<String, dynamic> jsonBody) async{
  try {
    HttpClient client = new HttpClient();
   
    final _url = apiUrl + nsPM + tMakePromise;
    var response = await performApiRequest(client, _url, jsonBody);
    print (response.toString());
  } catch (e) {
   // return "Error";
   print(e.toString());
  }
}
void updatePromise(String txnType, Map<String, dynamic> jsonBody) async{
  try {
    HttpClient client = new HttpClient();
    final _url = apiUrl + nsPM + txnType;
    var response = await performApiRequest(client, _url, jsonBody);
   
  } catch (e) {
   // return "Error";
   print(e.toString());
  }
}

Future<Map<String, dynamic>> performApiRequest(
    HttpClient client, String url, Map<String, dynamic> jsonBody,
    [String accessToken]) async {
  final String requestBody = json.encode(jsonBody);
  
  HttpClientRequest request = await client.postUrl(Uri.parse(url))
    //..headers.add(HttpHeaders.ACCEPT, ContentType.JSON)
    ..headers.contentType = ContentType.JSON
    ..headers.contentLength = requestBody.length
    ..headers.chunkedTransferEncoding = true;
  if (accessToken != null) {
    request.headers.add(HttpHeaders.AUTHORIZATION, 'Bearer $accessToken');
  }
  request.write(requestBody);
  HttpClientResponse response = await request.close();
  if (response.headers.contentType.toString() != ContentType.JSON.toString()) {
    //throw new UnsupportedError('Server returned an unsupported content type: '
    //      '${response.headers.contentType} from ${request.uri}');
  }
  if (response.statusCode != HttpStatus.OK) {
    // throw new StateError(
    //     'Server responded with error: ${response.statusCode} ${response.reasonPhrase}');
  }
  return json.decode(await response.transform(utf8.decoder).join());
}