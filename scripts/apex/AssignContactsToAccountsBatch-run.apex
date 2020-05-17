Integer numOfBatches = 20;
String contactFirstNamePrefix = 'Employee';
String accountNamePrefix = 'Company';

Id batchId = Database.executeBatch(new AssignContactsToAccountsBatch(contactFirstNamePrefix, accountNamePrefix), numOfBatches);
System.debug('Batch Id: ' + batchId);