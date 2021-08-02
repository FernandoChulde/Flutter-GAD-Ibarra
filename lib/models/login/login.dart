class Login{
  String us;
  String pw;

  Login({this.us, this.pw});

  factory Login.fromJson(Map json){
    return Login(
      us: json['us'],
      pw: json['pw']
    );
  }

  Map toJson(){
    var map = new Map();
    map['us'] = us;
    map['pw'] = pw;

    return map;
  }
}