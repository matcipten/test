<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Aggiornamento_Sconto_MOP_riga</fullName>
        <field>Sconto_MOP__c</field>
        <formula>if ( 
Or (Prezzo_di_listino_MOP__c - Prezzo_di_vendita_MOP__c =0, (And (Prezzo_di_listino_MOP__c &lt; Prezzo_di_vendita_MOP__c , Prezzo_di_listino_MOP__c &gt;0 )), 
(And (Prezzo_di_listino_MOP__c &gt; Prezzo_di_vendita_MOP__c , Prezzo_di_listino_MOP__c &lt;0 )) 
), 
0 , 
Prezzo_di_listino_MOP__c - Prezzo_di_vendita_MOP__c 
)</formula>
        <name>Aggiornamento Sconto MOP riga</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Compilazione_Chiave_dettaglio_transazion</fullName>
        <field>Key_Dettaglio_Transazione__c</field>
        <formula>Numero_Scontrino__c &amp; Id_Location_Micros__c &amp; Codice_Cassa__c &amp; Name</formula>
        <name>Compilazione Chiave dettaglio transazion</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Quantita_Segno_Negativo</fullName>
        <description>setta negativa la quantità in caso di reso o exchange</description>
        <field>Quantita__c</field>
        <formula>- Quantita__c</formula>
        <name>Quantità Segno Negativo</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Sconto_BRL_riga</fullName>
        <field>PSconto_BRL__c</field>
        <formula>if 
( OR( Prezzo_di_listino_BRL__c=0.00, ISBLANK(Prezzo_di_listino_BRL__c )), 0, 

if ( 
(Sconto_BRL__c / Prezzo_di_listino_BRL__c)&lt;0, 
0, 
Sconto_BRL__c / Prezzo_di_listino_BRL__c 
) 
)</formula>
        <name>Update % Sconto BRL riga</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Sconto_CAD_riga</fullName>
        <field>Pdi_Sconto_CAD__c</field>
        <formula>if 
( OR( Prezzo_di_listino_CAD__c=0.00, ISBLANK(Prezzo_di_listino_CAD__c )), 0, 

if ( 
(Sconto_CAD__c / Prezzo_di_listino_CAD__c)&lt;0, 
0, 
Sconto_CAD__c / Prezzo_di_listino_CAD__c 
) 
)</formula>
        <name>Update % Sconto CAD riga</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Sconto_CHF_riga</fullName>
        <field>PSconto_CHF__c</field>
        <formula>if 
( OR( Prezzo_di_listino_CHF__c=0.00, ISBLANK(Prezzo_di_listino_CHF__c )), 0, 

if ( 
(Sconto_CHF__c / Prezzo_di_listino_CHF__c)&lt;0, 
0, 
Sconto_CHF__c / Prezzo_di_listino_CHF__c 
) 
)</formula>
        <name>Update % Sconto CHF riga</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Sconto_CNY_riga</fullName>
        <field>PSconto_CNY__c</field>
        <formula>if 
( OR( Prezzo_di_listino_CNY__c=0.00, ISBLANK(Prezzo_di_listino_CNY__c )), 0, 

if ( 
(Sconto_CNY__c / Prezzo_di_listino_CNY__c)&lt;0, 
0, 
Sconto_CNY__c / Prezzo_di_listino_CNY__c 
) 
)</formula>
        <name>Update % Sconto CNY riga</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Sconto_EUR_riga</fullName>
        <field>PSconto_EUR__c</field>
        <formula>if 
( OR( Prezzo_di_Listino_EUR__c=0.00, ISBLANK(Prezzo_di_Listino_EUR__c )), 0, 

if ( 
(Sconto_EUR__c / Prezzo_di_Listino_EUR__c)&lt;0, 
0, 
Sconto_EUR__c / Prezzo_di_Listino_EUR__c 
) 
)</formula>
        <name>Update % Sconto EUR riga</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Sconto_GBP_riga</fullName>
        <field>PSconto_GBP__c</field>
        <formula>if 
( OR( Prezzo_di_listino_GBP__c=0.00, ISBLANK(Prezzo_di_listino_GBP__c )), 0, 

if ( 
(Sconto_GBP__c / Prezzo_di_listino_GBP__c)&lt;0, 
0, 
Sconto_GBP__c / Prezzo_di_listino_GBP__c 
) 
)</formula>
        <name>Update % Sconto GBP riga</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Sconto_HKD_riga</fullName>
        <field>PSconto_HKD__c</field>
        <formula>if 
( OR( Prezzo_di_listino_HKD__c=0.00, ISBLANK(Prezzo_di_listino_HKD__c )), 0, 

if ( 
(Sconto_HKD__c / Prezzo_di_listino_HKD__c)&lt;0, 
0, 
Sconto_HKD__c / Prezzo_di_listino_HKD__c 
) 
)</formula>
        <name>Update % Sconto HKD riga</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Sconto_JPY_riga</fullName>
        <field>PSconto_JPY__c</field>
        <formula>if 
( OR( Prezzo_di_listino_JPY__c=0.00, ISBLANK(Prezzo_di_listino_JPY__c )), 0, 

if ( 
(Sconto_JPY__c / Prezzo_di_listino_JPY__c)&lt;0, 
0, 
Sconto_JPY__c / Prezzo_di_listino_JPY__c 
) 
)</formula>
        <name>Update % Sconto JPY riga</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Sconto_MOP_riga</fullName>
        <field>PSconto_MOP__c</field>
        <formula>if 
( OR( Prezzo_di_listino_MOP__c=0.00, ISBLANK(Prezzo_di_listino_MOP__c )), 0, 

if ( 
(Sconto_MOP__c / Prezzo_di_listino_MOP__c)&lt;0, 
0, 
Sconto_MOP__c / Prezzo_di_listino_MOP__c 
) 
)</formula>
        <name>Update % Sconto MOP riga</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Sconto_USD_riga</fullName>
        <field>PSconto_USD__c</field>
        <formula>if 
( OR( Prezzo_di_listino_USD__c=0.00, ISBLANK(Prezzo_di_listino_USD__c )), 0, 

if ( 
(Sconto_USD__c / Prezzo_di_listino_USD__c)&lt;0, 
0, 
Sconto_USD__c / Prezzo_di_listino_USD__c 
) 
)</formula>
        <name>Update % Sconto USD riga</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>%25 di Sconto Riga</fullName>
        <actions>
            <name>Update_Sconto_BRL_riga</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Sconto_CAD_riga</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Sconto_CHF_riga</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Sconto_CNY_riga</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Sconto_EUR_riga</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Sconto_GBP_riga</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Sconto_HKD_riga</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Sconto_JPY_riga</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Sconto_MOP_riga</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Sconto_USD_riga</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Popola i campi % sconto per tutte le valute</description>
        <formula>TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Compilazione Chiave dettaglio transazione</fullName>
        <actions>
            <name>Compilazione_Chiave_dettaglio_transazion</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>OR( 
ISBLANK( Key_Dettaglio_Transazione__c ), 
ISCHANGED(Numero_Scontrino__c), 
ISCHANGED(Id_Location_Micros__c ), 
ISCHANGED(Codice_Cassa__c ), 
ISCHANGED(Name) 

)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Importo Sconto Riga MOP</fullName>
        <actions>
            <name>Aggiornamento_Sconto_MOP_riga</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Popola i campi Importo sconto per la valuta MOP</description>
        <formula>true</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Segno_Quantità</fullName>
        <actions>
            <name>Quantita_Segno_Negativo</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Workflow che determina il segno del campo Quantità, se &quot;S&quot; positivo, se &quot;R&quot; o &quot;E&quot; negativo</description>
        <formula>Or(
	And(
		Or(
			Text(Tipo_Vendita__c) = &quot;r&quot;,
			Text(Tipo_Vendita__c) = &quot;e&quot;
			),
	ISNEW()),
 And(
	Or(
	text(PRIORVALUE(Tipo_Vendita__c)) = &quot;s&quot;,
	text(PRIORVALUE(Tipo_Vendita__c)) = &quot;n&quot;),
	Or(
	ISPICKVAL(Tipo_Vendita__c, &quot;r&quot;),
	ISPICKVAL(Tipo_Vendita__c, &quot;e&quot;)),
	Not(ISNEW())),

		And(
		Or(Text(Tipo_Vendita__c) = &quot;r&quot;,
		Text(Tipo_Vendita__c) = &quot;e&quot;),
		Not(ISNEW()),
		ISCHANGED(Quantita__c))

)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
