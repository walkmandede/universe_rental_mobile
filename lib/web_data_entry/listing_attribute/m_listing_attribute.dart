class ListingAttribute{
  String id;
  String name;


  ListingAttribute({
    required this.id,
    required this.name,
  });

  factory ListingAttribute.fromApi({required Map<String,dynamic> data}){
    return ListingAttribute(
      id: data["id"].toString(),
      name: data["name"].toString(),
    );
  }

}