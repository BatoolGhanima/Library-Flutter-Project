class Book {
 final String name;
 final String author;
 final String category;
 final int date;
 final String about;
 final String image;
 final int count;
 final String pdfUrl;
 Book({required this.name,required this.author , required this.category, required this.image  , required this.about,required this.count , required this.date ,required this.pdfUrl,});
Map<String , dynamic> toMap(){
  return {
    'name' : name,
    'author' : author,
    'about' : about,
    'category': category,
    'date' : date,
    'image': image,
    'count':count,
    'pdfUrl': pdfUrl,
    

  };
}
factory Book.fromMap(Map<String , dynamic> map){
  return Book(name: map['name'], author: map['author'], category: map['category'], image: map['image'], about: map['about'], count: map['count'], date: map['date'], pdfUrl: map['pdfUrl']);
}
}