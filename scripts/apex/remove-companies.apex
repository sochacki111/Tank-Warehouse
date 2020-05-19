String companyNamePrefix = 'Company';
companyNamePrefix += ' %';
List<Account> companiesToRemove = [
    select id,
    name
    from Account
    where name like :companyNamePrefix
];

try {
    delete companiesToRemove;
        if(companiesToRemove.size() > 0) {
            Database.emptyRecycleBin(companiesToRemove);
        }
} catch (DMLException e) {
    System.System.debug(e);
}