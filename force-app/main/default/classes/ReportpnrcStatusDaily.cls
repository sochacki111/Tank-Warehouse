global class ReportpnrcStatusDaily implements Schedulable {

    global void execute(SchedulableContext ctx) {
        Database.executeBatch(new ReportSfToSfConnectionBatch());
    }
}