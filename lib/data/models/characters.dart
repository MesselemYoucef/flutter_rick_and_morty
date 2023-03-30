class Characters{
  late int charId;
  late String name;
  late String statusIdDeadOrAlive;
  late String species;
  late String gender;
  late String image;
  late String created;
  late List<dynamic> episodes;

  Characters.fromJson(Map<String, dynamic> json){
    charId = json['id'];
    name = json['name'];
    statusIdDeadOrAlive = json['status'];
    species = json['species'];
    gender = json['gender'];
    image = json['image'];
    created = json['created'];
    episodes = json['episodes'];
  }
}