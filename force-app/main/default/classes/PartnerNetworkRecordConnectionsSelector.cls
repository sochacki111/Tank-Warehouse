public class PartnerNetworkRecordConnectionsSelector {
    public static Database.QueryLocator findAllSentRecords() {
        return Database.getQueryLocator([
            select localRecordId
            from PartnerNetworkRecordConnection
            where connectionId = '04P5I000000GmaY'
        ]);
    }

    public static Set<Id> findAllLocalRecordIds() { // TODO Query for localRecordIds in more elegant way
        Set<Id> localRecordIds = new Set<Id>();
        List<PartnerNetworkRecordConnection> pnrcs = ([
            select localRecordId
            from PartnerNetworkRecordConnection
        ]);

        for (PartnerNetworkRecordConnection pnrc : pnrcs) {
            localRecordIds.add((Id)pnrc.localRecordId);
        }

        return localRecordIds;
    }
}