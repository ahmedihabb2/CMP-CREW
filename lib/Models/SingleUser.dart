class SingleUser{
  String uid;
  SingleUser({this.uid});
}

class UserData{
  final String uid;
  final String name;
  final List<dynamic> meal;
  int cost;
  bool sawab3;
  UserData({this.uid,this.name , this.meal,this.cost,this.sawab3});
}