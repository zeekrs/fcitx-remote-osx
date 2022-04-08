//
//  main.swift
//  fcitx-remote-osx
//
//  Created by zeekrs on 2022/3/22.
//

import Foundation
import Carbon


let EN_KEYLAYOUT = "com.apple.keylayout.ABC"

//let CN_KEYLAYOUT = "com.apple.inputmethod.SCIM.ITABC"
let CN_KEYLAYOUT = "com.sogou.inputmethod.sogou.pinyin"




func getImnameFromSource(_ source :TISInputSource) -> String{
    if let  property = TISGetInputSourceProperty(source,kTISPropertyInputSourceID) {
        return Unmanaged<AnyObject>.fromOpaque(property).takeUnretainedValue() as! String
    }
    return ""
}


func getCurrentImname() -> String {
    let currentKeyboardInputSource = TISCopyCurrentKeyboardInputSource().takeRetainedValue()
    return getImnameFromSource(currentKeyboardInputSource)
}

func switchTo(_ name:String) {
    
    let inputSources = TISCreateInputSourceList(nil, false).takeRetainedValue() as! [TISInputSource]
    
    let inputSource =  inputSources.first { source in
        
        return getImnameFromSource(source) == name
    }
    if(inputSource == nil){
        print("fail to select InputSource for [\(name)]")
        return;
    }
    
    TISSelectInputSource(inputSource)
    
}

func status() -> Int{
    if(getCurrentImname() == EN_KEYLAYOUT){
        return 1;
    }else if(getCurrentImname() == CN_KEYLAYOUT){
        return 2;
    }else{
        return 0
    }
}

func active(){
    if(status() != 2){
        switchTo(CN_KEYLAYOUT)
    }
}

func inactive(){
    if(status() != 1){
        switchTo(EN_KEYLAYOUT)
    }
}

func switchBetween(){
    if(status() == 1){
        switchTo(CN_KEYLAYOUT)
    }else{
        switchTo(EN_KEYLAYOUT)
    }
    
}



let args = CommandLine.arguments

let help = """
       -c     inactivate input method

       -o     activate input method

       -t     switch between active/inactive

       -n     display current imname

       -s imname
              switch to the input method uniquely identified by imname

       [no option]
              display fcitx state, 0 for close, 1 for inactive, 2 for active

       -h     display help and exit
"""
if( args.count > 1){
    
    switch args[1]{
    case "-c":
        inactive()
        break
    case "-o":
        active()
        break
    case "-t":
        switchBetween()
        break
    case "-n":
        print(getCurrentImname())
        break
    case "-s":
        if(args.count > 2){
            switchTo(args[2])
        }else{
            print("imname can't be empty")
        }
        break
    case "-h":
        print(help)
    default:
        print( "unknow command \"\(args[1])\" for \"fcitx-remote\"")
        break
    }
    
}else{
    
    print(String(describing: status()))
    
}

