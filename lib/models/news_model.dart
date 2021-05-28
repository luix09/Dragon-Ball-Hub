class NewsModel {
 final String title;
 final String description;
 final String date;
 final String img;
 final String url;
 final String source;
 final String category;

 NewsModel({
   required this.title,
   required this.description,
   required this.date,
   required this.img,
   required this.url,
   required this.source,
   required this.category,
 });

 factory NewsModel.fromJson(Map<String, dynamic> json) {
   return NewsModel(
       title: json['title'],
       description: json['description'],
       date: json['date'],
       img: json['img'],
       url: json['url'],
       source: json['source'],
       category: json['category']);
 }
}