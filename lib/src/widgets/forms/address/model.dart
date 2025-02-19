class Address {
  final String neighbor;
  final String zipCode;
  final String city;
  final String complement;
  final String description;
  final String state;
  final String lat;
  final String lng;
  final String number;
  final String street;

  const Address({
    this.neighbor,
    this.zipCode,
    this.city,
    this.complement,
    this.description,
    this.state,
    this.lat,
    this.lng,
    this.number,
    this.street,
  });

  @override
  String toString({
    String separator = ' ',
  }) =>
      [
        street,
        number,
        neighbor,
        city,
        state,
      ].where((element) => element != null).join(separator);

  factory Address.blank() => const Address();

  factory Address.overwrite(
    Address address, {
    String neighbor,
    String zipCode,
    String city,
    String complement,
    String description,
    String state,
    String lat,
    String lng,
    String number,
    String street,
  }) =>
      Address(
        neighbor: neighbor ?? address?.neighbor,
        zipCode: zipCode ?? address?.zipCode,
        city: city ?? address?.city,
        complement: complement ?? address?.complement,
        description: description ?? address?.description,
        state: state ?? address?.state,
        lat: lat ?? address?.lat,
        lng: lng ?? address?.lng,
        number: number ?? address?.number,
        street: street ?? address?.street,
      );

  factory Address.merge({
    Address oldModel,
    Address newModel,
  }) =>
      Address(
        neighbor: newModel?.neighbor ?? oldModel?.neighbor,
        zipCode: newModel?.zipCode ?? oldModel?.zipCode,
        city: newModel?.city ?? oldModel?.city,
        complement: newModel?.complement ?? oldModel?.complement,
        description: newModel?.description ?? oldModel?.description,
        state: newModel?.state ?? oldModel?.state,
        lat: newModel?.lat ?? oldModel?.lat,
        lng: newModel?.lng ?? oldModel?.lng,
        number: newModel?.number ?? oldModel?.number,
        street: newModel?.street ?? oldModel?.street,
      );

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        neighbor: json['neighbor'],
        zipCode: json['zipCode'],
        city: json['city'],
        complement: json['complement'],
        description: json['description'],
        state: json['state'],
        lat: json['lat'],
        lng: json['lng'],
        number: json['number'],
        street: json['street'],
      );

  factory Address.fromViaCep(Map<String, dynamic> json) => Address(
        neighbor: json['bairro'],
        zipCode: json['cep'],
        city: json['localidade'],
        state: json['uf'],
        lat: json['lat'],
        lng: json['lng'],
        street: json['logradouro'],
      );

  Map<String, dynamic> toJson() => {
        'neighbor': neighbor,
        'zipCode': zipCode,
        'city': city,
        'complement': complement,
        'description': description,
        'state': state,
        'lat': lat,
        'lng': lng,
        'number': number,
        'street': street,
      };

  static List<Address> fromJsonList(List jsonList) =>
      (jsonList ?? []).map((json) => Address.fromJson(json)).toList();
}
