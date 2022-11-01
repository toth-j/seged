; Segéd 1.0
; (C) Tóth József, 2022

#SingleInstance force
SetWorkingDir %A_ScriptDir%
SetTitleMatchMode,2
SendMode Input

;menü
Menu Tray, nostandard 
Menu Tray, Add, &Rövidítések, Sajat
Menu Tray, Add, &Program mappája, Mappa
Menu Tray, Add, 
Menu Tray, Add, &Súgó, Sugo
Menu Tray, Add, &Leírás, Leiras
Menu Tray, Add, &Névjegy..., Nevjegy
Menu Tray, Add, 
Menu Tray, Add, &Automatikus indítás, Autind
Menu Tray, Add, &Felfüggesztés, Felfugg
Menu Tray, Add, &Újratöltés, Ujra
Menu Tray, Add, &Kilépés..., Kilep

;automatikus indítás vizsgálata
ifexist, %A_Startup%\seged.lnk
{
	auto:=1
	Menu, Tray ,Check, &Automatikus indítás
}
else
{
	auto:=0
	Menu, Tray, UnCheck, &Automatikus indítás
}

;tálca ikon
IfExist seged.ico
	Menu Tray, Icon, seged.ico 
Menu Tray, Tip, Segéd 1.0
Menu Tray, Default, &Rövidítések

;tizedespont kikapcsolva
Hotkey,NumPadDot,pont,off

return
;===============================================================
;tizedespont bekapcsolása
pont:
	send .
return
^#NumPadDot::
#NumPadDot::Hotkey, NumPadDot, Toggle
return
;menüpontok-------------------------------------------------------
Sajat:
	gosub ^#Space
return
Mappa:
	run %A_Scriptdir%
return
Sugo:
	gosub ^#F1
return
Leiras:
	gosub ^#F2
return
Nevjegy:
	MsgBox,64,Segéd 1.0,(C) Tóth József`, 2022`nhttps://toth-j.github.io`n`nGépnév: %A_ComputerName%`nFelhasználó: %A_UserName%`nWindows: %A_OSVersion%`n`nKészült a Pogány Frigyes technikumban.`nTanulj nálunk informatikát!`nhttps://poganysuli.hu
return
Autind:
	if (auto=1)
	{
		FileDelete,%A_Startup%\seged.lnk
		auto:=0
		Menu,Tray,Uncheck,&Automatikus indítás
	}
	else
	{
		FileCreateShortcut, %A_Scriptdir%\seged.ahk, %A_Startup%\seged.lnk,%A_Scriptdir%,,, %A_Scriptdir%\seged.ico
		auto:=1
		Menu,Tray,Check,&Automatikus indítás
	}
return
Felfugg:  
	gosub +Pause
return
Ujra:
	reload
return
Kilep:
	gosub ^#Q
return
;-----------------------------------------------------------------
;saját rövidítések
#Hotstring o
#Hotstring EndChars -
#Include sajat.txt

;saját rövidítések szerkesztése
^#Space::
	IfWinExist sajat.txt
		WinActivate
	else {
		ifnotexist sajat.txt
			fileappend,,sajat.txt
		run notepad sajat.txt
	}
	WinWait,sajat.txt
return
;---------------------------------------------------------------------
;dátum beszúrása
^#N::
	FormatTime,datum,,LongDate
	SendInput %datum%
return
;---------------------------------------------------------------------
; idézõjelek
^#ö::send „
^#ü::send ”
;---------------------------------------------------------------------
;súgó
^#F1::
	IfWinExist seged.txt
		WinActivate
	else
		IfExist seged.txt
			run notepad seged.txt
		else
			msgbox 16,Segéd 1.0,Nem találom a seged.txt fájlt!
return
;-----------------------------------------------------------------
;leírás
^#F2::
	run https://toth-j.github.io/seged.html
return
;-----------------------------------------------------------------
;suspend hotkeys
+Pause::
	suspend
	Menu Tray, ToggleCheck, &Felfüggesztés
return
;-----------------------------------------------------------------
;kilépés
^#Q::
	MsgBox 36,Segéd 1.0,Ki szeretnél lépni?
	IfMsgBox Yes
		ExitApp
return
;-----------------------------------------------------------------
;menü megjelenítése
#Y::
	Menu Tray,Show
return
