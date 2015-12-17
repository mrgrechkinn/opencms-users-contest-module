<%/*****************************************************************
* Project: TTK - Portal
*****************************************************************/
%><%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="org.opencms.jsp.*"
    import="org.opencms.main.*"
    import="org.opencms.file.*"
    import="java.util.*"
    import="java.text.SimpleDateFormat"
%><%!

static final String moduleBaseUri = "/system/modules/ru.onemanteam.opencms.modules.portal";

%><%


CmsJspXmlContentBean cms = new CmsJspXmlContentBean(pageContext, request, response);
CmsObject cmsObj = cms.getCmsObject();
Locale locale = cms.getRequestContext().getLocale();

String thisUri = cms.getRequestContext().getUri();



/*

https://kttk-jbp1app1.transtk.ru:8443/orgstruct-ws/ObjectProxy/rest/json/getSectionList
https://kttk-jbp1app1.transtk.ru:8443/orgstruct-ws/ObjectProxy/rest/json/getSectionList?sectionId=137d902d-567f-4053-b2f5-4dc6681a357e
https://kttk-jbp1app1.transtk.ru:8443/orgstruct-ws/ObjectProxy/rest/json/getSectionPersonsList?sectionId=7fdd588d-1d31-45fb-8561-c3625a4f5e05
https://kttk-jbp1app1.transtk.ru:8443/orgstruct-ws/ObjectProxy/rest/json/getSection?sectionId=7fdd588d-1d31-45fb-8561-c3625a4f5e05
https://kttk-jbp1app1.transtk.ru:8443/orgstruct-ws/ObjectProxy/rest/json/getPerson?personId=41f95224-aeb9-4fa7-996e-5c6cd3d96f91
https://kttk-jbp1app1.transtk.ru:8443/orgstruct-ws/ObjectProxy/rest/json/searchPersonsByName?name=Р�РІР°РЅРѕРІ
https://kttk-jbp1app1.transtk.ru:8443/orgstruct-ws/ObjectProxy/rest/json/getContactsForPerson?personId=41f95224-aeb9-4fa7-996e-5c6cd3d96f91

*/



String labels = "/common/labels/common.xml";

boolean orgStructure = request.getAttribute("orgStructure") != null;

%>

var servicesUri = "http://10.110.56.40/orgstruct-ws/";

var departments = '';
var persons = '';

var personObj;
var personContactsHTML;
var personInfoHTML;


// We are the scorpions

var hereWeGo = {
		'569b4902-199a-4291-8abe-565abffea927' : '',
		'5656d8c3-1dd4-4e00-b0c8-fdb2c3de248e' : '',
		'80cc37f5-9bec-4c31-ab3b-cbd613938aaa' : ''
		};


var mon = {0:"января", 1:"февраля", 2:"марта", 3:"апреля", 4:"мая", 5:"июня", 6:"июля", 7:"августа", 8:"сентября", 9:"октября", 10:"ноября", 11:"декабря"};


//-------------------------------- binds -------------------------------- 

$(document).on('click', '.department', function() {

	departmentId = $(this).attr('id');

	
	if ($(this).parent().hasClass("expanded")) {
		$(this).next('ul').remove();
		$(this).parent().removeClass("expanded");
	
	} else {
		
		
		getDepartmentChildsListById(departmentId);
		
		
	}

});



$(document).bind('keydown', function(e) { 
    if (e.which == 27) {
    	$('#opaco').toggleClass('hidden').removeAttr('style').unbind('click');
    	$('#personPopup').addClass('hidden');
    }
}); 



$(document).on('click', '#closeMe', function() {
	$('#opaco').toggleClass('hidden').removeAttr('style').unbind('click');
	$('#personPopup').addClass('hidden');
});



$(document).on('click', '.person', function() {

	personId = $(this).attr('id');
	_getPerson(personId);


	
	
//	$.when( _getPerson(personId) , _getPersonContacts(personId)).done(function(p, pc) {
//
//		var html = '';
//
//		var photoUri = servicesUri + 'AttachmentLoader?id=';
//		var noPhotoImg = '<%=cms.link("/common/images/no-photo.jpg")%>';
//		var imgHTML = '<img width="220" src="' + noPhotoImg +'" />';
//
//		var person = p[0].response.person;
//		var contacts = pc[0].response.contacts;
//		
//		
//		html += '<table><tr>';
//		html += '<td width="232">';
//		
//		if (person.photo != undefined) {
//			imgHTML = '<img width="220" src="' + photoUri + person.photo.ref.substr(-36, 36) +'" />';
//		}
//		
//		if (hereWeGo[person.id] != undefined) {
//			imgHTML = '<img width="220" src="' + hereWeGo[person.id] + '" />';
//		}
//		
//		html += imgHTML;
//
//		html += '</td><td valign="top">';
//			html += '<table class="personData">';
//
//			
//			//main info
//			//html += '<tr><td>Версия</td><td>' + person.version + '</td></tr>';
//    		//html += '<tr><td>Удален</td><td>' + person.deleted + '</td></tr>';
//    		
//    		html += '<tr><td colspan="2" class="personName">' + person.displayName + '</td></tr>';
//    		
//    		html += '<tr><td>Должность</td><td>' + person.position + '</td></tr>';
//    		if (hereWeGo[person.id] != undefined) {
//    			html += '<tr><td>День рождения</td><td>раз в году</td></tr>';
//    		} else {
//    			
//    			if (person.birthDate) {
//    				//html += '<tr><td>День рождения</td><td>' + person.birthDate.substr(0, 10) + '</td></tr>';
//    				html += '<tr><td>День рождения</td><td>' + person.birthDate.substr(5, 5) + '</td></tr>';
//    			}
//    			
//    		}
//    		html += '<tr><td>Подразделение</td><td>' + person.section.displayName + '</td></tr>';
//    		
//			//contacts
//			if (contacts.length > 0) {
//	    		for (var i = 0; i < contacts.length; i++) {
//	    			var contact = contacts[i];	    	
//	    			html += '<tr><td>' + contact.type + '</td><td>' + contact.data + '</td></tr>';
//	    		}
//	    	}
//			
//
//			html += '</table>';
//		html += '</td>';
//		html += '</tr></table>';
//		html += "<div style='position:absolute;bottom:5px;right:10px;font-size:10px;cursor:pointer;'><span id='closeMe'>Закрыть (ESC)</span></div>";
//		$('#personPopup').html(html);
//	$('#personPopup').togglePopup();
//
//		
//		return false;
//		
//		
//	});

});



function _drawPersonPopup(person) {
	
	
	var html = '';
	var photoUri = servicesUri + 'AttachmentLoader?id=';
	var noPhotoImg = '<%=cms.link("/common/images/no-photo.jpg")%>';
	var imgHTML = '<img width="220" src="' + noPhotoImg +'" />';

	
	html += '<table><tr>';

	html += '<td width="232">';
	

	if (person.photo != undefined) {
		imgHTML = '<img width="220" src="' + photoUri + person.photo +'" />';
	}
	

	if (hereWeGo[person.id] != undefined) {
		
		imgHTML = '<img width="220" src="' + hereWeGo[person.id] + '" />';
	}


	html += imgHTML;
	
	
	
	html += '</td><td valign="top">';
		html += '<table class="personData">';
		
		html += '<tr><td colspan="2" class="personName">' + person.displayName + '</td></tr>';
		
		html += '<tr><td>Подразделение</td><td>' + person.division + '</td></tr>';
		html += '<tr><td>Должность</td><td>' + person.position + '</td></tr>';
		
		var contacts = person.contacts;
		
		if (contacts.length > 0) {
    		for (var i = 0; i < contacts.length; i++) {
    			var contact = contacts[i];	    	
    			html += '<tr><td>' + contact.type + '</td><td>' + contact.data + '</td></tr>';
    		}
    	}
		
		if (hereWeGo[person.id] != undefined) {
			html += '<tr><td>День рождения</td><td>раз в году</td></tr>';
		} else {
			
			if (person.birthDate) {
				
				var d = new Date(person.birthDate);
				text = d.getDate();
		
				
				//html += '<tr><td>День рождения</td><td>' + person.birthDate.substr(0, 10) + '</td></tr>';
				//html += '<tr><td>День рождения</td><td>' + person.birthDate.substr(5, 5) + '</td></tr>';

				// nex time uncomment this line
				//html += '<tr><td>День рождения</td><td>' + text[0] + " " + text[1] + '</td></tr>';
				
				html += '<tr><td>День рождения</td><td>' + text + " " + mon[d.getMonth()] + '</td></tr>';
				
			}
			
		}

		
		
		html += '</table>';
	html += '</td>';
	html += '</tr></table>';
	html += "<div style='position:absolute;bottom:5px;right:10px;font-size:10px;cursor:pointer;'><span id='closeMe'>Закрыть (ESC)</span></div>";
	
	$('#personPopup').html(html);
	$('#personPopup').togglePopup();

	
	return false;
}








//function _getPersonContactsHTML(personId){
//	
//	var url = servicesUri + 'ObjectProxy/rest/json/getContactsForPerson?personId=' + personId;
//	
//	if ($.browser.msie && window.XDomainRequest) {
//	    
//		// Use Microsoft XDR
//    	var xdr = new XDomainRequest();
//    	xdr.open("get",  url);
//    	xdr.onload = function () {
//    
//	    	var JSON = $.parseJSON(xdr.responseText);
//	    	
//	    	if (JSON == null || typeof (JSON) == 'undefined')
//	    	{
//	        	JSON = $.parseJSON(data.firstChild.textContent);
//	    	}
//	    		
//			/*******************************/
//	    	var entries = JSON.response.contacts;
//			alert(9);
//			html = "";
//			if (entries.length > 0) {
//				for (var i = 0; i < entries.length; i++) {
//					var entry = entries[i];	    	
//					html += '<tr><td>' + entry.type + '</td><td>' + entry.data + '</td></tr>';
//				}
//			}
//			
//			personContactsHTML = html;
//    	
//    	};
//    	xdr.send();
//	
//	} else {
//		
//		$.ajax({
//			url: url,
//			dataType: 'json',
//			crossDomain: 'true',
//			success:function(data){
//				
//				var entries = data.response.contacts;
//				
//				html = "";
//				if (entries.length > 0) {
//					for (var i = 0; i < entries.length; i++) {
//						var entry = entries[i];	    	
//						html += '<tr><td>' + entry.type + '</td><td>' + entry.data + '</td></tr>';
//					}
//				}
//				
//				personContactsHTML = html;
//				
//				
//			},
//			error:function(){
//				
//			}
//		});
//		
//	}
//	
//	
//	
//	
//}

//
//function _getPersonInfoHTML(personId) {
//	
//	var url = servicesUri + 'ObjectProxy/rest/json/getPerson?personId=' + personId;
//	
//	if ($.browser.msie && window.XDomainRequest) {
//	    
//		// Use Microsoft XDR
//    	var xdr = new XDomainRequest();
//    	xdr.open("get",  url);
//    	xdr.onload = function () {
//    
//    	var JSON = $.parseJSON(xdr.responseText);
//    	
//    	if (JSON == null || typeof (JSON) == 'undefined')
//    	{
//        	JSON = $.parseJSON(data.firstChild.textContent);
//    	}
//	    	
//    		/*******************************/
//    		personObj = JSON.response.person;
//	    	
//	    	var html = '';
//			
//	    	html += '<tr><td colspan="2"><h2>' + personObj.displayName + '</h2></td></tr>';
//	    	html += '<tr><td>Версия</td><td>' + personObj.version + '</td></tr>';
//			html += '<tr><td>Удален</td><td>' + personObj.deleted + '</td></tr>';
//			html += '<tr><td>Позиция</td><td>' + personObj.position + '</td></tr>';
//			html += '<tr><td>День рождения</td><td>' + personObj.birthDate + '</td></tr>';
//			html += '<tr><td>Имя дисплея</td><td>' + personObj.section.displayName + '</td></tr>';
//			
//			personInfoHTML = html;
//			
//    	};
//    	xdr.send();
//	
//	} else {
//	
//	
//		$.ajax({
//			url: url,
//		    dataType: 'json',
//			crossDomain: 'true',
//		    success:function(data){
//		    	
//		    	personObj = data.response.person;
//		    	
//		    	var html = '';
//	    		
//		    	html += '<tr><td colspan="2"><h2>' + personObj.displayName + '</h2></td></tr>';
//		    	html += '<tr><td>Версия</td><td>' + personObj.version + '</td></tr>';
//	    		html += '<tr><td>Удален</td><td>' + personObj.deleted + '</td></tr>';
//	    		html += '<tr><td>Позиция</td><td>' + personObj.position + '</td></tr>';
//	    		html += '<tr><td>День рождения</td><td>' + personObj.birthDate + '</td></tr>';
//	    		html += '<tr><td>Имя дисплея</td><td>' + personObj.section.displayName + '</td></tr>';
//	    		
//	    		personInfoHTML = html;
//	    		
//		    },
//			error:function(){
//				
//		    }
//		});	
//	}
//}
//


function _getPerson(personId) {
	
	var url =  servicesUri + 'ObjectProxy/rest/json/getPerson?personId=' + personId;

	if ($.browser.msie && window.XDomainRequest) {
	    // Use Microsoft XDR
	    var xdr = new XDomainRequest();
	    xdr.open("get", url);
	    xdr.onload = function () {
		    var JSON = $.parseJSON(xdr.responseText);
		    if (JSON == null || typeof (JSON) == 'undefined') {
		        JSON = $.parseJSON(data.firstChild.textContent);
		    }
		    
		    /*********************/
			_drawPersonPopup(JSON.response.row);
			
	    };
	    xdr.send();
	
	} else {
	
		return $.ajax({
			url: url,
		    dataType: 'json',
			crossDomain: 'true',
		    success:function(data){
		    	
		    	/*********************/
		    	_drawPersonPopup(data.response.row);
		    	
		    },
			error:function(){
				//noop
			}
		
			});	
	}
	
	
}






//function _getPersonContacts(personId) {
//	
//	var url = servicesUri + 'ObjectProxy/rest/json/getContactsForPerson?personId=' + personId;
//	
//	if ($.browser.msie && window.XDomainRequest) {
//	    // Use Microsoft XDR
//	    var xdr = new XDomainRequest();
//	    xdr.open("get", url);
//	    xdr.onload = function () {
//		    var JSON = $.parseJSON(xdr.responseText);
//		    if (JSON == null || typeof (JSON) == 'undefined')
//		    {
//		        JSON = $.parseJSON(data.firstChild.textContent);
//		    }
//
//		    return JSON;
//	    };
//	    xdr.send();
//	
//	} else {
//	
//		return $.ajax({
//			url: url,
//		    dataType: 'json',
//			crossDomain: 'true'
//		});
//	}
//	
//}



function collectInnerHTML(departmentId) {
	
   	var html = "";


	

	if (persons.length > 0) {
		for (var i = 0; i < persons.length; i++) {
			var entry = persons[i];	    	
			//html += '<li><span class="person" id="' + entry.id + '">' + entry.name + '</span></li>';
			html += '<li>';
			html += '<div class="person" style="height:76px;">';
			html += '<div style="border-radius: 34px;float: left;height: 68px;margin: 0 8px 0px 0;width: 68px;background-image:url(http://10.110.56.40/orgstruct-ws/AttachmentLoader?id=' + entry.photo + ')" class="photo">&nbsp;</div>';
			html += '<span class="person" id="' + entry.id + '">' + entry.name + '</span>'; 
			html += '</div></li>';
		}
	}
	    	

	if (departments.length > 0) {
   		for (var i = 0; i < departments.length; i++) {
   			var entry = departments[i];	    	
   			html += '<li><span class="department" id="' + entry.id + '">' + entry.name + '</span></li>';
   		}
   	}
	
	// replace departments and persons
	
  	var beforeText = '<span class="department" id="' + departmentId + '">' + $("#" + departmentId).text() + '</span>';
  	$("#" + departmentId).parent().html(beforeText + '<ul>' + html + '</ul>');
  	$("#" + departmentId).parent().addClass("expanded");

}


function getDepartmentChildsListById(departmentId) {
	
	var url = servicesUri + 'ObjectProxy/rest/json/getSectionList?sectionId=' + departmentId;
	
	if ($.browser.msie && window.XDomainRequest) {
		// Use Microsoft XDR
    	var xdr = new XDomainRequest();
    	xdr.open("get",  url);
    	xdr.onload = function () {
    
    	var JSON = $.parseJSON(xdr.responseText);
    	
    	if (JSON == null || typeof (JSON) == 'undefined')
    	{
        	JSON = $.parseJSON(data.firstChild.textContent);
    	}
    		
    		/*******************************/
    		departments = JSON.response.rows;  
    		getPersonsListByDepartmentId(departmentId);
    		
    		
    	};
    	xdr.send();
	
	} else {
		$.ajax({
			url: url,
		    dataType: 'json',
			crossDomain: 'true',
		    success:function(data){
		    	
		    	departments = data.response.rows;  
		    	getPersonsListByDepartmentId(departmentId);
		    	
		    },
			error:function(){
				
		    }
		});
	}
}


function getPersonsListByDepartmentId(departmentId){
	
	var url = servicesUri + 'ObjectProxy/rest/json/getSectionPersonsList?sectionId=' + departmentId;
	if ($.browser.msie && window.XDomainRequest) {
	    
		// Use Microsoft XDR
    	var xdr = new XDomainRequest();
    	xdr.open("get",  url);
    	xdr.onload = function () {
    
	    	var JSON = $.parseJSON(xdr.responseText);
	    	
	    	/*******************************/
	    	persons = JSON.response.rows;
	    	collectInnerHTML(departmentId);
    	
    	};
    	xdr.send();
	
	} else {
	
	
		$.ajax({
			url: url,
		    dataType: 'json',
			crossDomain: 'true',
		    success:function(data){
		    	
		    	persons = data.response.rows;
		    	collectInnerHTML(departmentId);
		    	
		    	
		    },
			error:function(){
				
		    }
		});
	}
	
	
	
}


function initTree() {
	
	var url = servicesUri + 'ObjectProxy/rest/json/getSectionList';
	if ($.browser.msie && window.XDomainRequest) {
	    // Use Microsoft XDR
	    var xdr = new XDomainRequest();
	    xdr.open("get", url);
	    xdr.onload = function () {
	    var JSON = $.parseJSON(xdr.responseText);
	    if (JSON == null || typeof (JSON) == 'undefined')
		    {
		        JSON = $.parseJSON(data.firstChild.textContent);
		    }

		    var html = "";
	    	var entries = JSON.response.rows;  
			
	    	if (entries.length > 0) {
	    		for (var i = 0; i < entries.length; i++) {
	    			var entry = entries[i];	    	
	    			html += '<li><span class="department" id="' + entry.id + '">' + entry.name + '</span></li>';
	    		}
	
	    		$("#orgStruct").html(html);
	
	    	}
	    
	    };
	    xdr.send();
	    
	} else {
		$.ajax({
			url: url,
		    dataType: 'json',
			crossDomain: 'true',
		    cache: false, 
			dataType: "json",
			
		    success:function(data){
		    	
		    	var html = "";
		    	var entries = data.response.rows;  
		
	    	
		    	if (entries.length > 0) {
		    		for (var i = 0; i < entries.length; i++) {
		    			var entry = entries[i];	    	
		    			html += '<li><span class="department" id="' + entry.id + '">' + entry.name + '</span></li>';
		    		}
	
		    		$("#orgStruct").html(html);
	
		    	}
	    	
		    	
		    },
			error:function(){
				
		    }
		});
	}
}















function test_json() {
	
	return $.ajax({
		url: "https://crm.ttk.ru/address/rest/find/street2/%D0%9B%D0%B5%D0%BD%D0%B8%D0%BD%D1%81%D0%BA%D0%B8%D0%B9/parentuuid/0c5b2444-70a0-4932-980c-b4dc0d3f02b5",
	    dataType: 'json',
		crossDomain: 'true',
	    success:function(data){
	    	
	    	alert ("oloe");
	    	
	    },
		error:function(){
			//noop
		}
	
		});	
		
	
}




$(document).ready(function()
{
	
	//test_json();
	
	var myElem = document.getElementById('orgStruct');
	if (myElem != null) {
		initTree();		
	} 
	
	
	$("body").append("<div id='personPopup' class='hidden'></div>");
	
		//align element in the middle of the screen
		$.fn.alignCenter = function() {
			var marginLeft =  - $(this).width()/2 + 'px';
			var marginTop =  - $(this).height()/2 + 'px';
			return $(this).css({'margin-left':marginLeft, 'margin-top':marginTop});
		};

		
		$.fn.togglePopup = function(){

			
	     if($('#personPopup').hasClass('hidden'))
	     {
	       //when IE - fade immediately
	       if($.browser.msie)
	       {
	         $('#opaco').height($(document).height()).toggleClass('hidden')
	                    .click(function(){$(this).togglePopup();});
	       }
	       
	       //in all the rest browsers - fade slowly
	       else       
	       {
	         $('#opaco').height($(document).height()).toggleClass('hidden').fadeTo('slow', 0.7)
	                    .click(function(){$(this).togglePopup();});
	       }

	       $('#personPopup')
	         .html($(this).html())
	         .alignCenter()
	         .toggleClass('hidden');
	     }
	     else
	     {
	    	 
	    	 //visible - then hide
	    	 $('#opaco').toggleClass('hidden').removeAttr('style').unbind('click');
	       $('#personPopup').toggleClass('hidden');
	     }
	   };
	
	
	
	
});
