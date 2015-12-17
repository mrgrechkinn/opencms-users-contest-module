<%/*****************************************************************
* Project: TTK - Portal
*****************************************************************/
%><%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="org.opencms.jsp.*"
    import="java.util.*"
    import="org.opencms.search.*"
    import="org.opencms.file.*"
    
	import="java.net.MalformedURLException"
	import="java.net.URL"
	import="java.security.cert.Certificate"
	import="java.io.*"
 
	import="javax.net.ssl.HttpsURLConnection"
	import="javax.net.ssl.SSLPeerUnverifiedException"


%><%!


private void testIt(){
	 
    String https_url = "https://kttk-jbp1app1.transtk.ru:8443/orgstruct-ws/ObjectProxy/rest/json/searchPersonsByName?name=Васильев";
    URL url;
    try {

	     url = new URL(https_url);
	     HttpsURLConnection con = (HttpsURLConnection)url.openConnection();

	     //dumpl all cert info
	     print_https_cert(con);

	     //dump all the content
	     print_content(con);

    } catch (MalformedURLException e) {
	     e.printStackTrace();
    } catch (IOException e) {
	     e.printStackTrace();
    }

 }

private void print_https_cert(HttpsURLConnection con){
	 
    if(con!=null){
 
      try {
 
	System.out.println("Response Code : " + con.getResponseCode());
	System.out.println("Cipher Suite : " + con.getCipherSuite());
	System.out.println("\n");
 
	Certificate[] certs = con.getServerCertificates();
	for(Certificate cert : certs){
	   System.out.println("Cert Type : " + cert.getType());
	   System.out.println("Cert Hash Code : " + cert.hashCode());
	   System.out.println("Cert Public Key Algorithm : " 
                                    + cert.getPublicKey().getAlgorithm());
	   System.out.println("Cert Public Key Format : " 
                                    + cert.getPublicKey().getFormat());
	   System.out.println("\n");
	}
 
	} catch (SSLPeerUnverifiedException e) {
		e.printStackTrace();
	} catch (IOException e){
		e.printStackTrace();
	}
 
     }
 
   }


private void print_content(HttpsURLConnection con){
	if(con!=null){

	try {

	   System.out.println("****** Content of the URL ********");			
	   BufferedReader br = 
		new BufferedReader(
			new InputStreamReader(con.getInputStream()));

	   String input;

	   while ((input = br.readLine()) != null){
	      System.out.println(input);
	   }
	   br.close();

	} catch (IOException e) {
	   e.printStackTrace();
	}

    }

}



private static String readUrl( String urlString ) throws Exception {
	
    BufferedReader reader = null;

    try {
    
    	URL url = new URL(urlString);
        
    	reader = new BufferedReader(new InputStreamReader(url.openStream()));
        StringBuffer buffer = new StringBuffer();
        
        int read;
        
        char[] chars = new char[1024];
        
        while ((read = reader.read(chars)) != -1)
            buffer.append(chars, 0, read); 

        return buffer.toString();
    
    } finally {
        if (reader != null)
            reader.close();
    }
    
}

%><%

CmsJspActionElement cms = new CmsJspActionElement(pageContext, request, response);
CmsObject cmsObj = cms.getCmsObject();
Locale locale = cms.getRequestContext().getLocale();
String labels = "/common/labels/common.xml";
int minQueryLength = 3;
int matchesPerPage = 10;


%>
<div class="searchPersons"></div>



<div class="searchResult">

<%  testIt();%>

</div>