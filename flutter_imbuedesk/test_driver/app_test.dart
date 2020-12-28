// Integration testing is done here
//Here, it will create an account with a given email and password, and logs in and signs out
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Todo App', () {
    final usernameField = find.byValueKey('username');
    final passwordField = find.byValueKey('password');
    final signInButton = find.byValueKey('signIn');
    final createAccountButton = find.byValueKey('createAccount');

    final signOutButton = find.byValueKey('signOut');
    final addField = find.byValueKey('addField');
    final addButton = find.byValueKey('addButton');

    FlutterDriver driver;

    Future<bool> isPresent(SerializableFinder byValueKey,
        {Duration timeout = const Duration(seconds: 1)}) async {
      try {
        await driver.waitFor(byValueKey, timeout: timeout);
        return true;
      } catch (exception) {
        return false;
      }
    }

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

//Creating account
    test('create account', () async {
      if (await isPresent(signOutButton)) {
        await driver.tap(signOutButton);
      }

      await driver.tap(usernameField);
      await driver.enterText("sandeshjatla1@gmail.com");

      await driver.tap(passwordField);
      await driver.enterText("hello1");

      await driver.tap(createAccountButton);
      await driver.waitFor(find.text("Your Todos"));
    });

//Login
    test('login', () async {
      if (await isPresent(signOutButton)) {
        await driver.tap(signOutButton);
      }

      await driver.tap(usernameField);
      await driver.enterText("sandeshjatla1@gmail.com");

      await driver.tap(passwordField);
      await driver.enterText("hello1");

      await driver.tap(signInButton);
      await driver.waitFor(find.text("Your Todos"));
    });

//Add a todo
    test('add a todo', () async {
      if (await isPresent(signOutButton)) {
        await driver.tap(addField);
        await driver.enterText("make an integration test video");
        await driver.tap(addButton);

        await driver.waitFor(find.text("make an integration test video"),
            timeout: const Duration(seconds: 3));
      }
    });
  });
}
