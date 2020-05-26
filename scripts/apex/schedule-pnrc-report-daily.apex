        
SalesforceToSalesforceConnection__c s2s = SalesforceToSalesforceConnection__c.getInstance();
String cronExpression = (String)s2s.get('cronExpression__c');
String jobName = 'Daily Report on PNRC Status';

String jobId = System.schedule(jobName, cronExpression, new ReportpnrcStatusDaily());