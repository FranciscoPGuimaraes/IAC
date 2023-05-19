import 'package:hive/hive.dart';

class CrudHivePlano {
  late final Box box = Hive.box('plano');

  addInfo(plano) async {
    await box.put("plano", plano);
  }

  getInfo() {
    return box.get("plano");
  }
  	
  close(){
    Hive.close();
  }
}