//
//  Log.swift
//
//  Created by Alan Westbrook on 2016.07.05.
//  Copyright © 2016 rockwood software. All rights reserved.
//
// It's log, it's log ... it's big, it's heavy, it's wood!

import Foundation

// Static class so that it may be acted upon from the debug console

class Log {
    
    // built in categories for convenience. I find myself using these in every project I write.
    struct Cat {
        static let config = "config error" 
        static let data = "data error"
    }
    
    struct Info {
        let categories:[String]
        let text:String
        let userInfo:AnyObject?
    }
    
    typealias LogAction = (logInfo:Info) -> Void

    private static var actions:[String:[LogAction]] = [:]
    private static var categories:[String:Bool] = [Log.Cat.config:true]
    private static var firehose:Bool = false
    
    static func message(_ category:String, text:String, userInfo:AnyObject? = nil) {
        Log.message([category], text: text, userInfo: userInfo)
    }

    static func message(_ categories:[String], text:String, userInfo:AnyObject? = nil) {
        
        var active = firehose ? 1 : 0
        
        if active == 0 {
            active = categories.reduce(0) { (current, name) -> Int in
                return ( (self.categories[name] ?? false) ? 1 : 0 ) + current
            }
        }
        
        if active > 0 {
            Log.log(categories, text: text, userInfo: userInfo)
        }
        
        Log.action(categories, text: text, userInfo: userInfo)
    }

    static func enable(_ category:String) {
        Log.categories[category] = true
    }
    
    static func disable(_ category:String) {
        Log.categories[category] = false
    }
    
    static func firehose(_ on:Bool) {
        Log.firehose = on
    }
    
    static func showCategories() {
        print(Log.categories.map({ (name, active) -> String in
            return "\(name): \(active ? "on" : "off")"
        }).joined(separator: "\n"))
    }
    
    static func addAction(action:LogAction, forCategory category:String) {
        if var actions = Log.actions[category] {
            actions.append(action)
            Log.actions[category] = actions
        }
        else {
            Log.actions[category] = [action]
        }
    }
    
    private static func log(_ categories:[String], text:String, userInfo:AnyObject?) {
        
        let catOutput = categories.joined(separator: ", ")
        
        print("[\(catOutput)]: \(text)")
    }
    
    private static func action(_ categories:[String], text:String, userInfo:AnyObject?) {
        let info = Log.Info(categories: categories, text: text, userInfo: userInfo)
        
        for cat in categories {
            if let actionsActual = actions[cat] {
                actionsActual.forEach { action in action(logInfo: info) }
            }
        }
    }
}

