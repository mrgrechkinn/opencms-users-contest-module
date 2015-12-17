<%/*****************************************************************
* Project: TTK - Portal
*****************************************************************/
%><%@ page language="java" 
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
	import="org.opencms.jsp.*"	
	import="org.opencms.file.*"
    import="org.opencms.xml.page.*"  
    import="java.util.*"  
    import="java.text.*"

%><%!

String getContainerXmlContent (CmsJspXmlContentBean cms, I_CmsXmlContentContainer container, String parName, Locale locale) {
	String par = cms.contentshow(container, parName, locale).trim();
	if (("".equals(par))||(par.startsWith("???"))) par = ""; 
	return par;
}

// Sort tags Map
private static Map<String, Integer> sortTagsMap(Map<String, Integer> unsortMap) {
    List<Map.Entry<String, Integer>> list = new LinkedList<Map.Entry<String, Integer>>(unsortMap.entrySet());
    //sort list based on comparator
    Collections.sort(list, new Comparator<Map.Entry<String, Integer>>() {
		public int compare(Map.Entry<String,Integer> o1, Map.Entry<String,Integer> o2) {
			return o2.getValue().compareTo(o1.getValue());
		}
	});
    //put sorted list into map again
	Map<String, Integer> sortedMap = new LinkedHashMap<String,Integer>();
	for (Map.Entry<String, Integer> entry : list) {
	     sortedMap.put(entry.getKey(), entry.getValue());
	}
	return sortedMap;
}	

%><%

CmsJspXmlContentBean cms = new CmsJspXmlContentBean(pageContext, request, response);
CmsObject cmsObj = cms.getCmsObject();
//String moduleBaseUri = "/system/modules/ru.onemanteam.opencms.modules.portal";

Locale locale = new Locale(cms.property("locale", "search"));
String labels = "/common/labels/common.xml";
String newsFolder = cms.getContent(labels, "NewsFolder", locale);
String thisUri = cms.getRequestContext().getUri();
String thisFolderUri = cms.getRequestContext().getFolderUri();


//String blogUri = org.opencms.main.OpenCms.getSiteManager().getCurrentSite(cms.getCmsObject()).getServerPrefix(cms.getCmsObject(), cms.getRequestContext().getUri()) + "/" + locale.toString() + "/blog/index.html";

int curMonth = request.getParameter("month") != null ? Integer.parseInt(request.getParameter("month")) : 0;
int curYear = request.getParameter("year") != null ? Integer.parseInt(request.getParameter("year")) : 0;

Map<String, Integer> tagsMap = new HashMap <String, Integer>(); // key - tag, value - quantity
int limit = 20; // tag's limit
TreeMap<String,String> tagsMapAlphabetic = new TreeMap<String,String> ();




try {

I_CmsXmlContentContainer container = cms.contentload("allInFolderPriorityDateDesc", newsFolder + "news_${number}.html|news|10000", locale, false);

SimpleDateFormat df = new SimpleDateFormat("dd/MM/yy");
SimpleDateFormat mf = new SimpleDateFormat("MM");
SimpleDateFormat yf = new SimpleDateFormat("yy");
int year = 0;
int month = 0;
int prevYear = 0;
int prevMonth = 0;

while (container.hasMoreContent()) {
	String theLink = cms.contentshow(container, "${opencms.filename}");
	CmsResource resource = cms.getCmsObject().readResource(theLink);

	String [] tagCloud = getContainerXmlContent(cms, container, "Tags", locale).split(","); 

	
	for (int i = 0; i < tagCloud.length; i++ ){
		if (tagCloud[i].trim()=="") continue;
		Integer tagCounter = tagsMap.get(tagCloud[i].trim());
		tagsMap.put(tagCloud[i].trim(), (tagCounter == null) ? Integer.valueOf(1) : Integer.valueOf(tagCounter.intValue() + 1));
	}	
	
	String dateStr = "";

		String dateStrTemp = cms.contentshow(container, "Date", locale);
		if (!dateStrTemp.startsWith("???") && !"".equals(dateStrTemp.trim())){
			dateStr = dateStrTemp;
		}
	
/* swh 	
	if (!"".equals(dateStr.trim()) && "true".equals(cmsObj.readProperty(theLink, "Archived"))){
	
			Date date = new Date(Long.parseLong(dateStr));
		
			year = Integer.parseInt(yf.format(date));
			month = Integer.parseInt(mf.format(date));			
			
			String visibility = "style=\"display:none;\"";
			String current = "";

			if (year == curYear) {
				visibility = "style=\"display:block;\"";
			}
			
			if (year != prevYear || year == 0) {
				if (year != prevYear) {
					archiveList+="</ul></li></ul>";
				}
				if (year == curYear || year == 0) {
					archiveList+="<ul><li class=\"blog_year current\"><span>"+year+"</span><ul class=\"bl_monthes\" style=\"display:block;\">";
				}
				else {
					archiveList+="<ul><li class=\"blog_year\"><span>"+year+"</span><ul class='bl_monthes' style='display:none;'>";
				}
				
				prevYear = year;
				prevMonth = 0;
			}
			
			if (month != prevMonth || month == 0) {
				if (month == curMonth && year == curYear){
					archiveList+="<a class='subelement_current' href='"+cms.link(blogUri + "?blogLang=" + blogLang + "&month=" + month + "&year=" + year) +"'><div class='content'>"+ getMonthName(month, locale) +"</div></a>";
				} else {
					archiveList+="<a class='subelement' href='"+cms.link(blogUri + "?blogLang=" + blogLang + "&month=" + month + "&year=" + year) +"'><div class='content'>"+ getMonthName(month, locale) +"</div></a>";
				}
				prevMonth = month;
			}

			if (year != prevYear) {
				archiveList+="</li></ul>";
			}

			
	
	}
*/

	
}



Map<String,Integer> tagsMapSorted = sortTagsMap(tagsMap);
int j = 1;
int tagLevel = 1;
int[] tagLevelgrad = {20, 40, 70, 1000};
Random rand = new Random(50);

for (String key : tagsMapSorted.keySet()) {
	if (((double)j / limit * 100) > tagLevelgrad[tagLevel]) {
		tagLevel++;
	}
	//tagsMapAlphabetic.put(key.trim()," <div class='tag-item level"+ tagLevel + "'><a class='tagPallet-" + rand.nextInt(3) + "' href=\"" + cms.link(thisUri + "?tag=" + key) + "\">" + key +"</a></div>");
	tagsMapAlphabetic.put(key.trim()," <li><a class='tagPallet-" + rand.nextInt(3) + "' href=\"" + cms.link(newsFolder + "?tag=" + key) + "\">" + key +"</a></li>");
	if (++j > limit) { break;}
}


 } catch (Exception e) {
    e.printStackTrace(new java.io.PrintWriter(out));
}


%>

<div class="tagCloud">
<%
/*for (String s : tagsMapAlphabetic.keySet()) {
	%><%= tagsMapAlphabetic.get(s) %><%
}
*/
%>
</div>



<div id="myCanvasContainer">
      <canvas width="240" height="240" id="myCanvas">
        <p>Anything in here will be replaced on browsers that support the canvas element</p>
      </canvas>
    </div>
    <div id="tags">
      <ul>
		<%
		for (String s : tagsMapAlphabetic.keySet()) {
			%><%= tagsMapAlphabetic.get(s) %><%
		}
		%>
      </ul>
</div>

