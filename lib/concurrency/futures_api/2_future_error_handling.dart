///https://www.youtube.com/watch?v=-zNC2hWftho&list=RDCMUC8NpGP0AOQ0kX9ZRcohiPeQ&index=10
///Future error handling
void main() async {
  try {
    var jorge = await getFullName1(firstName: 'jorge', lastName: 'dieguez');
    print(jorge);
    var jorge2 = await getFullName1(firstName: '', lastName: 'dieguez');
    print(jorge2);
  } on FirstOrLastNameMissing catch (e) {
    e.toString();
    print('first or last name missing');
  }
  try {
    var age1 = await getAge(age: 2);
    print('age: $age1');
  } on AgeError catch (e) {
    AgeError error = e;
    print(error);
    print(error.message);
  }
  try {
    var age2 = await getAge(age: 1);
    print('age: $age2');
  } on AgeError catch (e) {
    AgeError error = e;
    print(error);
    print(error.message);
  }
}

Future<String> getFullName1({required String firstName, required String lastName}) async {
  if (firstName.isEmpty || lastName.isEmpty) {
    throw const FirstOrLastNameMissing();
  } else {
    return '$firstName, $lastName';
  }
}

Future<String> getFullName2({required String firstName, required String lastName}) {
  if (firstName.isEmpty || lastName.isEmpty) {
    throw const FirstOrLastNameMissing();
  } else {
    return Future.value('$firstName, $lastName');
  }
}

Future<int> getAge({required int age}) {
  if (age.isOdd) {
    throw AgeError(message: 'Age is oddd');
  } else {
    throw AgeError(message: 'Age is even');
    return Future.value(age);
  }
}

class FirstOrLastNameMissing implements Exception {
  const FirstOrLastNameMissing();
}

class AgeError extends Error {
  final String message;

  AgeError({required this.message});
}
