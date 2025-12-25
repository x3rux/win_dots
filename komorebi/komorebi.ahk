#Requires AutoHotkey v2.0
#SingleInstance Force

WorkspaceNumber := 5
ArrayFromZero(Length){
  temp := []
  Loop Length {
    temp.Push(A_Index-1)
  }
  return temp
}
; Set workspaces (start from 0)
; ArrayFromZero(7) => [0,1,2,3,4,5,6]
global numbers := ArrayFromZero(WorkspaceNumber)

init(){
  Run "komorebic float-rule title Settings", ,"Hide"
  Run "komorebic float-rule class TaskManagerWindow", , "Hide"
  Run "komorebic float-rule exe explorer.exe", , "Hide"
}
init()

reload_komorebi(){
  Run "komorebic stop", , "Hide"
  Run "komorebic start", , "Hide"
}

reload_ahk(){
  Run ".\C:\Users\user\.config\komorebi\komorebic.ahk", , "Hide"
}

; Reload conf
#+o::{ 
  reload_komorebi()
}
; #o::{ 
;   reload_ahk()
; }

; Window Manipulation
#f:: {
	Run "komorebic toggle-maximize", , "Hide"
}
#+f:: {
	Run "komorebic toggle-float", , "Hide"
}
;retile
#+r::{ 
  Run "komorebic retile", ,"Hide"
}
; Close focused window
#c::{
    WinClose("A")
}

; Change the focused window
#h::{ 
  Run "komorebic focus left", , "Hide"
}
#j::{ 
  Run "komorebic focus down", , "Hide"
}
#k::{ 
  Run "komorebic focus up", , "Hide"
}
#l::{ 
  Run "komorebic focus right", , "Hide"
}

; Move the focused window in a given direction, Alt + Shift + Vim direction keys
#+h::{ 
  Run "komorebic move left", ,"Hide"
}

#+j::{ 
  Run "komorebic move down", ,"Hide"
}

#+k::{ 
  Run "komorebic move up", ,"Hide"
}

#+l::{ 
  Run "komorebic move right", ,"Hide"
}

; Switch to Workspaces
For num in numbers{
  Hotkey("#" . (num+1), (key) => Run("komorebic focus-workspace " . Integer(SubStr(key, 2))-1, ,"Hide"))
}

; Move window to workspace
For num in numbers{
  Hotkey("#+" . (num+1), (key) => Run("komorebic move-to-workspace " . Integer(SubStr(key, 3))-1, ,"Hide"))
}

; Window resizing
#=::{
  Run "komorebic resize-axis horizontal increase", , "Hide"
}
#-::{
  Run "komorebic resize-axis horizontal decrease", , "Hide"
}
#+=::{
  Run "komorebic resize-axis vertical increase", , "Hide"
}
#+-::{
  Run "komorebic resize-axis vertical decrease", , "Hide"
}

; Launch Apps
#b::{
  Run "zen", , "Hide"
}
#Enter::{
  Run "wt.exe"
}