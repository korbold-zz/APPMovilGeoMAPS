abstract class RegisterDomainRepositoryINTERFACE {
  Future<bool> postRegister(
      {String dni,
      String firstName,
      String lastName,
      String dateBirth,
      String numberCell,
      String userName,
      String password,
      String email});
}
