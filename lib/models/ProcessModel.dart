
class ProcessModel {
  final String name;
  final String upload;
  final String download;
  final String uploadSpeed;
  final String downloadSpeed;

  ProcessModel({
    required this.name,
    //required this.createTime,
    //required this.lastTimeUpdated,
    required this.upload,
    required this.download,
    required this.uploadSpeed,
    required this.downloadSpeed,
  });

  factory ProcessModel.fromJson(Map<String, dynamic> json) {
    return ProcessModel(
      name: json['name'],
      upload: json['upload'],
      download: json['download'],
      uploadSpeed: json['upload_speed'],
      downloadSpeed: json['download_speed'],
    );
  }
}