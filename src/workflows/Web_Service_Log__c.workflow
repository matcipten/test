<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Send_email_ERROR_on_callout</fullName>
        <ccEmails>luca.ruzzon@tengroup.it</ccEmails>
        <ccEmails>oms@brunellocucinelli.it</ccEmails>
        <description>Send email ERROR on callout</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/WebService_Callout_Error</template>
    </alerts>
    <rules>
        <fullName>ERROR on callout</fullName>
        <actions>
            <name>Send_email_ERROR_on_callout</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Web_Service_Log__c.Result_Code__c</field>
            <operation>equals</operation>
            <value>ERROR</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
