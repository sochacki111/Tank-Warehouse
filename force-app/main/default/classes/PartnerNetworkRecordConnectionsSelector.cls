public class PartnerNetworkRecordConnectionsSelector {
    public static Database.QueryLocator findAllPublishedRecords(Id connectionId) {
        return Database.getQueryLocator([
            select localRecordId
            from PartnerNetworkRecordConnection
            where connectionId = :connectionId
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