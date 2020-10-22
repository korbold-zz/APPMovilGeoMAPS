import 'package:busmart/features/register/presentation/bloc/register_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../registerRepositoryMock.dart';

void main() {
  final registerMOCK = RegisterRepositoryMOCK();
  final registerTest = RegistrerBloc(registerMOCK);
  group('Register Tester', () {
    test('send Register Data', () async {
      when(registerMOCK.postRegister(
              dni: '1234567890',
              dateBirth: '1995-08-20',
              email: 'galo@live.com',
              firstName: 'Galo',
              lastName: 'Martinez',
              numberCell: '0987654321',
              password: 'hasdas111',
              userName: 'galomar'))
          .thenAnswer((realInvocation) => Future.value(true));
      final result = await registerTest.sendRegisterData(
          dni: '1234567890',
          dateBirth: '1995-08-20',
          email: 'galo@live.com',
          firstName: 'Galo',
          lastName: 'Martinez',
          numberCell: '0987654321',
          password: 'hasdas111',
          userName: 'galomar');
      expect(result, isTrue);
    });
  });
}
