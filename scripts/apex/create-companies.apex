Integer numOfCompanies = 6;
List<Account> companies = new List<Account>();

for (Integer i = 0; i < numOfCompanies; i++) {
    Account company = new Account(name = 'Company ' + i);
    companies.add(company);
}

try {
    insert companies;
} catch (DMLException e) {
    System.System.debug(e);
}
