class ExpenseEntry {
  final String title;
  final double amount;
  final DateTime date;

  ExpenseEntry(this.title, this.amount, this.date);

  ExpenseEntry.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        amount = json['amount'] as double,
        date = json['date'] as DateTime;

  Map<String, dynamic> toJson() =>
      {'title': title, 'amount': amount, 'date': date};

  ExpenseEntry modifyTitle(String newTitle) {
    return ExpenseEntry(newTitle, amount, date);
  }

  ExpenseEntry modifyAmount(double newAmount) {
    return ExpenseEntry(title, newAmount, date);
  }
}
