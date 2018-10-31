<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Comunicazione_Annullamento_Anagrafica</fullName>
        <description>Comunicazione Annullamento Anagrafica</description>
        <protected>false</protected>
        <recipients>
            <recipient>francesca.picchio@brunellocucinelli.it</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Approval_Processes/Comunicazione_Annullamento_Anagrafica</template>
    </alerts>
    <alerts>
        <fullName>Comunicazione_esito_negativo_modifica_Categoria_Cliente</fullName>
        <description>Comunicazione esito negativo modifica Categoria Cliente</description>
        <protected>false</protected>
        <recipients>
            <field>Email_Approval_Process_Submitter__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Approval_Processes/Esito_Negativo_Richiesta_modifica_Categoria_Cliente_Account</template>
    </alerts>
    <alerts>
        <fullName>Comunicazione_esito_positivo_modifica_Categoria_Cliente</fullName>
        <description>Comunicazione esito positivo modifica Categoria Cliente</description>
        <protected>false</protected>
        <recipients>
            <field>Email_Approval_Process_Submitter__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Approval_Processes/Esito_Positivo_Richiesta_modifica_Categoria_Cliente_Account</template>
    </alerts>
    <fieldUpdates>
        <fullName>Aggiornamento_Data_Approvazione</fullName>
        <field>Data_Approvazione_Categoria__c</field>
        <formula>Today()</formula>
        <name>Aggiornamento Data Approvazione</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Compilazione_Categoria_Shadow</fullName>
        <field>Categoria_Cliente_Shadow__c</field>
        <formula>Text(Categoria_Cliente_Proposta__c)</formula>
        <name>Compilazione Categoria Shadow</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Compilazione_Vecchia_Categoria_Cliente</fullName>
        <field>Vecchia_Categoria_Cliente__c</field>
        <formula>Vecchia_Categoria_Shadow__c</formula>
        <name>Compilazione Vecchia Categoria Cliente</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Compilazione_Vecchia_Categoria_Shadow</fullName>
        <field>Vecchia_Categoria_Shadow__c</field>
        <formula>Categoria_Cliente__c</formula>
        <name>Compilazione Vecchia Categoria Shadow</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>First_ID_Location</fullName>
        <field>First_ID_Location__c</field>
        <formula>Id_Location__c</formula>
        <name>First ID Location</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>First_Location</fullName>
        <field>First_Location__c</field>
        <formula>Location__c</formula>
        <name>First Location</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>First_Location_Name</fullName>
        <field>First_Location_Name__c</field>
        <formula>Location__r.Name</formula>
        <name>First Location Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Flag_Processo_Annullamento</fullName>
        <field>Processo_Annullamento_Attivo__c</field>
        <literalValue>1</literalValue>
        <name>Flag Processo Annullamento</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Flag_Processo_Categoria</fullName>
        <field>Processo_Categoria_Attivo__c</field>
        <literalValue>1</literalValue>
        <name>Flag Processo Categoria</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Flag_Variazione_Categoria_ETL</fullName>
        <field>Categoria_Cliente_Variazione_ETL__c</field>
        <literalValue>1</literalValue>
        <name>Flag Variazione Categoria ETL</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Inserimento_Data_Annullamento</fullName>
        <field>Data_Annullamento__c</field>
        <formula>Today()</formula>
        <name>Inserimento Data Annullamento</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Modifica_Stato_Approvazione</fullName>
        <field>Stato_Approvazione_Categoria__c</field>
        <literalValue>Da Autorizzare</literalValue>
        <name>Modifica Stato Approvazione</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Modifica_Stato_Approvazione_Negativo</fullName>
        <field>Stato_Approvazione_Categoria__c</field>
        <name>Modifica Stato Approvazione Negativo</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Modifica_Stato_Approvazione_positivo</fullName>
        <field>Stato_Approvazione_Categoria__c</field>
        <name>Modifica Stato Approvazione Positivo</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>NextValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Reset_Categoria_Proposta</fullName>
        <field>Categoria_Cliente_Proposta__c</field>
        <name>Reset Categoria Proposta</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Reset_Check_Annullamento</fullName>
        <field>Richiesta_Annullamento_Anagrafica__c</field>
        <literalValue>0</literalValue>
        <name>Reset Check Annullamento</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Reset_Descrizione_Annullamento</fullName>
        <field>Descrizione_Annullamento__c</field>
        <name>Reset Descrizione Annullamento</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Reset_Motivazione_Annullamento</fullName>
        <field>Motivazione_Annullamento__c</field>
        <name>Reset Motivazione Annullamento</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Reset_Processo_Annullamento</fullName>
        <field>Processo_Annullamento_Attivo__c</field>
        <literalValue>0</literalValue>
        <name>Reset Processo Annullamento</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Reset_Processo_Categoria</fullName>
        <field>Processo_Categoria_Attivo__c</field>
        <literalValue>0</literalValue>
        <name>Reset Processo Categoria</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Utente_Registrato_E_commerce_Yoox</fullName>
        <field>Anagrafica_E_commerce_Yoox__c</field>
        <formula>&quot;Utente Registrato&quot;</formula>
        <name>Set Utente Registrato E-commerce Yoox</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Spunta_registrazione_al_sito</fullName>
        <field>Registrazione_Al_Sito__c</field>
        <literalValue>1</literalValue>
        <name>Spunta registrazione al sito</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Categoria_Cliente</fullName>
        <field>Categoria_Cliente__c</field>
        <formula>Categoria_Cliente_Shadow__c</formula>
        <name>Update Categoria Cliente</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Valorizzazione_Campo_Email_Submitter</fullName>
        <field>Email_Approval_Process_Submitter__c</field>
        <formula>$User.Email</formula>
        <name>Valorizzazione Campo Email Submitter</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>First Location</fullName>
        <actions>
            <name>First_ID_Location</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>First_Location</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>First_Location_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.Creato_da_Scheda_Digitale__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Utente Registrato E-commerce Yoox</fullName>
        <actions>
            <name>Set_Utente_Registrato_E_commerce_Yoox</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Spunta_registrazione_al_sito</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Account.CreatedById</field>
            <operation>startsWith</operation>
            <value>Admin</value>
        </criteriaItems>
        <description>Regola per caricamento una tantum anagrfaiche Yoox</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
