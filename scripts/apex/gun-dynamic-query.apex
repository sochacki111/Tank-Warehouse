String query = '';
query += 'select id, name, turret__r.name, turret__r.tank__r.name, turret__r.tank__r.country__c ';
query += 'from Gun__c ';
System.debug('query = '+ query);
List<Gun__c> gunList = (List<Gun__c>)Database.query(query);

for (Gun__c gun : gunList) {
    System.debug(
        '\n' +
        gun.id + '\n' +
        gun.name + '\n' +
        gun.turret__r.name + '\n' +
        gun.turret__r.tank__r.name + '\n' +
        gun.turret__r.tank__r.country__c
    );
}
