<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Notifica_campi_modificati_da_sarto</fullName>
        <description>Notifica campi modificati da sarto</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Assignment_Templates/Misure_modificate_da_sarto</template>
    </alerts>
    <rules>
        <fullName>Modifica Sarto</fullName>
        <actions>
            <name>Notifica_campi_modificati_da_sarto</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <booleanFilter>(1 OR 2) AND (3 OR 4)</booleanFilter>
        <criteriaItems>
            <field>User.ProfileId</field>
            <operation>equals</operation>
            <value>Sarto</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.ProfileId</field>
            <operation>equals</operation>
            <value>First Level Approver MTM</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account_Misure_Sartoriali__c.New_values__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Account_Misure_Sartoriali__c.Misure_dubbie__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
