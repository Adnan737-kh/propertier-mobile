import 'package:flutter/material.dart';

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
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Select Category:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentCategory != null
                        ? 'Current $currentCategory'
                        : 'No category selected',
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Search Bar
                  TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 12.0),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Center(
                    child: Text(
                      'All categories:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: filteredServices.length,
              itemBuilder: (context, index) {
                final parentServiceName = filteredServices[index];
                return ListTile(
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

                      Navigator.pop(context); // Close the SelectCategory screen
                    },
                    child: Container(
                      height: 22,
                      width: 22,
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
