<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Scrittura_Chiave_Tender</fullName>
        <field>Tender_Key_ETL__c</field>
        <formula>Numero_Transazione__c &amp; Id_Location_Micros__c &amp; Codice_Cassa__c &amp; Name</formula>
        <name>Scrittura Chiave Tender</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Compilazione Chiave Tender</fullName>
        <actions>
            <name>Scrittura_Chiave_Tender</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>Or( 

ISBLANK( Tender_Key_ETL__c ) , 
ISCHANGED(Numero_Transazione__c), 
ISCHANGED(Id_Location_Micros__c ), 
ISCHANGED(Codice_Cassa__c ), 
ISCHANGED(Name) 

)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
