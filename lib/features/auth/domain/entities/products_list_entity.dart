


class ProductsListEntity {
  num id;
  String title;
  num price;
  String description;
  String category;
  String image;
  RatingEntity rating;

  ProductsListEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });
}

class RatingEntity {
  num rate;
  num count;

  RatingEntity({required this.rate, required this.count});
}
