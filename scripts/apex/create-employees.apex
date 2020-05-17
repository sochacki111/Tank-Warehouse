Integer numOfEmployees = 1000;
Integer numOfCompanies = 6;
List<Contact> employees = new List<Contact>();

Integer j = 0;
for (Integer i = 0; i < numOfEmployees; i++) {
	Contact emploee = new Contact(
		firstName = 'Employee ' + i,
		lastName = 'Company ' + j
	);
	employees.add(emploee);

	j++;
	if (j >= numOfCompanies) {
		j = 0;
	}
}
insert employees;