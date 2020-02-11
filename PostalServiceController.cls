public with sharing class PostalServiceController 
{
    
    public Jiffy_Mailer_Account__C acc {get; set;}
    public Package__C pkg {get; set;}
    public Inhabitant__C inhab {get; set;}
    public Address__C addy {get; set;}
    public Contact con {get; set;}
    public Pagereference pg {get; set;}

    public PostalServiceController() 
    {
        acc = new Jiffy_Mailer_Account__C();
        pkg = new Package__C();
        inhab = new Inhabitant__C();
        addy = new Address__C();
        con = new Contact();
    }

    public Pagereference save()
    {
        try
        {
            insert acc;
            pg = new Pagereference('/' + acc.id);
            pg.setRedirect(true);
            return pg;
        }catch(exception e)
        {
            system.debug(e.getMessage());
        }
        
        return pg;
    }
    
    public void cancel()
    {
        
    }
}
