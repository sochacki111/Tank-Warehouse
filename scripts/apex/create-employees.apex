Integer numOfEmployees = 1000;
Integer numOfCompanies = 6;
List<Contact> employees = new List<Contact>();

Integer j = 0;
for (Integer i = 0; i < numOfEmployees; i ++) {    
    Contact e = new Contact(
        FirstName = 'Employee ' + i,
        LastName = 'Company ' + j
    );
    employees.add(e);

    j ++;
    if (j >= numOfCompanies) {
        j = 0;
    }
}
insert employees;