import 'package:flutter/material.dart';

enum Gender { male, female }

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        unselectedWidgetColor: Colors.pink,
      ),
      home: Scaffold(
        appBar: AppBar(),
        body: const Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  MyFormState createState() => MyFormState();

}

class MyFormState extends State {
  final _formKey = GlobalKey<FormState>();
  bool value = false;

  Gender? _gender;

  final notifications = [
    CheckBoxState(title: 'Сухой корм'),
    CheckBoxState(title: 'Влажный корм'),
    CheckBoxState(title: 'Натуральный корм'),
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                const Text(
                  'Имя пользователя:',
                  style: TextStyle(fontSize: 20.0),
                ),
                TextFormField(validator: (value) {
                  if (value!.isEmpty) return 'Ваше имя';
                }),
                const SizedBox(height: 20.0),
                const Text(
                  'Контактный E-mail:',
                  style: TextStyle(fontSize: 20.0),
                ),
                TextFormField(validator: (value) {
                  if (value!.isEmpty) return 'Пожалуйста введите свой E-mail';
                  if (!value.contains('@')) return 'Это не E-mail';
                }),
                const SizedBox(height: 20.0),
                const Text(
                  'Кличка котика ^^',
                  style: TextStyle(fontSize: 20.0),
                ),
                TextFormField(validator: (value) {
                  if (value!.isEmpty) return 'Кличка котика';
                }),
                const SizedBox(height: 20.0),
                const Text(
                  'Порода котика',
                  style: TextStyle(fontSize: 20.0),
                ),
                TextFormField(validator: (value) {
                  if (value!.isEmpty) return 'Порода котика';
                }),
                const SizedBox(height: 20.0),
                const Text(
                  'Пол котика:',
                  style: TextStyle(fontSize: 20.0),
                ),
                RadioListTile(
                  title: const Text('Котик',
                    style: TextStyle(fontSize: 20.0),),
                  value: Gender.male,
                  groupValue: _gender,
                  onChanged: (Gender? value) {
                    setState(() {
                      if (value != null) _gender = value;
                    });
                  },
                ),
                RadioListTile(
                  title: const Text('Кошечка',
                    style: TextStyle(fontSize: 20.0),),
                  value: Gender.female,
                  groupValue: _gender,
                  onChanged: (Gender? value) {
                    setState(() {
                      if (value != null) _gender = value;
                    });
                  },
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.restaurant,
                        size: 50),
                    const SizedBox(height: 20.0),
                    const Text('Питание котика:',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    ...notifications.map(buildSingleCheckbox).toList(),
                    ],
                  ),
                const SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Color color = Colors.amber;
                      String text;

                      if (_gender == null) {
                        text = 'Выберите пол';
                      } else if (!notifications.any((e) => e.value)) {
                        text = 'Необходимо выбрать один из вариантов';
                      }else {
                        text = 'Форма успешно заполнена';
                        color = Colors.amberAccent;
                        }

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(text),
                          backgroundColor: Colors.pink,
                        ),
                      );
                    }
                  },
                  child: const Text('Проверить'),
                ),
              ],
            ),
          ),
        ));
  }

  Widget buildSingleCheckbox(CheckBoxState checkbox) =>
      CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: Colors.pink,
        value: checkbox.value,
        title: Text(
          checkbox.title,
          style: TextStyle(fontSize: 20),
        ),
        onChanged: (value) => setState(() => checkbox.value = value!),
          );

}

class CheckBoxState {
  final String title;
  bool value;

  CheckBoxState({
    required this.title,
    this.value = false,
  });
}