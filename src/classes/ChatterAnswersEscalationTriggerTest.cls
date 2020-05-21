@isTest
private class ChatterAnswersEscalationTriggerTest {
	static testMethod void validateQuestionEscalation() {
		RecordTypeSetting__c rst = new RecordTypeSetting__c(Name='General');
            rst.Caso_ResoCambio__c = DescribeUtils.getRecordTypeId('Case', 'Reso_Cambio');
            rst.Caso_ResoCambioStore__c = DescribeUtils.getRecordTypeId('Case', 'Reso_Cambio_in_Store');
            rst.Caso_CustomerCare__c = DescribeUtils.getRecordTypeId('Case', 'Ticket_E_commerce');
            rst.Caso_BrandSpecialist__c = DescribeUtils.getRecordTypeId('Case', 'Brand_Specialist');
            rst.Caso_OMS__c = DescribeUtils.getRecordTypeId('Case', 'Ticket_OMS');
            rst.Task_ResoCambioStore__c = DescribeUtils.getRecordTypeId('Task', 'Reso_Cambio_in_Store');
            rst.Task_Wishlist__c = DescribeUtils.getRecordTypeId('Task', 'Wishlist');
            rst.Caso_NotifyMe__c = DescribeUtils.getRecordTypeId('Case', 'Ticket_E_commerce_Notify_Me');
            insert rst;


		String questionTitle = 'questionTitle';
		String questionBody = 'questionBody';
		Community[] c = [SELECT Id from Community];
		// We cannot create a question without a community
		if (c.size() == 0) { return; }
		String communityId = c[0].Id;

		Case cTest = new Case();
		cTest.Origin = 'Chatter Answers';
		cTest.CommunityId = communityId;
		cTest.Subject = questionTitle;
		cTest.Description = questionBody;
	
		
		Question q = new Question();
		q.Title = questionTitle;
		q.Body = questionBody;
		q.CommunityId = communityId;
		insert(q);
		q.Priority = 'high';
		cTest.QuestionId = q.Id;
		insert cTest;
		update(q);
		Case ca = [SELECT Origin, CommunityId, Subject, Description from Case where QuestionId =: q.Id limit 1];
		// Test that escaltion trigger correctly escalate the question to a case
		System.assertEquals(questionTitle, ca.Subject);
		System.assertEquals(questionBody, ca.Description);
		System.assertEquals('Chatter Answers', ca.Origin);
		System.assertEquals(communityId, ca.CommunityId);
	}
}