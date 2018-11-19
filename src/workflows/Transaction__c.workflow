<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Aggiornamento_Sconto_MOP_Testata</fullName>
        <field>Sconto_MOP__c</field>
        <formula>if ( 
Or (Prezzo_di_listino_MOP__c - Prezzo_di_vendita_MOP__c =0, (And (Prezzo_di_listino_MOP__c &lt; Prezzo_di_vendita_MOP__c , Prezzo_di_listino_MOP__c &gt;0 )), 
(And (Prezzo_di_listino_MOP__c &gt; Prezzo_di_vendita_MOP__c , Prezzo_di_listino_MOP__c &lt;0 )) 
), 
0 , 
Prezzo_di_listino_MOP__c - Prezzo_di_vendita_MOP__c 
)</formula>
        <name>Aggiornamento Sconto MOP Testata</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Scrittura_chiave_Transazione</fullName>
        <field>Key_Transazione__c</field>
        <formula>Name &amp; Id_Location_Micros__c &amp; Codice_Cassa__c</formula>
        <name>Scrittura chiave Transazione</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Sconto_BRL_Testata</fullName>
        <field>PSconto_BRL__c</field>
        <formula>if 
( OR( Prezzo_di_listino_BRL__c=0.00, ISBLANK(Prezzo_di_listino_BRL__c )), 0, 

if ( 
(Sconto_BRL__c / Prezzo_di_listino_BRL__c)&lt;0, 
0, 
Sconto_BRL__c / Prezzo_di_listino_BRL__c 
) 
)</formula>
        <name>Update % Sconto BRL Testata</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Sconto_CAD_testata</fullName>
        <field>PSconto_CAD__c</field>
        <formula>if 
( OR( Prezzo_di_listino_CAD__c=0.00, ISBLANK(Prezzo_di_listino_CAD__c )), 0, 

if ( 
(Sconto_CAD__c / Prezzo_di_listino_CAD__c)&lt;0, 
0, 
Sconto_CAD__c / Prezzo_di_listino_CAD__c 
) 
)</formula>
        <name>Update % Sconto CAD testata</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Sconto_CHF_testata</fullName>
        <field>PSconto_CHF__c</field>
        <formula>if 
( OR( Prezzo_di_listino_CHF__c=0.00, ISBLANK(Prezzo_di_listino_CHF__c )), 0, 

if ( 
(Sconto_CHF__c / Prezzo_di_listino_CHF__c)&lt;0, 
0, 
Sconto_CHF__c / Prezzo_di_listino_CHF__c 
) 
)</formula>
        <name>Update % Sconto CHF testata</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Sconto_CNY_testata</fullName>
        <field>PSconto_CNY__c</field>
        <formula>if 
( OR( Prezzo_di_listino_CNY__c=0.00, ISBLANK(Prezzo_di_listino_CNY__c )), 0, 

if ( 
(Sconto_CNY__c / Prezzo_di_listino_CNY__c)&lt;0, 
0, 
Sconto_CNY__c / Prezzo_di_listino_CNY__c 
) 
)</formula>
        <name>Update % Sconto CNY testata</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Sconto_EUR_testata</fullName>
        <field>PSconto_EUR__c</field>
        <formula>if 
( OR( Prezzo_di_listino_EUR__c=0.00, ISBLANK(Prezzo_di_listino_EUR__c )), 0, 

if ( 
(Sconto_EUR__c / Prezzo_di_listino_EUR__c)&lt;0, 
0, 
Sconto_EUR__c / Prezzo_di_listino_EUR__c 
) 
)</formula>
        <name>Update % Sconto EUR testata</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Sconto_GBP_Testata</fullName>
        <field>PSconto_GBP__c</field>
        <formula>if 
( OR( Prezzo_di_listino_GBP__c=0.00, ISBLANK(Prezzo_di_listino_GBP__c )), 0, 

if ( 
(Sconto_GBP__c / Prezzo_di_listino_GBP__c)&lt;0, 
0, 
Sconto_GBP__c / Prezzo_di_listino_GBP__c 
) 
)</formula>
        <name>Update % Sconto GBP Testata</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Sconto_HKD_testata</fullName>
        <field>PSconto_HKD__c</field>
        <formula>if 
( OR( Prezzo_di_listino_HKD__c=0.00, ISBLANK(Prezzo_di_listino_HKD__c )), 0, 

if ( 
(Sconto_HKD__c / Prezzo_di_listino_HKD__c)&lt;0, 
0, 
Sconto_HKD__c / Prezzo_di_listino_HKD__c 
) 
)</formula>
        <name>Update % Sconto HKD testata</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Sconto_JPY_Testata</fullName>
        <field>PSconto_JPY__c</field>
        <formula>if 
( OR( Prezzo_di_listino_JPY__c=0.00, ISBLANK(Prezzo_di_listino_JPY__c )), 0, 

if ( 
(Sconto_JPY__c / Prezzo_di_listino_JPY__c)&lt;0, 
0, 
Sconto_JPY__c / Prezzo_di_listino_JPY__c 
) 
)</formula>
        <name>Update % Sconto JPY Testata</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Sconto_MOP_testata</fullName>
        <field>PSconto_MOP__c</field>
        <formula>if 
( OR( Prezzo_di_listino_MOP__c=0.00, ISBLANK(Prezzo_di_listino_MOP__c )), 0, 

if ( 
(Sconto_MOP__c / Prezzo_di_listino_MOP__c)&lt;0, 
0, 
Sconto_MOP__c / Prezzo_di_listino_MOP__c 
) 
)</formula>
        <name>Update % Sconto MOP testata</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Sconto_USD_Testata</fullName>
        <field>PSconto_USD__c</field>
        <formula>if 
( OR( Prezzo_di_listino_USD__c=0.00, ISBLANK(Prezzo_di_listino_USD__c )), 0, 

if ( 
(Sconto_USD__c / Prezzo_di_listino_USD__c)&lt;0, 
0, 
Sconto_USD__c / Prezzo_di_listino_USD__c 
) 
)</formula>
        <name>Update % Sconto USD Testata</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>%25 di Sconto Testata</fullName>
        <actions>
            <name>Update_Sconto_BRL_Testata</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Sconto_CAD_testata</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Sconto_CHF_testata</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Sconto_CNY_testata</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Sconto_EUR_testata</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Sconto_GBP_Testata</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Sconto_HKD_testata</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Sconto_JPY_Testata</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Sconto_MOP_testata</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Sconto_USD_Testata</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>popola le percentuali di sconto per tutte le valute della testata</description>
        <formula>true</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Compilazione Chiave Transazione</fullName>
        <actions>
            <name>Scrittura_chiave_Transazione</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Compilazione Chiave Transazione per inserimenti in realtime</description>
        <formula>Or( 
ISBLANK( Key_Transazione__c ) , 
ISCHANGED(Name), 
ISCHANGED(Id_Location_Micros__c), 
ISCHANGED(Codice_Cassa__c) 


)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Importo Sconto Testata MOP</fullName>
        <actions>
            <name>Aggiornamento_Sconto_MOP_Testata</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>true</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
