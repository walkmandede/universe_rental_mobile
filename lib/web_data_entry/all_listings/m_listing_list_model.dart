class ListingListModel {
  String id;
  String title;
  String address;
  ListingListModel(
      {required this.id, required this.title, required this.address});

  factory ListingListModel.fromApi(Map<String, dynamic> data) {
    return ListingListModel(
        id: data['id'],
        title: data['title'],
        address: data['listingLocation']['fullAddress']);
  }
}
