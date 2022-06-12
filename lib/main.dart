import 'package:flutter/material.dart';
import 'lib/model/checkbox_state.dart';
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
  //var _agreement = false;
  Gender? _gender;

 // var CheckboxState = <MyFormState>[];
  final notifications = [
    CheckboxState(title: 'сухой корм'),
    CheckboxState(title: 'влажный корм'),
    CheckboxState(title: 'натуральный корм'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10.0),
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
        'Кличка котика',
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
        title: const Text('Котик'),
        value: Gender.male,
        groupValue: _gender,
        onChanged: (Gender? value) {
          setState(() {
            if (value != null) _gender = value;
          });
        },
      ),
      RadioListTile(
        title: const Text('Кошечка'),
        value: Gender.female,
        groupValue: _gender,
        onChanged: (Gender?  value) {
          setState(() {
            if (value != null) _gender = value;
          });
        },
      ),
      Expanded(child:
          Column(
              children: [
                ...notifications.map(buildSingleCheckbox).toList(),
              ],

          ),

        Widget buildSingleCheckbox(CheckboxState checkbox) => CheckboxListTile(
         controlAffinity: ListTileControlAffinity.leading,
        activeColor: Colors.pink,
        value: checkbox.value,
           title: Text(
             checkbox.title,
             style: TextStyle(fontSize: 20),
           ),
           onChanged: (value) => setState(() => checkbox.value = value!),
       ),

    ])));

  }
}