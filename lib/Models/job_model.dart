class JobModel {
  String? displayName;
  String? duration;
  String? date;
  

  //constructor
  JobModel(
      {this.displayName,
      this.duration,
      this.date,
      });

  // we need to create map
  JobModel.fromJson(json) {
    displayName = json["displayName"]??"";
    duration = json["duration"]??"";
    date = json["date"]??"";
   
  }

  Map<String, dynamic> toJson() {
    // object - data
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['displayName'] = displayName;
    data['duration'] = duration;
    data['date'] = date;
    
    return data;
  }
}
