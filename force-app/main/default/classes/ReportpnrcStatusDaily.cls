global class ReportpnrcStatusDaily implements Schedulable {
    public ReportpnrcStatusDaily() { 

    }
    
    global static String scheduleMe() {
        String jobName = 'Daily Report on PNRC Status';
        String cronExpression = '0 0 20 * * ? *';
        return System.schedule(jobName, cronExpression, new ReportpnrcStatusDaily());
    }

    global void execute(SchedulableContext ctx) {
        Id batchId = Database.executeBatch(new ReportSfToSfConnectionBatch());
    }
}