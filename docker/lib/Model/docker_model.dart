class DockerModel {
  String? id;
  String? name;
  String? email;
  String? gender;
  String? age;

  DockerModel({this.id, this.name, this.email, this.gender, this.age});

  DockerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    gender = json['gender'];
    age = json['age'];
  }

}
