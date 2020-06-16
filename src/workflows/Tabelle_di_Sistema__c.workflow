<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update_Flag_Flusso_Delta</fullName>
        <field>Ricalcolo_Delta__c</field>
        <literalValue>0</literalValue>
        <name>Update Flag Flusso Delta</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Update Flag Flussi ETL</fullName>
        <actions>
            <name>Update_Flag_Flusso_Delta</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED(Ricalcolo_FULL__c) &amp;&amp; Ricalcolo_FULL__c = true</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
