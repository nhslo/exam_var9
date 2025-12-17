/*
Наиболее подходящий паттерн по моему мнению Factory Method.
Он идеален здесь потому что нужно создавать разные объекты платежей такие как CreditCardPayment, EWalletPayment и т.д..
на основе выбранного типа, все они реализуют один интерфейс IPayment, и система должна легко расширяться новыми методами оплаты без изменения существующего кода.
Другие паттерны Strategy, Abstract Factory здесь менее точны
Strategy больше про смену поведения, а не создание объектов
*/


// интерфейс платежа
abstract class IPayment {
  void processPayment(double amount);
  bool validatePaymentDetails(Map<String, String> details);
  String getTransactionStatus();
}

// реализации
class CreditCardPayment implements IPayment {
  @override
  void processPayment(double amount) {
    print('оплата $amount ₽ по карте прошла');
  }

  @override
  bool validatePaymentDetails(Map<String, String> details) {
    print('карта проверена');
    return true;
  }

  @override
  String getTransactionStatus() => 'оплачено';
}

class EWalletPayment implements IPayment {
  @override
  void processPayment(double amount) {
    print('оплата $amount ₽ через кошелёк прошла');
  }

  @override
  bool validatePaymentDetails(Map<String, String> details) {
    print('кошелёк проверен');
    return true;
  }

  @override
  String getTransactionStatus() => 'оплачено';
}

class BankTransferPayment implements IPayment {
  @override
  void processPayment(double amount) {
    print('перевод $amount ₽ в банк отправлен');
  }

  @override
  bool validatePaymentDetails(Map<String, String> details) {
    print('реквизиты проверены');
    return true;
  }

  @override
  String getTransactionStatus() => 'в обработке';
}

class CryptoPayment implements IPayment {
  @override
  void processPayment(double amount) {
    print('крипта на $amount ₽ отправлена');
  }

  @override
  bool validatePaymentDetails(Map<String, String> details) {
    print('адрес кошелька проверен');
    return true;
  }

  @override
  String getTransactionStatus() => 'ждёт подтверждений';
}

// фабрика
class PaymentFactory {
  static IPayment createPayment(String type) {
    switch (type.toLowerCase()) {
      case 'creditcard':
        return CreditCardPayment();
      case 'ewallet':
        return EWalletPayment();
      case 'banktransfer':
        return BankTransferPayment();
      case 'crypto':
        return CryptoPayment();
      default:
        throw Exception('способ оплаты не существует');
    }
  }
}

// демонстрация
void main() {
  double sum = 2500.0;

  print('проверка оплаты картой..');
  var card = PaymentFactory.createPayment('creditcard');
  card.validatePaymentDetails({});
  card.processPayment(sum);
  print('статус: ${card.getTransactionStatus()}\n');

  print('проверка оплаты кошельком..');
  var wallet = PaymentFactory.createPayment('ewallet');
  wallet.validatePaymentDetails({});
  wallet.processPayment(sum);
  print('статус: ${wallet.getTransactionStatus()}\n');

  print('проверка банковского перевода..');
  var bank = PaymentFactory.createPayment('banktransfer');
  bank.validatePaymentDetails({});
  bank.processPayment(sum);
  print('статус: ${bank.getTransactionStatus()}\n');

  print('проверка оплаты криптой..');
  var crypto = PaymentFactory.createPayment('crypto');
  crypto.validatePaymentDetails({});
  crypto.processPayment(sum);
  print('статус: ${crypto.getTransactionStatus()}');
}
