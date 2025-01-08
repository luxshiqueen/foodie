import 'package:myapp/model/meal_plan.dart';
import 'package:myapp/services/meal_plan_database.dart';


class MealPlanController {
  Future<void> addMeal(MealPlan meal) async {
    await MealPlanDatabase.instance.insertMeal(meal);
  }

  Future<List<MealPlan>> fetchMealsByDate(DateTime date) async {
    return await MealPlanDatabase.instance.fetchMealsByDate(date);
  }

  Future<void> updateMeal(MealPlan meal) async {
    await MealPlanDatabase.instance.updateMeal(meal);
  }

  Future<void> deleteMeal(int id) async {
    await MealPlanDatabase.instance.deleteMeal(id);
  }
}
