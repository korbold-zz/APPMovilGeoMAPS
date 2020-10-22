import 'package:busmart/features/login/presentation/bloc/login_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../loginRepositoryMock.dart';

void main() {
  final loginMOCK = LoginRespositoryMOCK();
  final loginBlocTEST =  LoginBloc(loginMOCK);

  group('Test Login', (){
    test('Send if you is initial Session True', () async {
      when(loginMOCK.verifySessionInCache()).thenAnswer((_) => Future.value(true));
      final result = await loginBlocTEST.verifyCredentials();
      expect(result, isTrue);
    });

    test('Send if you is initial Session false', () async {
      when(loginMOCK.verifySessionInCache()).thenAnswer((_) => Future.value(false));
      final result = await loginBlocTEST.verifyCredentials();
      expect(result, isFalse);
    });
    test('Send Session credentials', () async {
      when(loginMOCK.postLogin('korbold', 'get321')).thenAnswer((_) => Future.value());
      final result = await loginBlocTEST.sendSession();
      expect(result, isNotNull);
    });

    test('Send Sign Out', () async {
      when(loginMOCK.clearCredentials()).thenAnswer((realInvocation) => Future.value(true));
      final result = await loginBlocTEST.signOut();
      expect(result, isTrue);
    });
    test('Send Reset Password', () async {
      when(loginMOCK.postPasswordReset('korbold@live.com')).thenAnswer((realInvocation) => Future.value(true));
      final result = await loginBlocTEST.sendPasswordReset(email: 'korbold@live.com');
      expect(result, isTrue);
    });
  });


}
