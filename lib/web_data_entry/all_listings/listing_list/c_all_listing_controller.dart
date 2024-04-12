import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:universe_rental/web_data_entry/_common/models/m_night_fee_model.dart';
import 'package:universe_rental/web_data_entry/currency/m_currency_model.dart';
import 'package:universe_rental/web_data_entry/listing_attribute/m_listing_attribute.dart';
import 'package:universe_rental/web_data_entry/listing_offers/m_listing_tag.dart';
import 'package:universe_rental/web_data_entry/listing_place/m_listing_place.dart';
import 'package:universe_rental/web_data_entry/listing_tags/m_listing_tag.dart';
import 'package:universe_rental/web_data_entry/listing_type/m_listing_type.dart';

import '../m_listing_model.dart';

class AllListingController extends GetxController {
  ValueNotifier<List<ListingModel>> allData = ValueNotifier([]);

  @override
  void onInit() {
    initLoad();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Future<void> initLoad() async {
    updateData();
  }

  Future<void> updateData() async {
    allData.value = [
      ListingModel(
          id: "12322322",
          title: "Some Title",
          about: "241455",
          subTitle: 'subtitle',
          listingType: ListingType(id: 'nikni', name: 'Entire House'),
          listingTags: [
            ListingTag(
                id: "we3wew3232",
                name: "beach house",
                icon:
                    '''<?xml version="1.0" ?><!DOCTYPE svg  PUBLIC '-//W3C//DTD SVG 1.1//EN'  'http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd'><svg enable-background="new 0 0 128 128" id="Layer_1" version="1.1" viewBox="0 0 128 128" xml:space="preserve" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path d="M121,112c0,1.1-0.9,2-2,2H18c-1.1,0-2-0.9-2-2V33c0-1.1,0.9-2,2-2H119c1.1,0,2,0.9,2,2V112z" fill="#FFFFFF"/><path d="M121,112c0,1.1-0.9,2-2,2H18c-1.1,0-2-0.9-2-2V33  c0-1.1,0.9-2,2-2H119c1.1,0,2,0.9,2,2V112z" fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2"/><path d="M56,114h10v2h-9.4c-0.3,0-0.6-0.4-0.6-0.6V114z" fill="#53AF80"/><path d="M56,114h10v2h-9.4c-0.3,0-0.6-0.4-0.6-0.6V114z" fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2"/><path d="M56,31h10v-2h-9.4c-0.3,0-0.6,0.3-0.6,0.6V31z" fill="#53AF80"/><path d="M56,31h10v-2h-9.4c-0.3,0-0.6,0.3-0.6,0.6V31z" fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2"/><rect fill="#C1C1C0" height="83" width="10" x="6" y="30"/><rect fill="none" height="83" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2" width="10" x="6" y="30"/><path d="M15.9,49.8c0,0,5.9-19.8,5.2-19.8h-8.8c-0.3,0-0.5,0.1-0.5,0.4l3.8,19.8C15.7,50.5,15.9,50.2,15.9,49.8z" fill="#53AF80"/><path d="  M21,30h-8.7c-0.3,0-0.5,0.1-0.5,0.4l3.8,19.7c0.1,0.3,0.2,0.2,0.2-0.2" fill="none" stroke="#3D3D3D" stroke-linecap="round" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2"/><path d="M5,49.6C5,50,5.3,50.3,5.4,50l3.9-19.6C9.3,30.1,9.1,30,8.8,30H5V49.6z" fill="#53AF80"/><path d="  M5,49.6C5,50,5.3,50.3,5.4,50l3.9-19.6C9.3,30.1,9.1,30,8.8,30H5V49.6z" fill="none" stroke="#3D3D3D" stroke-linecap="round" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2"/><path d="M16,49.6V33.5c0-2.2,1.4-3.5,3.6-3.5h16.1c0.4,0,0.7,0.3,0.3,0.6L16.7,50.1C16.4,50.4,16,50,16,49.6z" fill="#53AF80"/><path d="M123,49.6V33.5c0-2.2-2.2-3.5-4.4-3.5h-16.3c-0.4,0-0.7,0.3-0.3,0.6l19.8,19.4C122.2,50.4,123,50,123,49.6z" fill="#53AF80"/><path d="M123,94.5v15.9c0,2.2-2.2,3.6-4.4,3.6h-16.3c-0.4,0-0.7-0.3-0.3-0.6L121.9,94C122.2,93.7,123,94.1,123,94.5z  " fill="#53AF80"/><path d="M16,49.6V33.5c0-2.2,1.4-3.5,3.6-3.5h16.1  c0.4,0,0.7,0.3,0.3,0.6L16.7,50.1C16.4,50.4,16,50,16,49.6z" fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2"/><path d="M15.9,94.1c0,0,5.9,19.9,5.2,19.9h-8.8c-0.3,0-0.5-0.2-0.5-0.5l3.8-19.8C15.7,93.4,15.9,93.6,15.9,94.1z" fill="#53AF80"/><path d="  M21,114h-8.7c-0.3,0-0.5-0.2-0.5-0.5l3.8-19.7c0.1-0.3,0.2-0.1,0.2,0.3" fill="none" stroke="#3D3D3D" stroke-linecap="round" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2"/><path d="M5,94.2c0-0.4,0.3-0.7,0.4-0.3l3.9,19.7c0.1,0.3-0.1,0.5-0.4,0.5H5V94.2z" fill="#53AF80"/><path d="  M5,94.2c0-0.4,0.3-0.7,0.4-0.3l3.9,19.7c0.1,0.3-0.1,0.5-0.4,0.5H5V94.2z" fill="none" stroke="#3D3D3D" stroke-linecap="round" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2"/><path d="M16,94.2v16.1c0,2.2,1.4,3.8,3.6,3.8h16.1c0.4,0,0.7-0.5,0.3-0.8L16.7,93.8C16.4,93.5,16,93.7,16,94.2z" fill="#53AF80"/><path d="M16,94.2v16.1c0,2.2,1.4,3.8,3.6,3.8h16.1  c0.4,0,0.7-0.5,0.3-0.8L16.7,93.8C16.4,93.5,16,93.7,16,94.2z" fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2"/><path d="M123,49.6V33.5c0-2.2-2.2-3.5-4.4-3.5h-16.3  c-0.4,0-0.7,0.3-0.3,0.6l19.8,19.4C122.2,50.4,123,50,123,49.6z" fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2"/><path d="M123,94.5v15.9c0,2.2-2.2,3.6-4.4,3.6h-16.3  c-0.4,0-0.7-0.3-0.3-0.6L121.9,94C122.2,93.7,123,94.1,123,94.5z" fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2"/><path d="M75,29.5c0-0.3-0.2-0.5-0.5-0.5h-10c-0.3,0-0.5,0.2-0.5,0.5v86c0,0.3,0.2,0.5,0.5,0.5h10  c0.3,0,0.5-0.2,0.5-0.5V29.5z" fill="#8DCEA8"/><path d="M75,29.5c0-0.3-0.2-0.5-0.5-0.5h-10  c-0.3,0-0.5,0.2-0.5,0.5v86c0,0.3,0.2,0.5,0.5,0.5h10c0.3,0,0.5-0.2,0.5-0.5V29.5z" fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2"/><polyline fill="none" points="64.4,89.5 69.9,93.7 74.6,89.9 " stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2"/><path d="M77,85.5c0,0.3-0.2,0.5-0.5,0.5h-13c-0.3,0-0.5-0.2-0.5-0.5v-1c0-0.3,0.2-0.5,0.5-0.5h13  c0.3,0,0.5,0.2,0.5,0.5V85.5z" fill="#E2E2E2"/><path d="M77,85.5c0,0.3-0.2,0.5-0.5,0.5h-13  c-0.3,0-0.5-0.2-0.5-0.5v-1c0-0.3,0.2-0.5,0.5-0.5h13c0.3,0,0.5,0.2,0.5,0.5V85.5z" fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2"/><circle cx="69.5" cy="41.7" fill="#3D3D3D" r="1.7"/><circle cx="69.5" cy="47.7" fill="#3D3D3D" r="1.7"/><circle cx="69.5" cy="53.7" fill="#3D3D3D" r="1.7"/><circle cx="69.9" cy="59.7" fill="#3D3D3D" r="1.7"/><ellipse cx="69.5" cy="65.9" fill="#3D3D3D" rx="1.7" ry="1.9"/><circle cx="69.5" cy="76" fill="#3D3D3D" r="1.7"/><path d="M79,61c0-1.1-0.9-2-2-2H62c-1.1,0-2,0.9-2,2V70c0,1.1,0.9,2,2,2H77c1.1,0,2-0.9,2-2V61z M77,70H63v-9h14V70z  " fill="#E2E2E2"/><path d="M79,70c0,1.1-0.9,2-2,2H62c-1.1,0-2-0.9-2-2V61  c0-1.1,0.9-2,2-2H77c1.1,0,2,0.9,2,2V70z" fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2"/><rect fill="none" height="7" stroke="#3D3D3D" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2" width="13" x="63" y="62"/><rect fill="#FFFFFF" height="7" width="1" x="69" y="66"/><rect fill="#8DCEA8" height="13.8" transform="matrix(-0.2479 0.9688 -0.9688 -0.2479 188.1328 -25.2419)" width="3.4" x="102.1" y="53.5"/><rect fill="none" height="7" stroke="#3D3D3D" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2" width="1" x="69" y="66"/><path d="M108.8,67l-12.4-3.2c-0.3-0.1-0.4-0.3-0.4-0.6  l2.3-9.1c0.1-0.3,0.3-0.4,0.6-0.4l12.4,3.2c0.3,0.1,0.4,0.3,0.4,0.6l-2.3,9.1C109.3,66.9,109.1,67.1,108.8,67z" fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2"/><polygon fill="none" points="36.7,56.4   42.5,55.4 40.9,54.4 44.3,49.1 42.5,49.4 42.4,46.7 40.2,48.1 39.4,45.9 37.4,50.1 36.4,43.7 34.6,45.6 31.8,42.8 31.4,46.7   28.8,46.4 32.1,52 27.9,50 28.6,52.2 26.1,52.5 27.8,54.6 26.1,55.6 32.2,57.5 31.5,59.3 " stroke="#3D3D3D" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2"/><line fill="none" stroke="#3D3D3D" stroke-linecap="round" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2" x1="34.5" x2="38.1" y1="50.2" y2="60.4"/><line fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2" x1="97.6" x2="111" y1="57" y2="60.4"/><line fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2" x1="96.8" x2="110.1" y1="60.4" y2="63.8"/><path d="M89.5,106.2c0,0,3.4-7.5,0.1-18.5" fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2"/><path d="M102.3,102.3c0,0-7.5-4.2-10.8-15.2" fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2"/><line fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2" x1="87.6" x2="93.8" y1="106.8" y2="104.8"/><line fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2" x1="97.7" x2="103.9" y1="103.7" y2="101.8"/><path d="M92.5,105.3c-0.6-1.8,0.4-3.8,2.2-4.3  c1.8-0.5,3.7,0.5,4.3,2.3" fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2"/><polygon fill="none" points="89.4,87.7 88,85.8 89.4,83.9 91.7,84.7   91.6,87 " stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2"/><line fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2" x1="89.5" x2="88.9" y1="84" y2="82.1"/><line fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2" x1="89.5" x2="95.6" y1="95.1" y2="93.3"/><line fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2" x1="88.9" x2="99" y1="100.4" y2="97.4"/><path d="M111.1,83.8  c-1.9-1.3-3.6-2.7-5.2-4.3c-0.8-0.8-1.7-1.7-2-2.8c-0.3-1.1,0.1-2.6,1.2-3c0.5-0.2,1.1-0.2,1.6,0c1.3,0.4,2.3,1.4,2.7,2.7  c0-0.5,0.4-0.9,0.8-1.2c1.2-0.8,2.6-1.1,4-0.9c1.1,0.2,2.2,0.9,2.3,1.9c0.1,0.7-0.4,1.4-0.8,2c-0.8,0.9-1.8,1.7-2.7,2.5  C112,81.5,111.3,82.6,111.1,83.8z" fill="none" stroke="#3D3D3D" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2"/><path d="M79,28v-2.4c0-4.2-1.6-8.5-13.5-8.5c-11.9,0-13.5,4.3-13.5,8.5V28h-3v-2.4c0-12,12.3-12,17-12  c4.7,0,17,0,17,12V28H79z" fill="#C1C1C0"/><path d="M50.6,28H38.8c-0.3,0-0.8,0.3-0.8,0.6V31h13v-2.4C51,28.3,50.9,28,50.6,28z" fill="#FFFFFF"/><path d="M79,28v-2.4c0-4.2-1.6-8.5-13.5-8.5  c-11.9,0-13.5,4.3-13.5,8.5V28h-3v-2.4c0-12,12.3-12,17-12c4.7,0,17,0,17,12V28H79z" fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2"/><path d="M90.8,28H79c-0.3,0,0,0.3,0,0.6V31h12v-2.4C91,28.3,91.1,28,90.8,28z" fill="#FFFFFF"/><path d="M90.8,28H79c-0.3,0,0,0.3,0,0.6V31h12v-2.4  C91,28.3,91.1,28,90.8,28z" fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2"/><path d="M93.8,28H82c-0.3,0-1,0.3-1,0.6V31h13v-2.4C94,28.3,94.1,28,93.8,28z" fill="#FFFFFF"/><path d="M93.8,28H82c-0.3,0-1,0.3-1,0.6V31h13v-2.4  C94,28.3,94.1,28,93.8,28z" fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2"/><path d="M50.6,28H38.8c-0.3,0-0.8,0.3-0.8,0.6V31h13v-2.4  C51,28.3,50.9,28,50.6,28z" fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2"/><polygon fill="#FFFFFF" points="26.9,85 21.7,78.9 25.8,72.1 33.6,73.9 34.3,81.8 "/><path d="M53.6,28H41.8c-0.3,0-0.8,0.3-0.8,0.6V31h13v-2.4C54,28.3,53.9,28,53.6,28z" fill="#FFFFFF"/><polygon fill="none" points="26.9,85 21.7,78.9   25.8,72.1 33.6,73.9 34.3,81.8 " stroke="#3D3D3D" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2"/><path d="M53.6,28H41.8c-0.3,0-0.8,0.3-0.8,0.6V31h13v-2.4  C54,28.3,53.9,28,53.6,28z" fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2"/><polygon fill="#E2E2E2" points="30.6,81.1 38,72.7 41.6,83.4 "/><polygon fill="none" points="30.6,81.1 38,72.7   41.6,83.4 " stroke="#3D3D3D" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2"/><line fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2" x1="6" x2="16" y1="61" y2="61"/><line fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2" x1="6" x2="16" y1="66" y2="66"/><line fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2" x1="6" x2="16" y1="71" y2="71"/><line fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2" x1="6" x2="16" y1="76" y2="76"/><line fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2" x1="6" x2="16" y1="81" y2="81"/></svg>
''')
          ],
          addressLocation: const LatLng(16.774617296225806, 96.15883738225342),
          dailyNightData: {
            "2021-2-02": [
              NightFeeModel(
                  perNightFee: 2000,
                  currencyModel: CurrencyModel(
                      abbr: "Ks",
                      id: "23232",
                      name: "Myanmar Kyat",
                      sign: "MMK")),
              NightFeeModel(
                  perNightFee: 2,
                  currencyModel: CurrencyModel(
                      abbr: "\$", id: "joij", name: "US  Dollar", sign: "USD"))
            ],
            "2021-2-19": [
              NightFeeModel(
                  perNightFee: 1000000000,
                  currencyModel: CurrencyModel(
                      abbr: "Ks",
                      id: "23232",
                      name: "Myanmar Kyat",
                      sign: "MMK")),
              NightFeeModel(
                  perNightFee: 100,
                  currencyModel: CurrencyModel(
                      abbr: "\$", id: "joij", name: "US  Dollar", sign: "USD"))
            ],
          },
          addressRemark: 'Near Pansoedan',
          hostName: 'May',
          fullAddress: 'suleapgeogodfd',
          listingAttributesQty: {
            ListingAttribute(id: "23232", name: "name1"): 1
          },
          listingPlacesImages: {
            ListingPlace(id: 'fdfd', name: "place1"): [
              'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0d/bc/d4/38/grand-vista.jpg?w=1200&h=1200&s=1',
              'https://upload.wikimedia.org/wikipedia/commons/2/2a/Pyin_U_Lwin_Myanmar.jpg',
              'https://www.malaysia-traveller.com/images/National-Kandawgyi-Botanical-Gardens-flower-shop.jpg',
              'https://i0.wp.com/frustratedgardener.com/wp-content/uploads/2012/11/20121104-170628.jpg?ssl=1'
            ],
            ListingPlace(id: '2e32we', name: "place2"): [
              'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0d/bc/d4/38/grand-vista.jpg?w=1200&h=1200&s=1',
              'https://upload.wikimedia.org/wikipedia/commons/2/2a/Pyin_U_Lwin_Myanmar.jpg',
              'https://www.malaysia-traveller.com/images/National-Kandawgyi-Botanical-Gardens-flower-shop.jpg',
              'https://i0.wp.com/frustratedgardener.com/wp-content/uploads/2012/11/20121104-170628.jpg?ssl=1'
            ],
            ListingPlace(id: 'olijo', name: "place3"): [
              'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0d/bc/d4/38/grand-vista.jpg?w=1200&h=1200&s=1',
              'https://upload.wikimedia.org/wikipedia/commons/2/2a/Pyin_U_Lwin_Myanmar.jpg',
              'https://www.malaysia-traveller.com/images/National-Kandawgyi-Botanical-Gardens-flower-shop.jpg',
              'https://i0.wp.com/frustratedgardener.com/wp-content/uploads/2012/11/20121104-170628.jpg?ssl=1'
            ],
          },
          listingImages: [
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0d/bc/d4/38/grand-vista.jpg?w=1200&h=1200&s=1',
            'https://upload.wikimedia.org/wikipedia/commons/2/2a/Pyin_U_Lwin_Myanmar.jpg',
            'https://c8.alamy.com/comp/DGXB0W/the-national-kandawgyi-botanical-gardens-are-a-world-renowned-botanical-DGXB0W.jpg',
            'https://www.malaysia-traveller.com/images/National-Kandawgyi-Botanical-Gardens-flower-shop.jpg',
            'https://i0.wp.com/frustratedgardener.com/wp-content/uploads/2012/11/20121104-170628.jpg?ssl=1'
          ],
          offerList: [
            ListingOffer(id: "232", name: "Free wifi", icon: '''
<?xml version="1.0" ?><svg viewBox="0 0 356.8 431.51" xmlns="http://www.w3.org/2000/svg"><title/><g data-name="Layer 2" id="Layer_2"><g data-name="japan, tower, tokyo, landmark, travel, architecture, tourism, view" id="japan_tower_tokyo_landmark_travel_architecture_tourism_view"><path d="M158,147.22v74.9a5.47,5.47,0,1,0,10.93,0v-74.9a5.47,5.47,0,0,0-10.93,0Z"/><path d="M121.29,227.42a5.18,5.18,0,0,0,1.34.17,5.47,5.47,0,0,0,5.3-4.13c.47-1.86.93-3.75,1.39-5.63l13,8.81a5.46,5.46,0,0,0,6.14-9l-16.39-11.13q3.25-13.87,6.28-28.35l3.5,3a5.47,5.47,0,1,0,7.08-8.34l-8.09-6.86q2.42-12.18,4.66-24.66a5.47,5.47,0,0,0-10.76-1.93c-5.1,28.51-11,55.92-17.39,81.48A5.46,5.46,0,0,0,121.29,227.42Z"/><path d="M241.32,256.91a5.47,5.47,0,0,0-5.47,5.47v.68a5.47,5.47,0,0,0,10.93,0v-.68A5.46,5.46,0,0,0,241.32,256.91Z"/><path d="M241.32,237.22H85.67a5.47,5.47,0,0,0-5.47,5.47v49.59a5.47,5.47,0,0,0,5.47,5.47H241.32a5.46,5.46,0,0,0,5.46-5.47V281.74a5.47,5.47,0,0,0-10.93,0v5.07H91.13V248.15H241.32a5.47,5.47,0,0,0,0-10.93Z"/><path d="M123.92,96.9V120a5.47,5.47,0,0,0,5.47,5.47H197.6a5.47,5.47,0,0,0,5.47-5.47V96.9a5.47,5.47,0,0,0-10.94,0v17.64H134.85V102.36h42.24a5.47,5.47,0,0,0,0-10.93h-47.7A5.47,5.47,0,0,0,123.92,96.9Z"/><path d="M178.55,217.6a5.46,5.46,0,1,0,6.14,9l13-8.81c.46,1.88.92,3.77,1.39,5.63a5.46,5.46,0,0,0,5.29,4.13,5.18,5.18,0,0,0,1.34-.17,5.46,5.46,0,0,0,4-6.63c-6.44-25.56-12.3-53-17.4-81.48a5.47,5.47,0,0,0-10.76,1.93q2.24,12.48,4.66,24.66l-8.08,6.86a5.46,5.46,0,0,0,3.54,9.63,5.42,5.42,0,0,0,3.53-1.29l3.51-3q3,14.46,6.27,28.35Z"/><path d="M163.49,0A5.46,5.46,0,0,0,158,5.47V24.75h-2.81a5.46,5.46,0,0,0-5.45,5c0,.18-1.53,18.52-5.32,47.1a5.46,5.46,0,0,0,4.7,6.14,5.79,5.79,0,0,0,.72,0,5.45,5.45,0,0,0,5.41-4.74c2.67-20.12,4.23-35.24,4.93-42.63h6.57c.7,7.39,2.25,22.51,4.92,42.63a5.46,5.46,0,0,0,5.41,4.74,6,6,0,0,0,.73,0,5.47,5.47,0,0,0,4.7-6.14c-3.8-28.58-5.31-46.92-5.32-47.1a5.46,5.46,0,0,0-5.45-5H169V5.47A5.47,5.47,0,0,0,163.49,0Z"/><path d="M0,426a5.47,5.47,0,0,0,5.47,5.47H132.1a5.47,5.47,0,0,0,0-10.94H113.28L114.74,405a46.55,46.55,0,0,1,17.72-32.34,6.59,6.59,0,0,0,.57-.34,5.07,5.07,0,0,0,.85-.75,50.85,50.85,0,0,1,59.22,0,5.14,5.14,0,0,0,.86.75,6.42,6.42,0,0,0,.56.34A46.52,46.52,0,0,1,212.25,405l1.46,15.56H196.83a5.47,5.47,0,0,0,0,10.94H321.31a5.47,5.47,0,0,0,0-10.94h-20c-23.44-24.19-44.66-60.52-63.07-108.08a5.47,5.47,0,1,0-10.2,3.95q9.4,24.29,19.79,44.78l-20.07-5.31A5.47,5.47,0,1,0,225,366.48l29.82,7.89q15,27,31.68,46.2h-56.2l21.92-30.78a5.46,5.46,0,1,0-8.9-6.34L223.78,410.9l-.65-6.91a57.3,57.3,0,0,0-18.6-37.17l7.11-10.08h0l14.07-20a5.46,5.46,0,0,0-8.93-6.3L206.61,344.9l-21-22.63a5.47,5.47,0,1,0-8,7.43L200.17,354l-4.37,6.2A60.85,60.85,0,0,0,169,351.38V314.46a5.47,5.47,0,0,0-10.93,0v36.91a60.85,60.85,0,0,0-26.85,8.85L126.81,354l22.57-24.33a5.47,5.47,0,1,0-8-7.43l-21,22.63L110.2,330.47a5.46,5.46,0,0,0-8.93,6.3l14.06,20,0,0,7.1,10.06A57.33,57.33,0,0,0,103.86,404l-.65,6.91L83.66,383.45a5.46,5.46,0,0,0-8.9,6.34l21.92,30.78H40.48q16.68-19.2,31.67-46.2L102,366.48a5.47,5.47,0,1,0-2.8-10.57l-20.07,5.31q10.38-20.5,19.79-44.78a5.46,5.46,0,1,0-10.19-3.95c-18.42,47.56-39.63,83.89-63.07,108.08H5.47A5.47,5.47,0,0,0,0,426Z"/><path d="M163.49,420.57a5.47,5.47,0,0,0,0,10.94h2.59a5.47,5.47,0,0,0,0-10.94Z"/><path d="M348.75,420.57a5.47,5.47,0,0,0,0,10.94h2.58a5.47,5.47,0,0,0,0-10.94Z"/><path d="M118.45,262.1v13.12a5.47,5.47,0,0,0,10.94,0V262.1a5.47,5.47,0,0,0-10.94,0Z"/><path d="M158,262.1v13.12a5.47,5.47,0,0,0,10.93,0V262.1a5.47,5.47,0,0,0-10.93,0Z"/><path d="M197.6,262.1v13.12a5.47,5.47,0,0,0,10.93,0V262.1a5.47,5.47,0,0,0-10.93,0Z"/></g></g></svg>
''')
          ]),
      ListingModel(
          id: "121212121",
          title: "Kalaw ",
          about: "kalaw township",
          subTitle: 'kalaw view point',
          listingType: ListingType(id: 'ka323', name: 'Part House'),
          listingTags: [
            ListingTag(id: "we3wew3232", name: "kalaw house", icon: '''
<?xml version="1.0" ?><svg id="Layer_2" style="enable-background:new 0 0 1000 1000;" version="1.1" viewBox="0 0 1000 1000" xml:space="preserve" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><circle cx="225.928" cy="483.898" r="20.67" style="fill:#231F20;"/><path d="M167.038,410.238h5.77l-9.17,53c-4.08,23.58-0.85,47.84,9.26,69.53l2.69,5.78  c3.06,6.56,9.36,11,16.56,11.67l192.03,17.83l111.22-111.22c-74.42-0.29-148.83-7.52-222.23-21.74h-0.01  c-15.56-3.02-28.79-13.2-35.7-27.47c-4.19-8.68-10.69-15.78-18.54-20.7c-7.85-4.93-17.07-7.69-26.71-7.69h-25.17  c-8.42,0-15.23,6.82-15.23,15.23v0.55C151.808,403.418,158.617,410.238,167.038,410.238z M225.928,446.228  c20.77,0,37.67,16.9,37.67,37.67c0,20.77-16.9,37.67-37.67,37.67s-37.67-16.9-37.67-37.67  C188.258,463.128,205.158,446.228,225.928,446.228z" style="fill:#231F20;"/><path d="M832.252,379.229h-5.061h-19.399c-19.282,0-36.865,11.029-45.259,28.388v0  c-6.902,14.274-20.134,24.456-35.7,27.471h0c-50.225,9.727-100.92,16.176-151.769,19.382L456.657,572.877  c51.239,1.862,102.567,0.431,153.666-4.315l197.521-18.345c7.202-0.669,13.508-5.111,16.563-11.667  c11.861-25.454,15.652-53.927,10.865-81.597l-8.081-46.719h5.499c8.81,0,15.904-7.349,15.485-16.252  C847.782,385.644,840.6,379.229,832.252,379.229z" style="fill:#231F20;"/><path d="M604.924,410.625l79.955-70.646c6.411-5.665,6.717-15.563,0.667-21.613l-13.033-13.032  c-6.049-6.05-15.948-5.744-21.613,0.667l-70.646,79.955c-3.327,3.766-4.397,8.771-3.286,13.341L390.176,586.09  c-4.57-1.112-9.576-0.042-13.341,3.285l-79.955,70.646c-6.411,5.665-6.717,15.563-0.668,21.613l13.033,13.032  c6.05,6.05,15.948,5.744,21.613-0.667l70.646-79.955c3.327-3.766,4.397-8.771,3.285-13.341L591.582,413.91  C596.153,415.022,601.158,413.952,604.924,410.625z" style="fill:#231F20;"/></svg>
''')
          ],
          listingImages: [
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTt2vxLLGX0IZTmCWFhnn5D8VQSxh4NcALTh6m2B9GmzQ&s'
          ],
          addressLocation: const LatLng(16.774617296225806, 96.15883738225342),
          dailyNightData: {
            "2023-2-02": [
              NightFeeModel(
                  perNightFee: 300000,
                  currencyModel: CurrencyModel(
                      abbr: "Ks",
                      id: "323121",
                      name: "Myanmar Kyat",
                      sign: "MMK"))
            ]
          },
          addressRemark: 'Near Kalaw Center',
          hostName: 'May',
          fullAddress: 'kalaw address',
          listingAttributesQty: {
            ListingAttribute(id: "23232", name: "view"): 20
          },
          listingPlacesImages: {
            ListingPlace(id: 'fdfd', name: "place111"): [
              'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0d/bc/d4/38/grand-vista.jpg?w=1200&h=1200&s=1',
              'https://upload.wikimedia.org/wikipedia/commons/2/2a/Pyin_U_Lwin_Myanmar.jpg',
            ],
            ListingPlace(id: '2e32we', name: "place2222"): [
              'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0d/bc/d4/38/grand-vista.jpg?w=1200&h=1200&s=1',
              'https://upload.wikimedia.org/wikipedia/commons/2/2a/Pyin_U_Lwin_Myanmar.jpg',
            ],
            ListingPlace(id: 'olijo', name: "place3333"): [
              'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0d/bc/d4/38/grand-vista.jpg?w=1200&h=1200&s=1',
              'https://upload.wikimedia.org/wikipedia/commons/2/2a/Pyin_U_Lwin_Myanmar.jpg',
            ],
          },
          offerList: [
            ListingOffer(id: "232", name: "Free wifi", icon: '''
<?xml version="1.0" ?><svg viewBox="0 0 356.8 431.51" xmlns="http://www.w3.org/2000/svg"><title/><g data-name="Layer 2" id="Layer_2"><g data-name="japan, tower, tokyo, landmark, travel, architecture, tourism, view" id="japan_tower_tokyo_landmark_travel_architecture_tourism_view"><path d="M158,147.22v74.9a5.47,5.47,0,1,0,10.93,0v-74.9a5.47,5.47,0,0,0-10.93,0Z"/><path d="M121.29,227.42a5.18,5.18,0,0,0,1.34.17,5.47,5.47,0,0,0,5.3-4.13c.47-1.86.93-3.75,1.39-5.63l13,8.81a5.46,5.46,0,0,0,6.14-9l-16.39-11.13q3.25-13.87,6.28-28.35l3.5,3a5.47,5.47,0,1,0,7.08-8.34l-8.09-6.86q2.42-12.18,4.66-24.66a5.47,5.47,0,0,0-10.76-1.93c-5.1,28.51-11,55.92-17.39,81.48A5.46,5.46,0,0,0,121.29,227.42Z"/><path d="M241.32,256.91a5.47,5.47,0,0,0-5.47,5.47v.68a5.47,5.47,0,0,0,10.93,0v-.68A5.46,5.46,0,0,0,241.32,256.91Z"/><path d="M241.32,237.22H85.67a5.47,5.47,0,0,0-5.47,5.47v49.59a5.47,5.47,0,0,0,5.47,5.47H241.32a5.46,5.46,0,0,0,5.46-5.47V281.74a5.47,5.47,0,0,0-10.93,0v5.07H91.13V248.15H241.32a5.47,5.47,0,0,0,0-10.93Z"/><path d="M123.92,96.9V120a5.47,5.47,0,0,0,5.47,5.47H197.6a5.47,5.47,0,0,0,5.47-5.47V96.9a5.47,5.47,0,0,0-10.94,0v17.64H134.85V102.36h42.24a5.47,5.47,0,0,0,0-10.93h-47.7A5.47,5.47,0,0,0,123.92,96.9Z"/><path d="M178.55,217.6a5.46,5.46,0,1,0,6.14,9l13-8.81c.46,1.88.92,3.77,1.39,5.63a5.46,5.46,0,0,0,5.29,4.13,5.18,5.18,0,0,0,1.34-.17,5.46,5.46,0,0,0,4-6.63c-6.44-25.56-12.3-53-17.4-81.48a5.47,5.47,0,0,0-10.76,1.93q2.24,12.48,4.66,24.66l-8.08,6.86a5.46,5.46,0,0,0,3.54,9.63,5.42,5.42,0,0,0,3.53-1.29l3.51-3q3,14.46,6.27,28.35Z"/><path d="M163.49,0A5.46,5.46,0,0,0,158,5.47V24.75h-2.81a5.46,5.46,0,0,0-5.45,5c0,.18-1.53,18.52-5.32,47.1a5.46,5.46,0,0,0,4.7,6.14,5.79,5.79,0,0,0,.72,0,5.45,5.45,0,0,0,5.41-4.74c2.67-20.12,4.23-35.24,4.93-42.63h6.57c.7,7.39,2.25,22.51,4.92,42.63a5.46,5.46,0,0,0,5.41,4.74,6,6,0,0,0,.73,0,5.47,5.47,0,0,0,4.7-6.14c-3.8-28.58-5.31-46.92-5.32-47.1a5.46,5.46,0,0,0-5.45-5H169V5.47A5.47,5.47,0,0,0,163.49,0Z"/><path d="M0,426a5.47,5.47,0,0,0,5.47,5.47H132.1a5.47,5.47,0,0,0,0-10.94H113.28L114.74,405a46.55,46.55,0,0,1,17.72-32.34,6.59,6.59,0,0,0,.57-.34,5.07,5.07,0,0,0,.85-.75,50.85,50.85,0,0,1,59.22,0,5.14,5.14,0,0,0,.86.75,6.42,6.42,0,0,0,.56.34A46.52,46.52,0,0,1,212.25,405l1.46,15.56H196.83a5.47,5.47,0,0,0,0,10.94H321.31a5.47,5.47,0,0,0,0-10.94h-20c-23.44-24.19-44.66-60.52-63.07-108.08a5.47,5.47,0,1,0-10.2,3.95q9.4,24.29,19.79,44.78l-20.07-5.31A5.47,5.47,0,1,0,225,366.48l29.82,7.89q15,27,31.68,46.2h-56.2l21.92-30.78a5.46,5.46,0,1,0-8.9-6.34L223.78,410.9l-.65-6.91a57.3,57.3,0,0,0-18.6-37.17l7.11-10.08h0l14.07-20a5.46,5.46,0,0,0-8.93-6.3L206.61,344.9l-21-22.63a5.47,5.47,0,1,0-8,7.43L200.17,354l-4.37,6.2A60.85,60.85,0,0,0,169,351.38V314.46a5.47,5.47,0,0,0-10.93,0v36.91a60.85,60.85,0,0,0-26.85,8.85L126.81,354l22.57-24.33a5.47,5.47,0,1,0-8-7.43l-21,22.63L110.2,330.47a5.46,5.46,0,0,0-8.93,6.3l14.06,20,0,0,7.1,10.06A57.33,57.33,0,0,0,103.86,404l-.65,6.91L83.66,383.45a5.46,5.46,0,0,0-8.9,6.34l21.92,30.78H40.48q16.68-19.2,31.67-46.2L102,366.48a5.47,5.47,0,1,0-2.8-10.57l-20.07,5.31q10.38-20.5,19.79-44.78a5.46,5.46,0,1,0-10.19-3.95c-18.42,47.56-39.63,83.89-63.07,108.08H5.47A5.47,5.47,0,0,0,0,426Z"/><path d="M163.49,420.57a5.47,5.47,0,0,0,0,10.94h2.59a5.47,5.47,0,0,0,0-10.94Z"/><path d="M348.75,420.57a5.47,5.47,0,0,0,0,10.94h2.58a5.47,5.47,0,0,0,0-10.94Z"/><path d="M118.45,262.1v13.12a5.47,5.47,0,0,0,10.94,0V262.1a5.47,5.47,0,0,0-10.94,0Z"/><path d="M158,262.1v13.12a5.47,5.47,0,0,0,10.93,0V262.1a5.47,5.47,0,0,0-10.93,0Z"/><path d="M197.6,262.1v13.12a5.47,5.47,0,0,0,10.93,0V262.1a5.47,5.47,0,0,0-10.93,0Z"/></g></g></svg>
''')
          ]),
      ListingModel(
          id: "232343290",
          title: "Chaung Thar",
          about: "241455",
          subTitle: 'Chaung thar beach',
          listingType: ListingType(id: 'nikni', name: 'Full House'),
          listingTags: [
            ListingTag(
                id: "1212nnfdfnd",
                name: "beach house",
                icon:
                    '''<?xml version="1.0" ?><!DOCTYPE svg  PUBLIC '-//W3C//DTD SVG 1.1//EN'  'http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd'><svg enable-background="new 0 0 128 128" id="Layer_1" version="1.1" viewBox="0 0 128 128" xml:space="preserve" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path d="M121,112c0,1.1-0.9,2-2,2H18c-1.1,0-2-0.9-2-2V33c0-1.1,0.9-2,2-2H119c1.1,0,2,0.9,2,2V112z" fill="#FFFFFF"/><path d="M121,112c0,1.1-0.9,2-2,2H18c-1.1,0-2-0.9-2-2V33  c0-1.1,0.9-2,2-2H119c1.1,0,2,0.9,2,2V112z" fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2"/><path d="M56,114h10v2h-9.4c-0.3,0-0.6-0.4-0.6-0.6V114z" fill="#53AF80"/><path d="M56,114h10v2h-9.4c-0.3,0-0.6-0.4-0.6-0.6V114z" fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2"/><path d="M56,31h10v-2h-9.4c-0.3,0-0.6,0.3-0.6,0.6V31z" fill="#53AF80"/><path d="M56,31h10v-2h-9.4c-0.3,0-0.6,0.3-0.6,0.6V31z" fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2"/><rect fill="#C1C1C0" height="83" width="10" x="6" y="30"/><rect fill="none" height="83" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2" width="10" x="6" y="30"/><path d="M15.9,49.8c0,0,5.9-19.8,5.2-19.8h-8.8c-0.3,0-0.5,0.1-0.5,0.4l3.8,19.8C15.7,50.5,15.9,50.2,15.9,49.8z" fill="#53AF80"/><path d="  M21,30h-8.7c-0.3,0-0.5,0.1-0.5,0.4l3.8,19.7c0.1,0.3,0.2,0.2,0.2-0.2" fill="none" stroke="#3D3D3D" stroke-linecap="round" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2"/><path d="M5,49.6C5,50,5.3,50.3,5.4,50l3.9-19.6C9.3,30.1,9.1,30,8.8,30H5V49.6z" fill="#53AF80"/><path d="  M5,49.6C5,50,5.3,50.3,5.4,50l3.9-19.6C9.3,30.1,9.1,30,8.8,30H5V49.6z" fill="none" stroke="#3D3D3D" stroke-linecap="round" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2"/><path d="M16,49.6V33.5c0-2.2,1.4-3.5,3.6-3.5h16.1c0.4,0,0.7,0.3,0.3,0.6L16.7,50.1C16.4,50.4,16,50,16,49.6z" fill="#53AF80"/><path d="M123,49.6V33.5c0-2.2-2.2-3.5-4.4-3.5h-16.3c-0.4,0-0.7,0.3-0.3,0.6l19.8,19.4C122.2,50.4,123,50,123,49.6z" fill="#53AF80"/><path d="M123,94.5v15.9c0,2.2-2.2,3.6-4.4,3.6h-16.3c-0.4,0-0.7-0.3-0.3-0.6L121.9,94C122.2,93.7,123,94.1,123,94.5z  " fill="#53AF80"/><path d="M16,49.6V33.5c0-2.2,1.4-3.5,3.6-3.5h16.1  c0.4,0,0.7,0.3,0.3,0.6L16.7,50.1C16.4,50.4,16,50,16,49.6z" fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2"/><path d="M15.9,94.1c0,0,5.9,19.9,5.2,19.9h-8.8c-0.3,0-0.5-0.2-0.5-0.5l3.8-19.8C15.7,93.4,15.9,93.6,15.9,94.1z" fill="#53AF80"/><path d="  M21,114h-8.7c-0.3,0-0.5-0.2-0.5-0.5l3.8-19.7c0.1-0.3,0.2-0.1,0.2,0.3" fill="none" stroke="#3D3D3D" stroke-linecap="round" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2"/><path d="M5,94.2c0-0.4,0.3-0.7,0.4-0.3l3.9,19.7c0.1,0.3-0.1,0.5-0.4,0.5H5V94.2z" fill="#53AF80"/><path d="  M5,94.2c0-0.4,0.3-0.7,0.4-0.3l3.9,19.7c0.1,0.3-0.1,0.5-0.4,0.5H5V94.2z" fill="none" stroke="#3D3D3D" stroke-linecap="round" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2"/><path d="M16,94.2v16.1c0,2.2,1.4,3.8,3.6,3.8h16.1c0.4,0,0.7-0.5,0.3-0.8L16.7,93.8C16.4,93.5,16,93.7,16,94.2z" fill="#53AF80"/><path d="M16,94.2v16.1c0,2.2,1.4,3.8,3.6,3.8h16.1  c0.4,0,0.7-0.5,0.3-0.8L16.7,93.8C16.4,93.5,16,93.7,16,94.2z" fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2"/><path d="M123,49.6V33.5c0-2.2-2.2-3.5-4.4-3.5h-16.3  c-0.4,0-0.7,0.3-0.3,0.6l19.8,19.4C122.2,50.4,123,50,123,49.6z" fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2"/><path d="M123,94.5v15.9c0,2.2-2.2,3.6-4.4,3.6h-16.3  c-0.4,0-0.7-0.3-0.3-0.6L121.9,94C122.2,93.7,123,94.1,123,94.5z" fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2"/><path d="M75,29.5c0-0.3-0.2-0.5-0.5-0.5h-10c-0.3,0-0.5,0.2-0.5,0.5v86c0,0.3,0.2,0.5,0.5,0.5h10  c0.3,0,0.5-0.2,0.5-0.5V29.5z" fill="#8DCEA8"/><path d="M75,29.5c0-0.3-0.2-0.5-0.5-0.5h-10  c-0.3,0-0.5,0.2-0.5,0.5v86c0,0.3,0.2,0.5,0.5,0.5h10c0.3,0,0.5-0.2,0.5-0.5V29.5z" fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2"/><polyline fill="none" points="64.4,89.5 69.9,93.7 74.6,89.9 " stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2"/><path d="M77,85.5c0,0.3-0.2,0.5-0.5,0.5h-13c-0.3,0-0.5-0.2-0.5-0.5v-1c0-0.3,0.2-0.5,0.5-0.5h13  c0.3,0,0.5,0.2,0.5,0.5V85.5z" fill="#E2E2E2"/><path d="M77,85.5c0,0.3-0.2,0.5-0.5,0.5h-13  c-0.3,0-0.5-0.2-0.5-0.5v-1c0-0.3,0.2-0.5,0.5-0.5h13c0.3,0,0.5,0.2,0.5,0.5V85.5z" fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2"/><circle cx="69.5" cy="41.7" fill="#3D3D3D" r="1.7"/><circle cx="69.5" cy="47.7" fill="#3D3D3D" r="1.7"/><circle cx="69.5" cy="53.7" fill="#3D3D3D" r="1.7"/><circle cx="69.9" cy="59.7" fill="#3D3D3D" r="1.7"/><ellipse cx="69.5" cy="65.9" fill="#3D3D3D" rx="1.7" ry="1.9"/><circle cx="69.5" cy="76" fill="#3D3D3D" r="1.7"/><path d="M79,61c0-1.1-0.9-2-2-2H62c-1.1,0-2,0.9-2,2V70c0,1.1,0.9,2,2,2H77c1.1,0,2-0.9,2-2V61z M77,70H63v-9h14V70z  " fill="#E2E2E2"/><path d="M79,70c0,1.1-0.9,2-2,2H62c-1.1,0-2-0.9-2-2V61  c0-1.1,0.9-2,2-2H77c1.1,0,2,0.9,2,2V70z" fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2"/><rect fill="none" height="7" stroke="#3D3D3D" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2" width="13" x="63" y="62"/><rect fill="#FFFFFF" height="7" width="1" x="69" y="66"/><rect fill="#8DCEA8" height="13.8" transform="matrix(-0.2479 0.9688 -0.9688 -0.2479 188.1328 -25.2419)" width="3.4" x="102.1" y="53.5"/><rect fill="none" height="7" stroke="#3D3D3D" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2" width="1" x="69" y="66"/><path d="M108.8,67l-12.4-3.2c-0.3-0.1-0.4-0.3-0.4-0.6  l2.3-9.1c0.1-0.3,0.3-0.4,0.6-0.4l12.4,3.2c0.3,0.1,0.4,0.3,0.4,0.6l-2.3,9.1C109.3,66.9,109.1,67.1,108.8,67z" fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2"/><polygon fill="none" points="36.7,56.4   42.5,55.4 40.9,54.4 44.3,49.1 42.5,49.4 42.4,46.7 40.2,48.1 39.4,45.9 37.4,50.1 36.4,43.7 34.6,45.6 31.8,42.8 31.4,46.7   28.8,46.4 32.1,52 27.9,50 28.6,52.2 26.1,52.5 27.8,54.6 26.1,55.6 32.2,57.5 31.5,59.3 " stroke="#3D3D3D" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2"/><line fill="none" stroke="#3D3D3D" stroke-linecap="round" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2" x1="34.5" x2="38.1" y1="50.2" y2="60.4"/><line fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2" x1="97.6" x2="111" y1="57" y2="60.4"/><line fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2" x1="96.8" x2="110.1" y1="60.4" y2="63.8"/><path d="M89.5,106.2c0,0,3.4-7.5,0.1-18.5" fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2"/><path d="M102.3,102.3c0,0-7.5-4.2-10.8-15.2" fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2"/><line fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2" x1="87.6" x2="93.8" y1="106.8" y2="104.8"/><line fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2" x1="97.7" x2="103.9" y1="103.7" y2="101.8"/><path d="M92.5,105.3c-0.6-1.8,0.4-3.8,2.2-4.3  c1.8-0.5,3.7,0.5,4.3,2.3" fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2"/><polygon fill="none" points="89.4,87.7 88,85.8 89.4,83.9 91.7,84.7   91.6,87 " stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2"/><line fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2" x1="89.5" x2="88.9" y1="84" y2="82.1"/><line fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2" x1="89.5" x2="95.6" y1="95.1" y2="93.3"/><line fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2" x1="88.9" x2="99" y1="100.4" y2="97.4"/><path d="M111.1,83.8  c-1.9-1.3-3.6-2.7-5.2-4.3c-0.8-0.8-1.7-1.7-2-2.8c-0.3-1.1,0.1-2.6,1.2-3c0.5-0.2,1.1-0.2,1.6,0c1.3,0.4,2.3,1.4,2.7,2.7  c0-0.5,0.4-0.9,0.8-1.2c1.2-0.8,2.6-1.1,4-0.9c1.1,0.2,2.2,0.9,2.3,1.9c0.1,0.7-0.4,1.4-0.8,2c-0.8,0.9-1.8,1.7-2.7,2.5  C112,81.5,111.3,82.6,111.1,83.8z" fill="none" stroke="#3D3D3D" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2"/><path d="M79,28v-2.4c0-4.2-1.6-8.5-13.5-8.5c-11.9,0-13.5,4.3-13.5,8.5V28h-3v-2.4c0-12,12.3-12,17-12  c4.7,0,17,0,17,12V28H79z" fill="#C1C1C0"/><path d="M50.6,28H38.8c-0.3,0-0.8,0.3-0.8,0.6V31h13v-2.4C51,28.3,50.9,28,50.6,28z" fill="#FFFFFF"/><path d="M79,28v-2.4c0-4.2-1.6-8.5-13.5-8.5  c-11.9,0-13.5,4.3-13.5,8.5V28h-3v-2.4c0-12,12.3-12,17-12c4.7,0,17,0,17,12V28H79z" fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2"/><path d="M90.8,28H79c-0.3,0,0,0.3,0,0.6V31h12v-2.4C91,28.3,91.1,28,90.8,28z" fill="#FFFFFF"/><path d="M90.8,28H79c-0.3,0,0,0.3,0,0.6V31h12v-2.4  C91,28.3,91.1,28,90.8,28z" fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2"/><path d="M93.8,28H82c-0.3,0-1,0.3-1,0.6V31h13v-2.4C94,28.3,94.1,28,93.8,28z" fill="#FFFFFF"/><path d="M93.8,28H82c-0.3,0-1,0.3-1,0.6V31h13v-2.4  C94,28.3,94.1,28,93.8,28z" fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2"/><path d="M50.6,28H38.8c-0.3,0-0.8,0.3-0.8,0.6V31h13v-2.4  C51,28.3,50.9,28,50.6,28z" fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2"/><polygon fill="#FFFFFF" points="26.9,85 21.7,78.9 25.8,72.1 33.6,73.9 34.3,81.8 "/><path d="M53.6,28H41.8c-0.3,0-0.8,0.3-0.8,0.6V31h13v-2.4C54,28.3,53.9,28,53.6,28z" fill="#FFFFFF"/><polygon fill="none" points="26.9,85 21.7,78.9   25.8,72.1 33.6,73.9 34.3,81.8 " stroke="#3D3D3D" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2"/><path d="M53.6,28H41.8c-0.3,0-0.8,0.3-0.8,0.6V31h13v-2.4  C54,28.3,53.9,28,53.6,28z" fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2"/><polygon fill="#E2E2E2" points="30.6,81.1 38,72.7 41.6,83.4 "/><polygon fill="none" points="30.6,81.1 38,72.7   41.6,83.4 " stroke="#3D3D3D" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2"/><line fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2" x1="6" x2="16" y1="61" y2="61"/><line fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2" x1="6" x2="16" y1="66" y2="66"/><line fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2" x1="6" x2="16" y1="71" y2="71"/><line fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2" x1="6" x2="16" y1="76" y2="76"/><line fill="none" stroke="#3D3D3D" stroke-miterlimit="10" stroke-width="2" x1="6" x2="16" y1="81" y2="81"/></svg>
''')
          ],
          listingImages: [
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTt2vxLLGX0IZTmCWFhnn5D8VQSxh4NcALTh6m2B9GmzQ&s'
          ],
          addressLocation: const LatLng(16.774617296225806, 96.15883738225342),
          dailyNightData: {
            "2022-2-02": [
              NightFeeModel(
                  perNightFee: 40000,
                  currencyModel: CurrencyModel(
                      abbr: "Ks",
                      id: "23232",
                      name: "Myanmar Kyat",
                      sign: "MMK"))
            ]
          },
          addressRemark: 'Near Pansoedan',
          hostName: 'May',
          fullAddress: 'suleapgeogodfd',
          listingAttributesQty: {
            ListingAttribute(id: "23232", name: "name1"): 1
          },
          listingPlacesImages: {
            ListingPlace(id: 'fdfd', name: "place13232"): [
              'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0d/bc/d4/38/grand-vista.jpg?w=1200&h=1200&s=1',
              'https://upload.wikimedia.org/wikipedia/commons/2/2a/Pyin_U_Lwin_Myanmar.jpg',
            ],
            ListingPlace(id: '2e32we', name: "place322"): [
              'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0d/bc/d4/38/grand-vista.jpg?w=1200&h=1200&s=1',
              'https://upload.wikimedia.org/wikipedia/commons/2/2a/Pyin_U_Lwin_Myanmar.jpg',
            ],
            ListingPlace(id: 'olijo', name: "place342"): [
              'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0d/bc/d4/38/grand-vista.jpg?w=1200&h=1200&s=1',
              'https://upload.wikimedia.org/wikipedia/commons/2/2a/Pyin_U_Lwin_Myanmar.jpg',
            ],
          },
          offerList: [
            ListingOffer(id: "232", name: "Free wifi", icon: '''
<?xml version="1.0" ?><svg viewBox="0 0 356.8 431.51" xmlns="http://www.w3.org/2000/svg"><title/><g data-name="Layer 2" id="Layer_2"><g data-name="japan, tower, tokyo, landmark, travel, architecture, tourism, view" id="japan_tower_tokyo_landmark_travel_architecture_tourism_view"><path d="M158,147.22v74.9a5.47,5.47,0,1,0,10.93,0v-74.9a5.47,5.47,0,0,0-10.93,0Z"/><path d="M121.29,227.42a5.18,5.18,0,0,0,1.34.17,5.47,5.47,0,0,0,5.3-4.13c.47-1.86.93-3.75,1.39-5.63l13,8.81a5.46,5.46,0,0,0,6.14-9l-16.39-11.13q3.25-13.87,6.28-28.35l3.5,3a5.47,5.47,0,1,0,7.08-8.34l-8.09-6.86q2.42-12.18,4.66-24.66a5.47,5.47,0,0,0-10.76-1.93c-5.1,28.51-11,55.92-17.39,81.48A5.46,5.46,0,0,0,121.29,227.42Z"/><path d="M241.32,256.91a5.47,5.47,0,0,0-5.47,5.47v.68a5.47,5.47,0,0,0,10.93,0v-.68A5.46,5.46,0,0,0,241.32,256.91Z"/><path d="M241.32,237.22H85.67a5.47,5.47,0,0,0-5.47,5.47v49.59a5.47,5.47,0,0,0,5.47,5.47H241.32a5.46,5.46,0,0,0,5.46-5.47V281.74a5.47,5.47,0,0,0-10.93,0v5.07H91.13V248.15H241.32a5.47,5.47,0,0,0,0-10.93Z"/><path d="M123.92,96.9V120a5.47,5.47,0,0,0,5.47,5.47H197.6a5.47,5.47,0,0,0,5.47-5.47V96.9a5.47,5.47,0,0,0-10.94,0v17.64H134.85V102.36h42.24a5.47,5.47,0,0,0,0-10.93h-47.7A5.47,5.47,0,0,0,123.92,96.9Z"/><path d="M178.55,217.6a5.46,5.46,0,1,0,6.14,9l13-8.81c.46,1.88.92,3.77,1.39,5.63a5.46,5.46,0,0,0,5.29,4.13,5.18,5.18,0,0,0,1.34-.17,5.46,5.46,0,0,0,4-6.63c-6.44-25.56-12.3-53-17.4-81.48a5.47,5.47,0,0,0-10.76,1.93q2.24,12.48,4.66,24.66l-8.08,6.86a5.46,5.46,0,0,0,3.54,9.63,5.42,5.42,0,0,0,3.53-1.29l3.51-3q3,14.46,6.27,28.35Z"/><path d="M163.49,0A5.46,5.46,0,0,0,158,5.47V24.75h-2.81a5.46,5.46,0,0,0-5.45,5c0,.18-1.53,18.52-5.32,47.1a5.46,5.46,0,0,0,4.7,6.14,5.79,5.79,0,0,0,.72,0,5.45,5.45,0,0,0,5.41-4.74c2.67-20.12,4.23-35.24,4.93-42.63h6.57c.7,7.39,2.25,22.51,4.92,42.63a5.46,5.46,0,0,0,5.41,4.74,6,6,0,0,0,.73,0,5.47,5.47,0,0,0,4.7-6.14c-3.8-28.58-5.31-46.92-5.32-47.1a5.46,5.46,0,0,0-5.45-5H169V5.47A5.47,5.47,0,0,0,163.49,0Z"/><path d="M0,426a5.47,5.47,0,0,0,5.47,5.47H132.1a5.47,5.47,0,0,0,0-10.94H113.28L114.74,405a46.55,46.55,0,0,1,17.72-32.34,6.59,6.59,0,0,0,.57-.34,5.07,5.07,0,0,0,.85-.75,50.85,50.85,0,0,1,59.22,0,5.14,5.14,0,0,0,.86.75,6.42,6.42,0,0,0,.56.34A46.52,46.52,0,0,1,212.25,405l1.46,15.56H196.83a5.47,5.47,0,0,0,0,10.94H321.31a5.47,5.47,0,0,0,0-10.94h-20c-23.44-24.19-44.66-60.52-63.07-108.08a5.47,5.47,0,1,0-10.2,3.95q9.4,24.29,19.79,44.78l-20.07-5.31A5.47,5.47,0,1,0,225,366.48l29.82,7.89q15,27,31.68,46.2h-56.2l21.92-30.78a5.46,5.46,0,1,0-8.9-6.34L223.78,410.9l-.65-6.91a57.3,57.3,0,0,0-18.6-37.17l7.11-10.08h0l14.07-20a5.46,5.46,0,0,0-8.93-6.3L206.61,344.9l-21-22.63a5.47,5.47,0,1,0-8,7.43L200.17,354l-4.37,6.2A60.85,60.85,0,0,0,169,351.38V314.46a5.47,5.47,0,0,0-10.93,0v36.91a60.85,60.85,0,0,0-26.85,8.85L126.81,354l22.57-24.33a5.47,5.47,0,1,0-8-7.43l-21,22.63L110.2,330.47a5.46,5.46,0,0,0-8.93,6.3l14.06,20,0,0,7.1,10.06A57.33,57.33,0,0,0,103.86,404l-.65,6.91L83.66,383.45a5.46,5.46,0,0,0-8.9,6.34l21.92,30.78H40.48q16.68-19.2,31.67-46.2L102,366.48a5.47,5.47,0,1,0-2.8-10.57l-20.07,5.31q10.38-20.5,19.79-44.78a5.46,5.46,0,1,0-10.19-3.95c-18.42,47.56-39.63,83.89-63.07,108.08H5.47A5.47,5.47,0,0,0,0,426Z"/><path d="M163.49,420.57a5.47,5.47,0,0,0,0,10.94h2.59a5.47,5.47,0,0,0,0-10.94Z"/><path d="M348.75,420.57a5.47,5.47,0,0,0,0,10.94h2.58a5.47,5.47,0,0,0,0-10.94Z"/><path d="M118.45,262.1v13.12a5.47,5.47,0,0,0,10.94,0V262.1a5.47,5.47,0,0,0-10.94,0Z"/><path d="M158,262.1v13.12a5.47,5.47,0,0,0,10.93,0V262.1a5.47,5.47,0,0,0-10.93,0Z"/><path d="M197.6,262.1v13.12a5.47,5.47,0,0,0,10.93,0V262.1a5.47,5.47,0,0,0-10.93,0Z"/></g></g></svg>
''')
          ]),
    ];

    allData.notifyListeners();
  }
}
