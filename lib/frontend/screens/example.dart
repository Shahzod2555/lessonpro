import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isChecked = false; 

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Stack(
        children: [
          Align(alignment: Alignment.topCenter, child: Image.asset('static/images/image.png')),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                  Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          label: const Text("Введите почту"),
                          labelStyle: TextStyle(
                            color: colorScheme.secondary
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          label: const Text("Введите почту"),
                          labelStyle: TextStyle(
                            color: colorScheme.secondary
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(value: isChecked, onChanged: (bool? value) => setState(() => isChecked = value!)),
                            const Text("Keep me logged in")
                          ],
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text("Forgott Password?")
                        )
                      ],
                    )
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {},
                      child: const Padding(padding: EdgeInsets.all(15), child: Text("Login"))
                    )
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 15), child: Text("OR")),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: colorScheme.primary,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: SvgPicture.asset('static/google_icon.svg', width: 24.0, height: 24.0)
                              ),
                              const Padding(
                                padding: EdgeInsets.all(5),
                                child: Text("Google")
                              )
                            ],
                          )
                        )
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: colorScheme.primary,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: SvgPicture.asset('static/facebook_icon.svg', width: 24.0, height: 24.0)
                              ),
                              const Padding(
                                padding: EdgeInsets.all(5),
                                child: Text("Facebook")
                              )
                            ],
                          )
                        )
                      ),
                    ],
                  )
                ],
              ),
            )
          )
        ],
      )
    );
  }
}