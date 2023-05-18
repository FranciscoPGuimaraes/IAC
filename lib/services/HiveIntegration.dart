import 'package:ViasatMonitor/models/NetTestHiveModel.dart';
import 'package:hive/hive.dart';

class CrudHive {
  late final Box box = Hive.box('box');

  /*addInfoSummed(String date,double data) async {
    await box.put(date, data);
    print("adicionados");
  }

  addInfo(date,process,download,upload) async {
    await box.put(date+"_"+upload, date);
    await box.put(date+"_"+process, process);
    await box.put(date+"_"+download, download);
    await box.put(date+"_"+upload, upload);
    print("adicionados");
  }*/

  getInfo() {
    var name = box.get("2023-05-17_20-34");
    print("Nome: $name");
  }

  updateInfo() {
    // Update info of people box
  }

  deleteInfo() {
    // Delete info from people box
  }
  	
  close(){
    Hive.close();
  }
}