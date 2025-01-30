import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Recipes extends StatefulWidget {
  const Recipes({super.key});

  @override
  State<Recipes> createState() => _RecipesState();
}

class _RecipesState extends State<Recipes> {
  String _searchQuery = '';

  void _showRecipeDetails(String recipeId) {
    print("Show details for recipe: $recipeId");
  }

  void _addNewRecipe() {
    showModalBottomSheet(
      context: context,
      builder: (context) => AddRecipeForm(),
    );
  }

  void _editRecipe(String recipeId, Map<String, dynamic> recipeData) {
    showModalBottomSheet(
      context: context,
      builder: (context) =>
          EditRecipeForm(recipeId: recipeId, recipeData: recipeData),
    );
  }

  void _deleteRecipe(String recipeId) {
    FirebaseFirestore.instance
        .collection('Complete-Flutter-App')
        .doc(recipeId)
        .delete()
        .then((value) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Recipe deleted successfully')));
    }).catchError((error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error deleting recipe')));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          UserSearch(
              onChanged: (value) => setState(() => _searchQuery = value)),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('Complete-Flutter-App').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                final filteredDocs = snapshot.data!.docs.where((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  final recipeName = data['name'] ?? '';
                  return recipeName.toLowerCase().contains(
                      _searchQuery.toLowerCase());
                }).toList();

                if (filteredDocs.isEmpty) {
                  return Center(child: Text('No recipes found'));
                }

                return ListView.builder(
                  itemCount: filteredDocs.length,
                  itemBuilder: (context, index) {
                    final doc = filteredDocs[index];
                    final data = doc.data() as Map<String, dynamic>;
                    final recipeName = data['name'] ?? 'No name';
                    final category = data['category'] ?? 'No category';
                    final rate = data['rate'] ?? 'No rating';
                    final reviews = data['reviews'] ?? 0;
                    final time = data['time'] ?? 0;

                    return ListTile(
                      title: Text(recipeName),
                      subtitle: Text(
                          'Category: $category\nRating: $rate ($reviews reviews)\nTime: $time mins'),
                      onTap: () {
                        _showRecipeDetails(doc.id);
                      },
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              _editRecipe(doc.id, data);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _deleteRecipe(doc.id);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: _addNewRecipe,
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}

class UserSearch extends StatelessWidget {
  final Function(String) onChanged;

  UserSearch({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Search recipes',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
        ),
        onChanged: onChanged,
      ),
    );
  }
}

class AddRecipeForm extends StatefulWidget {
  @override
  _AddRecipeFormState createState() => _AddRecipeFormState();
}

class _AddRecipeFormState extends State<AddRecipeForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _imageController = TextEditingController();
  final _rateController = TextEditingController();
  final _reviewsController = TextEditingController();
  final _timeController = TextEditingController();
  final _caloriesController = TextEditingController();
  final _ingredientsController = TextEditingController();
  final _stepsController = TextEditingController();

  void _saveRecipe() {
    if (_formKey.currentState!.validate()) {
      FirebaseFirestore.instance.collection('Complete-Flutter-App').add({
        'name': _nameController.text,
        'category': _categoryController.text,
        'image': _imageController.text,
        'rate': _rateController.text,
        'reviews': int.tryParse(_reviewsController.text) ?? 0,
        'time': int.tryParse(_timeController.text) ?? 0,
        'cal': int.tryParse(_caloriesController.text) ?? 0,
        'ingredients': _ingredientsController.text.split(','), // Assuming comma-separated
        'steps': _stepsController.text.split(','), // Assuming comma-separated
      }).then((value) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Recipe added successfully')));
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error adding recipe')));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Recipe Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _categoryController,
              decoration: InputDecoration(labelText: 'Category'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a category';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _imageController,
              decoration: InputDecoration(labelText: 'Image URL'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an image URL';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _rateController,
              decoration: InputDecoration(labelText: 'Rate'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a rating';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _reviewsController,
              decoration: InputDecoration(labelText: 'Reviews'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter reviews count';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _timeController,
              decoration: InputDecoration(labelText: 'Time'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter cooking time';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _caloriesController,
              decoration: InputDecoration(labelText: 'Calories'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter calorie count';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _ingredientsController,
              decoration: InputDecoration(labelText: 'Ingredients (comma-separated)'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter ingredients';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _stepsController,
              decoration: InputDecoration(labelText: 'Steps (comma-separated)'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter steps';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveRecipe,
              child: Text('Save Recipe'),
            ),
          ],
        ),
      ),
    );
  }
}

class EditRecipeForm extends StatefulWidget {
  final String recipeId;
  final Map<String, dynamic> recipeData;

  const EditRecipeForm({required this.recipeId, required this.recipeData, Key? key}) : super(key: key);

  @override
  _EditRecipeFormState createState() => _EditRecipeFormState();
}

class _EditRecipeFormState extends State<EditRecipeForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _categoryController;
  late TextEditingController _imageController;
  late TextEditingController _rateController;
  late TextEditingController _reviewsController;
  late TextEditingController _timeController;
  late TextEditingController _caloriesController;
  late TextEditingController _ingredientsController;
  late TextEditingController _stepsController;

  @override
  void initState() {
    super.initState();

    // Initialize controllers with existing recipe data
    _nameController = TextEditingController(text: widget.recipeData['name'] ?? '');
    _categoryController = TextEditingController(text: widget.recipeData['category'] ?? '');
    _imageController = TextEditingController(text: widget.recipeData['image'] ?? '');
    _rateController = TextEditingController(text: widget.recipeData['rate'] ?? '');
    _reviewsController = TextEditingController(text: widget.recipeData['reviews']?.toString() ?? '');
    _timeController = TextEditingController(text: widget.recipeData['time']?.toString() ?? '');
    _caloriesController = TextEditingController(text: widget.recipeData['cal']?.toString() ?? '');
    _ingredientsController = TextEditingController(
        text: (widget.recipeData['ingredients'] as List<dynamic>?)?.join(', ') ?? '');
    _stepsController = TextEditingController(
        text: (widget.recipeData['steps'] as List<dynamic>?)?.join(', ') ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    _imageController.dispose();
    _rateController.dispose();
    _reviewsController.dispose();
    _timeController.dispose();
    _caloriesController.dispose();
    _ingredientsController.dispose();
    _stepsController.dispose();
    super.dispose();
  }

  void _saveUpdatedRecipe() {
    if (_formKey.currentState!.validate()) {
      FirebaseFirestore.instance
          .collection('Complete-Flutter-App')
          .doc(widget.recipeId)
          .update({
        'name': _nameController.text,
        'category': _categoryController.text,
        'image': _imageController.text,
        'rate': _rateController.text,
        'reviews': int.tryParse(_reviewsController.text) ?? 0,
        'time': int.tryParse(_timeController.text) ?? 0,
        'cal': int.tryParse(_caloriesController.text) ?? 0,
        'ingredients': _ingredientsController.text.split(',').map((e) => e.trim()).toList(),
        'steps': _stepsController.text.split(',').map((e) => e.trim()).toList(),
      }).then((value) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Recipe updated successfully')));
      }).catchError((error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error updating recipe')));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Recipe Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _categoryController,
              decoration: InputDecoration(labelText: 'Category'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a category';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _imageController,
              decoration: InputDecoration(labelText: 'Image URL'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an image URL';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _rateController,
              decoration: InputDecoration(labelText: 'Rate'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a rating';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _reviewsController,
              decoration: InputDecoration(labelText: 'Reviews'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter reviews count';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _timeController,
              decoration: InputDecoration(labelText: 'Time (in minutes)'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter cooking time';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _caloriesController,
              decoration: InputDecoration(labelText: 'Calories'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter calorie count';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _ingredientsController,
              decoration: InputDecoration(labelText: 'Ingredients (comma-separated)'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter ingredients';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _stepsController,
              decoration: InputDecoration(labelText: 'Steps (comma-separated)'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter steps';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveUpdatedRecipe,
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}