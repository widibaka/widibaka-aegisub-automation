--[[
README:

Indo: Menambahkan teks di clipboard ke awal kalimat di line yang di-select.
Eng: Append text from clipboard into selected lines.

Makes all lines in the selection italic.
]]

--Script properties
script_name="DiaKomen Plus"
script_description="Copy-Paste Line yang sudah dijadikan komentar ke samping kirinya"
script_author="widibaka"
script_version="0.5"

--Function utama
function italicize(sub, sel)
	--Go through all the lines in the selection
	for si,li in ipairs(sel) do
		
		--Read in the line
		local line=sub[li]
		teks=line.text
		-- SCRIPT DIAKOMEN MAXFIREHEART
		:gsub("\\N","_br_")
		:gsub("{([^\\}]-)}","}%1{")		
		:gsub("^([^{]+)","{%1")		
		:gsub("([^}]+)$","%1}")		
		:gsub("([^}])({\\[^}]-})([^{])","%1}%2{%3")		
		:gsub("^({\\[^}]-})([^{])","%1{%2")		
		:gsub("([^}])({\\[^}]-})$","%1}%2")		
		:gsub("{}","")
		
		:gsub("_br_","\\N")
		:gsub("%(x","{%(x")
		:gsub("q%)","q%)}")
		
		--Menggabungkan comment + uncommented text
		line.text=line.text..teks
		
		--Put the line back into the subtitles
		sub[li]=line
		
	end
	
	--Set undo point and maintain selection
	aegisub.set_undo_point(script_name)
	return sel
end

--Register macro (no validation function required)
aegisub.register_macro(script_name,script_description,italicize)