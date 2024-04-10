
class ListingOffer{
  String id;
  String name;
  String icon;

  ListingOffer({
    required this.id,
    required this.name,
    required this.icon,
  });

  factory ListingOffer.fromApi({required Map<String,dynamic> data}){
    return ListingOffer(
      id: data["id"].toString(),
      name: data["name"].toString(),
      icon: data["icon"].toString(),
    );
  }

}