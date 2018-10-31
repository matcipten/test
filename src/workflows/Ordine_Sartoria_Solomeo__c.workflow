<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Sbianca_Conteggia</fullName>
        <field>Conteggia__c</field>
        <literalValue>0</literalValue>
        <name>Sbianca Conteggia</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Data_approvazione_ordine_1_liv</fullName>
        <field>Data_approvazione_ordine_1_livello__c</field>
        <formula>now()</formula>
        <name>Update Data approvazione ordine 1 liv</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Data_approvazione_ordine_2_liv</fullName>
        <field>Data_approvazione_ordine_2_livello__c</field>
        <formula>now()</formula>
        <name>Update 	 Data approvazione ordine 2 liv</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Data_consegna_a_cliente</fullName>
        <field>Data_consegna_a_cliente__c</field>
        <formula>now()</formula>
        <name>Update Data consegna a cliente</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Data_consegna_in_negozio</fullName>
        <field>Data_consegna_in_negozio__c</field>
        <formula>now()</formula>
        <name>Update Data consegna in negozio</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Ordine Sartoria Annullato</fullName>
        <actions>
            <name>Sbianca_Conteggia</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Ordine_Sartoria_Solomeo__c.Status__c</field>
            <operation>equals</operation>
            <value>Annullato</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Status Ordine %22Approvato dal sarto%22</fullName>
        <actions>
            <name>Update_Data_approvazione_ordine_2_liv</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Ordine_Sartoria_Solomeo__c.Status__c</field>
            <operation>equals</operation>
            <value>Approvato dal sarto</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Status Ordine %22Consegnato al Cliente%22</fullName>
        <actions>
            <name>Update_Data_consegna_a_cliente</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Ordine_Sartoria_Solomeo__c.Status__c</field>
            <operation>equals</operation>
            <value>Consegnato al Cliente</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Status Ordine %22In revisione dal sarto%22</fullName>
        <actions>
            <name>Update_Data_approvazione_ordine_1_liv</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Ordine_Sartoria_Solomeo__c.Status__c</field>
            <operation>equals</operation>
            <value>In revisione dal sarto</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Status Ordine %22Ricevuto in negozio%22</fullName>
        <actions>
            <name>Update_Data_consegna_in_negozio</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Ordine_Sartoria_Solomeo__c.Status__c</field>
            <operation>equals</operation>
            <value>Ricevuto in negozio</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
