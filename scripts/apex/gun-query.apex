List<Gun__c> gunList = [
    select id, 
    name, 
    turret__r.name, 
    turret__r.tank__r.name, 
    turret__r.tank__r.country__c 
    from Gun__c
];

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