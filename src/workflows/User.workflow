<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Language_Email_English</fullName>
        <field>Language_Email__c</field>
        <formula>&quot;English&quot;</formula>
        <name>Language Email English</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Language_Email_Italian</fullName>
        <field>Language_Email__c</field>
        <formula>&quot;Italian&quot;</formula>
        <name>Language Email Italian</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>User English</fullName>
        <actions>
            <name>Language_Email_English</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.LanguageLocaleKey</field>
            <operation>notEqual</operation>
            <value>Italiano</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>User Italian</fullName>
        <actions>
            <name>Language_Email_Italian</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.LanguageLocaleKey</field>
            <operation>equals</operation>
            <value>Italiano</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
