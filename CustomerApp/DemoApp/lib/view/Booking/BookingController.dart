
import 'package:demoapp/view/Booking/model/item.dart';
import 'package:get/get.dart';
import 'dart:math';

class BookingController extends GetxController implements GetxService {

  List<String> countries = ["Lausanne", "Tulip Inn", "USA", "ibis Lausanne Center", "China","ibis Lausanne Center", "ibis Lausanne Center", "Uruguay"];
  List<String> discription = ["10 cgemin du cerisler lausane", "Lausanne", "Rued du maupos 20", "Rued du maupos 20", "ibis Lausanne Center","UK", "Uganda", "Uruguay"];
   RxList _items = [].obs;

   LevelUp() {
      _items = List.generate(countries.length,
             (index) => Item(
             id: index,
             name: countries[index],
             price:discription[index],
             inWishList: false.obs)).obs;
   }



  // Use this to retrieve all products


  List<Item> get items {
    return [..._items];
  }

  // This will return the products that were added to wish list
  List get wishListItems {
    return _items.where((item) => item.inWishList.value == true).toList();
  }

  // Add an item to the wish list
  void addItem(int id) {
    final int index = _items.indexWhere((item) => item.id == id);
    _items[index].inWishList.value = true;
  }

  // Remove an item from the wish list
  void removeItem(int id) {
    final int index = _items.indexWhere((item) => item.id == id);
    _items[index].inWishList.value = false;
  }
}