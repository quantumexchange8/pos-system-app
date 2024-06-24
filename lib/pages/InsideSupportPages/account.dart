import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pos_system/const/textStyle.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Account',
          style: bodyMregular.copyWith(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.tertiary,
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('Delete account', style: heading4Regular),
            subtitle: Text(
                'Permanently delete your Einbill account and all its data',
                style: bodySregular),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  bool _isVisible = false;
                  return StatefulBuilder(
                    builder: (context, setState) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        backgroundColor:
                            Theme.of(context).colorScheme.background,
                        title: Text('Enter your password', style: heading3Regular),
                        content: SizedBox(
                          height: 110,
                          child: Column(
                            children: [
                              Text(
                                'For security reasons, please enter your password to continue',
                                style: bodySregular,
                              ),
                              const SizedBox(height: 15),
                              TextField(
                                controller: passwordController,
                                obscureText: !_isVisible,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _isVisible = !_isVisible;
                                      });
                                    },
                                    icon: _isVisible
                                        ? const Icon(Icons.visibility_outlined)
                                        : const Icon(Icons.visibility_off_outlined),
                                  ),
                                  labelText: 'Password',
                                  labelStyle: heading4Regular,
                                  contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('CANCEL'),
                          ),
                          TextButton(
                            onPressed: () {
                              // Handle the continue action
                              //need firebase auth to delete user accounts
                            },
                            child: const Text('CONTINUE'),
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
