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

    public PostalServiceController() 
    {
        pkg = new Package__C();
        inhab = new Inhabitant__C();
        addy = new Address__C();
        con = new Contact();
        updateBox = 'Updates Ready...';
        initUserAccount();
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
            if(a != null)
            {                
                system.debug('Finding related account...');
                userAcc = a;
                updateUpdateBox('Finding related account...');            
            }

            else 
            {
                updateUpdateBox('Default Account Pulled');
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
            insert con;
            updateUpdateBox('Contact Saved!');

        }catch(exception e)
        {
            system.debug(e.getMessage());
        }
    }
    
    public void cancel()
    {
        
    }
}