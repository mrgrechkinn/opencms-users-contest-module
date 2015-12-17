function timeConverter(timestamp){
 
	var a = new Date(timestamp);
 
	var months = ['янв','фев','мар','апр','май','июн','июл','авг','сен','окт','ноя','дек'];
    var year = a.getFullYear();
    var month = months[a.getMonth()];
    var date = a.getDate();
    var hour = a.getHours();
    var min = a.getMinutes();
    var sec = a.getSeconds();
    //return date+','+ month +' '+ year +' '+ hour +':'+ min +':'+ sec ;
    
    return date+' '+ month +' '+ year;
    
 }

$(document).ready(function(){
	
	
	$('input[type=search]').bind('focus blur', function() {
	    $(this).toggleClass('white-bg');
	});
	
	
	
    $(document).on("scroll",function(){
        if(window.scrollY>90) {
            $(".stripe.center.maincolor").addClass("fixed");
            $(".stripeup.center.maincolor").addClass("fixed");
            $(".header").addClass("fixedheader");
            
        } else {
            $(".stripe.center.maincolor").removeClass("fixed");
            $(".stripeup.center.maincolor").removeClass("fixed");
            $(".header").removeClass("fixedheader");
        }
    });

    
    /*
    $("#searchlink").on("click",function(){
        $(".navigation input").show().animate({"width":300,"opacity":1},function(){
            $("body").addClass("search");
        }).focus();
        return false;
    });
    */
    
    
    $(document).on('click', '.birthdays .more', function() {
    //$(".birthdays .more").on("click",function(){
        $(this).hide();
        $(".person.hidden").show();
        return false;
    });

    
    $(".switcher A").on("click",function(){
        $(".listing").hide();
        $("."+$(this).attr("class")+".listing").show();
        $(".active").removeClass("active");
        $(this).parent().addClass("active");
        return false;
    });
    
    /*
    $(".navigation .menu li").on("mouseenter",function(){
        $(this).children(".hovermenu").show();
    });
    $(".navigation .menu li").on("mouseleave",function(){
        $(this).children(".hovermenu").hide();
    });
     */

});