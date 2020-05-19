Integer numOfEmployees = 1000;
Integer numOfCompanies = 6;
Integer randomNumber;
List<Contact> employees = new List<Contact>();

for (Integer i = 0; i < numOfEmployees; i++) {
	randomNumber = Integer.valueof((Math.random() * numOfCompanies));
	Contact employee = new Contact(
		firstName = 'Employee ' + i,
		lastName = 'Company ' + randomNumber
	);
	employees.add(employee);
}

try {
	insert employees;
} catch (DMLException e) {
    System.System.debug(e);
}