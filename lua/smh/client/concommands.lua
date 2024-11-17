concommand.Add("+smh_menu", function()
    SMH.Controller.OpenMenu()
end)

concommand.Add("-smh_menu", function()
    SMH.Controller.CloseMenu()
end)

concommand.Add("smh_record", function()
    SMH.Controller.Record()
end)

concommand.Add("smh_delete", function()
	local frame = SMH.State.Frame
	local ids = SMH.UI.GetKeyframesOnFrame(frame)
	if not ids then return end

    SMH.Controller.DeleteKeyframe(ids)
end)

concommand.Add("smh_next", function()
    local pos = SMH.State.Frame + 1
    if pos >= SMH.State.PlaybackLength then
        pos = 0
    end
    SMH.Controller.SetFrame(pos)
end)

concommand.Add("smh_previous", function()
    local pos = SMH.State.Frame - 1
    if pos < 0 then
        pos = SMH.State.PlaybackLength - 1
    end
    SMH.Controller.SetFrame(pos)
end)

concommand.Add("+smh_playback", function()
    SMH.Controller.StartPlayback()
end)

concommand.Add("-smh_playback", function()
    SMH.Controller.StopPlayback()
end)

concommand.Add("smh_quicksave", function()
    SMH.Controller.QuickSave()
end)

concommand.Add("smh_makejpeg", function(pl, cmd, args)
    local startframe
    if args[1] then
        startframe = args[1] - GetConVar("smh_startatone"):GetInt()
    else
        startframe = 0
    end
    if startframe < 0 then startframe = 0 end
    if startframe < SMH.State.PlaybackLength then
        SMH.Controller.ToggleRendering(false, startframe)
    else
        print("Specified starting frame is outside of the current Frame Count!")
    end
end)

concommand.Add("smh_makescreenshot", function(pl, cmd, args)
    local startframe
    if args[1] then
        startframe = args[1] - GetConVar("smh_startatone"):GetInt()
    else
        startframe = 0
    end
    if startframe < 0 then startframe = 0 end
    if startframe < SMH.State.PlaybackLength then
        SMH.Controller.ToggleRendering(true, startframe)
    else
        print("Specified starting frame is outside of the current Frame Count!")
    end
end)

concommand.Add("smh_smoothone", function()
    local tab = {}
    table.insert(tab,"Record")
    table.insert(tab,"Next")
    table.insert(tab,"Record")
    table.insert(tab,"Prev")
    table.insert(tab,"Prev")
    table.insert(tab,"Record")
    table.insert(tab,"Next")
    table.insert(tab,"Remove")
    SmoothRunComms(tab)

end)


concommand.Add("smh_smooth", function(ply,cmd,args)
    local tab = {}
    table.insert(tab,"Record")
    table.insert(tab,"Next")
    table.insert(tab,"Record")
    table.insert(tab,"Prev")
    table.insert(tab,"Prev")
    table.insert(tab,"Record")
    table.insert(tab,"Next")
    table.insert(tab,"Remove")
    table.insert(tab,"Next")
    table.insert(tab,"Next")
    table.insert(tab,"Record")
    table.insert(tab,"Prev")
    table.insert(tab,"Prev")
    table.insert(tab,"Record")
    table.insert(tab,"Prev")
    table.insert(tab,"Prev")
    table.insert(tab,"Record")
    table.insert(tab,"Next")
    table.insert(tab,"Remove")

    local j = 1
    local k = 3
    for i=1,args[1] do
        for i=1,j do
        table.insert(tab,"Next")
        table.insert(tab,"Next")
        table.insert(tab,"Remove")
        end
        table.insert(tab,"Next")
        table.insert(tab,"Next")
        table.insert(tab,"Record")
        for i=1,k do
        table.insert(tab,"Prev")
        table.insert(tab,"Prev")
        table.insert(tab,"Record")
        end
        table.insert(tab,"Next")
        table.insert(tab,"Remove")
        
        j = j +1
        k = k +1
    end
    for i=1,j do
        table.insert(tab,"Next")
        table.insert(tab,"Next")
        table.insert(tab,"Remove")
    end
    table.insert(tab,"Next")

    SmoothRunComms(tab)

end);

function Remove()
    RunConsoleCommand("smh_delete","");
end
function Next()
    RunConsoleCommand("smh_next","")
end
function Prev()
    RunConsoleCommand("smh_previous","")
end
function Record()
    RunConsoleCommand("smh_record","")
end

function SmoothRunComms(tab)
    local timestart = 0.01
    local timeinterval = 0.05
    for key,comm in ipairs(tab) do
        timer.Simple(timestart, function() 
            _G[comm]()
        end
        )
        timestart = timestart + timeinterval
    end
    
end

CreateClientConVar("smh_startatone", 0, true, false, nil, 0, 1)
CreateClientConVar("smh_currentpreset", "default", true, false)
