import 'package:final_exam1/controller/fire_base_controller.dart';
import 'package:final_exam1/helper/expense_helper.dart';
import 'package:final_exam1/modal/expense_modal.dart';
import 'package:get/get.dart';

class ExpenseController extends GetxController {
  var expenseList = <Expense>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchExpenses();
    super.onInit();
  }

  void fetchExpenses() async {
    isLoading(true);
    try {
      var expenses = await DBHelper.getExpenses();
      expenseList.assignAll(expenses);
    } finally {
      isLoading(false);
    }
  }

  void addExpense(Expense expense, ) async {
    await DBHelper.insertExpense(expense);
    fetchExpenses();
  }

  void updateExpense(Expense expense) async {
    await DBHelper.updateExpense(expense);
    fetchExpenses();
  }

  void deleteExpense(int id) async {
    expenseList.removeAt(id);
    await DBHelper.deleteExpense(id);
    fetchExpenses();
  }

  void allDataStoreToDataBase()
  {
    for(Expense expense in expenseList)
    {
      GoogleFirebaseServices.googleFirebaseServices.allDataStore(expense);
    }
  }

}
