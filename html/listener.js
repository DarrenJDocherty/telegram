window.addEventListener('message', (event) => {
	var telegram = event.data 

	if (telegram.message == null) {
		$("body").hide();
		console.log("Null")
	} else if (telegram.message == "No telegrams to display.") {
		console.log(telegram.message)
		$("body").show();
		$('.telegram_message').html(telegram.message);
	} else {
		console.log(telegram.sender)
		console.log(telegram.message)
		$("body").show();
		$('.telegram_sender').html("Troye Hamilton");
		$('.telegram_message').html(telegram.message);
	}
	
	$(".telegram_back_button").unbind().click(function(){
		$.post('http://telegram/back', JSON.stringify({})
	  );
	});

	$(".telegram_next_button").unbind().click(function(){
		$.post('http://telegram/next', JSON.stringify({})
	  );
	});

	$(".telegram_new_button").unbind().click(function(){
		$.post('http://telegram/new', JSON.stringify({})
	  );
	});

	$(".telegram_close_button").unbind().click(function(){
		$.post('http://telegram/close', JSON.stringify({})
	  );
	});
});

function Post(endpoint, data) {
	$.post('http://' + resource + '/' + endpoint + '', JSON.stringify(data))
}
