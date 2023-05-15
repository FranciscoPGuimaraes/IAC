import 'package:hive/hive.dart';

class CrudHive {
  late final Box box = Hive.box('peopleBox');

  addInfo(nome) async {
    await box.put("nome", nome);
    print("adicionado");
  }

  getInfo() {
    var name = box.get("nome");
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