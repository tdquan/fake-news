$(document).ready(function(){
	rememberScrollY();
	if (sessionStorage.getItem("scrollPos")) {
		$(document).scrollTop(sessionStorage.getItem("scrollPos"));
	}
})

var rememberScrollY = function(){
	$(window).on("unload", function(){
		sessionStorage.setItem("scrollPos", $(document).scrollTop());
	})
}
