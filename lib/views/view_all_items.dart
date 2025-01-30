import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../Utils/constants.dart';
import '../widget/food_items_display.dart';
import '../widget/my_icon_button.dart';

class ViewAllItems extends StatefulWidget {
  const ViewAllItems({super.key});

  @override
  State<ViewAllItems> createState() => _ViewAllItemsState();
}

class _ViewAllItemsState extends State<ViewAllItems> {
  final CollectionReference completeApp =
      FirebaseFirestore.instance.collection("Complete-Flutter-App");
  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffeff1f7),
      appBar: AppBar(
        backgroundColor: kbackgroundColor,
        automaticallyImplyLeading: false, // it removes the appbar back button
        elevation: 0,
        actions: [
          const SizedBox(width: 15),
          MyIconButton(
            icon: Icons.arrow_back_ios_new,
            pressed: () {
              Navigator.pop(context);
            },
          ),
          const Spacer(),
          const Text(
            "Quick & Easy",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          MyIconButton(
            icon: Iconsax.notification,
            pressed: () {},
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 7, right: 5),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 22),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  prefixIcon: const Icon(Iconsax.search_normal),
                  fillColor: Colors.white,
                  border: InputBorder.none,
                  hintText: "Search any recipes",
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 8),
            StreamBuilder<QuerySnapshot>(
              stream: completeApp.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (!streamSnapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final filteredDocs = streamSnapshot.data!.docs.where((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  final recipeName = data['name'] ?? '';
                  return recipeName
                      .toLowerCase()
                      .contains(_searchQuery.toLowerCase());
                }).toList();

                if (filteredDocs.isEmpty) {
                  return const Center(child: Text('No recipes found'));
                }

                return GridView.builder(
                  itemCount: filteredDocs.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.78,
                  ),
                  itemBuilder: (context, index) {
                    final doc = filteredDocs[index];
                    final data = doc.data() as Map<String, dynamic>;

                    return Column(
                      children: [
                        FoodItemsDisplay(documentSnapshot: doc),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                           Row(
                             children: [
                               const Icon(
                                 Iconsax.star1,
                                 color: Colors.amberAccent,
                               ),
                               const SizedBox(width: 5),
                               Text(
                                 data['rate'] ?? 'No rating',
                                 style: const TextStyle(
                                   fontWeight: FontWeight.bold,
                                 ),
                               ),
                               const Text("/5", style: const TextStyle(
                                 fontWeight: FontWeight.bold,
                               ),),
                               const SizedBox(width: 5),
                             ],
                           ),
                            Text(
                              "${data['reviews'] ?? 0} Reviews",
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: 6),
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
