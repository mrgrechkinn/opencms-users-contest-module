<%/*****************************************************************
* Gridnine AB http://www.gridnine.com
* Project: Recipharm
* Legal notice: (c) Gridnine AB. All rights reserved.
*****************************************************************/
%><%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="org.opencms.jsp.*"
    import="org.opencms.file.*"
    import="java.util.*"
%><%!

final String checkNavUriProperty(CmsJspActionElement cms, String path) {
    String navUrlProp = cms.property("NavUri", path);
    if(navUrlProp != null && !"".equals(navUrlProp.trim())) {
        return navUrlProp.trim();
    }
    return path;
}


%><%

CmsJspActionElement cms = new CmsJspActionElement(pageContext, request, response);
String moduleBaseUri = "/system/modules/ru.onemanteam.opencms.modules.portal";
Locale locale = cms.getRequestContext().getLocale();
String thisFolder = cms.getRequestContext().getFolderUri();
String thisUri = cms.getRequestContext().getUri();
CmsObject cmsObj = cms.getCmsObject();

List<CmsJspNavElement> bc = null;
String path = null;


%>







        <div class="grid_6 suffix_1 leftcolumn">
			<% cms.include(moduleBaseUri + "/elements/menu-left.jsp"); %>
			<% //cms.include(thisUri, "left", true); %>
		</div>
        
        <div class="grid_17 centercolumn">
        <% cms.include(thisUri, "body", true); %>

<% /* нахрен моя карта ненужна %>
        
        <div id="containerBox" style="position:relative; border:1px solid #999;width:628px; height:500px;overflow:hidden;margin-bottom:40px;" >
  			<img id="zoomImage" src="http://10.110.56.40/portal/opencms/common/images/net_map/bigmap.jpg" style="width:2048px; height:1384px;position:absolute; top:-250px;left:-415px;cursor:move;" />
  			<div style='position:absolute;bottom:0px;left:0px;border:1px solid #fff;'><img src="http://10.110.56.40/portal/opencms/common/images/net_map/legend.jpg" style="width:230px"/></div>
		</div>

<script type="text/javascript">
function Position(x, y)
{
  this.X = x;
  this.Y = y;
  
  this.Add = function(val)
  {
    var newPos = new Position(this.X, this.Y);
    if(val != null)
    {
      if(!isNaN(val.X))
        newPos.X += val.X;
      if(!isNaN(val.Y))
        newPos.Y += val.Y
    }
    return newPos;
  }
  
  this.Subtract = function(val)
  {
    var newPos = new Position(this.X, this.Y);
    if(val != null)
    {
      if(!isNaN(val.X))
        newPos.X -= val.X;
      if(!isNaN(val.Y))
        newPos.Y -= val.Y
    }
    return newPos;
  }
  
  this.Min = function(val)
  {
    var newPos = new Position(this.X, this.Y)
    if(val == null)
      return newPos;
    
    if(!isNaN(val.X) && this.X > val.X)
      newPos.X = val.X;
    if(!isNaN(val.Y) && this.Y > val.Y)
      newPos.Y = val.Y;
    
    return newPos;  
  }
  
  this.Max = function(val)
  {
    var newPos = new Position(this.X, this.Y)
    if(val == null)
      return newPos;
    
    if(!isNaN(val.X) && this.X < val.X)
      newPos.X = val.X;
    if(!isNaN(val.Y) && this.Y < val.Y)
      newPos.Y = val.Y;
    
    return newPos;  
  }  
  
  this.Bound = function(lower, upper)
  {
    var newPos = this.Max(lower);
    return newPos.Min(upper);
  }
  
  this.Check = function()
  {
    var newPos = new Position(this.X, this.Y);
    if(isNaN(newPos.X))
      newPos.X = 0;
    if(isNaN(newPos.Y))
      newPos.Y = 0;
    return newPos;
  }
  
  this.Apply = function(element)
  {
    if(typeof(element) == "string")
      element = document.getElementById(element);
    if(element == null)
      return;
    if(!isNaN(this.X))
      element.style.left = this.X + 'px';
    if(!isNaN(this.Y))
      element.style.top = this.Y + 'px';  
  }
}

function hookEvent(element, eventName, callback)
{
  if(typeof(element) == "string")
    element = document.getElementById(element);
  if(element == null)
    return;
  if(element.addEventListener)
  {
    element.addEventListener(eventName, callback, false);
  }
  else if(element.attachEvent)
    element.attachEvent("on" + eventName, callback);
}

function unhookEvent(element, eventName, callback)
{
  if(typeof(element) == "string")
    element = document.getElementById(element);
  if(element == null)
    return;
  if(element.removeEventListener)
    element.removeEventListener(eventName, callback, false);
  else if(element.detachEvent)
    element.detachEvent("on" + eventName, callback);
}

function cancelEvent(e)
{
  e = e ? e : window.event;
  if(e.stopPropagation)
    e.stopPropagation();
  if(e.preventDefault)
    e.preventDefault();
  e.cancelBubble = true;
  e.cancel = true;
  e.returnValue = false;
  return false;
}

function getMousePos(eventObj)
{
  eventObj = eventObj ? eventObj : window.event;
  var pos;
  if(isNaN(eventObj.layerX))
    pos = new Position(eventObj.offsetX, eventObj.offsetY);
  else
    pos = new Position(eventObj.layerX, eventObj.layerY);
  return correctOffset(pos, pointerOffset, true);
}

function getEventTarget(e)
{
  e = e ? e : window.event;
  return e.target ? e.target : e.srcElement;
}

function absoluteCursorPostion(eventObj)
{
  eventObj = eventObj ? eventObj : window.event;
  
  if(isNaN(window.scrollX))
    return new Position(eventObj.clientX + document.documentElement.scrollLeft + document.body.scrollLeft, 
      eventObj.clientY + document.documentElement.scrollTop + document.body.scrollTop);
  else
    return new Position(eventObj.clientX + window.scrollX, eventObj.clientY + window.scrollY);
}

function dragObject(element, attachElement, lowerBound, upperBound, startCallback, moveCallback, endCallback, attachLater)
{
  if(typeof(element) == "string")
    element = document.getElementById(element);
  if(element == null)
      return;

  var cursorStartPos = null;
  var elementStartPos = null;
  var dragging = false;
  var listening = false;
  var disposed = false;

  function dragStart(eventObj)
  {
    if(dragging || !listening || disposed) return;
    dragging = true;

    if(startCallback != null)
      startCallback(eventObj, element);

    cursorStartPos = absoluteCursorPostion(eventObj);

    elementStartPos = new Position(parseInt(element.style.left), parseInt(element.style.top));

    elementStartPos = elementStartPos.Check();

    hookEvent(document, "mousemove", dragGo);
    hookEvent(document, "mouseup", dragStopHook);

    return cancelEvent(eventObj);
  }

  function dragGo(eventObj)
  {
    if(!dragging || disposed) return;

    var newPos = absoluteCursorPostion(eventObj);
    newPos = newPos.Add(elementStartPos).Subtract(cursorStartPos);
    newPos = newPos.Bound(lowerBound, upperBound)
    newPos.Apply(element);
    if(moveCallback != null)
      moveCallback(newPos, element);

    return cancelEvent(eventObj);
  }

  function dragStopHook(eventObj)
  {
    dragStop();
    return cancelEvent(eventObj);
  }

  function dragStop()
  {
    if(!dragging || disposed) return;
    unhookEvent(document, "mousemove", dragGo);
    unhookEvent(document, "mouseup", dragStopHook);
    cursorStartPos = null;
    elementStartPos = null;
    if(endCallback != null)
      endCallback(element);
    dragging = false;
  }

  this.Dispose = function()
  {
    if(disposed) return;
    this.StopListening(true);
    element = null;
    attachElement = null
    lowerBound = null;
    upperBound = null;
    startCallback = null;
    moveCallback = null
    endCallback = null;
    disposed = true;
  }
  
  this.GetLowerBound = function()
  { return lowerBound; }
  
  this.GetUpperBound = function()
  { return upperBound; }

  this.StartListening = function()
  {
    if(listening || disposed) return;
    listening = true;
    hookEvent(attachElement, "mousedown", dragStart);
  }

  this.StopListening = function(stopCurrentDragging)
  {
    if(!listening || disposed) return;
    unhookEvent(attachElement, "mousedown", dragStart);
    listening = false;

    if(stopCurrentDragging && dragging)
      dragStop();
  }

  this.IsDragging = function(){ return dragging; }
  this.IsListening = function() { return listening; }
  this.IsDisposed = function() { return disposed; }

  if(typeof(attachElement) == "string")
    attachElement = document.getElementById(attachElement);
  if(attachElement == null)
    attachElement = element;

  if(!attachLater)
    this.StartListening();
}
   
</script>

<script src="<%= cms.link(moduleBaseUri + "/resources/js/jquery/jquery.wheelzoom.js") %>"></script>
<script type="text/javascript">

  var el = document.getElementById('zoomImage');
  var parent = el.parentNode;
  var leftEdge = parent.clientWidth - el.clientWidth;
  var topEdge = parent.clientHeight - el.clientHeight;
  var dragObj = new dragObject(el, null, new Position(leftEdge, topEdge), new Position(0, 0));
  
</script>
<%  нахрен моя карта ненужна */ %>
        
		</div>

		<div id='simplePopup'>
			<!-- <div class="zoom" id="ex2"><center><img style="max-height: 628px !important;" rel="http://10.110.56.40/portal/opencms/common/images/net_map/bigmap.jpg" src="http://10.110.56.40/portal/opencms/common/images/net_map/bigmap.jpg" alt="" /></center></div> -->
			
			<div class="zoom" id="ex2"><center><img style="max-height: 628px !important;" rel="http://10.110.55.40/portal/opencms/common/images/net_map/bigmap.jpg" src="/system/modules/ru.onemanteam.opencms.modules.portal/resources/css/img/bigmap.jpg" alt="" /></center></div>
			
			<!-- <div style='position:absolute;bottom:64px;left:14px;border:1px solid #fff;'><img src="http://10.110.56.40/portal/opencms/common/images/net_map/legend.jpg" /></div> -->
			
			<div style='position:absolute;bottom:64px;left:14px;border:1px solid #fff;'><img src="/system/modules/ru.onemanteam.opencms.modules.portal/resources/css/img/legend.jpg" /></div>
			
			
			<div style='position:absolute;bottom:5px;right:10px;font-size:10px;cursor:pointer;'><span id='closeMe'>Закрыть (ESC)</span></div>
		</div>




<script type="text/javascript" src="/portal/opencms/common/images/net_map/jquery.zoom-min.js"></script>
<script type="text/javascript">


$(document).bind('keydown', function(e) { 
    if (e.which == 27) {
    	$('#opaco').toggleClass('hidden').removeAttr('style').unbind('click');
    	$('#simplePopup').addClass('hidden');
    }
}); 

$(document).on('click', '#closeMe', function() {
	$('#opaco').toggleClass('hidden').removeAttr('style').unbind('click');
	$('#simplePopup').addClass('hidden');
});

$(document).on('click', '#zoomMap', function() {
	$('#simplePopup').togglePopup();
});


$(document).ready(function(){
		
	   
	
	   
	   $('#ex2').zoom({duration:1800});
	
		$.fn.alignCenter = function() {
			var marginLeft =  - $(this).width()/2 + 'px';
			var marginTop =  - $(this).height()/2 + 'px';
			return $(this).css({'margin-left':marginLeft, 'margin-top':marginTop});
		};

		
		$.fn.togglePopup = function(){
			
	     if($('#simplePopup').hasClass('hidden'))
	     {

	       if($.browser.msie)
	       {
	    	   $('#opaco').height($(document).height()).toggleClass('hidden')
	                    .click(function(){$(this).togglePopup();});
	       }
	       
	       else       
	       {
	         $('#opaco').height($(document).height()).toggleClass('hidden').fadeTo('slow', 0.7)
	                    .click(function(){$(this).togglePopup();});
	       }

	       $('#simplePopup')
	         .alignCenter()
	         .toggleClass('hidden');
	     }
	     else
	     {
	    	 
	    	 $('#opaco').toggleClass('hidden').removeAttr('style').unbind('click');
	         $('#simplePopup').toggleClass('hidden');
	     }
	   };
   
	   $('#simplePopup').togglePopup();
	   
	   
	   //jQuery("#draggableElement").draggable(); 
	   $('#zoomImage').wheelzoom();

});

</script>

