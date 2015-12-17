$(function() {
    $('#tabs>a').click(function() {
		
    	$('.news_text').hide();
		$('.first_news').show();
    	
        var click_id=$(this).attr('id');
        if (click_id != $('#tabs>a.visible').attr('id') ) {
            $('#tabs>a').removeClass('visible');
            $(this).addClass('visible');
            $('#tabs div').removeClass('visible');
            $('#con_' + click_id).addClass('visible');
        }
    });
});










SSS_news = {
		init : function() {
			$('.news_text').hide();
			$('.news_title').css("cursor", "pointer");

			$('.first_news').show();
			
			$('.news_title').click(function() { 
				SSS_news.open(this);
			});
		},


		open : function(elt) {
			$('.news_text').hide();
			$(elt).next().slideDown('fast');
			
		}
	};





SSS_spoiler = {
		init : function() {
			$('.spoiler_body').hide();
			$('.spoiler_title').click(function() { 
				SSS_spoiler.toggle(this);
			});
		},

		toggle : function(elt) {
			//$(elt).siblings('.spoiler_body').slideToggle('fast');
			$(elt).toggleClass("closed").toggleClass("opened").next().toggle();
		},
		
		open : function(elt) {
			
			$(elt).removeClass("closed").addClass("opened").next().show();
			//flashColor(elt.next());
		}
	};

$(function() {
	SSS_news.init();
	SSS_spoiler.init();
});




