#MaxHotkeysPerInterval 200

SendMode Input
SetWorkingDir %A_ScriptDir%

CapsLock::Send, {Ctrl Down}{Shift Down}{Shift Up}{Ctrl Up}
return

<!k::
    send {up}
return 

<!j::
    send {down}
return 

<!h::
    send {left}
return 

<!l::
    send {right}
return 




<!+o::
    send {PgDn}
return 

<!+i::
    send {PgUp}
return 

<!+p:: 
  send {End}
return 

<!+u::
  send {Home}
return



<![::
    send {BackSpace}
return 

<!]::
    send {Del}
return 

<!m::
    send {enter}
return 

#Esc:: ; switch to next desktop with Windows key + Left Alt key
  KeyWait Esc
  SendInput #^{Right}
  Return

#LCtrl:: ; switch to previous desktop with Windows key + Left CTRL key
  KeyWait LCtrl
  SendInput #^{Left}
  Return

RAlt & j::
 Send #{Down}
Return

RAlt & k::
 Send #{Up}
Return

RAlt & h::
 Send #{Left}
Return

RAlt & l::
 Send #{Right}
Return
