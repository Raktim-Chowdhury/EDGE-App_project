import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<String>> _recipes = {};

  @override
  void initState() {
    super.initState();
    _loadRecipes();
  }

  Future<void> _loadRecipes() async {
    final prefs = await SharedPreferences.getInstance();
    final String? storedRecipes = prefs.getString('recipes');
    if (storedRecipes != null) {
      setState(() {
        _recipes = (json.decode(storedRecipes) as Map<String, dynamic>).map(
              (key, value) => MapEntry(
            DateTime.parse(key),
            List<String>.from(value),
          ),
        );
      });
    }
  }

  Future<void> _saveRecipes() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedData = json.encode(_recipes.map((key, value) => MapEntry(
      key.toIso8601String(),
      value,
    )));
    await prefs.setString('recipes', encodedData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Meal Plan',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xffeff1f7),
      ),
      body: Container(
        color: const Color(0xffeff1f7),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _statusIndicator("Breakfast", Colors.green),
                  _statusIndicator("Lunch", Colors.red),
                  _statusIndicator("Dinner", Colors.lightBlue),
                  _statusIndicator("Snacks", Colors.orange),
                ],
              ),
            ),
            TableCalendar(
              focusedDay: _focusedDay,
              firstDay: DateTime(2000),
              lastDay: DateTime(2100),
              calendarFormat: CalendarFormat.month,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
                _showAddRecipeDialog(selectedDay);
              },
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, focusedDay) {
                  if (_recipes.containsKey(day)) {
                    final categories = _recipes[day]!;
                    final colors = _getCategoryColors(categories);

                    return Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: colors.length > 1
                            ? LinearGradient(
                          colors: colors,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                            : null,
                        color: colors.length == 1 ? colors.first : null,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${day.day}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }
                  return null;
                },
              ),
              calendarStyle: const CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.blueGrey,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _selectedDay != null && _recipes[_selectedDay!] != null
                  ? ListView.builder(
                itemCount: _recipes[_selectedDay!]!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_recipes[_selectedDay!]![index]),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          _recipes[_selectedDay!]!.removeAt(index);
                          if (_recipes[_selectedDay!]!.isEmpty) {
                            _recipes.remove(_selectedDay!);
                          }
                        });
                        _saveRecipes();
                      },
                    ),
                  );
                },
              )
                  : const Center(
                child: Text(
                  "No recipes for this day",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statusIndicator(String label, Color color) {
    return Row(
      children: [
        CircleAvatar(
          radius: 8,
          backgroundColor: color,
        ),
        const SizedBox(width: 5),
        Text(label),
      ],
    );
  }

  void _showAddRecipeDialog(DateTime date) {
    TextEditingController recipeController = TextEditingController();
    String selectedCategory = 'Breakfast';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Recipe'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: recipeController,
              decoration: const InputDecoration(hintText: 'Enter recipe name'),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedCategory,
              items: ['Breakfast', 'Lunch', 'Dinner', 'Snacks']
                  .map((category) => DropdownMenuItem(
                value: category,
                child: Text(category),
              ))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedCategory = value;
                  });
                }
              },
              decoration: const InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                if (recipeController.text.isNotEmpty) {
                  final recipe = '${selectedCategory.toUpperCase()}: ${recipeController.text}';
                  if (_recipes[date] == null) {
                    _recipes[date] = [];
                  }
                  _recipes[date]!.add(recipe);
                  _saveRecipes();
                }
              });
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  List<Color> _getCategoryColors(List<String> categories) {
    final categoryColors = {
      'BREAKFAST': Colors.green,
      'LUNCH': Colors.red,
      'DINNER': Colors.lightBlue,
      'SNACKS': Colors.orange,
    };

    final categoryKeys = categoryColors.keys.toList(); // Get the list of category keys
    final categoryValues = categoryColors.values.toList(); // Get the list of colors

    final uniqueCategories = categories
        .map((recipe) => recipe.split(': ')[0])
        .toSet(); // Extract unique categories from recipes

    return uniqueCategories.map((category) {
      if (categoryColors.containsKey(category)) {
        return categoryColors[category]!;
      } else {
        // Dynamically assign fallback color based on the hash of the category name
        final index = category.hashCode % categoryValues.length;
        return categoryValues[index];
      }
    }).toList();
  }

}
