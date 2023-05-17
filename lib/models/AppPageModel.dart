class AppScreenArguments {
  final String name;
  final String dowload;
  final String upload;

  AppScreenArguments(
    this.name, 
    this.dowload, 
    this.upload
  );

  factory AppScreenArguments.toAppScreenArguments(obj){
    AppScreenArguments objA = AppScreenArguments(obj.name, obj.download, obj.upload);
    return objA;
  }

}