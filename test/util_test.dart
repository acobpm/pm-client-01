import "package:test/test.dart";
import "package:pm_client_01/util.dart";

void main() {
  test("Util formatDate()", () {
    
    var date = new DateTime(2013,12,25,23,54,00);
    var strDate = formatDate(date, "F");
    expect(strDate, equals("25/12/2013 23:54:00"));
  });

  test("String.trim() removes surrounding whitespace", () {
    var string = "  foo ";
    
    expect(string.trim(), equals("foo"));
  });
}