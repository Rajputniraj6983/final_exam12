import 'package:final_exam1/helper/expense_helper.dart';
import 'package:final_exam1/modal/expense_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/expense_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  get index => null;
  @override
  Widget build(BuildContext context) {
    ExpenseController expenseController = Get.put(ExpenseController());

    void addExpense() {
      TextEditingController titleController = TextEditingController();
      TextEditingController amountController = TextEditingController();
      TextEditingController categoryController = TextEditingController();

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Add New Expense',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: amountController,
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: categoryController,
                  decoration: InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (titleController.text.isNotEmpty &&
                      amountController.text.isNotEmpty &&
                      categoryController.text.isNotEmpty) {
                    Expense ex = Expense(
                        title: titleController.text,
                        amount: double.parse(amountController.text),
                        category: categoryController.text);
                    expenseController.addExpense(ex);
                    Get.back();
                  }
                },
                child: const Text('Add'),
              ),
              TextButton(
                onPressed: () => Get.back(),
                child: const Text('Cancel'),
              ),
            ],
          );
        },
      );
    }

    void showEditDialog(BuildContext context, Expense expense) {
      final TextEditingController titleController =
          TextEditingController(text: expense.title);
      final TextEditingController amountController =
          TextEditingController(text: expense.amount.toString());
      final TextEditingController categoryController =
          TextEditingController(text: expense.category);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Edit Expense'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      labelText: 'Title'),
                ),
                SizedBox(height: 15),
                TextField(
                  controller: amountController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      labelText: 'Amount'),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 15),
                TextField(
                  controller: categoryController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      labelText: 'Category'),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  final updatedExpense = Expense(
                    id: expense.id,
                    title: titleController.text,
                    amount: double.tryParse(amountController.text) ?? 0.0,
                    category: categoryController.text,
                  );
                  DBHelper.updateExpense(updatedExpense);
                  Navigator.of(context).pop();
                },
                child: const Text('Save'),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.menu,
          color: Colors.white,
        ),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              expenseController.allDataStoreToDataBase();
            },
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          ),
        ],
        title: const Text(
          'Expenses',
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: Obx(() {
        if (expenseController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: expenseController.expenseList.length,
          itemBuilder: (context, index) {
            final expense = expenseController.expenseList[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: ListTile(
                  onTap: () {
                    showEditDialog(context, expense);
                  },
                  title: Text(expense.title),
                  subtitle: Text('${expense.amount} - ${expense.category}'),
                  trailing: InkWell(
                    onTap: () {
                      expenseController.deleteExpense(index);
                    },
                    child: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        onPressed: addExpense,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
