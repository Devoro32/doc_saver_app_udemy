class FileCardModel {
  final String title;
  final String subTitle;
  final String dateAdded;
  final String fileType;
  final String fileUrl;
  final String fileName;

  FileCardModel({
    required this.title,
    required this.subTitle,
    required this.dateAdded,
    required this.fileUrl,
    required this.fileType,
    required this.fileName,
  });

//create a factory contructor that will automatically take the values from the database
//and place them into a list view
  factory FileCardModel.fromJson(Map<dynamic, dynamic> json) {
    return FileCardModel(
      title: json['title'].toString(),
      subTitle: json['note'].toString(),
      dateAdded: json['dateAdded'].toString(),
      fileUrl: json['fileUrl'].toString(),
      fileType: json['fileType'].toString(),
      fileName: json['fileName'].toString(),
    );
  }
}
