<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Avviso_Nuova_Riparazione</fullName>
        <description>Avviso Nuova Riparazione</description>
        <protected>false</protected>
        <recipients>
            <recipient>vanina.facchin@brunellocucinelli.it</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Riparazione/Riparazione_1_avviso_nuova_riparazione</template>
    </alerts>
    <alerts>
        <fullName>Avviso_Nuova_Riparazione_ALL</fullName>
        <description>Avviso Nuova Riparazione ALL</description>
        <protected>false</protected>
        <recipients>
            <field>Email_Responsabile_Sede__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Riparazione/Riparazione_1_avviso_nuova_riparazione</template>
    </alerts>
    <alerts>
        <fullName>Avviso_Nuova_Riparazione_IT_Svizzera</fullName>
        <description>Avviso Nuova Riparazione - IT, Svizzera</description>
        <protected>false</protected>
        <recipients>
            <recipient>laura.tartacca@brunellocucinelli.it</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Riparazione/Riparazione_1_avviso_nuova_riparazione</template>
    </alerts>
    <alerts>
        <fullName>Capo_inviato_verso_sede</fullName>
        <description>Capo inviato verso sede</description>
        <protected>false</protected>
        <recipients>
            <recipient>simona.caterina@brunellocucinelli.it</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Riparazione/Riparazione_3_capo_inviato_verso_sede</template>
    </alerts>
    <alerts>
        <fullName>Capo_ricevuto_in_sede_e_affidato_ENG</fullName>
        <description>Capo ricevuto in sede e affidato - ENG</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Riparazione/Riparazione_4_capo_ricevuto_in_sede_ENG</template>
    </alerts>
    <alerts>
        <fullName>Capo_ricevuto_in_sede_e_affidato_ITA</fullName>
        <description>Capo ricevuto in sede e affidato - ITA</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Riparazione/Riparazione_4_capo_ricevuto_in_sede_ITA</template>
    </alerts>
    <alerts>
        <fullName>Data_riparazione_prevista_modificata_ENG</fullName>
        <description>Data riparazione prevista modificata - ENG</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Riparazione/Riparazione_5_data_riparazione_modificata_ENG</template>
    </alerts>
    <alerts>
        <fullName>Data_riparazione_prevista_modificata_ITA</fullName>
        <description>Data riparazione prevista modificata - ITA</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Riparazione/Riparazione_5_data_riparazione_modificata_ITA</template>
    </alerts>
    <alerts>
        <fullName>Numero_Autorizzazione_inserito_ENG</fullName>
        <description>Numero Autorizzazione inserito - ENG</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Riparazione/Riparazione_2_numero_autorizzazione_inserito_ENG</template>
    </alerts>
    <alerts>
        <fullName>Numero_Autorizzazione_inserito_ITA</fullName>
        <description>Numero Autorizzazione inserito - ITA</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Riparazione/Riparazione_2_numero_autorizzazione_inserito_ITA</template>
    </alerts>
    <alerts>
        <fullName>Riparazione_effettuata_CC</fullName>
        <description>Riparazione effettuata (CC)</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Riparazione/Riparazione_6_riparazone_effettuata_CC</template>
    </alerts>
    <alerts>
        <fullName>Riparazione_effettuata_e_spedita_sede_ENG</fullName>
        <description>Riparazione effettuata e spedita (sede) - ENG</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Riparazione/Riparazione_6_riparazone_effettuata_e_spedita_ENG</template>
    </alerts>
    <alerts>
        <fullName>Riparazione_effettuata_e_spedita_sede_ITA</fullName>
        <description>Riparazione effettuata e spedita (sede) - ITA</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Riparazione/Riparazione_6_riparazone_effettuata_e_spedita_ITA</template>
    </alerts>
    <alerts>
        <fullName>Riparazione_non_autorizzata_ENG</fullName>
        <description>Riparazione non autorizzata - ENG</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Riparazione/Riparazione_non_autorizzata_ENG</template>
    </alerts>
    <alerts>
        <fullName>Riparazione_non_autorizzata_ITA</fullName>
        <description>Riparazione non autorizzata - ITA</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Riparazione/Riparazione_non_autorizzata_ITA</template>
    </alerts>
    <alerts>
        <fullName>Sollecito_chiusura_operazione</fullName>
        <description>Sollecito chiusura operazione</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>simona.caterina@brunellocucinelli.it</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Riparazione/Riparazione_sollecito_chiusura_operazione</template>
    </alerts>
    <alerts>
        <fullName>Sollecito_fine_riparazione</fullName>
        <description>Sollecito fine riparazione</description>
        <protected>false</protected>
        <recipients>
            <recipient>simona.caterina@brunellocucinelli.it</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Riparazione/Riparazione_sollecito_fine_riparazione</template>
    </alerts>
    <alerts>
        <fullName>Sollecito_invio_verso_sede</fullName>
        <description>Sollecito invio verso sede</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>simona.caterina@brunellocucinelli.it</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Riparazione/Riparazione_sollecito_invio_verso_sede</template>
    </alerts>
    <fieldUpdates>
        <fullName>Close_Dettaglio_Riparazione</fullName>
        <field>Status__c</field>
        <literalValue>Chiuso</literalValue>
        <name>Close Dettaglio Riparazione</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Data_riparazione_effettiva_today</fullName>
        <field>Data_riparazione_effettiva__c</field>
        <formula>today()</formula>
        <name>Data riparazione effettiva today</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Popola_Email_Responsabile_CC</fullName>
        <field>Email_Responsabile_Sede__c</field>
        <formula>&quot;riparazioni.customercare@brunellocucinelli.it&quot;</formula>
        <name>Popola Email Responsabile CC</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Popola_Email_Responsabile_Sede</fullName>
        <field>Email_Responsabile_Sede__c</field>
        <formula>CASE ( $User.Country, 
&quot;IT&quot;, &quot;laura.tartacca@brunellocucinelli.it&quot;, 
&quot;CH&quot;, &quot;laura.tartacca@brunellocucinelli.it&quot;,
&quot;ES&quot;, &quot;eleonora.bisogni@brunellocucinelli.it&quot;,
&quot;GR&quot;, &quot;eleonora.bisogni@brunellocucinelli.it&quot;, 
&quot;vanina.facchin@brunellocucinelli.it&quot; )</formula>
        <name>Popola Email Responsabile Sede</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Stato_inviato_verso_sede</fullName>
        <field>Status__c</field>
        <literalValue>Invio capo verso sede</literalValue>
        <name>Stato inviato verso sede</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Stato_riparazione_effettuata</fullName>
        <field>Status__c</field>
        <literalValue>Riparazione effettuata</literalValue>
        <name>Stato: riparazione effettuata</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_Repaired_Prod_Received_in_Bout</fullName>
        <field>Status__c</field>
        <literalValue>Ricevimento capo riparato in boutique</literalValue>
        <name>Status: Repaired Prod Received in Bout.</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_Repaired_Product_Shipped</fullName>
        <field>Status__c</field>
        <literalValue>Spedizione capo riparato effettuata</literalValue>
        <name>Status: Repaired Product Shipped</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_Ricevimento_capo_danneggiato_in_s</fullName>
        <field>Status__c</field>
        <literalValue>Ricevimento capo danneggiato in sede</literalValue>
        <name>Status Ricevimento capo danneggiato in s</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_Riconsegna_al_cliente_effettuata</fullName>
        <field>Status__c</field>
        <literalValue>Riconsegna al cliente effettuata</literalValue>
        <name>Status Riconsegna al cliente effettuata</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_capo_riconsegnato_a_cliente</fullName>
        <field>Status__c</field>
        <literalValue>Riconsegna al cliente effettuata</literalValue>
        <name>Status &quot;capo riconsegnato a cliente&quot;</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Capo affidato e data riparazione prevista</fullName>
        <actions>
            <name>Stato_riparazione_effettuata</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(
ISCHANGED( Affidato_a__c ),
ISCHANGED( Data_riparazione_prevista__c ), NOT(ISBLANK(Affidato_a__c )),
NOT(ISBLANK(Data_riparazione_prevista__c )))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Creazione Riparazione CC</fullName>
        <actions>
            <name>Avviso_Nuova_Riparazione_ALL</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Popola_Email_Responsabile_CC</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Dettaglio_Riparazione__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Repair - Customer Care</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Creazione Riparazione Sede</fullName>
        <actions>
            <name>Avviso_Nuova_Riparazione_ALL</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Popola_Email_Responsabile_Sede</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Dettaglio_Riparazione__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Riparazione - Sede</value>
        </criteriaItems>
        <description>In creazione di un dettaglio riparazione di sede, viene inviata un&apos;email al responsabile di sede (diverso per ogni area)</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Creazione Riparazione Sede - ITA %2B Svizzera</fullName>
        <actions>
            <name>Avviso_Nuova_Riparazione_IT_Svizzera</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <booleanFilter>1 AND (2 OR 3)</booleanFilter>
        <criteriaItems>
            <field>Dettaglio_Riparazione__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Riparazione - Sede</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.Country</field>
            <operation>equals</operation>
            <value>IT</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.Country</field>
            <operation>equals</operation>
            <value>CH</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Creazione Riparazione Sede NO ITA%2C Svizzera</fullName>
        <actions>
            <name>Avviso_Nuova_Riparazione</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Dettaglio_Riparazione__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Riparazione - Sede</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.Country</field>
            <operation>notEqual</operation>
            <value>IT</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.Country</field>
            <operation>notEqual</operation>
            <value>CH</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Nota avvenuta riparazione inserita</fullName>
        <actions>
            <name>Status_Repaired_Product_Shipped</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND( OR( RecordType.DeveloperName = &quot;Riparazione_Sede&quot;, 
RecordType.DeveloperName = &quot;Riparazione_Customer_Care&quot;), 
ISCHANGED(Riparazione_completata_Note__c ), NOT(ISBLANK(Riparazione_completata_Note__c )))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Note avvenuta riconsegna</fullName>
        <actions>
            <name>Close_Dettaglio_Riparazione</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED(Note_Avvenuta_Riconsegna__c) &amp;&amp; NOT(ISBLANK(Note_Avvenuta_Riconsegna__c))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Numero autorizzazione inserito</fullName>
        <actions>
            <name>Stato_inviato_verso_sede</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND (OR( RecordType.DeveloperName = &quot;Riparazione_Sede&quot;, 
RecordType.DeveloperName = &quot;Riparazione_Customer_Care&quot;), 
ISCHANGED( Numero_Autorizzazione_Sede__c ), 
!ISBLANK(Numero_Autorizzazione_Sede__c ))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Repair note compilata</fullName>
        <actions>
            <name>Data_riparazione_effettiva_today</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND (RecordType.DeveloperName = &quot;Riparazione_Danno_Boutique&quot;, 
ISCHANGED(Riparazione_completata_Note__c ), NOT(ISBLANK(Riparazione_completata_Note__c )))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Riparazione non autorizzata - CC - ENG</fullName>
        <actions>
            <name>Riparazione_non_autorizzata_ENG</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Close_Dettaglio_Riparazione</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND( ISPICKVAL(Riparazione_autorizzata__c, &quot;No&quot;),  RecordType.DeveloperName = &quot;Riparazione_Customer_Care&quot;, CreatedBy.Language_Email__c &lt;&gt; &quot;Italian&quot;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Riparazione non autorizzata - CC - ITA</fullName>
        <actions>
            <name>Riparazione_non_autorizzata_ITA</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Close_Dettaglio_Riparazione</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND( ISPICKVAL(Riparazione_autorizzata__c, &quot;No&quot;),  RecordType.DeveloperName = &quot;Riparazione_Customer_Care&quot;, CreatedBy.Language_Email__c = &quot;Italian&quot;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Riparazione non autorizzata - no CC - ENG</fullName>
        <actions>
            <name>Riparazione_non_autorizzata_ENG</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Status_Riconsegna_al_cliente_effettuata</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND( 
ISPICKVAL(Riparazione_autorizzata__c, &quot;No&quot;), RecordType.DeveloperName &lt;&gt; &quot;Riparazione_Customer_Care&quot;, 
CreatedBy.Language_Email__c &lt;&gt; &quot;Italian&quot;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Riparazione non autorizzata - no CC - ITA</fullName>
        <actions>
            <name>Riparazione_non_autorizzata_ITA</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Status_Riconsegna_al_cliente_effettuata</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND( 
ISPICKVAL(Riparazione_autorizzata__c, &quot;No&quot;), RecordType.DeveloperName &lt;&gt; &quot;Riparazione_Customer_Care&quot;, 
CreatedBy.Language_Email__c = &quot;Italian&quot;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Sollecito chiusura operazione %28da creazione%29</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Dettaglio_Riparazione__c.Status__c</field>
            <operation>notEqual</operation>
            <value>Riconsegna al cliente effettuata</value>
        </criteriaItems>
        <criteriaItems>
            <field>Dettaglio_Riparazione__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Riparazione - Sede</value>
        </criteriaItems>
        <criteriaItems>
            <field>Dettaglio_Riparazione__c.Status__c</field>
            <operation>notEqual</operation>
            <value>Chiuso</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Sollecito_chiusura_operazione</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Dettaglio_Riparazione__c.CreatedDate</offsetFromField>
            <timeLength>30</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>Sollecito_chiusura_operazione</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Dettaglio_Riparazione__c.CreatedDate</offsetFromField>
            <timeLength>50</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>Sollecito_chiusura_operazione</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Dettaglio_Riparazione__c.CreatedDate</offsetFromField>
            <timeLength>40</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>Sollecito_chiusura_operazione</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Dettaglio_Riparazione__c.CreatedDate</offsetFromField>
            <timeLength>60</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Sollecito chiusura operazione %28da spedizione in boutique%29</fullName>
        <active>true</active>
        <formula>AND(  NOT(ISPICKVAL(Status__c, &quot;Riconsegna al cliente effettuata&quot;)), NOT(ISPICKVAL(Status__c, &quot;Chiuso&quot;)),  NOT(ISNULL( Data_Spedizione_da_Solomeo__c )))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Sollecito_chiusura_operazione</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Dettaglio_Riparazione__c.Data_Spedizione_da_Solomeo__c</offsetFromField>
            <timeLength>10</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>Sollecito_chiusura_operazione</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Dettaglio_Riparazione__c.Data_Spedizione_da_Solomeo__c</offsetFromField>
            <timeLength>20</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Sollecito fine riparazione</fullName>
        <active>true</active>
        <formula>ISPICKVAL(Status__c, &quot;Riparazione effettuata&quot;) &amp;&amp; NOT(ISNULL( Data_affidamento_riparazione__c ))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Sollecito_fine_riparazione</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Dettaglio_Riparazione__c.Data_affidamento_riparazione__c</offsetFromField>
            <timeLength>10</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>Sollecito_fine_riparazione</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Dettaglio_Riparazione__c.Data_affidamento_riparazione__c</offsetFromField>
            <timeLength>20</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>Sollecito_fine_riparazione</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Dettaglio_Riparazione__c.Data_affidamento_riparazione__c</offsetFromField>
            <timeLength>30</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>Sollecito_fine_riparazione</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Dettaglio_Riparazione__c.Data_affidamento_riparazione__c</offsetFromField>
            <timeLength>40</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Sollecito spedizione verso sede</fullName>
        <active>true</active>
        <formula>ISPICKVAL(Status__c, &quot;Invio capo verso sede&quot;) &amp;&amp; NOT(ISNULL(Data_accettazione_richiesta__c))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Sollecito_invio_verso_sede</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Dettaglio_Riparazione__c.Data_accettazione_richiesta__c</offsetFromField>
            <timeLength>3</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>Sollecito_invio_verso_sede</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Dettaglio_Riparazione__c.Data_accettazione_richiesta__c</offsetFromField>
            <timeLength>10</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>Sollecito_invio_verso_sede</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Dettaglio_Riparazione__c.Data_accettazione_richiesta__c</offsetFromField>
            <timeLength>5</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Tracking Number andata inserito</fullName>
        <actions>
            <name>Status_Ricevimento_capo_danneggiato_in_s</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED(Tracking_Number_ritiro__c) &amp;&amp; !ISBLANK(Tracking_Number_ritiro__c)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Tracking number ritorno inserito - CC</fullName>
        <actions>
            <name>Status_capo_riconsegnato_a_cliente</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(RecordType.DeveloperName = &quot;Riparazione_Customer_Care&quot;, ISCHANGED( Tracking_Number_uscita__c ), NOT(ISBLANK(Tracking_Number_uscita__c )))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Tracking number ritorno inserito - Sede</fullName>
        <actions>
            <name>Status_Repaired_Prod_Received_in_Bout</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(RecordType.DeveloperName = &quot;Riparazione_Sede&quot;, 
ISCHANGED( Tracking_Number_uscita__c ), NOT(ISBLANK(Tracking_Number_uscita__c )))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
