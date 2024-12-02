import 'package:flutter/material.dart';
import 'package:lessonproject/backend/login_services.dart' as login_ser;
import 'package:email_validator/email_validator.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}


enum InputType {email, phone}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameEmailPhoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isObscureText = true;
  InputType? inputType;

  bool isValidPhoneNumber(String value) => RegExp(r'^(\+7|8)\d{10}$').hasMatch(value);

  String? validatorEmailPhoneNumber() {
    var value = _usernameEmailPhoneController.text.trim();

    if (value.isEmpty) {
      return 'Это поле обязательно для заполнения';
    } else if (value.contains(' ')) {
      return 'Ввод не должен содержать пробелы';
    } else if (isValidPhoneNumber(value)) {
      inputType = InputType.phone;
      return null;
    } else if (EmailValidator.validate(value)) {
      inputType = InputType.email;
      return null;
    } else {
      return 'Некорректный номер телефона или адрес электронной почты';
    }
  }

  String? validatorPassword() {
    var value = _passwordController.text;

    if (value.isEmpty) {
      return 'Пароль обязателен для заполнения';
    } else if (value.length < 8) {
      return 'Пароль должен быть не менее 8 символов';
    } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Пароль должен содержать хотя бы одну заглавную букву';
    } else if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Пароль должен содержать хотя бы одну цифру';
    } else {
      return null;
    }
  }

  Future<void> onSave() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    try {
      final response = await login_ser.requestLogin(
        phoneNumber: inputType == InputType.phone 
        ? _usernameEmailPhoneController.text
         : null,
        
        email: inputType == InputType.email ? _usernameEmailPhoneController.text : null,
        password: _passwordController.text,
      );


      if (response.statusCode == 200) {
        Navigator.pushReplacementNamed(context,'/');
        showSnackBar("Вы успешно вошли в систему!");
      } else {
        showSnackBar("Ошибка: ${response.errorMessage ?? 'Неизвестная ошибка'}");
      }
    } catch (e) {
      showSnackBar("Что-то пошло не так. Попробуйте позже.");
    }
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }


@override
Widget build(BuildContext context) {
  final colorScheme = Theme.of(context).colorScheme;
  return Scaffold(
    body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0),
                children: <TextSpan>[
                  TextSpan(text: 'L', style: TextStyle(color: colorScheme.onSurface)),
                  TextSpan(text: 'O', style: TextStyle(color: colorScheme.primary)),
                  TextSpan(text: 'G', style: TextStyle(color: colorScheme.onSurface)),
                  TextSpan(text: 'O', style: TextStyle(color: colorScheme.primary)),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Text("Login To Your Account", style: TextStyle(color: colorScheme.onSurface, fontWeight: FontWeight.bold, fontSize: 20.0)),
            const SizedBox(height: 30),
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    validator: (_) => validatorEmailPhoneNumber(),
                    controller: _usernameEmailPhoneController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      label: const Text("Введите email или номер телефона."),
                      labelStyle: TextStyle(color: colorScheme.onSurface),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: colorScheme.onSurface)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    obscureText: isObscureText,
                    controller: _passwordController,
                    validator: (_) => validatorPassword(),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(icon: Icon(isObscureText ? Icons.visibility : Icons.visibility_off), onPressed: () => setState(() => isObscureText = !isObscureText)),
                      border: InputBorder.none,
                      label: const Text("Придумайте пароль"),
                      labelStyle: TextStyle(color: colorScheme.onSurface),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: colorScheme.onSurface)),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 20),
              child: TextButton(
                onPressed: () {},
                child: const Text("Forgot Password?"),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: onSave,
                child: const Padding(
                  padding: EdgeInsets.all(15),
                  child: Text("Login"),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.secondary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                ),
                onPressed: () {},
                child: const Text("SignUp"),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}