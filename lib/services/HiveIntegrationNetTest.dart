import 'package:hive/hive.dart';

class CrudHiveNet {
  late final Box box = Hive.box('net_tests');

  addInfoNetTest(date,upload,download,ping) async {
    await box.put(date, [date, ping, download, upload]);
  }

  getInfo() {
    return Hive.box('net_tests').values;
  }
  	
  close(){
    Hive.close();
  }
}