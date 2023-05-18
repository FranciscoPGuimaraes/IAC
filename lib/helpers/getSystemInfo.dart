import  'package:intl/intl.dart';

String getDate(){
    String tdata = DateFormat("yyyy-MM-dd_HH:mm:ss").format(DateTime.now());
    return tdata;
}