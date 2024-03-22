class MoneyTransfer {
  final String phone;
  final String date;
  final String name;
  final bool received;
  final String purpose;
  final String amount;
  final String sender;

  MoneyTransfer({
    required this.phone,
    required this.date,
    required this.name,
    required this.amount,
    required this.received,
    required this.purpose,
    required this.sender,
  });

  factory MoneyTransfer.fromMap(Map<String, dynamic> map) {
    return MoneyTransfer(
      phone: map['phone'] ?? '',
      date: (map['date'] ?? ''),
      name: map['name'] ?? '',
      purpose: map['purpose'] ?? '',
      amount: map['amount'] ?? '',
      received: map['received'] ?? false,
      sender: map['sender'] ?? '',
    );
  }

  factory MoneyTransfer.now({
    required String phone,
    required String name,
    required bool received,
    required String amount,
    required String sender,
    required String date,
    required String purpose,
  }) {
    return MoneyTransfer(
        phone: phone,
        date: date,
        name: name,
        purpose: purpose,
        received: received,
        sender: sender,
        amount: amount);
  }

  Map<String, dynamic> toMap() {
    return {
      'phone': phone,
      'date': date,
      'name': name,
      'received': received,
      'purpose': purpose,
      "amount": amount,
      "sender": sender
    };
  }
}
