<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Aggiorna_First_Response_Date</fullName>
        <field>First_response_date__c</field>
        <formula>NOW()</formula>
        <name>Aggiorna First Response Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>ParentId</targetObject>
    </fieldUpdates>
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
        <fullName>Popola_Checkbox_New_Customer_Email_Rec</fullName>
        <description>Popola Checkbox New Customer Email Received</description>
        <field>New_Customer_Email_Received__c</field>
        <literalValue>1</literalValue>
        <name>Popola Checkbox New Customer Email Rec.</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <targetObject>ParentId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Sbianca_checkbox_new_email_received</fullName>
        <description>Sbianca checkbox new customeri email received quando customer care invia risposta</description>
        <field>New_Customer_Email_Received__c</field>
        <literalValue>0</literalValue>
        <name>Sbianca checkbox new email received</name>
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
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>notEqual</operation>
            <value>Ticket E-commerce – Notify Me</value>
        </criteriaItems>
        <description>Regola per il cambio di stato di un caso quando il cliente risponde al messaggio di posta</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Email message Received Notify Me</fullName>
        <actions>
            <name>Popola_Checkbox_New_Customer_Email_Rec</name>
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
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Ticket E-commerce – Notify Me</value>
        </criteriaItems>
        <description>Regola per popolamento checkbox di un caso Notify Me quando il cliente risponde al messaggio di posta</description>
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
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>notEqual</operation>
            <value>Ticket E-commerce – Notify Me</value>
        </criteriaItems>
        <description>Cambio di stato per messaggio inviato da customer care</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Email message sent Notify Me</fullName>
        <actions>
            <name>Sbianca_checkbox_new_email_received</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>EmailMessage.Status</field>
            <operation>equals</operation>
            <value>Inviato</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Ticket E-commerce – Notify Me</value>
        </criteriaItems>
        <description>Sbianca checkbox per messaggio inviato da customer care</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>First response</fullName>
        <actions>
            <name>Aggiorna_First_Response_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>Incoming = false &amp;&amp;  ISBLANK(Parent.First_response_date__c ) &amp;&amp;  (FromAddress = &apos;customer.care@brunellocucinelli.it&apos; || FromAddress = &apos;customerserviceusa@brunellocucinelli.com&apos;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
