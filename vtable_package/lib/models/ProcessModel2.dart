class ProcessModel2 {
  final String name;
  final String upload;
  final String download;
  //final String uploadSpeed;
  //final String downloadSpeed;

  ProcessModel2({
    required this.name,
    //required this.createTime,
    //required this.lastTimeUpdated,
    required this.upload,
    required this.download,
    //required this.uploadSpeed,
    //required this.downloadSpeed,
  });

  factory ProcessModel2.fromJson(Map<String, dynamic> json) {
    return ProcessModel2(
      name: json['name'],
      upload: json['upload'],
      download: json['download'],
      //uploadSpeed: json['upload_speed'],
      //downloadSpeed: json['download_speed'],
    );
  }

  factory ProcessModel2.toProcessModel2(obj){
    final obj2 = ProcessModel2(download: obj.download, name: obj.name, upload: obj.upload);
    return obj2;
  }

}