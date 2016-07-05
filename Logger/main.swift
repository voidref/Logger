//
//  main.swift
//  Logger
//
//  Created by Alan Westbrook on 7/5/16.
//  Copyright © 2016 Rockwood. All rights reserved.
//

import Foundation

// enable categories you want to show
Log.enable(Log.Cat.data)
Log.message(Log.Cat.data, text: "Data is missing!")

// You can have an action performed any time a category is logged. This can be useful for things like analytics logging via the log interface in order to reduce the dependency on any one analytics library in your application.
// Actions are always called, even for disabled categories.
Log.addAction(action: { (logInfo) in
    print("log info: \(logInfo)")
    }, forCategory: Log.Cat.config)

// The Log.Cat.config category is enabled by default. This is generally for displaying errors in your configuration which would have serious impacts on your appliation's functionality, e.g.: missing resources
// The optional userInfo can be any object, it's only ever passed along to the log actions you have defined.
Log.message(Log.Cat.config, text:"Config error happened, or something", userInfo: ["keyName": "This is extra info!"])

// Logging a message without enabling the category will result in no output
Log.message("change", text:"This message will not show")
Log.enable("change")
Log.message("change", text:"This message will show!")

/*
     Set a breakpoint at the next line, and type: 
       ex Log.enable("during debug")
     in the console then continue execution
*/

Log.message("during debug", text:"If you follow the above instruction, this will display.")

