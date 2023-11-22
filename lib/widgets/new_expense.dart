import 'package:expenseapp/models/expense.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({Key? key}) : super(key: key);

  @override
  _NewExpenseState createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _namecontroller = TextEditingController();
  final _amountCountroller = TextEditingController();
  Category _selectedCategory = Category.education;
  DateTime? _selectedDate;

  void _openDatePicker() async {
    // DatePicker açmak..
    //Datepickerdan gelen değeri text olarak yazdırmak.
    //built-in function-> ilgili teknolojinin kendi içinde hazır bir şekilde gelmesidir.

    DateTime now = DateTime.now();
    DateTime oneYearAgo = DateTime(now.year - 1, now.month, now.day);

    //bir yıl öncesi ve bugun arasında kısıtlama oluşturuldu.
    //sync = bir işlem bitmeden diğer işlemin başlamadığı yapı
    //async = diğer işleme geçmek için önceki işlemin bitmesini beklemezler.

    /* showDatePicker(
            context: context,
            initialDate: now,
            firstDate: oneYearAgo,
            lastDate: now)
        .then((value) {
      print(value);
    });*/

    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate == null ? now : _selectedDate!,
        firstDate: oneYearAgo,
        lastDate: now);
    setState(() {
      _selectedDate = selectedDate;
    });

    // showdatepicker, kullanıcıdan bir değer girmesini bekleyen ve geriye bir Future (Gelecek) tipinde datetime döndüren bir işlevdir.
    //---> Bu işlev, asenkron bir yapıya sahiptir, bu nedenle kullanıcıdan giriş alınması işlemini beklemeden sonraki satıra geçer.
    //AWAİT, asenkron (asyn) programlamada bir işlemin sonlanmasını beklerken diğer işlemlerin devam etmesini sağlayan bir ifadedir.

    //Asenkron bir işlemden geriye değer nasıl alınır? (kullanıcının değeri ne zaman sececeği belli değil) ama then.(value){};
    //1* yöntem ==>> THEN,  asenkron işlemlerden dönen sonuçların elde edildiği zamanı belirleyen ve işlem tamamlandığında belirli bir aksiyonu gerçekleştiren bir yapıdır.
    //---> Bu durumda, kullanıcı bir tarih seçtiğinde çalışacak olan kodu içerir.

    //2* yöntem ==>> ilgili fonksiyona asenkron olarak tanımlama yapılabilir.  void _openDatePicker asyn () {};
    //--->ve asenkron işlemin önüne (showdatepicker)'a Await anahtar kelimesi eklenir. Await ilgili asyn işlemi gerçekleşene kadar bekle demektir.
    //bir satırı await ediliyorsa fonksiyon çıktısı bir değişkene atanabilir.?? DateTime? selectedDate = await showDatePicker---print(selectedDate)
  }

  void _addNewExpense() {
    final amount = double.tryParse(_amountCountroller
        .text); //parse değer nullsa hata fırlatır. tryparse değeri null olarak kalır
    if (amount == null ||
        amount < 0 ||
        _namecontroller.text.isEmpty ||
        _selectedDate == null) {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text("validation Error"),
              content: const Text("please fill all blank areas"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: const Text("okey"))
              ],
            );
          });
    } else {
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text("Bilgi"),
            content: const Text("Kaydınız Oluşturulmuştur."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text("Tamam"),
              ),
            ],
          );
        },
      );
    }
  }

  void _saveExpense() {
    if (_selectedDate != null &&
        _amountCountroller.text.isNotEmpty &&
        _namecontroller.text.isNotEmpty) {
      Expense newExpense = Expense(
        name: _namecontroller.text,
        price: double.parse(_amountCountroller.text),
        date: _selectedDate!,
        category: _selectedCategory,
      );
      print(
          "Yeni Gider: ${newExpense.name}, ${newExpense.price}, ${newExpense.formattedDate}, ${newExpense.category}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _namecontroller,
              maxLength: 50,
              decoration: const InputDecoration(label: Text("Expense Name")),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _amountCountroller,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        label: Text("Amount"), prefixText: "₺"),
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () => _openDatePicker(),
                          icon: const Icon(Icons.calendar_month)),
                      const SizedBox(
                        width: 30,
                      ),
                      //ternary operator --> tek satırlık if
                      Text(_selectedDate == null
                          ? "Tarih Seçiniz.."
                          : DateFormat.yMd().format(_selectedDate!)),
                      //(!) bir değişkenin veya ifadenin null olmadığını belirtmek için kullanılır.
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                DropdownButton(
                    value: _selectedCategory,
                    items: Category.values.map((Category) {
                      return DropdownMenuItem(
                        value: Category,
                        child: Text(Category.name.toString()),
                      );
                    }).toList(),
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        if (value != null) _selectedCategory = value;
                      });
                    })
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("vazgeç")),
                const SizedBox(
                  width: 30,
                ),
                ElevatedButton(
                    onPressed: () {
                      _saveExpense();
                      _addNewExpense();
                    },
                    child: const Text("kaydet")),
              ],
            ),
          ],
        ));
  }
}
