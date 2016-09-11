# Logger
A simple, debug console interactive, categorized, logging facility

Enable categories you want to show

    Log.enable(Log.Cat.data)
    Log.message(Log.Cat.data, text: "Data is missing!")

You can have an action performed any time a category is logged. This can be useful for things like analytics logging via the log interface in order to reduce the dependency on any one analytics library in your application.

Actions are always called, even for disabled categories.

    Log.addAction(action: { (logInfo) in
    print("log info: \(logInfo)")
    }, forCategory: Log.Cat.config)

The `Log.Cat.config` category is enabled by default. This is generally for displaying errors in your configuration which would have serious impacts on your appliation's functionality, e.g.: missing resources

The optional `userInfo` can be any object, it's only ever passed along to the log actions you have defined.

    Log.message(Log.Cat.config, text:"Config error happened, or something", userInfo: ["keyName": "This is extra info!"])

Logging a message without enabling the category will result in no output

    Log.message("change", text:"This message will not show")

Use `enable(String:name)` to have the output show up

    Log.enable("change")
    Log.message("change", text:"This message will show!")

You can set a breakpoint and use the following in the debug console then continue execution

    lldb$ ex Log.enable("during debug")

Assuming you have done this *before* the following line in the code, you will see the output.

    Log.message("during debug", text:"If you follow the above instruction, this will display.")

Messages can have more than one category:

    Log.message(["net", "frontend"], text: "Network connection to the frontend server stuff, or what have you.")
