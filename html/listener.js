window.addEventListener('message', (event) => {
    if (event.data.display === true) {
        $('.telegram').html(event.data.message);
		$("*").show();
    } else {
		$("*").hide();
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
