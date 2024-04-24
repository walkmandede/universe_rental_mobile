class ListingTag {
  String id;
  String name;
  String icon;

  ListingTag({
    required this.id,
    required this.name,
    required this.icon,
  });

  factory ListingTag.fromApi({required Map<String, dynamic> data}) {
    return ListingTag(
      id: data["id"].toString(),
      name: data["name"].toString(),
      icon: data["icon"] == ""
          ? '''<svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-24-hours" width="44" height="44" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
  <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
  <path d="M4 13c.325 2.532 1.881 4.781 4 6" />
  <path d="M20 11a8.1 8.1 0 0 0 -15.5 -2" />
  <path d="M4 5v4h4" />
  <path d="M12 15h2a1 1 0 0 1 1 1v1a1 1 0 0 1 -1 1h-1a1 1 0 0 0 -1 1v1a1 1 0 0 0 1 1h2" />
  <path d="M18 15v2a1 1 0 0 0 1 1h1" />
  <path d="M21 15v6" />
</svg>'''
          : data["icon"].toString(),
    );
  }
}
