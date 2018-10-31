<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Check_campo_gift</fullName>
        <field>Gift__c</field>
        <literalValue>1</literalValue>
        <name>Check campo gift</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Togliere_spunta_gift</fullName>
        <field>Gift__c</field>
        <literalValue>0</literalValue>
        <name>Togliere spunta gift</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>IdentificazioneAttività MKT gift</fullName>
        <actions>
            <name>Check_campo_gift</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Pannello_Amministrazione_Marketing__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Gift</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>IdentificazioneAttività MKT no gift</fullName>
        <actions>
            <name>Togliere_spunta_gift</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Pannello_Amministrazione_Marketing__c.RecordTypeId</field>
            <operation>notEqual</operation>
            <value>Gift</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
