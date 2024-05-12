///https://www.youtube.com/watch?v=-zNC2hWftho&list=RDCMUC8NpGP0AOQ0kX9ZRcohiPeQ&index=10
///futures
void main() async {
  print(await getUserName());
  print(await getPhoneNumber());
  print(await getAddress());
  print(await getCity());
  print(await getCountry());
  print(await getZipCode());
}

Future<String> getUserName() async  => 'Jorge';

//compute a future
Future<String> getAddress() => Future.value('123 Main Street');

Future<String> getPhoneNumber() => Future.delayed(const Duration(seconds: 2), () => '555 555 5555');

Future<String> getCity() async {
  await Future.delayed(const Duration(seconds: 2));
  return 'New York';
}

Future<String> getCountry() async => 'India';

//* async keyword does not contribute anything here, because we are not awaiting for the future nor we are returning any row value as in the first example
Future<String> getZipCode() => Future.delayed(const Duration(seconds: 2), () async => '12345');