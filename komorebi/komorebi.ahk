#SingleInstance Force

; Load library
#Include komorebic.lib.ahk

; Focus windows
; !h::Focus("left")
; !j::Focus("down")
; !k::Focus("up")
; !l::Focus("right")
; !+[::CycleFocus("previous")
; !+]::CycleFocus("next");
#left::Focus("left")
#down::Focus("down")
#up::Focus("up")
#right::Focus("right")
#+[::CycleFocus("previous")
#+]::CycleFocus("next")

; Move windows
; #+h::Move("left")
; #+j::Move("down")
; #+k::Move("up")
; #+l::Move("right")
!+Enter::Promote()
#^left::Move("left")
#^down::Move("down")
#^up::Move("up")
#^right::Move("right")

; Stack windows
#+Left::Stack("left")
#+Right::Stack("right")
#+Up::Stack("up")
#+Down::Stack("down")
#;::Unstack()
#[::CycleStack("previous")
#]::CycleStack("next")

; Resize - alt + shift
#!left::ResizeAxis("horizontal", "increase")
#!right::ResizeAxis("horizontal", "decrease")
#!up::ResizeAxis("vertical", "increase")
#!down::ResizeAxis("vertical", "decrease")

; Manipulate windows
#+F::ToggleFloat()
#f::ToggleMonocle()

; Window manager options
!r::Retile()
!p::TogglePause()
!m::Manage()

; Layouts
!x::FlipLayout("horizontal")
!y::FlipLayout("vertical")

; Workspaces
!1::FocusWorkspace(0)
!2::FocusWorkspace(1)
!3::FocusWorkspace(2)

; Move windows across workspaces
!+1::MoveToWorkspace(0)
!+2::MoveToWorkspace(1)
!+3::MoveToWorkspace(2)

#m::Minimize()
#+m::ToggleMaximize()

; RControl & RShift::AltTab  ; Hold down right-control then press right-shift repeatedly to move forward.
; RControl & Enter::ShiftAltTab  ; Without even having to release right-control, press Enter to reverse direction.