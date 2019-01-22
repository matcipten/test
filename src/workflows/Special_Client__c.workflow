<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Notifica_Boutique_IT_e_ROW</fullName>
        <ccEmails>no-reply.customercare@brunellocucinelli.it; ester.muggia@tengroup.it</ccEmails>
        <description>Notifica Boutique IT e ROW</description>
        <protected>false</protected>
        <recipients>
            <field>Email_Account_Owner__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Service_Note</template>
    </alerts>
    <alerts>
        <fullName>Notifica_Boutique_USA</fullName>
        <ccEmails>reply.customerserviceusa@brunellocucinelli.it; ester.muggia@tengroup.it</ccEmails>
        <description>Notifica Boutique USA</description>
        <protected>false</protected>
        <recipients>
            <field>Email_Account_Owner__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Service_Note</template>
    </alerts>
</Workflow>
