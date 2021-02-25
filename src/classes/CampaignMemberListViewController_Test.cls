@isTest
public class CampaignMemberListViewController_Test {
    @isTest
    public static void testMethod1(){
        
        User usr = AllDataFactory.create_User();
        insert usr;
        
        
        
        Test.startTest();
        System.runAs(usr){
            Profile__c profileSettings = AllDataFactory.create_TriggerSetting(usr.ProfileId);
            insert profileSettings;
            Account customer = new Account();
            customer.LastName = 'Brambilla';
            insert customer;
            
        
        Contact cont =  AllDataFactory.create_Contact();
        insert cont;
        
        List<Contact> contList =  AllDataFactory.create_BulkContact();
        insert contList;
        
        Campaign camp =  AllDataFactory.create_campaign();
        insert camp;
        
        CampaignMember campMem =  AllDataFactory.create_CampaignMemberSingle(camp.Id,cont.Id);
        insert campMem;
        
        Boolean bool =  CampaignMemberListViewController.verifyUser();
        Campaign campRes =  CampaignMemberListViewController.getCampaign(camp.Id);
        List<CampaignMember> campMemRes = CampaignMemberListViewController.getCampaignMembers(camp.Id, 0);       
        List<CampaignMember> allCampMemRes = CampaignMemberListViewController.getAllCampaignMembers(camp.Id);
        Integer intCampMemRes = CampaignMemberListViewController.getTotalNumberOfCampaignMems(camp.Id);
        List<CampaignMember> serachCampMemRes =  CampaignMemberListViewController.searchCamapaignMembers(camp.Id, campMem.Name);
        List<Contact> getContactsRes =  CampaignMemberListViewController.getContacts(0);
        List<Contact> getAllContactsRes = CampaignMemberListViewController.getAllContacts();
        Integer getTotalNumberOfContactsRes = CampaignMemberListViewController.getTotalNumberOfContacts();
        Map < String, String > getselectOptionsRes = CampaignMemberListViewController.getselectOptions(new CampaignMember(), 'Status');
        Integer count =0;
        List<Id> contIds= new List<Id>();
        for(contact con : contList){
            contIds.add(con.Id);
            count = count  +1;
            if(count == 5 ){
                break;
            }
        }
        
        List<CampaignMember> insertContactsAsCampaignMemRes = CampaignMemberListViewController.insertContactsAsCampaignMem( contIds,
                                                                                                                            'Inviato',
                                                                                                                            camp.Id, 
                                                                                                                            'Risposta');
        
        
         List<Contact> searchContactRes = CampaignMemberListViewController.searchContact('LastName', contIds);
        
        List<CampaignMember> queryCampaignMemberRes =  CampaignMemberListViewController.queryCampaignMember(camp.Id, contIds,0);
        List<CampaignMember> queryAllCampaignMemberRes = CampaignMemberListViewController.queryAllCampaignMember(camp.Id, contIds);
        Integer queryTotalCampaignMemberRes = CampaignMemberListViewController.queryTotalCampaignMember(camp.Id, contIds);
        List<CampaignMember> queryCampaignMemberRes1 = CampaignMemberListViewController.queryCampaignMember(camp.Id, contIds, campMem.Name);
        List<Contact> queryContactsRes = CampaignMemberListViewController.queryContacts(contIds,0);
        List<Contact> queryAllContactsRes = CampaignMemberListViewController.queryAllContacts(contIds);
        Integer queryTotalContactsRes = CampaignMemberListViewController.queryTotalContacts(contIds);
        List<Contact> queryContactsRes1 = CampaignMemberListViewController.queryContacts(contIds, 'Last');
        
        
        List<Id> campIds= new List<Id>();
        campIds.add(campMem.id);
        CampaignMemberListViewController.deleteCampaignMembers(campIds);
        
        
        
        
    }
        Test.stopTest();
        
    }
    @isTest
    public static void testMethod2(){
       	
        Profile prof =  [SELECT Id FROM Profile WHERE Name='BC - Associate'];
        User newUser = AllDataFactory.create_User(); 
        newUser.ProfileId = prof.Id;
        insert newUser;
        
        
        Test.startTest();
        System.runAs(newUser){
        
            Profile__c profileSettings = AllDataFactory.create_TriggerSetting(newUser.ProfileId);
            insert profileSettings;
            Account customer = new Account();
            customer.LastName = 'Brambilla';
            insert customer;
            
       
        Contact cont =  AllDataFactory.create_Contact();
        insert cont;
        
        List<Contact> contList =  AllDataFactory.create_BulkContact();
        insert contList;
        
        Campaign camp =  AllDataFactory.create_campaign();
        insert camp;
        
        CampaignMember campMem =  AllDataFactory.create_CampaignMemberSingle(camp.Id,cont.Id);
        insert campMem;
        
        Boolean bool =  CampaignMemberListViewController.verifyUser();
        Campaign campRes =  CampaignMemberListViewController.getCampaign(camp.Id);
        List<CampaignMember> campMemRes = CampaignMemberListViewController.getCampaignMembers(camp.Id, 0);       
        List<CampaignMember> allCampMemRes = CampaignMemberListViewController.getAllCampaignMembers(camp.Id);
        Integer intCampMemRes = CampaignMemberListViewController.getTotalNumberOfCampaignMems(camp.Id);
        List<CampaignMember> serachCampMemRes =  CampaignMemberListViewController.searchCamapaignMembers(camp.Id, campMem.Name);
        
        List<Contact> getContactsRes =  CampaignMemberListViewController.getContacts(0);
        List<Contact> getAllContactsRes = CampaignMemberListViewController.getAllContacts();
        Integer getTotalNumberOfContactsRes = CampaignMemberListViewController.getTotalNumberOfContacts();
        Map < String, String > getselectOptionsRes = CampaignMemberListViewController.getselectOptions(new CampaignMember(), 'Status');
        Integer count =0;
        List<Id> contIds= new List<Id>();
        for(contact con : contList){
            contIds.add(con.Id);
            count = count  +1;
            if(count == 5 ){
                break;
            }
        }
        
        List<CampaignMember> insertContactsAsCampaignMemRes = CampaignMemberListViewController.insertContactsAsCampaignMem( contIds,
                                                                                                                            'Inviato',
                                                                                                                            camp.Id, 
                                                                                                                            'Risposta');
        
        
        
        List<Contact> searchContactRes = CampaignMemberListViewController.searchContact('LastName',contIds);
        List<CampaignMember> queryCampaignMemberRes =  CampaignMemberListViewController.queryCampaignMember(camp.Id, contIds,0);
        List<CampaignMember> queryAllCampaignMemberRes = CampaignMemberListViewController.queryAllCampaignMember(camp.Id, contIds);
        Integer queryTotalCampaignMemberRes = CampaignMemberListViewController.queryTotalCampaignMember(camp.Id, contIds);
        List<CampaignMember> queryCampaignMemberRes1 = CampaignMemberListViewController.queryCampaignMember(camp.Id, contIds, campMem.Name);
        List<Contact> queryContactsRes = CampaignMemberListViewController.queryContacts(contIds,0);
        List<Contact> queryAllContactsRes = CampaignMemberListViewController.queryAllContacts(contIds);
        Integer queryTotalContactsRes = CampaignMemberListViewController.queryTotalContacts(contIds);
        List<Contact> queryContactsRes1 = CampaignMemberListViewController.queryContacts(contIds, 'Last');
        
        
        List<Id> campIds= new List<Id>();
        campIds.add(campMem.id);
        CampaignMemberListViewController.deleteCampaignMembers(campIds);
        
        }
        
        Test.stopTest();
        
        
    }
    @isTest
    public static void testMethod3(){
       
        Profile prof =  [SELECT Id FROM Profile WHERE Name='BC - Boutique'];
        User newUser = AllDataFactory.create_User(); 
        newUser.ProfileId = prof.Id;
        insert newUser;
        
        
        Test.startTest();
        System.runAs(newUser){
            Profile__c profileSettings = AllDataFactory.create_TriggerSetting(newUser.ProfileId);
            insert profileSettings;
            Account customer = new Account();
            customer.LastName = 'Brambilla';
            insert customer;
            
        
        Contact cont =  AllDataFactory.create_Contact();
        insert cont;
        
        List<Contact> contList =  AllDataFactory.create_BulkContact();
        insert contList;
        
        Campaign camp =  AllDataFactory.create_campaign();
        insert camp;
        
        CampaignMember campMem =  AllDataFactory.create_CampaignMemberSingle(camp.Id,cont.Id);
        insert campMem;
        
        Boolean bool =  CampaignMemberListViewController.verifyUser();
        Campaign campRes =  CampaignMemberListViewController.getCampaign(camp.Id);
        List<CampaignMember> campMemRes = CampaignMemberListViewController.getCampaignMembers(camp.Id, 0);       
        List<CampaignMember> allCampMemRes = CampaignMemberListViewController.getAllCampaignMembers(camp.Id);
        Integer intCampMemRes = CampaignMemberListViewController.getTotalNumberOfCampaignMems(camp.Id);
        List<CampaignMember> serachCampMemRes =  CampaignMemberListViewController.searchCamapaignMembers(camp.Id, campMem.Name);
        List<Contact> getContactsRes =  CampaignMemberListViewController.getContacts(0);
        List<Contact> getAllContactsRes = CampaignMemberListViewController.getAllContacts();
        Integer getTotalNumberOfContactsRes = CampaignMemberListViewController.getTotalNumberOfContacts();
        Map < String, String > getselectOptionsRes = CampaignMemberListViewController.getselectOptions(new CampaignMember(), 'Status');
        Integer count =0;
        List<Id> contIds= new List<Id>();
        for(contact con : contList){
            contIds.add(con.Id);
            count = count  +1;
            if(count == 5 ){
                break;
            }
        }
        
        List<CampaignMember> insertContactsAsCampaignMemRes = CampaignMemberListViewController.insertContactsAsCampaignMem( contIds,
                                                                                                                            'Inviato',
                                                                                                                            camp.Id, 
                                                                                                                            'Risposta');
        
        
        
        List<Contact> searchContactRes = CampaignMemberListViewController.searchContact('LastName',contIds);
        List<CampaignMember> queryCampaignMemberRes =  CampaignMemberListViewController.queryCampaignMember(camp.Id, contIds,0);
        List<CampaignMember> queryAllCampaignMemberRes = CampaignMemberListViewController.queryAllCampaignMember(camp.Id, contIds);
        Integer queryTotalCampaignMemberRes = CampaignMemberListViewController.queryTotalCampaignMember(camp.Id, contIds);
        List<CampaignMember> queryCampaignMemberRes1 = CampaignMemberListViewController.queryCampaignMember(camp.Id, contIds, campMem.Name);
        List<Contact> queryContactsRes = CampaignMemberListViewController.queryContacts(contIds,0);
        List<Contact> queryAllContactsRes = CampaignMemberListViewController.queryAllContacts(contIds);
        Integer queryTotalContactsRes = CampaignMemberListViewController.queryTotalContacts(contIds);
        List<Contact> queryContactsRes1 = CampaignMemberListViewController.queryContacts(contIds, 'Last');
        
        
        List<Id> campIds= new List<Id>();
        campIds.add(campMem.id);
        CampaignMemberListViewController.deleteCampaignMembers(campIds);
        
        }
        
        Test.stopTest();
        
        
    }
    
}