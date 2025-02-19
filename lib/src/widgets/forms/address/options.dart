class AddressDisplayOptions {
  final bool hasDescription;
  final bool hasZipCode;
  final bool hasStateCity;
  final bool hasNeighbor;
  final bool hasStreet;
  final bool hasNumber;
  final bool hasComplement;

  const AddressDisplayOptions({
    this.hasDescription = true,
    this.hasZipCode = true,
    this.hasStateCity = true,
    this.hasNeighbor = true,
    this.hasStreet = true,
    this.hasNumber = true,
    this.hasComplement = true,
  });
}

class AddressLabelOptions {
  final String description;
  final String zipCode;
  final String state;
  final String city;
  final String neighbor;
  final String street;
  final String number;
  final String complement;

  const AddressLabelOptions({
    this.description = 'Descrição',
    this.zipCode = 'CEP',
    this.state = 'Estado',
    this.city = 'Cidade',
    this.neighbor = 'Bairro',
    this.street = 'Rua',
    this.number = 'Número',
    this.complement = 'Complemento',
  });

  factory AddressLabelOptions.english() => AddressLabelOptions(
        description: 'Description',
        zipCode: 'ZipCode',
        state: 'State',
        city: 'City',
        neighbor: 'Neighbor',
        street: 'Street',
        number: 'Number',
        complement: 'Complement',
      );
}
