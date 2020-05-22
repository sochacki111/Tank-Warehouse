public class TanksSelector {
    public static List<Tank__c> findAll() {
        List<Tank__c> tanks = [
            select id,
            name,
            country__c
            from Tank__c
        ];
        return tanks;
    }

}
