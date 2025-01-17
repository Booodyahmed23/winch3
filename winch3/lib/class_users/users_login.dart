class UsersLogin{
  final String email;
  final String password;


  UsersLogin ({
   required this .email,
    required this .password,

});
}
List<UsersLogin> users = [
   UsersLogin(email: 'abdo@gmail.com', password: '123456'),
  UsersLogin(email: 'mt@gmail.com', password: '1234567'),
  UsersLogin(email: 'hm@gmail.com', password: '12345678'),
];



