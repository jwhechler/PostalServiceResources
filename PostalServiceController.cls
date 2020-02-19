public with sharing class PostalServiceController 
{
    public id b = userInfo.getUserId();
    public Jiffy_Mailer_Account__C userAcc {get; set;}
    public Package__C pkg {get; set;}
    public Inhabitant__C inhab {get; set;}
    public Address__C addy {get; set;}
    public Contact con {get; set;}
    public Pagereference pg {get; set;}
    public string updateBox {get; set;}
    public  String  headerdata{get;set;}
    public string urlvalue{get;set;}
    public string url{get;set;}

    public PostalServiceController() 
    {
        pkg = new Package__C();
        inhab = new Inhabitant__C();
        addy = new Address__C();
        con = new Contact();
        updateBox = 'Updates Ready...';
        initUserAccount();
    }   
        
    public void pageurlclass(String i)
    {
        
         headerdata= ApexPages.currentPage().getHeaders().get('Host');
        
         urlvalue=Apexpages.currentPage().getUrl();
        
         url='https://' + headerdata + urlvalue + '?id=' + i;
    }

    public void updateUpdateBox(String S)
    {
        if(String.isNotEmpty(s) || String.isNotBlank(s))
        {
            updateBox = s;
        }
    }

    public void initUserAccount()
    {
        Jiffy_Mailer_Account__C a = new Jiffy_Mailer_Account__C();
        try 
        {
            a = [SELECT id, name, full_name__c, mailing_address__c, contact__c FROM Jiffy_Mailer_Account__C WHERE ownerid = :b LIMIT 1];            
        } catch (Exception e) 
        {
            system.debug(e.getMessage());
            updateUpdateBox('No Account to be found, switching to default.');            
        }
        
        
        try
        {
            if(a.id != null)
            {
                userAcc = a;
                con = [SELECT id, firstname, lastname, mailingstreet, mailingcity, mailingstate, mailingpostalcode FROM contact WHERE Jiffy_Mailer_Account__C = :a.id LIMIT 1];

                updateUpdateBox('Finding related account...Account: ' + userAcc.name);        
            }

            else 
            {
                updateUpdateBox('Default Account Pulled.');
                userAcc = [SELECT id, name, full_name__c, mailing_address__c, contact__c FROM Jiffy_Mailer_Account__C WHERE full_name__c = 'This CouldBe You'];
            }

        }catch(exception e)
        {
            system.debug(e.getMessage());
        }
    }

    public void save()
    {
        try
        {
            if(userAcc == null || userAcc.full_name__c == 'This CouldBe You')
            {
                insert con;
                initUserAccount();
                updateUpdateBox('Contact Saved!');
            }

            else if(userAcc != null && userAcc.full_name__c != 'This CouldBe You')
            {
                update con;
                updateUpdateBox('Contact Updated!');
            }

        }catch(exception e)
        {
            system.debug(e.getMessage());
            updateUpdateBox('Error: ' + e.getMessage());
        }
    }
    
    public void cancel()
    {
        
    }
}