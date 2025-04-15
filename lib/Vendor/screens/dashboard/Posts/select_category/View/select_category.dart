import 'package:flutter/material.dart';
import 'package:propertier/constant/colors.dart';

class SelectCategory extends StatefulWidget {
  const SelectCategory({
    super.key,
    required this.category,
    required this.onCategorySelected,
    required this.parentServices,
  });

  final String category;
  final Function(String?) onCategorySelected;
  final List<String> parentServices;

  @override
  State<SelectCategory> createState() => _SelectCategoryState();
}

class _SelectCategoryState extends State<SelectCategory> {
  String? currentCategory;
  TextEditingController searchController = TextEditingController();
  List<String> filteredServices = [];

  @override
  void initState() {
    super.initState();
    currentCategory = widget.category;
    filteredServices = widget.parentServices;
    searchController.addListener(_filterServices);
  }

  @override
  void dispose() {
    searchController.removeListener(_filterServices);
    searchController.dispose();
    super.dispose();
  }

  void _filterServices() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredServices = widget.parentServices
          .where((service) => service.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.89,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              height: 5.0,
              width: 40.0,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(22.0), // Space above and below
              child: Material(
                elevation: 4, // Shadow effect
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColor.joinAsBtnColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          'Select Services You Offer',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: AppColor.white),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        currentCategory != null
                            ? 'Current $currentCategory'
                            : 'No category selected',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Search Bar
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(25),
                        shadowColor: Colors.black45,
                        child: Container(
                          height: 44.13, // 👈 Exact height
                          alignment: Alignment.center,
                          child: TextField(
                            controller: searchController,
                            style: const TextStyle(
                                fontSize: 14), // smaller text to fit
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              hintText: 'Search...',
                              filled: true,
                              fillColor: Colors.white,
                              isDense: true,
                              prefixIcon: const Icon(Icons.search,
                                  size: 24, color: Colors.grey),

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding:
                                  EdgeInsets.zero, // 👈 No extra padding
                            ),
                          ),
                        ),
                      ),

                      // const SizedBox(height: 10),

                      // const Center(
                      //   child: Text(
                      //     'All categories:',
                      //     style: TextStyle(
                      //       fontWeight: FontWeight.bold,
                      //       fontSize: 16,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: filteredServices.length,
              itemBuilder: (context, index) {
                final parentServiceName = filteredServices[index];
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: ListTile(
                        title: Text(parentServiceName),
                        trailing: InkWell(
                          onTap: () async {
                            if (currentCategory == parentServiceName) {
                              currentCategory = null;
                            } else {
                              currentCategory = parentServiceName;
                            }

                            // Pass the selected or deselected category back to the parent
                            await widget.onCategorySelected(currentCategory);

                            Navigator.pop(
                                context); // Close the SelectCategory screen
                          },
                          child: Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              color: currentCategory == parentServiceName
                                  ? const Color(0xFFFDCD54)
                                  : Colors.grey,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.check,
                              color: Color.fromARGB(255, 95, 16, 16),
                              size: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
