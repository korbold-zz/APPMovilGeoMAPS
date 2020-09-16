import 'package:busmart/features/login/data/repositories/login_data_repositoy.dart';
import 'package:flutter_test/flutter_test.dart';

LoginDataRepository _dataRepository;
void main() {
  group('login', () {
    post ()async {
      return await _dataRepository.postLogin('korbold', 'get\$321');
    }
    test('Login post', () {
            //take
      expect(
        post,
        isNotNull,
      );
    });

    test('Save Credentials', (){
      post();
    });
  });
}
