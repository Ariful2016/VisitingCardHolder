class ContactModel {
  static const String tblContact = 'tbl_contact';
  static const String tblContactColId = 'id';
  static const String tblContactColName = 'name';
  static const String tblContactColCompany = 'company';
  static const String tblContactColDesignation = 'designation';
  static const String tblContactColAddress = 'address';
  static const String tblContactColEmail = 'email';
  static const String tblContactColPhone = 'phone';
  static const String tblContactColWebsite = 'website';
  static const String tblContactColFavorite = 'isFavorite';

  int? id;
  String name;
  String companyName;
  String designation;
  String address;
  String email;
  String phone;
  String website;
  bool isFavorite;

  ContactModel(
      {this.id,
      this.name ='Not Available',
      this.companyName = 'Not Available',
      this.designation = 'Not Available',
      this.address = 'Not Available',
      this.email = 'Not Available',
      this.phone = 'Not Available',
      this.website = 'Not Available',
      this.isFavorite = false});

  Map<String, dynamic> toMap(){
    var map = <String, dynamic>{
      tblContactColName : name,
      tblContactColCompany : companyName,
      tblContactColDesignation : designation,
      tblContactColAddress : address,
      tblContactColEmail : email,
      tblContactColPhone : phone,
      tblContactColWebsite : website,
      tblContactColFavorite : isFavorite ? 1 : 0,
    };
    if(id!= null){
      map[tblContactColId] = id;
    }
    return map;
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) => ContactModel(
    id: map[tblContactColId],
    name: map[tblContactColName],
    companyName: map[tblContactColCompany],
    designation: map[tblContactColDesignation],
    address: map[tblContactColAddress],
    email: map[tblContactColEmail],
    phone: map[tblContactColPhone],
    website: map[tblContactColWebsite],
    isFavorite: map[tblContactColFavorite] == 0 ? false : true,
  );

  @override
  String toString() {
    return 'ContactModel{id: $id, name: $name, companyName: $companyName, designation: $designation, address: $address, email: $email, phone: $phone, website: $website, isFavorite: $isFavorite}';
  }
}