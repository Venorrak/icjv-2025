extends Node
class_name BBcodeBuilder

func center(text : String) -> String:
	text = "[center]" + text
	text += "[/center]"
	return text
	
func color(text : String, color : Color) -> String:
	text = "[color=" + str(color.to_html(false)) + "]" + text
	text += "[/color]"
	return text
	
func fontSize(text : String, fontSize : int) -> String:
	text = "[font_size=" + str(fontSize) + "]" + text
	text += "[/font_size]"
	return text

func bold(text : String) -> String:
	text = "[b]" + text + "[/b]"
	return text
	
func italic(text: String) -> String:
	text = "[i]" + text + "[/i]"
	return text
	
func underline(text : String) -> String:
	text = "[u]" + text + "[/u]"
	return text

func right(text : String) -> String:
	text = "[left]" + text + "[/left]"
	return text
	
func bgColor(text : String, color : Color) -> String:
	text = "[bgcolor=" + str(color.to_html(false)) + "]" + text + "[/bgcolor]"
	return text
	
func fgColor(text : String, color : Color) -> String:
	text = "[fgcolor=" + str(color.to_html(false)) + "]" + text + "[/fgcolor]"
	return text

func outline(text : String, color : Color, size: int) -> String:
	text = "[outline_size=" + str(size) + "][outline_color=" + str(color.to_html(false)) + "]" + text
	text += "[/outline_color][/outline_size]"
	return text
	
func pulse(text : String, freq : float, color : Color, ease : float) -> String:
	text = "[pulse freq" + str(freq) + " color=" + str(color.to_html(false)) + " ease=" + str(ease) + "]" + text
	text += "[/pulse]"
	return text
	
func wave(text : String, amp : float, freq : float, connected : bool) -> String:
	text = "[wave amp=" + str(amp) + " freq=" + str(freq) + " connected=" + str(int(connected)) + "]" + text + "[/wave]"
	return text

func tornado(text : String, radius : float, freq : float, connected : bool) -> String:
	text = "[tornado radius=" + str(radius) + " freq=" + str(int(connected)) + "]" + text + "[/tornado]"
	return text
	
func shake(text : String, rate : float, level : int, connected : bool) -> String:
	text = "[shake rate=" + str(int(rate)) + " level=" + str(level) + " connected=" + str(int(connected)) + "]" + text
	text += "[/shake]"
	return text

func fade(text : String, start : int, length : int) -> String:
	text = "[fade start=" + str(start) + " length=" + str(length) + "]" + text + "[/fade]"
	return text
	
func rainbow(text : String, freq : float, sat: float, val : float) -> String:
	text = "[rainbow freq=" + str(freq) + " sat=" + str(sat) + " val=" + str(val) + "]" + text + "[/rainbow]"
	return text
