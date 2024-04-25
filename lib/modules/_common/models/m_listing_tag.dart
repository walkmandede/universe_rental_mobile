
class ListingTag{

  String id;
  String name;
  String icon;

  ListingTag({
    required this.id,
    required this.name,
    required this.icon,
  });

  factory ListingTag.fromMap({required Map<String,dynamic> data}){
    return ListingTag(
      id: data["id"].toString(),
      name: data["name"].toString(),
      icon: data["icon"].toString(),
    );
  }

}