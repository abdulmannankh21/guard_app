class GuardDetails {
  String? displayName;
  String? email;
  String? photoURL;
  String? firstName;
  String? lastName;
  String? dob;
  String? address;
  String? summary;
  String? work;

  //constructor
  GuardDetails(
      {this.displayName,
      this.email,
      this.photoURL,
      this.firstName,
      this.lastName,
      this.dob,
      this.address,
      this.work,
      this.summary});

  // we need to create map
  GuardDetails.fromJson(json) {
    displayName = json["displayName"];
    photoURL = json["photoUrl"];
    email = json["email"];
    firstName = json["firstName"];
    lastName=json["lastName"];
    dob=json["dob"];
    address=json["address"];
    summary=json["summary"];
    work=json["work"];
  }

  Map<String, dynamic> toJson() {
    // object - data
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['displayName'] = this.displayName;
    data['email'] = this.email;
    data['photoUrl]'] = this.photoURL;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['dob'] = this.dob;
    data['address'] = this.address;
    data['summary'] = this.summary;
    data['work'] = this.work;

    return data;
  }
}
