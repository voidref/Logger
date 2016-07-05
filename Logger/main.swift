//
//  main.swift
//  Logger
//
//  Created by Alan Westbrook on 7/5/16.
//  Copyright © 2016 Rockwood. All rights reserved.
//

import Foundation

Log.enable(Log.Cat.data)

Log.message(Log.Cat.data, text: "Data is missing!")

Log.addAction(action: { (logInfo) in
    print("log info: \(logInfo)")
    }, forCategory: Log.Cat.config)

Log.message(Log.Cat.config, text:"Config error happened, or something", userInfo: ["keyName": "This is extra info!"])

Log.message("not yet enabled", text:"This message will not show")
Log.enable("not yet enabled")
Log.message("not yet enabled", text:"This message will now show!")

/*
     Set a breakpoint at the next line, and type: 
       ex Log.enable("during debug")
     in the console then continue execution
*/

Log.message("during debug", text:"enable 'during debug' in the debug console and then run this line")
