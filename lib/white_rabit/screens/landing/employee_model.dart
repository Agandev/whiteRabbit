// EmployerDetails employerDetailsModelFromJson(str) {
//   return EmployerDetails.fromJson(str);
// }


class EmployerDetails {
  int? id;
  String? name;
  String? username;
  String? email;
  String? profileImage;
  Address? address;
  String? phone;
  String? website;
  Company? company;

  EmployerDetails(
      {this.id,
        this.name,
        this.username,
        this.email,
        this.profileImage,
        this.address,
        this.phone,
        this.website,
        this.company});

  EmployerDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    profileImage = json['profile_image'];
    address =
    json['address'] != null ? Address.fromJson(json['address']) : null;
    phone = json['phone'];
    website = json['website'];
    company =
    json['company'] != null ? Company.fromJson(json['company']) : null;
  }
  EmployerDetails.fromJsonDB(Map<String, dynamic> json) {
    id = json['employee_id'];
    name = json['employee_name']?? 'Not Available';
    username = json['employee_username']?? 'Not Available';
    email = json['employee_email']?? 'Not Available';
    profileImage = json['employee_profile_image'];
    phone = json['phone']?? 'Not Available';
    website = json['website']?? 'Not Available';
    address=Address.fromJsonDB(json);
    company=Company.fromJsonDB(json);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['employee_id'] = id;
    data['employee_name'] = name;
    data['employee_username'] = username;
    data['employee_email'] = email;
    data['employee_profile_image'] = profileImage;
    if (address != null) {
      data['street']=address!.street;
      data['suite']=address!.suite;
      data['zipcode']=address!.zipcode;
      data['city']=address!.city;


    }
    data['phone'] = phone;
    data['website'] = website;
    if (company != null) {
      data['company_name'] = company!.name;
      data['company_catch_phrase'] = company!.catchPhrase;
      data['company_bs'] = company!.bs;
    }
    return data;
  }
}

class Address {
  String? street;
  String? suite;
  String? city;
  String? zipcode;


  Address({this.street, this.suite, this.city, this.zipcode});

  Address.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    suite = json['suite'];
    city = json['city'];
    zipcode = json['zipcode'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['street'] = street;
    data['suite'] = suite;
    data['city'] = city;
    data['zipcode'] = zipcode;
    return data;
  }
  Address.fromJsonDB(Map<String, dynamic> json) {

    //id = json['id'];
    street = json['street']?? 'Not Available';
    suite = json['suite']?? 'Not Available';
    city = json['city']?? 'Not Available';
    zipcode = json['zipcode']?? 'Not Available';

  }
}



class Company {
  String? name;
  String? catchPhrase;
  String? bs;

  Company({this.name, this.catchPhrase, this.bs});

  Company.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    catchPhrase = json['catchPhrase'];
    bs = json['bs'];
  }
  Company.fromJsonDB(Map<String, dynamic> json) {

    name = json['company_name'] ?? 'Not Available';
    catchPhrase = json['company_catch_phrase']?? 'Not Available';
    bs = json['company_bs']?? 'Not Available';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['name'] = name;
    data['catchPhrase'] = catchPhrase;
    data['bs'] = bs;
    return data;
  }
}