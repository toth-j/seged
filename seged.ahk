; Seg�d 1.0
; (C) T�th J�zsef, 2022

#SingleInstance force
SetWorkingDir %A_ScriptDir%
SetTitleMatchMode,2
SendMode Input

;men�
Menu Tray, nostandard 
Menu Tray, Add, &R�vid�t�sek, Sajat
Menu Tray, Add, &Program mapp�ja, Mappa
Menu Tray, Add, 
Menu Tray, Add, &S�g�, Sugo
Menu Tray, Add, &Le�r�s, Leiras
Menu Tray, Add, &N�vjegy..., Nevjegy
Menu Tray, Add, 
Menu Tray, Add, &Automatikus ind�t�s, Autind
Menu Tray, Add, &Felf�ggeszt�s, Felfugg
Menu Tray, Add, &�jrat�lt�s, Ujra
Menu Tray, Add, &Kil�p�s..., Kilep

;automatikus ind�t�s vizsg�lata
ifexist, %A_Startup%\seged.lnk
{
	auto:=1
	Menu, Tray ,Check, &Automatikus ind�t�s
}
else
{
	auto:=0
	Menu, Tray, UnCheck, &Automatikus ind�t�s
}

;t�lca ikon
IfExist seged.ico
	Menu Tray, Icon, seged.ico 
Menu Tray, Tip, Seg�d 1.0
Menu Tray, Default, &R�vid�t�sek

;tizedespont kikapcsolva
Hotkey,NumPadDot,pont,off

return
;===============================================================
;tizedespont bekapcsol�sa
pont:
	send .
return
^#NumPadDot::
#NumPadDot::Hotkey, NumPadDot, Toggle
return
;men�pontok-------------------------------------------------------
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
	MsgBox,64,Seg�d 1.0,(C) T�th J�zsef`, 2022`nhttps://toth-j.github.io`n`nG�pn�v: %A_ComputerName%`nFelhaszn�l�: %A_UserName%`nWindows: %A_OSVersion%`n`nK�sz�lt a Pog�ny Frigyes technikumban.`nTanulj n�lunk informatik�t!`nhttps://poganysuli.hu
return
Autind:
	if (auto=1)
	{
		FileDelete,%A_Startup%\seged.lnk
		auto:=0
		Menu,Tray,Uncheck,&Automatikus ind�t�s
	}
	else
	{
		FileCreateShortcut, %A_Scriptdir%\seged.ahk, %A_Startup%\seged.lnk,%A_Scriptdir%,,, %A_Scriptdir%\seged.ico
		auto:=1
		Menu,Tray,Check,&Automatikus ind�t�s
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
;saj�t r�vid�t�sek
#Hotstring o
#Hotstring EndChars `t
#Include sajat.txt

;saj�t r�vid�t�sek szerkeszt�se
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
;d�tum besz�r�sa
^#N::
	FormatTime,datum,,LongDate
	SendInput %datum%
return
;---------------------------------------------------------------------
; id�z�jelek
^#�::send �
^#�::send �
;---------------------------------------------------------------------
;s�g�
^#F1::
	IfWinExist seged.txt
		WinActivate
	else
		IfExist seged.txt
			run notepad seged.txt
		else
			msgbox 16,Seg�d 1.0,Nem tal�lom a seged.txt f�jlt!
return
;-----------------------------------------------------------------
;le�r�s
^#F2::
	run https://toth-j.github.io/seged.html
return
;-----------------------------------------------------------------
;suspend hotkeys
+Pause::
	suspend
	Menu Tray, ToggleCheck, &Felf�ggeszt�s
return
;-----------------------------------------------------------------
;kil�p�s
^#Q::
	MsgBox 36,Seg�d 1.0,Ki szeretn�l l�pni?
	IfMsgBox Yes
		ExitApp
return
;-----------------------------------------------------------------
;men� megjelen�t�se
#Y::
	Menu Tray,Show
return
