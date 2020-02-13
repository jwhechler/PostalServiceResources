public with sharing class PostalServiceController 
{
    
    public Jiffy_Mailer_Account__C acc {get; set;}
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
        acc = new Jiffy_Mailer_Account__C();
        pkg = new Package__C();
        inhab = new Inhabitant__C();
        addy = new Address__C();
        con = new Contact();
        updateBox = 'Updates Ready...';
    }

    public void updateUpdateBox(String S)
    {
        if(String.isNotEmpty(s) || String.isNotBlank(s))
        {
            updateBox = updateBox + ' : ' + s;
        }
    }

    public boolean checkForAccount()
    {
        boolean acc_Exists = false;
        Jiffy_Mailer_Account__C a = new Jiffy_Mailer_Account__C();

        a = [SELECT id FROM Jiffy_Mailer_Account__C WHERE ownerid = :b limit 1];
        if( a != null)
        {
            acc_Exists = true;
            system.debug('Account returned!');
            updateUpdateBox('Account returned!');
        }

        else 
        {
            acc_Exists = false;
            system.debug('No Account found!');            
            updateUpdateBox('No Account found!');
        }

        return acc_Exists;
    }

    public void getUserAcc()
    {
        updateUpdateBox('Initializing User Account...');
        userAcc = initUserAccount();
    }

    public Jiffy_Mailer_Account__c initUserAccount()
    {
        Jiffy_Mailer_Account__C a = new Jiffy_Mailer_Account__C();

        try
        {
            if(checkForAccount())
            {
                system.debug('Finding related account...');
                
                updateUpdateBox('Finding related account...');
                a = [SELECT id, name FROM Jiffy_Mailer_Account__C WHERE ownerid = :b LIMIT 1];            
            }

            else 
            {
                a = null;
            }

        }catch(exception e)
        {
            system.debug(e.getMessage());
        }

        return a;
    }

    public void save()
    {
        try
        {
            insert con;

        }catch(exception e)
        {
            system.debug(e.getMessage());
        }
    }
    
    public void cancel()
    {
        
    }
}