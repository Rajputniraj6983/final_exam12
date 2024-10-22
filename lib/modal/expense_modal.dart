
class Expense {
  int? id;
  String title;
  double amount;
  String category;

  Expense({this.id, required this.title, required this.amount, required this.category});


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'category': category,
    };
  }
  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      title: map['title'],
      amount: map['amount'],
      category: map['category'],
    );
  }
}
