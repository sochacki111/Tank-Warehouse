Integer numOfCompanies = 6;
List<Account> companies = new List<Account>();

for (Integer i = 0; i < numOfCompanies; i ++) {
    Account c = new Account(Name = 'Company ' + i);
    companies.add(c);
}
insert companies;