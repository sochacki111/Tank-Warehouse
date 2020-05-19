String employeeFirstNamePrefix = 'Employee';
employeeFirstNamePrefix += ' %';
List<Contact> employeesToRemove = [
    select id,
    firstName
    from Contact
    where firstName like :employeeFirstNamePrefix
];

try {
    delete employeesToRemove;
        if(employeesToRemove.size() > 0) {
            Database.emptyRecycleBin(employeesToRemove);
        }
} catch (DMLException e) {
    System.System.debug(e);
}