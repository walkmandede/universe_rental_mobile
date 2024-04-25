class ListingPlace{
  String id;
  String name;


  ListingPlace({
    required this.id,
    required this.name,
  });

  factory ListingPlace.fromApi({required Map<String,dynamic> data}){
    return ListingPlace(
      id: data["id"].toString(),
      name: data["name"].toString(),
    );
  }

}