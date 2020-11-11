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
        <description>Avviso Nuova Riparazione - IT</description>
        <protected>false</protected>
        <recipients>
            <recipient>chiara.rossi@brunellocucinelli.it</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>elena.cipolletta@brunellocucinelli.it</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>laura.tartacca@brunellocucinelli.it</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Riparazione/Riparazione_1_avviso_nuova_riparazione</template>
    </alerts>
    <alerts>
        <fullName>Avviso_Nuova_Riparazione_Svizzera</fullName>
        <description>Avviso Nuova Riparazione - Svizzera</description>
        <protected>false</protected>
        <recipients>
            <recipient>ilaria.mischianti@brunellocucinelli.it</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>laura.tartacca@brunellocucinelli.it</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>silvia.conti@brunellocucinelli.it</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Riparazione/Riparazione_1_avviso_nuova_riparazione</template>
    </alerts>
    <alerts>
        <fullName>Avviso_Nuova_Riparazione_WW</fullName>
        <description>Avviso Nuova Riparazione WW</description>
        <protected>false</protected>
        <recipients>
            <recipient>arianna.ricci@brunellocucinelli.it</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>simona.caterina@brunellocucinelli.it</recipient>
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
            <recipient>arianna.ricci@brunellocucinelli.it</recipient>
            <type>user</type>
        </recipients>
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
        <fullName>Controllo_caricamento_stock</fullName>
        <description>Controllo caricamento stock</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Riparazione/Controllo_caricamento_stock</template>
    </alerts>
    <alerts>
        <fullName>Controllo_ritiro_capo_e_chiusura_riparazione</fullName>
        <description>Controllo ritiro capo e chiusura riparazione</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Riparazione/Controllo_ritiro_capo_e_chiusura_riparazione</template>
    </alerts>
    <alerts>
        <fullName>Controllo_ritiro_divisa</fullName>
        <description>Controllo ritiro divisa</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Riparazione/Controllo_ritiro_divisa</template>
    </alerts>
    <alerts>
        <fullName>Controllo_stato_riparazione_e_contatto_cliente</fullName>
        <description>Controllo stato riparazione e contatto cliente</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Riparazione/Controllo_stato_riparazione_e_contatto_cliente</template>
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
        <fullName>Nuova_riparazione_AT</fullName>
        <description>Nuova riparazione AT</description>
        <protected>false</protected>
        <recipients>
            <recipient>irene.tarini@brunellocucinelli.it</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Riparazione/Riparazione_1_avviso_nuova_riparazione</template>
    </alerts>
    <alerts>
        <fullName>Nuova_riparazione_BE</fullName>
        <description>Nuova riparazione BE</description>
        <protected>false</protected>
        <recipients>
            <recipient>flavia.miluzzi@brunellocucinelli.it</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Riparazione/Riparazione_1_avviso_nuova_riparazione</template>
    </alerts>
    <alerts>
        <fullName>Nuova_riparazione_DE</fullName>
        <description>Nuova riparazione DE</description>
        <protected>false</protected>
        <recipients>
            <recipient>francesca.defelice@brunellocucinelli.it</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Riparazione/Riparazione_1_avviso_nuova_riparazione</template>
    </alerts>
    <alerts>
        <fullName>Nuova_riparazione_DK</fullName>
        <description>Nuova riparazione DK</description>
        <protected>false</protected>
        <recipients>
            <recipient>marta.barluzzi@brunellocucinelli.it</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Riparazione/Riparazione_1_avviso_nuova_riparazione</template>
    </alerts>
    <alerts>
        <fullName>Nuova_riparazione_DK_GB</fullName>
        <description>Nuova riparazione GB, DK, BE, AT, FR, DE</description>
        <protected>false</protected>
        <recipients>
            <recipient>arianna.ricci@brunellocucinelli.it</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>simona.caterina@brunellocucinelli.it</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>vanina.facchin@brunellocucinelli.it</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Riparazione/Riparazione_1_avviso_nuova_riparazione</template>
    </alerts>
    <alerts>
        <fullName>Nuova_riparazione_ES_GR</fullName>
        <description>Nuova riparazione ES, GR</description>
        <protected>false</protected>
        <recipients>
            <recipient>eleonora.bisogni@brunellocucinelli.it</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>vincenza.tralli@brunellocucinelli.it</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>yosi.casuscelli@brunellocucinelli.it</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Riparazione/Riparazione_1_avviso_nuova_riparazione</template>
    </alerts>
    <alerts>
        <fullName>Nuova_riparazione_FR</fullName>
        <description>Nuova riparazione FR</description>
        <protected>false</protected>
        <recipients>
            <recipient>flavia.miluzzi@brunellocucinelli.it</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>sara.dibello@brunellocucinelli.it</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Riparazione/Riparazione_1_avviso_nuova_riparazione</template>
    </alerts>
    <alerts>
        <fullName>Nuova_riparazione_GB</fullName>
        <description>Nuova riparazione GB</description>
        <protected>false</protected>
        <recipients>
            <recipient>irene.tarini@brunellocucinelli.it</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>marta.barluzzi@brunellocucinelli.it</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Riparazione/Riparazione_1_avviso_nuova_riparazione</template>
    </alerts>
    <alerts>
        <fullName>Nuova_riparazione_ROW</fullName>
        <description>Nuova riparazione ROW</description>
        <protected>false</protected>
        <recipients>
            <recipient>arianna.ricci@brunellocucinelli.it</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>simona.caterina@brunellocucinelli.it</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Riparazione/Riparazione_1_avviso_nuova_riparazione</template>
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
        <fullName>Riparazione_effettuata_e_spedita</fullName>
        <description>Riparazione effettuata e spedita</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Riparazione/Riparazione_effettuata_e_spedita</template>
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
            <recipient>arianna.ricci@brunellocucinelli.it</recipient>
            <type>user</type>
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
            <recipient>arianna.ricci@brunellocucinelli.it</recipient>
            <type>user</type>
        </recipients>
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
            <recipient>arianna.ricci@brunellocucinelli.it</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>simona.caterina@brunellocucinelli.it</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Riparazione/Riparazione_sollecito_invio_verso_sede</template>
    </alerts>
    <fieldUpdates>
        <fullName>Aggiornamento_Prodotto_Riparato</fullName>
        <description>Per RT Uniform/Personal Item_In Boutique (Tailor) e Item from Stock_In Boutique (Tailor)</description>
        <field>Status__c</field>
        <literalValue>Prodotto Riparato</literalValue>
        <name>Aggiornamento Prodotto Riparato</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Aggiornamento_Prodotto_consegnato</fullName>
        <field>Status__c</field>
        <literalValue>Prodotto riconsegnato</literalValue>
        <name>Aggiornamento Prodotto consegnato</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Aggiornamento_Prodotto_riconsegnato</fullName>
        <field>Status__c</field>
        <literalValue>Prodotto riconsegnato in Boutique</literalValue>
        <name>Aggiornamento Prodotto riconsegnato</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Aggiornamento_Stato_Capo_Ricevuto</fullName>
        <field>Status__c</field>
        <literalValue>Capo ricevuto in Boutique</literalValue>
        <name>Aggiornamento Stato Capo Ricevuto</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Aggiornamento_Status_Prodotto_Consegnato</fullName>
        <field>Status__c</field>
        <literalValue>Prodotto consegnato al cliente</literalValue>
        <name>Aggiornamento Status Prodotto Consegnato</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
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
        <fullName>Customer_contacted</fullName>
        <field>Status__c</field>
        <literalValue>Prodotto consegnato al cliente</literalValue>
        <name>Customer contacted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Data_contatto_cliente</fullName>
        <field>Data_contatto_cliente__c</field>
        <formula>NOW()</formula>
        <name>Data contatto cliente</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
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
        <literalValue>Cliente contattato</literalValue>
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
        <literalValue>Prodotto consegnato al cliente</literalValue>
        <name>Status &quot;capo riconsegnato a cliente&quot;</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Alert Caricamento stock</fullName>
        <active>true</active>
        <description>Secondo alert per RT:

Item from Stock _ IN BOUTIQUE (TAILOR)
Item from Stock _ LOCAL EXTERNAL SERVICE</description>
        <formula>AND( OR(   RecordType.Name = &apos;Item from Stock_External Service&apos;,  RecordType.Name = &apos;Item from Stock_In Boutique (Tailor)&apos; ),   OR(ISPICKVAL(Status__c, &quot;Prodotto Riparato&quot;), ISPICKVAL(Status__c, &quot;Prodotto riconsegnato in Boutique&quot;)), OR( NOT(ISNULL(Data_riparazione_prevista__c)),  NOT(ISNULL(Data_riparazione_prevista_modificata__c)) ))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Controllo_caricamento_stock</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Dettaglio_Riparazione__c.Data_riparazione_prevista_modificata__c</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>Controllo_caricamento_stock</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Dettaglio_Riparazione__c.Data_riparazione_prevista__c</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Alert Controllo caricamento stock</fullName>
        <active>true</active>
        <description>Quinto alert per RT:

ITEM FROM STOCK _ TO HEADQUARTER SOLOMEO</description>
        <formula>AND( RecordType.Name = &apos;Riparazione Stock&apos;, ISPICKVAL(Status__c, &quot;Capo ricevuto in Boutique&quot;),  ISBLANK(Data_ritiro_prevista_cliente__c))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Controllo_caricamento_stock</name>
                <type>Alert</type>
            </actions>
            <timeLength>5</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Alert Controllo ritiro capo e chiusura riparazione</fullName>
        <active>true</active>
        <description>Second Alert per RT:

Client Return _ IN BOUTIQUE (TAILOR)
Client Return _ LOCAL EXTERNAL SERVICE</description>
        <formula>AND(  OR( RecordType.Name = &apos;Riparazione Boutique - Tailor&apos;,   RecordType.Name = &apos;Riparazione Boutique - External Service&apos; ),   ISPICKVAL(Status__c, &quot;Cliente contattato&quot;),   OR( NOT(ISNULL(Data_riparazione_prevista__c)),   NOT(ISNULL(Data_riparazione_prevista_modificata__c)) ))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Controllo_ritiro_capo_e_chiusura_riparazione</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Dettaglio_Riparazione__c.Data_riparazione_prevista__c</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>Controllo_ritiro_capo_e_chiusura_riparazione</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Dettaglio_Riparazione__c.Data_riparazione_prevista_modificata__c</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Alert Controllo ritiro capo e chiusura riparazione Sede</fullName>
        <active>true</active>
        <description>Sesto alert per RT:

CLIENT RETURN _ TO HEADQUARTER SOLOMEO</description>
        <formula>AND( RecordType.Name = &apos;Riparazione - Sede&apos;, NOT(ISNULL(Data_ritiro_prevista_cliente__c)), ISPICKVAL(Status__c, &quot;Prodotto consegnato al cliente&quot;) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Controllo_ritiro_capo_e_chiusura_riparazione</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Dettaglio_Riparazione__c.Data_ritiro_prevista_cliente__c</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Alert Controllo ritiro divisa</fullName>
        <active>true</active>
        <description>Quinto alert per RT

UNIFORM / PERSONAL ITEM _ TO HEADQUARTER SOLOMEO</description>
        <formula>AND( RecordType.Name = &apos;Riparazione Uniform&apos;, ISPICKVAL(Status__c, &quot;Capo ricevuto in Boutique&quot;),  ISBLANK(Data_ritiro_prevista_cliente__c))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Controllo_ritiro_divisa</name>
                <type>Alert</type>
            </actions>
            <timeLength>5</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Alert Controllo ritiro divisa - local</fullName>
        <active>true</active>
        <description>Secondo alert per RT:

Uniform/Personal Item _ IN BOUTIQUE (TAILOR)
Uniform/Personal Item _ LOCAL EXTERNAL SERVICE</description>
        <formula>AND( OR(   RecordType.Name = &apos;Uniform/Personal Item_In Boutique (Tailor)&apos;,  RecordType.Name = &apos;Uniform/Personal Item_External Service&apos; ),   OR(ISPICKVAL(Status__c, &quot;Prodotto Riparato&quot;), ISPICKVAL(Status__c, &quot;Prodotto riconsegnato&quot;)), OR( NOT(ISNULL(Data_riparazione_prevista__c)),  NOT(ISNULL(Data_riparazione_prevista_modificata__c)) ))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Controllo_ritiro_divisa</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Dettaglio_Riparazione__c.Data_riparazione_prevista__c</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>Controllo_ritiro_divisa</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Dettaglio_Riparazione__c.Data_riparazione_prevista_modificata__c</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Alert Controllo stato riparazione e contatto cliente</fullName>
        <active>true</active>
        <description>Primo alert per RT:

Client Return _ IN BOUTIQUE (TAILOR)
Client Return _ LOCAL EXTERNAL SERVICE</description>
        <formula>AND(OR( 	 RecordType.Name = &apos;Riparazione Boutique - External Service&apos;, 	 RecordType.Name = &apos;Riparazione Boutique - Tailor&apos; ), 	 ISPICKVAL(Status__c, &quot;Aperto&quot;),   NOT(ISNULL(Data_riparazione_prevista__c)) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Controllo_stato_riparazione_e_contatto_cliente</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Dettaglio_Riparazione__c.Data_riparazione_prevista__c</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Alert Nota di chiusura</fullName>
        <active>true</active>
        <description>Sesto alert per RT:

Repair Customer Care</description>
        <formula>AND( RecordType.Name = &apos;Riparazione - Customer Care&apos;, NOT(ISNULL(Riparazione_completata_Note__c)), ISPICKVAL(Status__c, &quot;Prodotto consegnato al cliente&quot;) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Sollecito_invio_verso_sede</name>
                <type>Alert</type>
            </actions>
            <timeLength>2</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Alert Riparazione effettuata CC</fullName>
        <active>true</active>
        <description>Quinto alert per RT

Repair Customer Care</description>
        <formula>AND( RecordType.Name = &apos;Riparazione - Customer Care&apos;, ISBLANK(Data_ritiro_prevista_cliente__c), ISPICKVAL(Status__c, &quot;Cliente contattato&quot;) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Riparazione_effettuata_e_spedita</name>
                <type>Alert</type>
            </actions>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Alert Riparazione effettuata Sede</fullName>
        <active>true</active>
        <description>Quinto Alert per RT

CLIENT RETURN _ TO HEADQUARTER SOLOMEO</description>
        <formula>AND( RecordType.Name = &apos;Riparazione - Sede&apos;, ISPICKVAL(Status__c, &quot;Cliente contattato&quot;), ISBLANK(Data_ritiro_prevista_cliente__c) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Riparazione_effettuata_e_spedita</name>
                <type>Alert</type>
            </actions>
            <timeLength>5</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Alert chiusura riparazione</fullName>
        <active>true</active>
        <description>Quarto alert per RT:

CLIENT RETURN _ TO HEADQUARTER SOLOMEO
Repair Customer Care
UNIFORM / PERSONAL ITEM _ TO HEADQUARTER SOLOMEO
ITEM FROM STOCK _ TO HEADQUARTER SOLOMEO</description>
        <formula>AND( OR( NOT(ISNULL(Data_riparazione_prevista__c)), NOT(ISNULL(Data_riparazione_prevista_modificata__c)) ), ISPICKVAL(Status__c, &quot;Riparazione effettuata&quot;), OR( RecordType.Name = &apos;Riparazione Uniform&apos;, RecordType.Name = &apos;Riparazione Stock&apos;, RecordType.Name = &apos;Riparazione - Sede&apos;, RecordType.Name = &apos;Riparazione - Customer Care&apos; ))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Sollecito_invio_verso_sede</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Dettaglio_Riparazione__c.Data_riparazione_prevista_modificata__c</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>Sollecito_invio_verso_sede</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Dettaglio_Riparazione__c.Data_riparazione_prevista__c</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Alert fine riparazione</fullName>
        <active>true</active>
        <description>Primo alert per RT

Item from Stock _ IN BOUTIQUE (TAILOR)
Item from Stock _ LOCAL EXTERNAL SERVICE
Uniform/Personal Item _ IN BOUTIQUE (TAILOR)
Uniform/Personal Item _ LOCAL EXTERNAL SERVICE</description>
        <formula>AND(OR( 	 RecordType.Name = &apos;Uniform/Personal Item_In Boutique (Tailor)&apos;, 	 RecordType.Name = &apos;Uniform/Personal Item_External Service&apos;, 	 RecordType.Name = &apos;Item from Stock_External Service&apos;, 	 RecordType.Name = &apos;Item from Stock_In Boutique (Tailor)&apos; ), 	 ISPICKVAL(Status__c, &quot;Aperto&quot;),   NOT(ISNULL(Data_riparazione_prevista__c)) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Sollecito_fine_riparazione</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Dettaglio_Riparazione__c.Data_riparazione_prevista__c</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Alert inserimento affidato a</fullName>
        <active>true</active>
        <description>Terzo alert per RT:

CLIENT RETURN _ TO HEADQUARTER SOLOMEO
Repair Customer Care
UNIFORM / PERSONAL ITEM _ TO HEADQUARTER SOLOMEO
ITEM FROM STOCK _ TO HEADQUARTER SOLOMEO</description>
        <formula>AND( ISPICKVAL(Status__c, &quot;Ricevimento capo danneggiato in sede&quot;), ISBLANK(Affidato_a__c) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Sollecito_invio_verso_sede</name>
                <type>Alert</type>
            </actions>
            <timeLength>5</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Alert inserimento n%2E autorizzazione</fullName>
        <active>true</active>
        <description>Primo alert per RT:

CLIENT RETURN _ TO HEADQUARTER SOLOMEO
Repair Customer Care
UNIFORM / PERSONAL ITEM _ TO HEADQUARTER SOLOMEO
ITEM FROM STOCK _ TO HEADQUARTER SOLOMEO</description>
        <formula>AND( OR( ISPICKVAL(Status__c, &quot;Ricevimento capo danneggiato in boutique&quot;), ISPICKVAL(Status__c, &quot;Riparazione richiesta al Customer Care&quot;), ISPICKVAL(Status__c, &quot;Numero di autorizzazione inserito&quot;)), ISBLANK(Numero_Autorizzazione_Sede__c) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Sollecito_invio_verso_sede</name>
                <type>Alert</type>
            </actions>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Alert inserimento n%2E tracking</fullName>
        <active>true</active>
        <description>Secondo alert per RT

CLIENT RETURN _ TO HEADQUARTER SOLOMEO
Repair Customer Care
UNIFORM / PERSONAL ITEM _ TO HEADQUARTER SOLOMEO
ITEM FROM STOCK _ TO HEADQUARTER SOLOMEO</description>
        <formula>AND( ISPICKVAL(Status__c, &quot;Invio capo verso sede&quot;), ISBLANK(Tracking_Number_uscita__c ) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Numero_Autorizzazione_inserito_ITA</name>
                <type>Alert</type>
            </actions>
            <timeLength>3</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
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
        <fullName>Creazione Riparazione Sede - ES%2C GR</fullName>
        <actions>
            <name>Nuova_riparazione_ES_GR</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <booleanFilter>(1 OR 4 OR 5) AND (2 OR 3)</booleanFilter>
        <criteriaItems>
            <field>Dettaglio_Riparazione__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Client Return_To Headquarters Solomeo</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.Nation_Contact_Card__c</field>
            <operation>equals</operation>
            <value>ES</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.Nation_Contact_Card__c</field>
            <operation>equals</operation>
            <value>GR</value>
        </criteriaItems>
        <criteriaItems>
            <field>Dettaglio_Riparazione__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Item from Stock_To Headquarters Solomeo</value>
        </criteriaItems>
        <criteriaItems>
            <field>Dettaglio_Riparazione__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Uniform/Personal Items_To Headquarters Solomeo</value>
        </criteriaItems>
        <description>Invio alert nuova riparazione per Spagna, Grecia</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Creazione Riparazione Sede - GB%2C DK%2C BE%2C AT%2C FR%2C DE</fullName>
        <actions>
            <name>Nuova_riparazione_DK_GB</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <booleanFilter>1 AND (2 OR 3 OR 4 OR 5 OR 6 OR 7 OR 8)</booleanFilter>
        <criteriaItems>
            <field>Dettaglio_Riparazione__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Riparazione - Sede</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.Nation_Contact_Card__c</field>
            <operation>equals</operation>
            <value>DK</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.Nation_Contact_Card__c</field>
            <operation>equals</operation>
            <value>GB</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.Nation_Contact_Card__c</field>
            <operation>equals</operation>
            <value>BE</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.Nation_Contact_Card__c</field>
            <operation>equals</operation>
            <value>NL</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.Nation_Contact_Card__c</field>
            <operation>equals</operation>
            <value>AT</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.Nation_Contact_Card__c</field>
            <operation>equals</operation>
            <value>FR</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.Nation_Contact_Card__c</field>
            <operation>equals</operation>
            <value>DE</value>
        </criteriaItems>
        <description>Invio alert nuova riparazione per Inghilterra, Danimarca, Belgio, Austria, Francia, Germania</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Creazione Riparazione Sede - ITA</fullName>
        <actions>
            <name>Avviso_Nuova_Riparazione_IT_Svizzera</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <booleanFilter>1 AND 2</booleanFilter>
        <criteriaItems>
            <field>Dettaglio_Riparazione__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Riparazione - Sede</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.Nation_Contact_Card__c</field>
            <operation>equals</operation>
            <value>IT</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Creazione Riparazione Sede - Svizzera</fullName>
        <actions>
            <name>Avviso_Nuova_Riparazione_Svizzera</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <booleanFilter>1 AND 2</booleanFilter>
        <criteriaItems>
            <field>Dettaglio_Riparazione__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Riparazione - Sede</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.Country</field>
            <operation>equals</operation>
            <value>CH</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
        <workflowTimeTriggers>
            <offsetFromField>Dettaglio_Riparazione__c.CreatedDate</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
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
        <fullName>Creazione Riparazione Sede Team Riparazioni</fullName>
        <active>false</active>
        <booleanFilter>1 OR 2 OR 3 OR 4 OR 5</booleanFilter>
        <criteriaItems>
            <field>Dettaglio_Riparazione__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Client Return_To Headquarters Solomeo</value>
        </criteriaItems>
        <criteriaItems>
            <field>Dettaglio_Riparazione__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Item from Stock_To Headquarters Solomeo</value>
        </criteriaItems>
        <criteriaItems>
            <field>Dettaglio_Riparazione__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Uniform/Personal Items_To Headquarters Solomeo</value>
        </criteriaItems>
        <criteriaItems>
            <field>Dettaglio_Riparazione__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Repair - Customer Care</value>
        </criteriaItems>
        <criteriaItems>
            <field>Dettaglio_Riparazione__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Riparazione_Sede</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Creazione Riparazione Sede WW</fullName>
        <actions>
            <name>Avviso_Nuova_Riparazione_WW</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR 2 OR 3 OR 4</booleanFilter>
        <criteriaItems>
            <field>Dettaglio_Riparazione__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Riparazione - Sede</value>
        </criteriaItems>
        <criteriaItems>
            <field>Dettaglio_Riparazione__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Riparazione - Customer Care</value>
        </criteriaItems>
        <criteriaItems>
            <field>Dettaglio_Riparazione__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Riparazione Uniform</value>
        </criteriaItems>
        <criteriaItems>
            <field>Dettaglio_Riparazione__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Riparazione Stock</value>
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
        <active>false</active>
        <formula>/*ISCHANGED(Note_Avvenuta_Riconsegna__c) &amp;&amp; NOT(ISBLANK(Note_Avvenuta_Riconsegna__c))*/
true</formula>
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
        <active>false</active>
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
        <active>false</active>
        <formula>AND(  NOT(ISPICKVAL(Status__c, &quot;Riconsegna al cliente effettuata&quot;)), NOT(ISPICKVAL(Status__c, &quot;Chiuso&quot;)),  NOT(ISNULL( Data_Spedizione_da_Solomeo__c )))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Sollecito_chiusura_operazione</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Dettaglio_Riparazione__c.Data_Spedizione_da_Solomeo__c</offsetFromField>
            <timeLength>30</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>Sollecito_chiusura_operazione</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Dettaglio_Riparazione__c.Data_Spedizione_da_Solomeo__c</offsetFromField>
            <timeLength>40</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
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
        <active>false</active>
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
        <active>false</active>
        <formula>ISPICKVAL(Status__c, &quot;Invio capo verso sede&quot;) &amp;&amp; NOT(ISNULL(Data_accettazione_richiesta__c))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Sollecito_invio_verso_sede</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Dettaglio_Riparazione__c.Data_accettazione_richiesta__c</offsetFromField>
            <timeLength>20</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
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
    <rules>
        <fullName>Update Status Capo ricevuto in Boutique</fullName>
        <actions>
            <name>Aggiornamento_Stato_Capo_Ricevuto</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Aggiornamento Status per RT

UNIFORM / PERSONAL ITEM _ TO HEADQUARTER SOLOMEO
ITEM FROM STOCK _ TO HEADQUARTER SOLOMEO</description>
        <formula>AND( OR( RecordType.Name = &apos;Riparazione Stock&apos;, RecordType.Name = &apos;Riparazione Uniform&apos;), ISPICKVAL(Status__c, &quot;Riparazione effettuata&quot;), OR(NOT(ISBLANK(Riparazione_completata_Note__c)), NOT(ISBLANK(TEXT(Prodotto_riparato__c)))) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Status Chiuso</fullName>
        <actions>
            <name>Close_Dettaglio_Riparazione</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Aggiorna lo status in chiuso dopo inserimento ultimi key field per tutti i RT</description>
        <formula>OR(
AND(
ISCHANGED(Note_Avvenuta_Riconsegna__c),
NOT(ISBLANK(TEXT(Note_Avvenuta_Riconsegna__c))),
RecordType.Name &lt;&gt; &apos;Riparazione Boutique - External Service&apos;,
RecordType.Name &lt;&gt; &apos;Item from Stock_External Service&apos;,
RecordType.Name &lt;&gt; &apos;Item from Stock_In Boutique (Tailor)&apos;,
RecordType.Name &lt;&gt; &apos;Riparazione Stock&apos;,
RecordType.Name &lt;&gt; &apos;Riparazione Uniform&apos;,
RecordType.Name &lt;&gt; &apos;Uniform/Personal Item_In Boutique (Tailor)&apos;,
RecordType.Name &lt;&gt; &apos;Uniform/Personal Item_External Service&apos;
),
/* Riparazioni Stock e Uniform */
AND(
OR(
RecordType.Name = &apos;Riparazione Stock&apos;,
RecordType.Name = &apos;Riparazione Uniform&apos;),
ISPICKVAL(Status__c, &quot;Capo ricevuto in Boutique&quot;),
OR(NOT(ISBLANK(TEXT(Ritirato__c))),
NOT(ISBLANK(TEXT(Prodotto_caricato_a_stock__c))))),
/* Riparazione External Service */
AND(
RecordType.Name = &apos;Riparazione Boutique - External Service&apos;,
NOT(ISBLANK(TEXT(Note_Avvenuta_Riconsegna__c))),
NOT(ISBLANK(Costo__c)),
NOT(ISBLANK(TEXT(CurrencyIsoCode))),
NOT(ISBLANK(Fornitore__c))
),
/* Item from Stock_In Boutique (Tailor) */
AND(
RecordType.Name = &apos;Item from Stock_In Boutique (Tailor)&apos;,
ISCHANGED(Prodotto_caricato_a_stock__c),
NOT(ISBLANK(TEXT(Prodotto_caricato_a_stock__c)))),
/* Item from Stock_External Service */
AND(
RecordType.Name = &apos;Item from Stock_External Service&apos;,
ISCHANGED(Prodotto_caricato_a_stock__c),
NOT(ISBLANK(TEXT(Prodotto_caricato_a_stock__c))),
NOT(ISBLANK(Costo__c)),
NOT(ISBLANK(TEXT(CurrencyIsoCode))),
NOT(ISBLANK(Fornitore__c))),
/* Uniform/Personal Item_In Boutique (Tailor) */
AND(
RecordType.Name = &apos;Uniform/Personal Item_In Boutique (Tailor)&apos;,
NOT(ISBLANK(TEXT(Note_Avvenuta_Riconsegna__c))),
NOT(ISBLANK(TEXT(Ritirato__c)))),
/* Uniform/Personal Item_External Service */
AND(
RecordType.Name = &apos;Uniform/Personal Item_External Service&apos;,
NOT(ISBLANK(TEXT(Note_Avvenuta_Riconsegna__c))),
NOT(ISBLANK(TEXT(Ritirato__c))),
NOT(ISBLANK(Fornitore__c)),
NOT(ISBLANK(TEXT(CurrencyIsoCode))),
NOT(ISBLANK(Fornitore__c)))
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Status Cliente contattato</fullName>
        <actions>
            <name>Status_Repaired_Product_Shipped</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Aggiornamento status per RT

CLIENT RETURN _ TO HEADQUARTER SOLOMEO
Repair Customer Care</description>
        <formula>AND( OR( RecordType.DeveloperName = &quot;Riparazione_Sede&quot;,  RecordType.DeveloperName = &quot;Riparazione_Customer_Care&quot;),  ISCHANGED(Riparazione_completata_Note__c ), NOT(ISBLANK(Riparazione_completata_Note__c )))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Status Invio verso sede</fullName>
        <actions>
            <name>Stato_inviato_verso_sede</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Aggiornamento status per RT

CLIENT RETURN _ TO HEADQUARTER SOLOMEO
Repair Customer Care
UNIFORM / PERSONAL ITEM _ TO HEADQUARTER SOLOMEO
ITEM FROM STOCK _ TO HEADQUARTER SOLOMEO</description>
        <formula>AND (OR( RecordType.DeveloperName = &quot;Riparazione_Sede&quot;,  RecordType.DeveloperName = &quot;Riparazione_Customer_Care&quot;, RecordType.DeveloperName = &quot;Riparazione_Stock&quot;, RecordType.DeveloperName = &quot;Riparazione_Uniform&quot;),  ISCHANGED( Numero_Autorizzazione_Sede__c ),  !ISBLANK(Numero_Autorizzazione_Sede__c ))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Status Prodotto consegnato al cliente</fullName>
        <actions>
            <name>Customer_contacted</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Dopo inserimento Data ritiro prevista cliente inserita per RT

CLIENT RETURN _ TO HEADQUARTER SOLOMEO
Repair Customer Care</description>
        <formula>AND (OR( RecordType.DeveloperName = &quot;Riparazione_Sede&quot;,  RecordType.DeveloperName = &quot;Riparazione_Customer_Care&quot;),  ISCHANGED( Data_ritiro_prevista_cliente__c ),  !ISBLANK(Data_ritiro_prevista_cliente__c ))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Status Prodotto consegnato clt Tailor - External</fullName>
        <actions>
            <name>Status_capo_riconsegnato_a_cliente</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Aggiornamento status Prodotto consegnato al cliente per RT

Client Return _ IN BOUTIQUE (TAILOR)
Client Return _ LOCAL EXTERNAL SERVICE</description>
        <formula>AND(  NOT(ISNULL(Data_ritiro_prevista_cliente__c)), ISPICKVAL(Status__c, &quot;Cliente contattato&quot;),  OR( RecordType.Name = &apos;Riparazione Boutique - External Service&apos;, RecordType.Name = &apos;Riparazione Boutique - Tailor&apos; ))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Status Prodotto riconsegnato</fullName>
        <actions>
            <name>Aggiornamento_Prodotto_consegnato</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Aggiornamento status per RT:

Uniform/Personal Item _ LOCAL EXTERNAL SERVICE</description>
        <formula>AND( RecordType.Name = &apos;Uniform/Personal Item_External Service&apos;, NOT(ISBLANK(TEXT(Prodotto_riparato__c))), ISPICKVAL(Status__c, &quot;Prodotto in Riparazione&quot;), NOT(ISBLANK(Riparazione_completata_Note__c)) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Status Prodotto riconsegnato in Boutique</fullName>
        <actions>
            <name>Aggiornamento_Prodotto_riconsegnato</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Aggiornamento status per RT

Item from Stock _ LOCAL EXTERNAL SERVICE</description>
        <formula>AND( RecordType.Name = &apos;Item from Stock_External Service&apos;, NOT(ISBLANK(TEXT(Prodotto_riparato__c))), ISPICKVAL(Status__c, &quot;Prodotto in Riparazione&quot;), NOT(ISBLANK(Riparazione_completata_Note__c)) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Status Prodotto riparato</fullName>
        <actions>
            <name>Aggiornamento_Prodotto_Riparato</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Aggiornamento status per RT

Item from Stock _ IN BOUTIQUE (TAILOR)
Uniform/Personal Item _ IN BOUTIQUE (TAILOR)</description>
        <formula>AND(OR(  RecordType.Name = &apos;Uniform/Personal Item_In Boutique (Tailor)&apos;,  RecordType.Name = &apos;Item from Stock_In Boutique (Tailor)&apos;),   NOT(ISBLANK(TEXT(Prodotto_riparato__c))), ISPICKVAL(Status__c, &quot;Prodotto in Riparazione&quot;),  NOT(ISBLANK(Riparazione_completata_Note__c)) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Valorizza Data Contatto Cliente</fullName>
        <actions>
            <name>Data_contatto_cliente</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>WF per il calcolo del campo Data contatto cliente e del contatore
Durata Processo Riparazione (giorni)</description>
        <formula>OR(
ISPICKVAL(Status__c, &quot;Cliente Contattato&quot;),
ISPICKVAL(Status__c, &quot;Capo ricevuto in Boutique&quot;),
ISPICKVAL(Status__c, &quot;Prodotto Riparato&quot;),
ISPICKVAL(Status__c, &quot;Prodotto riconsegnato in Boutique&quot;),
ISPICKVAL(Status__c, &quot;Prodotto riconsegnato&quot;)
)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
