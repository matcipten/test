<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Aggiornamento_di_stato_in_attesa</fullName>
        <description>Aggiornamento di stato in attesa in caso di risposta inviata a cliente</description>
        <field>Status</field>
        <literalValue>In attesa</literalValue>
        <name>Aggiornamento di stato in attesa</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <targetObject>ParentId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Case_field_update</fullName>
        <description>Aggiornamento stato caso non appena si riceve una risposta dal cliente</description>
        <field>Status</field>
        <literalValue>Risposta ricevuta</literalValue>
        <name>Case field update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <targetObject>ParentId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_status_to_replied</fullName>
        <description>Aggiornamento stato caso non appena si riceve una risposta dal cliente</description>
        <field>Status</field>
        <literalValue>Risposta ricevuta</literalValue>
        <name>Set status to replied</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <targetObject>ParentId</targetObject>
    </fieldUpdates>
    <rules>
        <fullName>Email message Received</fullName>
        <actions>
            <name>Case_field_update</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_status_to_replied</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>EmailMessage.Incoming</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>EmailMessage.Status</field>
            <operation>equals</operation>
            <value>Nuovo</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>notEqual</operation>
            <value>Nuovo</value>
        </criteriaItems>
        <description>Regola per il cambio di stato di un caso quando il cliente risponde al messaggio di posta</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Email message sent</fullName>
        <actions>
            <name>Aggiornamento_di_stato_in_attesa</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>EmailMessage.Status</field>
            <operation>equals</operation>
            <value>Inviato</value>
        </criteriaItems>
        <description>Cambio di stato per messaggio inviato da customer care</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
