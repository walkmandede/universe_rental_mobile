class ListingAttribute {
  String id;
  String name;
  String description;

  ListingAttribute(
      {required this.id, required this.name, required this.description});

  factory ListingAttribute.fromApi({required Map<String, dynamic> data}) {
    return ListingAttribute(
        id: data["id"].toString(),
        name: data["name"].toString(),
        description: data['description'].toString());
  }
}
