function timer()
{
	if (argument_count >= 1)
	{
	    global.timertime = current_time;
	    global.timermessage = argument[0];
	}
	else
	{
	    show_debug_message(global.timermessage + ": " + string_format((current_time - global.timertime) / 1000, 6, 5));
	}
}