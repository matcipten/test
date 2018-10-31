<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Alert_MC_per_cambio_stato_Issue_Marketing_Cloud</fullName>
        <ccEmails>jacopo.maggi@tengroup.it</ccEmails>
        <description>Alert MC per cambio stato Issue Marketing Cloud</description>
        <protected>false</protected>
        <recipients>
            <recipient>tracking.user@brunellocucinelli.it</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Modello_per_alert_cambio_stato_issue_desk</template>
    </alerts>
    <alerts>
        <fullName>Alert_email_per_nuova_issue_creata</fullName>
        <ccEmails>luca.ruzzon@tengroup.it; dario.finotti@tengroup.it</ccEmails>
        <description>Alert email per nuova issue creata</description>
        <protected>false</protected>
        <recipients>
            <recipient>admin.ten@brunellocucinelli.it</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Modello_per_alert_nuovo_issue_desk</template>
    </alerts>
    <alerts>
        <fullName>Avviso_Team_Marketing_Cloud_Nuova_Issue_creata</fullName>
        <ccEmails>jacopo.maggi@tengroup.it</ccEmails>
        <description>Avviso Team Marketing Cloud Nuova Issue creata</description>
        <protected>false</protected>
        <recipients>
            <recipient>tracking.user@brunellocucinelli.it</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Modello_per_alert_nuovo_issue_desk</template>
    </alerts>
    <alerts>
        <fullName>Avviso_completamento_issue_desk_BC</fullName>
        <description>Avviso completamento issue desk - BC</description>
        <protected>false</protected>
        <recipients>
            <recipient>francesca.picchio@brunellocucinelli.it</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Modello_per_alert_completameto_issue_desk</template>
    </alerts>
    <alerts>
        <fullName>Avviso_email_issue_da_approvare</fullName>
        <description>Avviso email issue da approvare</description>
        <protected>false</protected>
        <recipients>
            <recipient>francesca.picchio@brunellocucinelli.it</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Modello_per_alert_issue_desk_da_approvare</template>
    </alerts>
    <alerts>
        <fullName>Avviso_issue_ha_cambiato_stato</fullName>
        <ccEmails>luca.ruzzon@tengroup.it; dario.finotti@tengroup.it</ccEmails>
        <description>Avviso issue ha cambiato stato</description>
        <protected>false</protected>
        <recipients>
            <recipient>admin.ten@brunellocucinelli.it</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Modello_per_alert_cambio_stato_issue_desk</template>
    </alerts>
    <rules>
        <fullName>Cambio stato Issue desk</fullName>
        <actions>
            <name>Avviso_issue_ha_cambiato_stato</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Notifica a Ten per cambio stato Issue desk</description>
        <formula>And (
 Not ISNEW() ,
 ISCHANGED( Status__c ) 
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Cambio stato Issue desk MC</fullName>
        <actions>
            <name>Alert_MC_per_cambio_stato_Issue_Marketing_Cloud</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Notifica a Ten per cambio stato Issue desk Marketing Cloud</description>
        <formula>And (
 Not ISNEW() ,
 ISCHANGED( Status__c ) ,
Text ( Macro_Area__c) = &quot;Marketing Cloud&quot; 

)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Issue Desk Completata</fullName>
        <actions>
            <name>Avviso_completamento_issue_desk_BC</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Notifica a Brunello Cucinelli per completamento issue</description>
        <formula>And (
 Not ISNEW() ,
 Text(Status__c )= &quot;Completata&quot; 
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Issue Desk Da Approvare</fullName>
        <actions>
            <name>Avviso_email_issue_da_approvare</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Notifica a Brunello Cucinelli per issue da approvare</description>
        <formula>And (
 Not ISNEW() ,
 Text(Status__c )= &quot;Da Approvare&quot; 
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Notifica nuova issue desk MC creata</fullName>
        <actions>
            <name>Avviso_Team_Marketing_Cloud_Nuova_Issue_creata</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Issue_Desk__c.Macro_Area__c</field>
            <operation>equals</operation>
            <value>Marketing Cloud</value>
        </criteriaItems>
        <description>Notifica a ten per nuova issue desk Marketing Cloud creata</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Notifica nuova issue desk creata</fullName>
        <actions>
            <name>Alert_email_per_nuova_issue_creata</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Notifica a ten per nuova issue desk creata</description>
        <formula>true</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
