List<Tank__c> tankList = [
    select id, 
    name, 
    (select id, name from Turrets__r)
    from Tank__c
];

for (Tank__c tank : tankList) {
    System.debug('Tank: ' + tank.name);
    for(Turret__c turret : tank.turrets__r) {
        System.debug(turret.name);
    }
}