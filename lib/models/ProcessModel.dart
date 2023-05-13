class ProcessListModel {
  final Map<String, ProcessModel> processes;

  ProcessListModel({required this.processes});

  factory ProcessListModel.fromJson(Map<String, dynamic> json) {
    var processMap = Map<String, ProcessModel>.fromEntries(json.entries.map((entry) {
      var id = entry.key;
      var processJson = entry.value as Map<String, dynamic>;
      var process = ProcessModel.fromJson(processJson);
      return MapEntry(id, process);
    }));

    return ProcessListModel(processes: processMap);
  }
}

class ProcessModel {
  late final int id;
  final String name;
  final DateTime createTime;
  final DateTime lastTimeUpdated;
  final String upload;
  final String download;
  final String uploadSpeed;
  final String downloadSpeed;

  ProcessModel({
    required this.id,
    required this.name,
    required this.createTime,
    required this.lastTimeUpdated,
    required this.upload,
    required this.download,
    required this.uploadSpeed,
    required this.downloadSpeed,
  });

  factory ProcessModel.fromJson(Map<String, dynamic> json) {
    return ProcessModel(
      id: int.parse(json['id']),
      name: json['name'],
      createTime: DateTime.parse(json['create_Time']),
      lastTimeUpdated: DateTime.parse(json['last_time_updated']),
      upload: json['upload'],
      download: json['download'],
      uploadSpeed: json['upload_speed'],
      downloadSpeed: json['download_speed'],
    );
  }
}