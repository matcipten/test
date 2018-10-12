public with sharing class OnAccountTriggerHandler {
    
    public static Set<Id> SetOfIDs = new Set<Id>();

    public static void CreateSlaveAssociation(list<Account> oldAccount){
 
        set<string> AccountIds                  = new set<string>();
        map<string, Account> MapAccount         = new map<string, Account>();
        list<Slave_Data__c> ListSlave           = new list<Slave_Data__c>();
        list<Map_Slave__c> ListMapSlaveToDelete = new list<Map_Slave__c>();
        set<string> MasterAccountIds            = new set<string>();
        
        
        // Ciclo tutte le anagrafiche cancellate      
        for(Account a:oldAccount){
            // Popolo un set di id da utilizzare come filtro nella query per recuperare i master record
            AccountIds.add(a.id);
            // Popolo la mappa con i dati delle anagrafiche cancellate
            MapAccount.put(a.id,a);
        
        }
        // Query per recuprerare gli id delle anagrafiche a partire 
        // dall'oggetto Map_Slave__c che la deduplica a correlato ai master
        list<Map_Slave__c> listMapSlave = [ select  Id_Account__c, 
                                                    Account__c 
                                            from Map_Slave__c 
                                            where Id_Account__c IN:AccountIds];

        for(Map_Slave__c m:listMapSlave){
        
            if(MapAccount.containsKey(m.Id_Account__c)){
                // Creo il nuovo record con i dati dello slave correlato al master
                Slave_Data__c sd                        = new Slave_Data__c();
                sd.Account__c                           = m.Account__c;
                sd.Name                                 = (MapAccount.get(m.Id_Account__c).FirstName + ' ' + MapAccount.get(m.Id_Account__c).LastName).left(80);
                sd.Id_Cliente_xStore__c                 = MapAccount.get(m.Id_Account__c).Id_Cliente_xStore__c;
                sd.Id_Cliente_Relate__c                 = MapAccount.get(m.Id_Account__c).Id_Cliente_Relate__c;
                sd.Id_Cliente__c                        = MapAccount.get(m.Id_Account__c).Id_Cliente__c;
                sd.Id_Cliente_DW__c                     = MapAccount.get(m.Id_Account__c).Id_Cliente_DW__c;
                sd.Id_Cliente_Salesforce__c             = MapAccount.get(m.Id_Account__c).Id_Cliente_Salesforce__c;
                sd.FirstName__c                         = MapAccount.get(m.Id_Account__c).FirstName;
                sd.LastName__c                          = MapAccount.get(m.Id_Account__c).LastName;
                sd.Nome_UTF_8__c                        = MapAccount.get(m.Id_Account__c).Nome_UTF_8__c;
                sd.Cognome_UTF_8__c                     = MapAccount.get(m.Id_Account__c).Cognome_UTF_8__c;
                sd.PersonMailingCountry__c              = MapAccount.get(m.Id_Account__c).PersonMailingCountry;
                sd.PersonMailingStreet__c               = MapAccount.get(m.Id_Account__c).PersonMailingStreet;
                sd.PersonMailingPostalCode__c           = MapAccount.get(m.Id_Account__c).PersonMailingPostalCode;
                sd.PersonMailingCity__c                 = MapAccount.get(m.Id_Account__c).PersonMailingCity;
                sd.PersonMailingState__c                = MapAccount.get(m.Id_Account__c).PersonMailingState;
                sd.ShippingCountry__c                   = MapAccount.get(m.Id_Account__c).ShippingCountry;
                sd.ShippingStreet__c                    = MapAccount.get(m.Id_Account__c).ShippingStreet;
                sd.ShippingPostalCode__c                = MapAccount.get(m.Id_Account__c).ShippingPostalCode;
                sd.ShippingCity__c                      = MapAccount.get(m.Id_Account__c).ShippingCity;
                sd.ShippingState__c                     = MapAccount.get(m.Id_Account__c).ShippingState;
                sd.Citta_UTF_8__c                       = MapAccount.get(m.Id_Account__c).Citta_UTF_8__c;
                sd.Indirizzo_UTF_8__c                   = MapAccount.get(m.Id_Account__c).Indirizzo_UTF_8__c;
                sd.Natura_Giuridica__c                  = MapAccount.get(m.Id_Account__c).Natura_Giuridica__c;
                sd.PersonBirthdate__c                   = MapAccount.get(m.Id_Account__c).PersonBirthdate;
                sd.Nazionalita__c                       = MapAccount.get(m.Id_Account__c).Nazionalita__c;
                sd.Data_Di_Registrazione__c             = MapAccount.get(m.Id_Account__c).Data_Di_Registrazione__c;
                sd.Data_Annullamento__c                 = MapAccount.get(m.Id_Account__c).Data_Annullamento__c;
                sd.Data_Registrazione_Newsletter__c     = MapAccount.get(m.Id_Account__c).Data_Registrazione_Newsletter__c;
                sd.Data_Cancellazione_Newsletter__c     = MapAccount.get(m.Id_Account__c).Data_Cancellazione_Newsletter__c;
                sd.PersonEmail__c                       = MapAccount.get(m.Id_Account__c).PersonEmail;
                sd.Email_Ecommerce__c                   = MapAccount.get(m.Id_Account__c).Email_Ecommerce__c;
                sd.Phone__c                             = MapAccount.get(m.Id_Account__c).Phone;
                sd.PersonOtherPhone__c                  = MapAccount.get(m.Id_Account__c).PersonOtherPhone;
                sd.PersonMobilePhone__c                 = MapAccount.get(m.Id_Account__c).PersonMobilePhone;
                sd.Fax__c                               = MapAccount.get(m.Id_Account__c).Fax;
                sd.Categoria_Cliente__c                 = MapAccount.get(m.Id_Account__c).Categoria_Cliente__c;
                sd.Sesso__c                             = MapAccount.get(m.Id_Account__c).Sesso__c;
                sd.Fascia_Di_Eta__c                     = MapAccount.get(m.Id_Account__c).Fascia_Di_Eta__c;
                sd.Id_Location__c                       = MapAccount.get(m.Id_Account__c).Id_Location__c;
                sd.Professione__c                       = MapAccount.get(m.Id_Account__c).Professione__c;
                sd.Id_Associate__c                      = MapAccount.get(m.Id_Account__c).Id_Associate__c;              
                sd.Cellulare__c                         = MapAccount.get(m.Id_Account__c).Cellulare__c;
                sd.Email__c                             = MapAccount.get(m.Id_Account__c).Email__c;
                sd.Newsletter__c                        = MapAccount.get(m.Id_Account__c).Newsletter__c;
                sd.Preferenza_newsletter__c             = MapAccount.get(m.Id_Account__c).Preferenza_newsletter__c;
                sd.Privacy_1__c                         = MapAccount.get(m.Id_Account__c).Privacy_1__c;
                sd.Telefono__c                          = MapAccount.get(m.Id_Account__c).Telefono__c;
                sd.Telefono_Lavoro__c                   = MapAccount.get(m.Id_Account__c).Telefono_Lavoro__c;
                sd.Country_Newsletter__c                = MapAccount.get(m.Id_Account__c).Country_Newsletter__c;                
                sd.Master_Slave__c                      = MapAccount.get(m.Id_Account__c).Master_Slave__c;
                
                ListSlave.add(sd);
                ListMapSlaveToDelete.add(m);                
                MasterAccountIds.add(m.Account__c);
            
            }
        
        }
        
        system.debug('SV');
       
        if(ListSlave.size()>0){         
            // inserisco i dati degli slave
            insert ListSlave;
        
        }
      
        if(ListMapSlaveToDelete.size()>0){          
            // Cancello i record di Map_Slave__c che non servono in quanto 
            // l'anagrafica slave è stata cancellata a fronte del merge
            delete ListMapSlaveToDelete;
        
        }   
        
    }

    public static void CreateSlaveMap(list<Account> newAccount){
 
        list<Map_Slave__c> ListMapSlave = new list<Map_Slave__c>();
               
        for(Account a:newAccount){
            // creo per ogni nuova anagrafica il corrispettivo record 
            // Map_Slave__c che verrà utilizzato a fronte di una deduplica
            Map_Slave__c ms     = new Map_Slave__c();
            ms.Name             = a.Id;
            ms.Account__c       = a.Id;
            ms.Id_Account__c    = a.Id;
                    
            ListMapSlave.add(ms);
        
        }

        if(ListMapSlave.size()>0){          
        
            insert ListMapSlave;
        
        }

    }

    @future(Callout=true)
    public static void sendRequestToRelate(Set<Id> accountId, String status, String stroldMap){
        
        system.debug('DEBUG@ IS accountId: ' + accountId);
        
        Map<String, SObject> oldMap = new Map<String, SObject>();
        if(stroldMap != null){
            oldMap = (Map<String, SObject>)
                JSON.deserialize(stroldMap, Map<String, SObject>.class);
        }
        
        system.debug('DEBUG@ IS oldMap: ' + oldMap);
        
        boolean IsSandbox;
        
        User user = [SELECT id, Codice_Boutique__c, Codice_Associate__c, FirstName, LastName, Alias FROM User WHERE Id=:UserInfo.getUserId()];
        
        List<organization> lstOrganization = [Select id,instanceName,isSandbox from Organization];
        if(lstOrganization.size()>0) {
            if(lstOrganization[0].isSandbox) {
                system.debug('DEBUG@ IS SANDBOX');
                IsSandbox = true;
            } else {
                system.debug('DEBUG@ IS PRODUCTION');
                IsSandbox = false;
            }
        }
                
        List<Account> newAccount = new List<Account>();
        for(String id : accountId){
            newAccount.add((Account)GenericDao.getAllFieldsResultById('Account', 'Id', id));
        }
                
        //ToDo set acc --> Account
        for (Account acc : newAccount){

            system.debug('DEBUG@ REQUEST ACC: ' + acc);
            system.debug('DEBUG@ REQUEST XML ACC ID: ' + acc.Id);
            
            Web_Service_Log__c relateResponse = new Web_Service_Log__c();
            relateResponse.Timestamp__c = System.now();

            HttpRequest req = new HttpRequest();
            req.setMethod('POST');
            req.setHeader('Content-Type', 'text/xml; charset=UTF-8');
            req.setHeader('SOAPAction', 'blank');

            if(IsSandbox){
                //DEV                
                system.debug('DEBUG@ DEV ENDPOINT');
                req.setEndpoint('https://dev-relate.dev.brunellocucinelli.it:8443/soap/BCG/v2_3/CustomerServices');                
                system.debug('DEBUG@ DEV CERTIFICATE');                
                req.setClientCertificate('' +
                'MIIVGAIBAzCCFN4GCSqGSIb3DQEHAaCCFM8EghTLMIIUxzCCD18GCSqGSIb3DQEH'+
                'BqCCD1Awgg9MAgEAMIIPRQYJKoZIhvcNAQcBMBwGCiqGSIb3DQEMAQYwDgQIruny'+
                '2pErwToCAggAgIIPGO7JS0B8r9pc+rzBnyVfwWS2qH6s0ijqFf5d1LSpeLQIw9gT'+
                'RaPlPwPPDsfX5BTp7DLjOUJeTRdyNDRkyEEp6IwyM3bp1aZ7ObLCIQkb2wpFcL1M'+
                'JbGTH3MzKXH7BZXStG1UfXLmldM2pnRX6aImNHoRNE5oMOo0MNiJpZ5al+KRZD6t'+
                'Fsi+0Oobw84d2dI8m2GN1lwW5eqxC5N6GxDRzvUsCqjdRUkCyBAaFn2BWnUSw8wq'+
                'Cb6mUBD873MG1p4Jvo+oIyUZmEL5KPIEA3Dz3MlmXwGFcAtSsg9w33v3mkLyR22/'+
                'b3DgzEVDmJwgFSbFypgbiaF8a9wPY9+tRKI4zyRDmc/mrvSnFmd+mla8qN6gaS/c'+
                'l62Ud9NP2rn9CPUNrUwRzx4YCE82VmralWZkeWlXb4LydXbIx/RJa/OuwZIgUP9x'+
                '9jkgS0wT/1pIlTVMKVISB860NvVNHGU+yEhScOFT6/QTRFRCGYkVWMBMp3cmf0Dh'+
                'BXefxcYag6mFsVDLLgx2ksrpA/N6LFPpF2iKrCPYF+rPDvkERX29UhoopJ7kQgD5'+
                'GoF0kUmVcYHf7fdSoHfOG8egCxhqjuPSe6bnJYV1UFxX/dnkPKBTO6kZqtYhhyCd'+
                'qACG+Q3Ye+ob8F+NU0nmSQ2KgjSd+xhp6kwe2pWojpK1VCV5CmHIyolMvQlGn5CT'+
                'udUer5U3PnxPwe9+dvJI++LvhagKlNMoRukpVwu7xmEXU0PoEgOIptLeuIGB6VU/'+
                'T/dk1G3yJ9EdLgwXlkgo88FY69p/cyaVFakatkKIrlWkrKIGWn4GVle1ofWhFYvC'+
                '0G059jtoszvQoagJ9xaiSS/okrKNnQphLM9WkAIJx4CBb01NSiHqYI1ZDlx2E3JS'+
                'jgB9FPhpZ/1GSY+LlmW3RByAuFz79OP6JxaX9ttYckimh3XLSWu0CPV3UqzpNylU'+
                'LXFl30JIh3GWPUY4KTBdjljBKys3IISFIp6f8MSJLXw4Jo0FxWqXfgMq10W01Evb'+
                '78H5EN3OCuxn8afZNACn8Q6SM8LOpWZEl9RYIg5mtTmugvXg3s0MLqZJ9bdFSyRg'+
                'YBG77IenLp/WBCzxFK5VXv/hMWKjUjxRuH0toI00tGnF4l2f4k6+VgImI6Ej5bRt'+
                'xSlGBhDPNAX6fFwOBN5hQz+tMHrxuHd4PR4hO4CJhsUCRGbeF/s/aOvtqrkhbt7S'+
                'KdvWQT+jaZALzxtTA4lkv9WGnGAjK0Ip6fjJ+rfAcEinQVqTCPeVQmxO6ujim47S'+
                'Qz06W31i5Mzk48+fd2+kwQ0Y07nGQVRxyRUjHbzgiXXfojDNHyzfP10FfW2HW1u1'+
                '9QwrDVdR4Dd1uGcYGsodVlJLV3duqnObczqJFctuBeXRUXoBtVgTjakeglK3f7ZR'+
                'DjkOtAY8Dnw7TzvCOArqKCJoHedfIpXhnsww0oKrVGWlmB9pd+NTFvL7b3FI1oVI'+
                'YyVApAuI3i25T45Qg1BljmuVZKmSLLSiJPuo/g0KyUuM5/BH3OIbmVLJSXH8T9sM'+
                'gNsa6WMkUUyV6NGVptgnQZOeKi7M7L2x8eQN6apqYYdwlhNwFc5FuwwCJFtFJy/Y'+
                'f8V5GX0J2MZEzpQGiRmpmu6Kk7qb91HjNDyW/Cx+E1ipRJT2eX9aKRxYvQdsNIcG'+
                'l0zsDDnTuTns1BUsuAVZZzU5k1d1M77eeRy1lE9Pjdd3ra/OrxoO5kmH0DsYvtWQ'+
                'lFIDG9MLqds814Ie5z0Jt2gpLQT1NyXzJ5e/JnHxINTFkqWGIt1EKvHnEiOJYpoM'+
                'InUZraR6rzpHg1ByJqSsYD9zSpp87bmz5p8N91yGpWPKiV5nPdA/CGISyPDbi0bW'+
                'CX5oVJfjWDSmDKAG85qjMry4U92LWNN6hO7rGU7aGkfZJY8JCnCT9TZiGOnYc99m'+
                'tvq/W8xbErdxTvtvsYSHzhJ/WUcBCS8Cmd7nPtspO5j8UQUhyv/TnPWlkE/H/LKk'+
                'DwQ/r97cMiIDT7LAekAkLWXSpspjrvFrsh0EJh6+h5t02y1akFEHJHPD/DbHeICi'+
                'vQFahFpyRn5ymonMEHT6iNmPNCfWQcpMOSU0eUbvttVkMsHHq2CKwnOwnfXDRzl+'+
                'gztf46Q4QpuOlD8RwoLEuiL9dyqA1jLkGMcDumiac4QClYvDGuhgV+xRgNQe6RX1'+
                'AgJVkoN2cHWSKa4EWrc8W+lajjZF6nNIzZgtxS0Va3+n1l38NqN8lcEFu2vV+djp'+
                'rFChIi5MyoEfbXnykW0y62EDurOjFY+bm6b7QABY/UitkLUeZrEBoYtvnfpC4Dbd'+
                'FY+fhGbNbPVEimBXQUsvsmYnojBOL8TZU8+Li4yXMhKQKBzALwsde7rGqOATsb3G'+
                'VgD5UrSyZy5TG4NPA4XgKXaw7pd7PiO0VeR9v6lobBAQqBmxJk64JkwEv6h75MOm'+
                '09RB6jUMdPrvrGYyAhRFMy5sfKu/bVKHR/BjCy2Oap1qWMPZrcar73vM+Vo1mMu2'+
                'Kjak0f94+T0z4kzGS6x9uVAWAwZdMlE0GinKDs5HLR0VD5wV4onByGO1cYOD5zO/'+
                '7UAvWc+b4DMR1aSFgJPTo1qUYvhQdlPQsE0DDHDw7eq8vxlxWin91KVlTejR0xQ/'+
                '8pMevCrqNkdiTjNSAHis2KuQ/xrQTIcWPX41cr5F2M1/u0X7DoP+0Xt+iDEW+LtL'+
                'Vlx87qhZ4/iFSk6X3HNTlKAqHrR6/TEfsi9nnauUcK0iQuEi8ZHizcnw/yxCkY21'+
                '+g06OJ2VeNCZuoc2ALqCCgnw6YNFuViUJYD7u7f7tZdQAs8qghNQHk+615oxcmlf'+
                'pqiBBtNLn6ou5MhemUIGOMfHYgJXL34V/yLWlcxkyCjvw+7pvatVSt6DwoqV5IPW'+
                'KpzbrDV76HBoLrCd07U9sRqrL3i3ODs6gdEyCxZq/5fqplvY8VJcdgRkBXh+dx6s'+
                'K6brjCFWjHmztjQQpMcA+B94OsVSyNo7HCYeQ+JSfv+wBetJK8AN2egETA6EHMmf'+
                '7lUy3v6yBGrGYyurse/cPmVO453xzmE8NPROzYo2HCYOke0mkW3SjX3Mn9VfChOi'+
                '+P3P/50KxM26a35Wp58FhZIVfIQuzON1IPv4qK8CNO/yX+dhPmehEzR6YgMoVcm9'+
                'vFntmenNnf041HUYXAKbKerwf3ppL1OhRqgoqh6P12zxF3+wAuw1Tl7iACZdPh6w'+
                'oc8lteREZN3IcZ+fyyzWqoSdli3l+NpAkKCSE9ONt+KK5/5acaOnZLzwLUkrAoE6'+
                'fpgpSE5EP17AKOlRLUgLIOejBsYeF+umnkGJc1oaZFAcIPZNFJqdStQLUMj/UaD4'+
                'U5D6/DbYv6lHRXKhq6nqvZlSTViilu49vEdWbVjJldNqTyifWZnTUdaTyE4sP3hg'+
                'InnaQ6kXDJkYjMM6O5seqBwM1obfDgaHeBooMRE3TG405b7ufOC+JJm46RPnSdfe'+
                '77qjETW4bjKO7zJSNPJowbU1ZiYnODMHkeOe5J+mYnW7qUv/gZRFY6WPOMR+JOsU'+
                'a2Uv8bi/MLV3n2VnckMcBP1XpnBRClL+AsSrMKVB7FdSvnDiTRMllQqcWvYooywz'+
                'y3URtF8m53v5kHqZZef53fWHjIIUPzQm88t3j43FK925GGENb6LaML3VrrtxNQU3'+
                'XUBVI2w8s8Ly6sdqmnf188PlWwz6PAgLfDQIMsOLfvyaZ4Ax9+bJHqCZ2VPSkPFf'+
                'dyTSDl5inkq4TKXlq81UGtaX8kJPEHPFFLnYLm2PCRwwAvdWWWgDUxkI+wxu0MD3'+
                '2SzFZrf/oBAbHW77ba9qwc+QMR95suV/3tRarbLcZvzwNT0F4WNaO+B7pK/VFf+d'+
                't2KDLZvyJCNNAksCbzCQAoUa2SQMMDLJrEZ4H2K2cGSLHlGI9KZ5xo4nfn5zj2bq'+
                'tuboe3DTfCunRmZSWrMXr+Gcws5bofOn1sau15ITGbf4uvVvc6GI3Q97LPEIh3rm'+
                'KHe+uo1LeTVZwZ16DqMclrFSNYD9/obntKJBQI2j7uzFf/YanafbFoCQcjDWedFJ'+
                'X9onW460uQmBOgJlqC34XvsD3MNkEdFgksQ1Y+t/w2VNv2hn9AYihBBKuZpe6AFi'+
                'AUTew/neBMHAELHuPMGNFi3o4yQ7Y6rVYBTGRvCxOqIFxOw1TMbAN8tUA9jSZx4u'+
                'hk7lZMV4svF8DFAof4vXGBG52YhV8G1wmagdcYduu8wWk7gc3O+QAAk8LVKWItQP'+
                'N9CjuXWlKSpJhkTGaNXdo0/lk4Ey+GEyowMqR0kNBS+ZFUiLy+vAs0KSwGxIGwcS'+
                'EV4fp7Z4gYnCv/Gl+YN3NXgvIz5WRE156cp5zaCzKHkkGux1hvFdTlM3OOToyEWq'+
                's6K50o8xgWKGlWZAwfqu+8mif2PFIAb18S67KdjCv1yVAz2arCFB+LHm6xCdFIeh'+
                'juZy2oSFTauQcoebSSI3ebXk0O9OsZi86J+qeFZmNoH9ht544JxLBJvtD6oW3rZe'+
                'sqiAIdatnxzhnSEeT+MkEPgejNEECr/O43HotlwT1VbS5PY7ZzV33gcIBfXety0j'+
                'tQOuN0MRQBJupiOmRvLNIauBqRodf0L5tRPO7OqX4qCvrTmU4sNIKOwMxjIbiPIJ'+
                'hw8sSli9fqgG2lS5AmawSFVuZP6ihvyso9Twpfa5sKpJ1R/bnUnCIdAEh3zfuaj6'+
                'V8ghGoYEZ+ooPgjevm/zN4GvJuhb8uKNJOjBGNdfR1YIv45a3KCO7V/1FQJiYHhP'+
                'qenQ0X2dM7G4C27A0sKSP2qz/a9qD56k6NNzgRYNZM/+B/A09JtdLdzT76FawTrF'+
                'WOzVqzgguzlslBwU8CNtN08/vbI1b2Zn5aQgU5eqyMWDb25tUktSFpQfP/1VA5OB'+
                'yLEP0wC6nbjBNGLMOSVYGbklAyH5uQqfE6XRoKRJqIze+fwBSjEUmd0u7iUOOFLu'+
                '85aES8SxD7gNul4aBkwvPlp5xD1MO4xVoZEhnMPNz9u4JWBrYZqIE2Tv8rp/SKVl'+
                'SNmEyY2OWgvDDnIlg6mCfBR0hW2mcHJ2kghXhPCHBeOrCwpO59HmbYqQdzR4KO4E'+
                'u+99b5SRt5mD0I4Fppuxl2bmPi7hSjeKCh1ZYfPR9+Tsi/wI2M+xfROZHmz1r2As'+
                'jsmEPGyn/EaZ78uQgyr4rbvJvR7bhx4Td7dmaeSJXyUAa/9/dzCCBWAGCSqGSIb3'+
                'DQEHAaCCBVEEggVNMIIFSTCCBUUGCyqGSIb3DQEMCgECoIIE7jCCBOowHAYKKoZI'+
                'hvcNAQwBAzAOBAhXxmarRCliQwICCAAEggTIwZTcUxpJvHVJCHfh3TcF+HUEk06p'+
                'RE+pXZTIiKqJ13xTUXC20HvbqZNm4DWFJ4edWswj3AElhKMVa5UBgrraU1pZdKAi'+
                '20nWyOTI2hlvNMaHQHIM0tWK2IYE0wPt8QrpH332DcYBLnTMhUITGdx/IpvCvPFF'+
                'FmeANCkB+/wnNvX6/1I8wqWvSzYSfJVUui+F2xKn0Ln1Bc6vvMbGPlh2z3M/9nKX'+
                'Iw+44BUZmzxYWeJPETRFUBf4mjg+H0M3gVWabugBj24eBrxrUyaOSvj+yKv8gTy7'+
                'aRrai/xr1ldvoMAXqBa8KUjggoDGSyTxDg7ZrUGXsoPvKCjCZq+M7xe8azHEMPX6'+
                '3vZvTav7rqu+Y9kjvY4ij5kqEVqVa8K1yjD1KGzmyq93romyFpy1OVAyzl/8zTfF'+
                'Aee+S99vML1xQs+tLOpS7bpwiITlfq63zrLj8ua9pdSz1ZQpjxAgItzTeQ7BWtEc'+
                'GC9JCLr7sYuT2o876/93AKOhIU1UeFrxi0ioaf9worwj4v5WSF93HpIgLrY4D1EY'+
                'Dipp7LdZfLG4G/mftQLfNhLu7Vqr5uVZfFP6XdVeUUUUf7yZ2dTohOVnZZFx29A7'+
                'Pa2Gj8I6H1fzgF6s0LrPVKzTShMXECXAssEgvNSE7Ppk3pm9jTQF9von1OXnZg5z'+
                'gm97Zmq80+B8gQyui7Gd2KOlFNvs2zpZjCexPNpg4tdKPJySs/lUhYn2bHLmPhu+'+
                'NQQzSFY1c08efiHWmWJ1jJ8dSGAvbu1AuWe9kzaLGprQE8yBhAF9vwO+NLELDuib'+
                'Xw/vxnzxEBAFYRxQF8REb6i8nU4LplaSeT/sq18kTaJ+bFUoldsk7qEc2iqNoalN'+
                'qShFcZNbsVEHf+6jZZNwY+4QaajuR41fL5wgMUTHuhlRcQ+/iTUuwLUXwkU9+A/I'+
                'RFA06EuAa5Cgyux6oj+OiCxB2JgCgtJ7X4+idGbhEMKR5Vd2VnaqtE+ZUM1v4gkp'+
                'wsIlYqNvmzakuw285N2MJ9vgOeL7gy1Ez9EtZO7kY3L3goD0EPqftUnlhHKmb7au'+
                's1FVPIgMU102Lsjd0NpPpa2otpf2w22+yb+Upb6zTDdtB9s4ItTPOajfmtpTQEPq'+
                'YDZOBLsp6S7OdqEJsfaGcgQZ2ZR1jajh4aH45wmu737BBLR53FTYFR31btBZB7dm'+
                'FPqHjNJioP6Vo995J2nqANaZSRkeRY1nPSYpODGwWn+4aMk+4XwFS4zyh0IjZTaP'+
                'egvpuuSQWy2+dRrlmKm8xWUXkOiZBK9IaZc54a/OGUMXkDkisJct+4kci0IiJf6U'+
                'JmZT+Ra1mHM29+v+XF3zwCSuwtM0rcOQJkH+O9VYrO9m6juM36o0cBvLUb/KX/iL'+
                'inH6x7fYxJfa4IHGyyVUirY/tRytPJKCHkpEApneSt9P1+SQUBrjlQUa/UL7+em4'+
                '6R5m+JxdCNsoyjDSbYWhGns963jpbYtrtSscaqSzLBSoEmCZHMtQxs69Loa4zPVl'+
                'gJs3zsjjU+w2uVRNue9Z7lmnZHsYHOV0APal0x9+yPUWth7l0cjtYuHFLstIyKBr'+
                '9WMH2MPBtmEtggEIpScF8w7+QgaV0EUggbHPkYs9Se+rYLvxfKepm8gUNFFd+d0w'+
                'mpZxMUQwHQYJKoZIhvcNAQkUMRAeDgB4AGMAZQBuAHQAZQByMCMGCSqGSIb3DQEJ'+
                'FTEWBBSXSUjmGukTW3e3wPKBxP2q3L8bSTAxMCEwCQYFKw4DAhoFAAQU28NX5p4a'+
                'DE/Ce7MbmGAGGm+H0rMECLPYPA0SCbCEAgIIAA==', 'kstr20140407.srvrlt');
            }
            else{
                //PROD
                system.debug('DEBUG@ PRODUCTION ENDPOINT');
                req.setEndpoint('https://srv-relate.brunellocucinelli.it:8443/soap/BCG/v2_3/CustomerServices');                
                system.debug('DEBUG@ PRODUCTION CERTIFICATE');              
                req.setClientCertificate(
                'MIIVGAIBAzCCFN4GCSqGSIb3DQEHAaCCFM8EghTLMIIUxzCCD18GCSqGSIb3DQEH'+
                'BqCCD1Awgg9MAgEAMIIPRQYJKoZIhvcNAQcBMBwGCiqGSIb3DQEMAQYwDgQIruny'+
                '2pErwToCAggAgIIPGO7JS0B8r9pc+rzBnyVfwWS2qH6s0ijqFf5d1LSpeLQIw9gT'+
                'RaPlPwPPDsfX5BTp7DLjOUJeTRdyNDRkyEEp6IwyM3bp1aZ7ObLCIQkb2wpFcL1M'+
                'JbGTH3MzKXH7BZXStG1UfXLmldM2pnRX6aImNHoRNE5oMOo0MNiJpZ5al+KRZD6t'+
                'Fsi+0Oobw84d2dI8m2GN1lwW5eqxC5N6GxDRzvUsCqjdRUkCyBAaFn2BWnUSw8wq'+
                'Cb6mUBD873MG1p4Jvo+oIyUZmEL5KPIEA3Dz3MlmXwGFcAtSsg9w33v3mkLyR22/'+
                'b3DgzEVDmJwgFSbFypgbiaF8a9wPY9+tRKI4zyRDmc/mrvSnFmd+mla8qN6gaS/c'+
                'l62Ud9NP2rn9CPUNrUwRzx4YCE82VmralWZkeWlXb4LydXbIx/RJa/OuwZIgUP9x'+
                '9jkgS0wT/1pIlTVMKVISB860NvVNHGU+yEhScOFT6/QTRFRCGYkVWMBMp3cmf0Dh'+
                'BXefxcYag6mFsVDLLgx2ksrpA/N6LFPpF2iKrCPYF+rPDvkERX29UhoopJ7kQgD5'+
                'GoF0kUmVcYHf7fdSoHfOG8egCxhqjuPSe6bnJYV1UFxX/dnkPKBTO6kZqtYhhyCd'+
                'qACG+Q3Ye+ob8F+NU0nmSQ2KgjSd+xhp6kwe2pWojpK1VCV5CmHIyolMvQlGn5CT'+
                'udUer5U3PnxPwe9+dvJI++LvhagKlNMoRukpVwu7xmEXU0PoEgOIptLeuIGB6VU/'+
                'T/dk1G3yJ9EdLgwXlkgo88FY69p/cyaVFakatkKIrlWkrKIGWn4GVle1ofWhFYvC'+
                '0G059jtoszvQoagJ9xaiSS/okrKNnQphLM9WkAIJx4CBb01NSiHqYI1ZDlx2E3JS'+
                'jgB9FPhpZ/1GSY+LlmW3RByAuFz79OP6JxaX9ttYckimh3XLSWu0CPV3UqzpNylU'+
                'LXFl30JIh3GWPUY4KTBdjljBKys3IISFIp6f8MSJLXw4Jo0FxWqXfgMq10W01Evb'+
                '78H5EN3OCuxn8afZNACn8Q6SM8LOpWZEl9RYIg5mtTmugvXg3s0MLqZJ9bdFSyRg'+
                'YBG77IenLp/WBCzxFK5VXv/hMWKjUjxRuH0toI00tGnF4l2f4k6+VgImI6Ej5bRt'+
                'xSlGBhDPNAX6fFwOBN5hQz+tMHrxuHd4PR4hO4CJhsUCRGbeF/s/aOvtqrkhbt7S'+
                'KdvWQT+jaZALzxtTA4lkv9WGnGAjK0Ip6fjJ+rfAcEinQVqTCPeVQmxO6ujim47S'+
                'Qz06W31i5Mzk48+fd2+kwQ0Y07nGQVRxyRUjHbzgiXXfojDNHyzfP10FfW2HW1u1'+
                '9QwrDVdR4Dd1uGcYGsodVlJLV3duqnObczqJFctuBeXRUXoBtVgTjakeglK3f7ZR'+
                'DjkOtAY8Dnw7TzvCOArqKCJoHedfIpXhnsww0oKrVGWlmB9pd+NTFvL7b3FI1oVI'+
                'YyVApAuI3i25T45Qg1BljmuVZKmSLLSiJPuo/g0KyUuM5/BH3OIbmVLJSXH8T9sM'+
                'gNsa6WMkUUyV6NGVptgnQZOeKi7M7L2x8eQN6apqYYdwlhNwFc5FuwwCJFtFJy/Y'+
                'f8V5GX0J2MZEzpQGiRmpmu6Kk7qb91HjNDyW/Cx+E1ipRJT2eX9aKRxYvQdsNIcG'+
                'l0zsDDnTuTns1BUsuAVZZzU5k1d1M77eeRy1lE9Pjdd3ra/OrxoO5kmH0DsYvtWQ'+
                'lFIDG9MLqds814Ie5z0Jt2gpLQT1NyXzJ5e/JnHxINTFkqWGIt1EKvHnEiOJYpoM'+
                'InUZraR6rzpHg1ByJqSsYD9zSpp87bmz5p8N91yGpWPKiV5nPdA/CGISyPDbi0bW'+
                'CX5oVJfjWDSmDKAG85qjMry4U92LWNN6hO7rGU7aGkfZJY8JCnCT9TZiGOnYc99m'+
                'tvq/W8xbErdxTvtvsYSHzhJ/WUcBCS8Cmd7nPtspO5j8UQUhyv/TnPWlkE/H/LKk'+
                'DwQ/r97cMiIDT7LAekAkLWXSpspjrvFrsh0EJh6+h5t02y1akFEHJHPD/DbHeICi'+
                'vQFahFpyRn5ymonMEHT6iNmPNCfWQcpMOSU0eUbvttVkMsHHq2CKwnOwnfXDRzl+'+
                'gztf46Q4QpuOlD8RwoLEuiL9dyqA1jLkGMcDumiac4QClYvDGuhgV+xRgNQe6RX1'+
                'AgJVkoN2cHWSKa4EWrc8W+lajjZF6nNIzZgtxS0Va3+n1l38NqN8lcEFu2vV+djp'+
                'rFChIi5MyoEfbXnykW0y62EDurOjFY+bm6b7QABY/UitkLUeZrEBoYtvnfpC4Dbd'+
                'FY+fhGbNbPVEimBXQUsvsmYnojBOL8TZU8+Li4yXMhKQKBzALwsde7rGqOATsb3G'+
                'VgD5UrSyZy5TG4NPA4XgKXaw7pd7PiO0VeR9v6lobBAQqBmxJk64JkwEv6h75MOm'+
                '09RB6jUMdPrvrGYyAhRFMy5sfKu/bVKHR/BjCy2Oap1qWMPZrcar73vM+Vo1mMu2'+
                'Kjak0f94+T0z4kzGS6x9uVAWAwZdMlE0GinKDs5HLR0VD5wV4onByGO1cYOD5zO/'+
                '7UAvWc+b4DMR1aSFgJPTo1qUYvhQdlPQsE0DDHDw7eq8vxlxWin91KVlTejR0xQ/'+
                '8pMevCrqNkdiTjNSAHis2KuQ/xrQTIcWPX41cr5F2M1/u0X7DoP+0Xt+iDEW+LtL'+
                'Vlx87qhZ4/iFSk6X3HNTlKAqHrR6/TEfsi9nnauUcK0iQuEi8ZHizcnw/yxCkY21'+
                '+g06OJ2VeNCZuoc2ALqCCgnw6YNFuViUJYD7u7f7tZdQAs8qghNQHk+615oxcmlf'+
                'pqiBBtNLn6ou5MhemUIGOMfHYgJXL34V/yLWlcxkyCjvw+7pvatVSt6DwoqV5IPW'+
                'KpzbrDV76HBoLrCd07U9sRqrL3i3ODs6gdEyCxZq/5fqplvY8VJcdgRkBXh+dx6s'+
                'K6brjCFWjHmztjQQpMcA+B94OsVSyNo7HCYeQ+JSfv+wBetJK8AN2egETA6EHMmf'+
                '7lUy3v6yBGrGYyurse/cPmVO453xzmE8NPROzYo2HCYOke0mkW3SjX3Mn9VfChOi'+
                '+P3P/50KxM26a35Wp58FhZIVfIQuzON1IPv4qK8CNO/yX+dhPmehEzR6YgMoVcm9'+
                'vFntmenNnf041HUYXAKbKerwf3ppL1OhRqgoqh6P12zxF3+wAuw1Tl7iACZdPh6w'+
                'oc8lteREZN3IcZ+fyyzWqoSdli3l+NpAkKCSE9ONt+KK5/5acaOnZLzwLUkrAoE6'+
                'fpgpSE5EP17AKOlRLUgLIOejBsYeF+umnkGJc1oaZFAcIPZNFJqdStQLUMj/UaD4'+
                'U5D6/DbYv6lHRXKhq6nqvZlSTViilu49vEdWbVjJldNqTyifWZnTUdaTyE4sP3hg'+
                'InnaQ6kXDJkYjMM6O5seqBwM1obfDgaHeBooMRE3TG405b7ufOC+JJm46RPnSdfe'+
                '77qjETW4bjKO7zJSNPJowbU1ZiYnODMHkeOe5J+mYnW7qUv/gZRFY6WPOMR+JOsU'+
                'a2Uv8bi/MLV3n2VnckMcBP1XpnBRClL+AsSrMKVB7FdSvnDiTRMllQqcWvYooywz'+
                'y3URtF8m53v5kHqZZef53fWHjIIUPzQm88t3j43FK925GGENb6LaML3VrrtxNQU3'+
                'XUBVI2w8s8Ly6sdqmnf188PlWwz6PAgLfDQIMsOLfvyaZ4Ax9+bJHqCZ2VPSkPFf'+
                'dyTSDl5inkq4TKXlq81UGtaX8kJPEHPFFLnYLm2PCRwwAvdWWWgDUxkI+wxu0MD3'+
                '2SzFZrf/oBAbHW77ba9qwc+QMR95suV/3tRarbLcZvzwNT0F4WNaO+B7pK/VFf+d'+
                't2KDLZvyJCNNAksCbzCQAoUa2SQMMDLJrEZ4H2K2cGSLHlGI9KZ5xo4nfn5zj2bq'+
                'tuboe3DTfCunRmZSWrMXr+Gcws5bofOn1sau15ITGbf4uvVvc6GI3Q97LPEIh3rm'+
                'KHe+uo1LeTVZwZ16DqMclrFSNYD9/obntKJBQI2j7uzFf/YanafbFoCQcjDWedFJ'+
                'X9onW460uQmBOgJlqC34XvsD3MNkEdFgksQ1Y+t/w2VNv2hn9AYihBBKuZpe6AFi'+
                'AUTew/neBMHAELHuPMGNFi3o4yQ7Y6rVYBTGRvCxOqIFxOw1TMbAN8tUA9jSZx4u'+
                'hk7lZMV4svF8DFAof4vXGBG52YhV8G1wmagdcYduu8wWk7gc3O+QAAk8LVKWItQP'+
                'N9CjuXWlKSpJhkTGaNXdo0/lk4Ey+GEyowMqR0kNBS+ZFUiLy+vAs0KSwGxIGwcS'+
                'EV4fp7Z4gYnCv/Gl+YN3NXgvIz5WRE156cp5zaCzKHkkGux1hvFdTlM3OOToyEWq'+
                's6K50o8xgWKGlWZAwfqu+8mif2PFIAb18S67KdjCv1yVAz2arCFB+LHm6xCdFIeh'+
                'juZy2oSFTauQcoebSSI3ebXk0O9OsZi86J+qeFZmNoH9ht544JxLBJvtD6oW3rZe'+
                'sqiAIdatnxzhnSEeT+MkEPgejNEECr/O43HotlwT1VbS5PY7ZzV33gcIBfXety0j'+
                'tQOuN0MRQBJupiOmRvLNIauBqRodf0L5tRPO7OqX4qCvrTmU4sNIKOwMxjIbiPIJ'+
                'hw8sSli9fqgG2lS5AmawSFVuZP6ihvyso9Twpfa5sKpJ1R/bnUnCIdAEh3zfuaj6'+
                'V8ghGoYEZ+ooPgjevm/zN4GvJuhb8uKNJOjBGNdfR1YIv45a3KCO7V/1FQJiYHhP'+
                'qenQ0X2dM7G4C27A0sKSP2qz/a9qD56k6NNzgRYNZM/+B/A09JtdLdzT76FawTrF'+
                'WOzVqzgguzlslBwU8CNtN08/vbI1b2Zn5aQgU5eqyMWDb25tUktSFpQfP/1VA5OB'+
                'yLEP0wC6nbjBNGLMOSVYGbklAyH5uQqfE6XRoKRJqIze+fwBSjEUmd0u7iUOOFLu'+
                '85aES8SxD7gNul4aBkwvPlp5xD1MO4xVoZEhnMPNz9u4JWBrYZqIE2Tv8rp/SKVl'+
                'SNmEyY2OWgvDDnIlg6mCfBR0hW2mcHJ2kghXhPCHBeOrCwpO59HmbYqQdzR4KO4E'+
                'u+99b5SRt5mD0I4Fppuxl2bmPi7hSjeKCh1ZYfPR9+Tsi/wI2M+xfROZHmz1r2As'+
                'jsmEPGyn/EaZ78uQgyr4rbvJvR7bhx4Td7dmaeSJXyUAa/9/dzCCBWAGCSqGSIb3'+
                'DQEHAaCCBVEEggVNMIIFSTCCBUUGCyqGSIb3DQEMCgECoIIE7jCCBOowHAYKKoZI'+
                'hvcNAQwBAzAOBAhXxmarRCliQwICCAAEggTIwZTcUxpJvHVJCHfh3TcF+HUEk06p'+
                'RE+pXZTIiKqJ13xTUXC20HvbqZNm4DWFJ4edWswj3AElhKMVa5UBgrraU1pZdKAi'+
                '20nWyOTI2hlvNMaHQHIM0tWK2IYE0wPt8QrpH332DcYBLnTMhUITGdx/IpvCvPFF'+
                'FmeANCkB+/wnNvX6/1I8wqWvSzYSfJVUui+F2xKn0Ln1Bc6vvMbGPlh2z3M/9nKX'+
                'Iw+44BUZmzxYWeJPETRFUBf4mjg+H0M3gVWabugBj24eBrxrUyaOSvj+yKv8gTy7'+
                'aRrai/xr1ldvoMAXqBa8KUjggoDGSyTxDg7ZrUGXsoPvKCjCZq+M7xe8azHEMPX6'+
                '3vZvTav7rqu+Y9kjvY4ij5kqEVqVa8K1yjD1KGzmyq93romyFpy1OVAyzl/8zTfF'+
                'Aee+S99vML1xQs+tLOpS7bpwiITlfq63zrLj8ua9pdSz1ZQpjxAgItzTeQ7BWtEc'+
                'GC9JCLr7sYuT2o876/93AKOhIU1UeFrxi0ioaf9worwj4v5WSF93HpIgLrY4D1EY'+
                'Dipp7LdZfLG4G/mftQLfNhLu7Vqr5uVZfFP6XdVeUUUUf7yZ2dTohOVnZZFx29A7'+
                'Pa2Gj8I6H1fzgF6s0LrPVKzTShMXECXAssEgvNSE7Ppk3pm9jTQF9von1OXnZg5z'+
                'gm97Zmq80+B8gQyui7Gd2KOlFNvs2zpZjCexPNpg4tdKPJySs/lUhYn2bHLmPhu+'+
                'NQQzSFY1c08efiHWmWJ1jJ8dSGAvbu1AuWe9kzaLGprQE8yBhAF9vwO+NLELDuib'+
                'Xw/vxnzxEBAFYRxQF8REb6i8nU4LplaSeT/sq18kTaJ+bFUoldsk7qEc2iqNoalN'+
                'qShFcZNbsVEHf+6jZZNwY+4QaajuR41fL5wgMUTHuhlRcQ+/iTUuwLUXwkU9+A/I'+
                'RFA06EuAa5Cgyux6oj+OiCxB2JgCgtJ7X4+idGbhEMKR5Vd2VnaqtE+ZUM1v4gkp'+
                'wsIlYqNvmzakuw285N2MJ9vgOeL7gy1Ez9EtZO7kY3L3goD0EPqftUnlhHKmb7au'+
                's1FVPIgMU102Lsjd0NpPpa2otpf2w22+yb+Upb6zTDdtB9s4ItTPOajfmtpTQEPq'+
                'YDZOBLsp6S7OdqEJsfaGcgQZ2ZR1jajh4aH45wmu737BBLR53FTYFR31btBZB7dm'+
                'FPqHjNJioP6Vo995J2nqANaZSRkeRY1nPSYpODGwWn+4aMk+4XwFS4zyh0IjZTaP'+
                'egvpuuSQWy2+dRrlmKm8xWUXkOiZBK9IaZc54a/OGUMXkDkisJct+4kci0IiJf6U'+
                'JmZT+Ra1mHM29+v+XF3zwCSuwtM0rcOQJkH+O9VYrO9m6juM36o0cBvLUb/KX/iL'+
                'inH6x7fYxJfa4IHGyyVUirY/tRytPJKCHkpEApneSt9P1+SQUBrjlQUa/UL7+em4'+
                '6R5m+JxdCNsoyjDSbYWhGns963jpbYtrtSscaqSzLBSoEmCZHMtQxs69Loa4zPVl'+
                'gJs3zsjjU+w2uVRNue9Z7lmnZHsYHOV0APal0x9+yPUWth7l0cjtYuHFLstIyKBr'+
                '9WMH2MPBtmEtggEIpScF8w7+QgaV0EUggbHPkYs9Se+rYLvxfKepm8gUNFFd+d0w'+
                'mpZxMUQwHQYJKoZIhvcNAQkUMRAeDgB4AGMAZQBuAHQAZQByMCMGCSqGSIb3DQEJ'+
                'FTEWBBSXSUjmGukTW3e3wPKBxP2q3L8bSTAxMCEwCQYFKw4DAhoFAAQU28NX5p4a'+
                'DE/Ce7MbmGAGGm+H0rMECLPYPA0SCbCEAgIIAA==','kstr20140407.srvrlt');
            }

            String IdClienteAS400 = '';
            String IdClientexStore = '';
            String IdClienteRelate = '';
            String AlternateKeyAS400_ID = '';
            String AlternateKeyRelate = '';
            String AlternateKeyXSTORE_ID = '';
            String PersonBirthdate ='';
            String PrimaryHomePhone = 'false';
            String PrimaryMobilePhone = 'false';
            String CurrentUserCode = 'SF';
            String CategoriaCliente = '';
            String AttributeCategoriaCliente = '';
            String CurrentDatePrivacy = '';
               
            if(!string.isEmpty(acc.Id_Cliente__c)){
                IdClienteAS400= acc.Id_Cliente__c;
                AlternateKeyAS400_ID =  '<AlternateKey TypeCode="AS400_ID"><AlternateID>' +
                                        IdClienteAS400 + 
                                        '</AlternateID></AlternateKey>';
            }
           
            if(!string.isEmpty(acc.Id_Cliente_Relate__c)){
                IdClienteRelate= acc.Id_Cliente_Relate__c;
                AlternateKeyRelate = '<AlternateKey TypeCode="XSTORE_CUST_ID"><AlternateID>' + 
                                        IdClienteRelate + 
                                        '</AlternateID></AlternateKey>'; 
            }

            if(!string.isEmpty(acc.Id_Cliente_xStore__c)){
                IdClientexStore= acc.Id_Cliente_xStore__c;
                AlternateKeyXSTORE_ID = '<AlternateKey TypeCode="XSTORE_ID"><AlternateID>' + 
                                        IdClientexStore + 
                                        '</AlternateID></AlternateKey>'; 
            }

            if(!string.isEmpty(acc.Categoria_Cliente__c)){
                CategoriaCliente= acc.Categoria_Cliente__c;
                AttributeCategoriaCliente = '<CustomAttribute name="CUSTOMER_GROUPS">'+
                                                '<AttributeValue>' + CategoriaCliente + '</AttributeValue>'+
                                            '</CustomAttribute>'; 
            }
            
            if(!string.isEmpty(acc.Categoria_Cliente__c)){
                CategoriaCliente= acc.Categoria_Cliente__c;
                AttributeCategoriaCliente = '<CustomAttribute name="CUSTOMER_GROUPS">'+
                                                '<AttributeValue>' + CategoriaCliente + '</AttributeValue>'+
                                            '</CustomAttribute>'; 
            }
            
            if(!string.isEmpty(acc.Phone)){
                PrimaryHomePhone = 'true';
            }
            else if(!string.isEmpty(acc.PersonMobilePhone)){
                PrimaryMobilePhone = 'true';
            }

            /*
            if(!string.isEmpty(user.Codice_Associate__c)){
                CurrentUserCode = user.Codice_Associate__c;
            }
            */
            
            if(acc.Data_Ultimo_Aggiornamento_Privacy__c != null){
                CurrentDatePrivacy = '<CustomAttribute name="LAST_UPDATE">'+
                           '<AttributeValue>' + FormatDateToRelate(acc.Data_Ultimo_Aggiornamento_Privacy__c) + '</AttributeValue>'+
                        '</CustomAttribute>';               
            }
            
            String xml_firstName = (status == 'U') ? setValueForRelate(acc.FirstName, (String)oldMap.get(acc.Id).get('FirstName')) : checkStringValue(acc.FirstName);
            String xml_lastName = (status == 'U') ? setValueForRelate(acc.LastName, (String)oldMap.get(acc.Id).get('LastName')) : checkStringValue(acc.LastName);
            String xml_personMailingStreet = (status == 'U') ? setValueForRelate(acc.PersonMailingStreet, (String)oldMap.get(acc.Id).get('PersonMailingStreet')) : checkStringValue(acc.PersonMailingStreet);
            String xml_personMailingCity = (status == 'U') ? setValueForRelate(acc.PersonMailingCity, (String)oldMap.get(acc.Id).get('PersonMailingCity')) : checkStringValue(acc.PersonMailingCity);
            String xml_personMailingCountry = (status == 'U') ? setValueForRelate(acc.PersonMailingCountry, (String)oldMap.get(acc.Id).get('PersonMailingCountry')) : checkStringValue(acc.PersonMailingCountry);
            String xml_personMailingState = (status == 'U') ? setValueForRelate(acc.PersonMailingState, (String)oldMap.get(acc.Id).get('PersonMailingState')) : checkStringValue(acc.PersonMailingState);
            String xml_personMailingPostalCode = (status == 'U') ? setValueForRelate(acc.PersonMailingPostalCode, (String)oldMap.get(acc.Id).get('PersonMailingPostalCode')) : checkStringValue(acc.PersonMailingPostalCode);
            String xml_personEmail = (status == 'U') ? setValueForRelate(acc.PersonEmail, (String)oldMap.get(acc.Id).get('PersonEmail')) : checkStringValue(acc.PersonEmail);
            String xml_phone = (status == 'U') ? setValueForRelate(acc.Phone, (String)oldMap.get(acc.Id).get('Phone')) : checkStringValue(acc.Phone);
            String xml_personMobilePhone = (status == 'U') ? setValueForRelate(acc.PersonMobilePhone, (String)oldMap.get(acc.Id).get('PersonMobilePhone')) : checkStringValue(acc.PersonMobilePhone);


            system.debug('DEBUG@ Id Cliente AS400: ' + IdClienteAS400);
            system.debug('DEBUG@ Id Cliente Relate: ' + IdClienteRelate);
            system.debug('DEBUG@ Id Cliente xStore: ' + IdClientexStore);
            
            String xml = 
            '<?xml version="1.0" encoding="UTF-8"?>'+
            '<env:Envelope xmlns:env="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">'+
               '<env:Header />'+
               '<env:Body>'+
                 '<m:addOrUpdateCustomer xmlns:m="http://v2_3.customer.webservices.csx.dtv.com/">'+
                     '<customerData>'+
                        '<RetailStoreID>' + checkStringValue(acc.First_ID_Location__c) + '</RetailStoreID>'+
                        '<Instrument />'+
                        '<CustomerID>' + IdClienteRelate + '</CustomerID>'+
                        '<OrgName />'+
                        '<CustOrgTypcode />'+
                        '<EmployeeID />'+
                        '<BusinessName />'+
                        '<CustomerClass />'+
                        '<Source />'+
                        '<Prospect>false</Prospect>'+
                        '<CustomerNumber/>'+
                        '<CustomerReference />'+
                        '<LastUpdateInfo>'+
                           '<UpdateUserID>' + CurrentUserCode + ' - ' + checkStringValue(user.Alias) + '</UpdateUserID>'+
                           '<UpdateDate>' + System.now() + '</UpdateDate>'+
                        '</LastUpdateInfo>'+                
                        '<Affiliation>'+
                            '<RetailStoreID>' + checkStringValue(acc.Id_Location__c) + '</RetailStoreID>'+
                        '</Affiliation>'+                                
                        '<EntityInformation>'+
                           '<Individual>'+
                              '<Name>'+
                                 '<Name Location="First">' + xml_firstName + '</Name>'+
                                 '<Name Location="Last">' + xml_lastName + '</Name>'+
                              '</Name>'+
                              '<Suffix />'+
                              '<SortingName>' + xml_firstName + ' ' + 
                                              xml_lastName + 
                              '</SortingName>'+
                              '<NickName />'+
                              '<Salutation>' + checkStringValue(acc.Salutation) + '</Salutation>'+
                              '<ContactInformation>'+
                                 '<Address PrimaryFlag="true">'+
                                    '<AddressLine1>' + xml_personMailingStreet + '</AddressLine1>'+
                                    '<AddressLine2 />'+
                                    '<AddressLine3 />'+
                                    '<AddressLine4 />'+
                                    '<ApartmentNumber />'+
                                    '<City>' + xml_personMailingCity + '</City>'+
                                    '<Country>'+ xml_personMailingCountry + '</Country>'+
                                    '<Territory>' + xml_personMailingState + '</Territory>'+
                                    '<PostalCode>' + xml_personMailingPostalCode + '</PostalCode>'+
                                 '</Address>'+
                                 '<EMail PrimaryFlag="true">'+
                                    '<EMailAddress>' + xml_personEmail + '</EMailAddress>'+
                                 '</EMail>'+
                                 '<Telephone TypeCode="HOME" PrimaryFlag="' + PrimaryHomePhone + '">'+
                                    '<PhoneNumber>' + xml_phone + '</PhoneNumber>'+
                                    '<Extension />'+
                                 '</Telephone>'+                
                                 '<Telephone TypeCode="MOBILE" PrimaryFlag="' + PrimaryMobilePhone + '">'+
                                    '<PhoneNumber>' + xml_personMobilePhone + '</PhoneNumber>'+
                                    '<Extension />'+
                                 '</Telephone>'+                                                
                              '</ContactInformation>'+
                              '<PersonalSummary>'+
                                 '<GenderType>' + checkStringValue(acc.Sesso__c) + '</GenderType>'+
                                 '<BirthDate>' + FormatDateToRelate(acc.PersonBirthdate) + '</BirthDate>'+
                                 '<MaritalStatusCode />'+
                                 '<Ethnicity />'+
                                 '<Rent>false</Rent>'+
                                 '<LanguageCode>' + checkStringValue(acc.Lingua__c) + '</LanguageCode>'+
                              '</PersonalSummary>'+
                              '<SocioEconomicProfile>'+
                                 '<AnnualIncomeAmount />'+
                                 '<NetWorth />'+
                                 '<HighestEducationalLevelName />'+
                              '</SocioEconomicProfile>'+
                           '</Individual>'+
                        '</EntityInformation>'+
                        '<PersonalPreferences />'+
                        
                        AlternateKeyAS400_ID +
                        AlternateKeyRelate + 
                        AlternateKeyXSTORE_ID + 
                        
                        '<AlternateKey TypeCode="BCG_ID_CUST_SALESFORCE">'+
                           '<AlternateID>' + acc.Id + '</AlternateID>'+
                        '</AlternateKey>'+                                
                        '<CustomAttribute name="PRIVACY">'+
                           '<AttributeValue>false</AttributeValue>'+
                        '</CustomAttribute>'+
                        '<CustomAttribute name="MARKETING_BC_SPA_FLAG">'+
                           '<AttributeValue>' + acc.Privacy1__c + '</AttributeValue>'+
                        '</CustomAttribute>'+
                        '<CustomAttribute name="MARKETING_BC_GROUP_FLAG">'+
                           '<AttributeValue>' + acc.Privacy2__c + '</AttributeValue>'+
                        '</CustomAttribute>'+
                        '<CustomAttribute name="PROFILING_FLAG">'+
                           '<AttributeValue>' + acc.Privacy3__c + '</AttributeValue>'+
                        '</CustomAttribute>'+
                        '<CustomAttribute name="PHONE_CONTACT_FLAG">'+
                           '<AttributeValue>' + acc.Telefono__c + '</AttributeValue>'+
                        '</CustomAttribute>'+
                        '<CustomAttribute name="EMAIL_FLAG">'+
                           '<AttributeValue>' + acc.Email__c + '</AttributeValue>'+
                        '</CustomAttribute>'+
                        '<CustomAttribute name="PAPER_MAIL_FLAG">'+
                           '<AttributeValue>' + acc.Posta__c + '</AttributeValue>'+
                        '</CustomAttribute>'+
                        '<CustomAttribute name="SMS_FLAG">'+
                           '<AttributeValue>' + acc.Social__c + '</AttributeValue>'+
                        '</CustomAttribute>'+
                        '<CustomAttribute name="INSTANT_MESSAGING_FLAG">'+
                           '<AttributeValue>' + acc.Messaging__c + '</AttributeValue>'+
                        '</CustomAttribute>'+
                CurrentDatePrivacy
                + 
                        '<CustomAttribute name="NATIONALITY">'+
                           '<AttributeValue>' + checkStringValue(acc.Nazionalita__c) + '</AttributeValue>'+
                        '</CustomAttribute>'+                                
                        '<CustomAttribute name="OCCUPATION">'+
                           '<AttributeValue>' + checkStringValue(acc.Professione__c) + '</AttributeValue>'+
                        '</CustomAttribute>'+  
                        '<CustomAttribute name="DATE_RANGE">'+
                           '<AttributeValue>' + checkStringValue(acc.Fascia_Di_Eta__c) + '</AttributeValue>'+
                        '</CustomAttribute>'+ 
                
                        AttributeCategoriaCliente +

                /*               
                        '<CustomAttribute name="?????">'+
                           '<AttributeValue>' + acc.WeChat__c + '</AttributeValue>'+
                        '</CustomAttribute>'+ 
                        '<CustomAttribute name="?????">'+
                           '<AttributeValue>' + acc.We_Chat_ID__c + '</AttributeValue>'+
                        '</CustomAttribute>'+ 
                        '<CustomAttribute name="?????">'+
                           '<AttributeValue>' + acc.Other__c + '</AttributeValue>'+
                        '</CustomAttribute>'+                 
                        '<CustomAttribute name="?????">'+
                           '<AttributeValue>' + acc.Other_text__c + '</AttributeValue>'+
                        '</CustomAttribute>'+                  
*/                                
                '</customerData>'+
                     '<securityUserId>100</securityUserId>'+
                  '</m:addOrUpdateCustomer>'+
               '</env:Body>'+
            '</env:Envelope>';
            
            system.debug('DEBUG@ REQUEST XML BODY: ' + xml);
            req.setTimeout(6000); // timeout in milliseconds
            req.setBody(xml);
            system.debug('DEBUG@ REQUEST BODY: ' + req.getBody());

            Http http = new Http();             
            HTTPResponse res = http.send(req);
            system.debug('DEBUG@ RESPONSE: ' + res);
            system.debug('DEBUG@ RESPONSE BODY: ' + res.getBody());
            system.debug('DEBUG@ RESPONSE STATUS: ' + res.getStatus());
            system.debug('DEBUG@ RESPONSE STATUS CODE: ' + res.getStatusCode());
            
            relateResponse.Record_id__c = acc.Id;
            relateResponse.Endpoint__c = req.getEndpoint();
            relateResponse.Result_Code__c = String.valueOf(res.getStatusCode());
            relateResponse.Result_Detail__c = res.getBody();
            relateResponse.Request__c = xml;
            
            
            
            insert relateResponse;
            
            system.debug('DEBUG@ relateResponse: ' + relateResponse);
                               
        }

    }

    public static string checkStringValue(string s) {       
        string result = '';        
        if(!string.isEmpty(s)){
            result = s;
        }
        return result;
    }

    public static string FormatDateToRelate(date d) {       
        string result = '';        
        if(d!=null){
            Datetime dt = datetime.newInstance(d.year(), d.month(), d.day());
            result = dt.format('yyyy-MM-dd');
            }
        return result;
    }
    
    public static string setValueForRelate(string newVal, string oldVal) {       
        string result = '';        
        System.debug('newVal: ' + newVal);
        System.debug('oldVal: ' + oldVal);
        if(String.isNotBlank(oldVal) && String.isBlank(newVal)){
            result = '-';
        } else {
            if(newVal == null){
                result = '';
            } else {
                result = newVal;
            }
            
        }
        System.debug('result: ' + result);
        return result;
    }
  
}