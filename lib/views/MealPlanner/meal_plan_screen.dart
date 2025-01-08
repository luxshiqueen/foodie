import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/controllers/meal_plan_controller.dart';
import 'package:myapp/model/meal_plan.dart';
import 'package:myapp/widget/custom_floating_action_button.dart';
import 'package:table_calendar/table_calendar.dart';

class MealPlanScreen extends StatefulWidget {
  const MealPlanScreen({super.key});

  @override
  _MealPlanScreenState createState() => _MealPlanScreenState();
}

class _MealPlanScreenState extends State<MealPlanScreen> {
  final MealPlanController _controller = MealPlanController();
  DateTime _selectedDate = DateTime.now();
  List<MealPlan> _meals = [];
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _fetchMeals();
  }

  Future<void> _fetchMeals() async {
    final meals = await _controller.fetchMealsByDate(_selectedDate);
    setState(() {
      _meals = meals;
    });
  }

  void _addMeal() {
    _showMealDialog(isEdit: false);
  }

  void _editMeal(MealPlan meal) {
    _showMealDialog(isEdit: true, meal: meal);
  }

  void _showMealDialog({required bool isEdit, MealPlan? meal}) {
    TextEditingController mealNameController =
        TextEditingController(text: isEdit ? meal?.title : '');
    String mealType = isEdit ? meal?.mealType ?? "Breakfast" : "Breakfast";
    File? image;

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: const Color.fromARGB(255, 33, 32, 32),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          isEdit ? "Edit Meal Plan" : "Add Meal Plan",
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white),
                        ),
                        const SizedBox(height: 20),
                        DropdownButtonFormField<String>(
                          dropdownColor: const Color.fromARGB(255, 19, 19, 19),
                          value: mealType,
                          items: ["Breakfast", "Lunch", "Dinner"]
                              .map(
                                (type) => DropdownMenuItem(
                                  value: type,
                                  child: Text(type,
                                      style:
                                          const TextStyle(color: Colors.white)),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            mealType = value!;
                          },
                          decoration: const InputDecoration(
                            labelText: "Meal Type",
                            labelStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: mealNameController,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            labelText: "Meal Name",
                            labelStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () async {
                            final pickedFile = await _picker.pickImage(
                              source: ImageSource.gallery,
                            );
                            if (pickedFile != null) {
                              setState(() {
                                image = File(pickedFile.path);
                              });
                            }
                          },
                          child: Container(
                            height: 100,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: image != null
                                ? Image.file(image!, fit: BoxFit.cover)
                                : (isEdit && meal?.imagePath.isNotEmpty == true)
                                    ? Image.file(File(meal!.imagePath),
                                        fit: BoxFit.cover)
                                    : const Center(
                                        child: Text(
                                          "Tap to select an image",
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Cancel",
                                  style: TextStyle(color: Colors.white)),
                            ),
                            TextButton(
                              onPressed: () async {
                                if (mealNameController.text.isNotEmpty) {
                                  if (isEdit && meal != null) {
                                    meal.mealType = mealType;
                                    meal.title = mealNameController.text;
                                    meal.imagePath = image != null
                                        ? image!.path
                                        : meal.imagePath;
                                    await _controller.updateMeal(meal);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text("Saved Successfully")),
                                    );
                                  } else {
                                    MealPlan newMeal = MealPlan(
                                      mealType: mealType,
                                      title: mealNameController.text,
                                      imagePath: image?.path ?? '',
                                      servings: 1,
                                      date: _selectedDate,
                                    );
                                    await _controller.addMeal(newMeal);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text("Saved Successfully")),
                                    );
                                  }
                                  _fetchMeals();
                                  Navigator.pop(context);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text("Please fill all fields.")),
                                  );
                                }
                              },
                              child: const Text("Save",
                                  style: TextStyle(color: Colors.orange)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void _deleteMeal(int id) async {
    await _controller.deleteMeal(id);
    _fetchMeals();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Deleted Successfully")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          'Meal Plan',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            TableCalendar(
              focusedDay: _selectedDate,
              firstDay: DateTime(2020),
              lastDay: DateTime(2030),
              onDaySelected: (selectedDay, _) {
                setState(() {
                  _selectedDate = selectedDay;
                });
                _fetchMeals();
              },
              calendarStyle: const CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                weekendTextStyle:
                    TextStyle(color: Color.fromARGB(255, 249, 114, 47)),
                defaultTextStyle: TextStyle(color: Colors.white),
              ),
              daysOfWeekStyle: const DaysOfWeekStyle(
                weekendStyle:
                    TextStyle(color: Color.fromARGB(255, 240, 118, 42)),
                weekdayStyle: TextStyle(color: Colors.white),
              ),
              headerStyle: const HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false,
                titleTextStyle: TextStyle(color: Colors.white, fontSize: 16),
                leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
                rightChevronIcon:
                    Icon(Icons.chevron_right, color: Colors.white),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _meals.length,
              itemBuilder: (context, index) {
                final meal = _meals[index];
                return Card(
                  color: const Color.fromARGB(255, 23, 23, 23),
                  elevation: 4,
                  shadowColor: Colors.orange.withOpacity(0.8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: meal.imagePath.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              File(meal.imagePath),
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Icon(Icons.fastfood, color: Colors.orange),
                    title: Text(meal.title,
                        style: const TextStyle(color: Colors.white)),
                    subtitle: Text(meal.mealType,
                        style: const TextStyle(color: Colors.grey)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.orange),
                          onPressed: () => _editMeal(meal),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.orange),
                          onPressed: () => _deleteMeal(meal.id!),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () => _addMeal(),
      ),
    );
  }
}
