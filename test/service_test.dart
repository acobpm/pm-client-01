import "package:test/test.dart";
import "package:pm_client_01/service/remote.dart";


void main() {
  test("Remote Connection", () async {
    print("Start remote");
    
    var f  = await getConnection();
    
    //f.then((String s){r = s;});
    print( f ); 
   
   // expect(strDate, equals("25/12/2013 23:54:00"));
  });

  test("String.trim() removes surrounding whitespace", () {
    var string = "  foo ";
    expect(string.trim(), equals("foo"));
  });
}