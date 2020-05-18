global class AssignContactsToAccountsBatch implements Database.Batchable<SObject>, Database.Stateful {

	String contactFirstNamePrefix {get; set;}
	String accountNamePrefix {get; set;}
	Map<String,List<Contact>> contactsByAccountsToUpdate {get; set;}
	List<Account> accounts {get; set;}

	public AssignContactsToAccountsBatch(String contactFirstNamePrefix, String accountNamePrefix) {
		this.contactFirstNamePrefix = contactFirstNamePrefix + ' %';
		this.accountNamePrefix = accountNamePrefix + ' %';
		this.contactsByAccountsToUpdate = new Map<String,List<Contact>>();

		this.accounts = [
			select id,
			name
			from Account
			where name like :this.accountNamePrefix
		];

		for (Account a : accounts) {
			contactsByAccountsToUpdate.put(a.name, new List<Contact>());
		}
	}

	global Database.QueryLocator start(Database.BatchableContext bc) {
		return Database.getQueryLocator([
			select id,
			firstName,
			lastName,
			accountId
			from Contact
			where firstName like :contactFirstNamePrefix
		]);
	}

	global void execute(Database.BatchableContext bc, List<Contact> contacts) {
		for (Contact c : contacts) {
			for (Account a : accounts) {
				if (c.lastName == a.name && c.accountId != a.id) {
					c.accountId = a.Id;
					contactsByAccountsToUpdate.get(a.name).add(c);
					break;
				}
			}
		}
	}

	global void finish(Database.BatchableContext bc) {
		/**
		 *  Flatten List<List<Contact>> into List<Contact>
		 *	DML update needs it
		 */ 
		List<Contact> contactsToUpdate = new List<Contact>();
		for (List<Contact> contacts: contactsByAccountsToUpdate.values()) {
			contactsToUpdate.addAll(contacts);
		}
		try {
			update contactsToUpdate;

			Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
			message.toAddresses = new String[] { 
				UserInfo.getUserEmail()
			};
			message.subject = 'AssignContactsToAccountsBatch finished';
			message.plainTextBody = 'AssignContactsToAccountsBatch finished:\n';
			for (Account a : accounts) {
				message.plainTextBody += 'For Account: ' + a.name + ' assigned: ' + contactsByAccountsToUpdate.get(a.name).size() + ' Contacts' + '\n';
			}
			List<Messaging.SendEmailResult> results = Messaging.sendEmail(
				new List<Messaging.SingleEmailMessage> {
					message
				}
			);
		} catch (Exception e) {
			System.debug(e);
		}
	}
}
