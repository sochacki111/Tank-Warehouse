String query = '';
query += 'select id, name, (select id, name from Turrets__r) ';
query += 'from Tank__c ';
System.debug('query = '+ query);

List<Tank__c> tankList = (List<Tank__c>)Database.query(query);

for (Tank__c tank : tankList) {
    System.debug('Tank: ' + tank.name);
    for(Turret__c turret : tank.turrets__r) {
        System.debug(turret.name);
    }
}
