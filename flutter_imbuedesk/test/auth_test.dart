//This is the file where testing related to authentication occurs
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_imbuedesk/services/auth.dart';
class MockUser extends Mock implements User {}

final MockUser _mockUser = MockUser();

class MockFirebaseAuth extends Mock implements FirebaseAuth {
  @override
  Stream<User> authStateChanges() {
    return Stream.fromIterable([
      _mockUser,
    ]);
  }
}

//Tests related to emission and creation
void main() {
  final MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
  final Auth auth = Auth(auth: mockFirebaseAuth);
  setUp(() {});
  tearDown(() {});

  test("emit occurs", () async {
    expectLater(auth.user, emitsInOrder([_mockUser]));
  });

  test("create account", () async {
    when(
      mockFirebaseAuth.createUserWithEmailAndPassword(
          email: "sandeshjatla@gmail.com", password: "hello1"),
    ).thenAnswer((realInvocation) => null);

    expect(
        await auth.createAccount(email: "sandeshjatla@gmail.com", password: "hello1"),
        "Success");
  });

  test("create account exception", () async {
    when(
      mockFirebaseAuth.createUserWithEmailAndPassword(
          email: "sandeshjatla@gmail.com", password: "hello1"),
    ).thenAnswer((realInvocation) =>
        throw FirebaseAuthException(message: "Some error has occured"));

    expect(
        await auth.createAccount(email: "sandeshjatla@gmail.com", password: "hello1"),
        "Some error has occured");
  });

//Tests related to sign in and exceptions
  test("sign in", () async {
    when(
      mockFirebaseAuth.signInWithEmailAndPassword(
          email: "sandeshjatla@gmail.com", password: "hello1"),
    ).thenAnswer((realInvocation) => null);

    expect(await auth.signIn(email: "sandeshjatla@gmail.com", password: "hello1"),
        "Success");
  });

  test("sign in exception", () async {
    when(
      mockFirebaseAuth.signInWithEmailAndPassword(
          email: "sandeshjatla@gmail.com", password: "hello1"),
    ).thenAnswer((realInvocation) =>
        throw FirebaseAuthException(message: "Some error has occured"));

    expect(await auth.signIn(email: "sandeshjatla@gmail.com", password: "hello1"),
        "Some error has occured");
  });

//Tests related to sign out and exceptions
  test("sign out", () async {
    when(
      mockFirebaseAuth.signOut(),
    ).thenAnswer((realInvocation) => null);

    expect(await auth.signOut(), "Success");
  });

  test("sign out exception", () async {
    when(
      mockFirebaseAuth.signOut(),
    ).thenAnswer((realInvocation) =>
        throw FirebaseAuthException(message: "Some error has occured"));

    expect(await auth.signOut(), "Some error has occured");
  });
}
