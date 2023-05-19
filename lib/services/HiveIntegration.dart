import 'package:hive/hive.dart';

import '../helpers/converter.dart';
import '../models/ProcessModel.dart';

class CrudHive {
  late final Box box = Hive.box('history_app');

  addInfoSummed(String date, List<ProcessModel> data) async {
    var keyName;
    var value;
    for (var element in data) {
      keyName = "${element.name.replaceAll(".exe", "")}_$date";
      value = sumAndConvertToMb(element.download,element.upload);
      await box.put(keyName, [value,date]);
    }
    print("adicionados");
  }
  /*
  addInfo(date,process,download,upload) async {
    await box.put(date+"_"+upload, date);
    await box.put(date+"_"+process, process);
    await box.put(date+"_"+download, download);
    await box.put(date+"_"+upload, upload);
    print("adicionados");
  }*/

  getHistory(String name) {
    final regex = RegExp(r'^'+name.replaceAll(".exe", ""));
    List<dynamic> dates = [];

    //print(name);

    for (var element in box.keys) {
      if(regex.hasMatch(element)){
        dates.add(box.get(element));
      }
    }
    //print(dates);
    return dates;
  }

  getInfo() {
    print(box.values.runtimeType);
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