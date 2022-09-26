class GuardDetails {
  String? firstName;
  String? lastName;
  String? dateOfBirth;
  String? email;
  String? password;
  String? address;
  String? summary;
  String? previousWork;
  String? profileURL;
  String? idFront;
  String? idBack;
  String? licenseFront;
  String? licenseBack;

  GuardDetails(
      {this.firstName,
      this.lastName,
      this.address,
      this.dateOfBirth,
      this.email,
      this.idBack,
      this.idFront,
      this.licenseBack,
      this.licenseFront,
      this.password,
      this.previousWork,
      this.profileURL,
      this.summary});

GuardDetails.fromJSON(Map<String,dynamic> json){
firstName = json["firstName"];
email = json["email"];
password = json["password"];
profileURL =json["profileURL"];

}
Map<String,dynamic> toJson(){
  final Map<String,dynamic> data = new Map<String,dynamic>();
  data['firstName'] = this.firstName;
  data['email'] = this.email;
  data['profileURL'] = this.profileURL;
return data;
}




}
