class Product{
  int id;
  int userId;
  String title;
  String body;
  String image;
  String price;
  DateTime createAt;
  DateTime updatedAt;

  Product.formJson(Map<String,dynamic> parsedJson){
    id = parsedJson['id'];
    userId = parsedJson['userId'];
    title = parsedJson['title'];
    body = parsedJson['body'];
    image = parsedJson['image'];
    price = parsedJson['price'];
    createAt = parsedJson['createAt'];
    updatedAt = parsedJson['updateAt'];
  }
}