local StarterGui = game:GetService("StarterGui")

        task.wait(0.1)
        StarterGui:SetCore("SendNotification", {
            Title = "Example!", -- Set the title for whatever you want.
            Text = "Main", -- Again, set the text for whatever you want.
            Duration = 3 -- Change the duration if you would like to.
        })

-- This script is really easy to make, and you can easily just find it in the Roblox Lua Docs.
