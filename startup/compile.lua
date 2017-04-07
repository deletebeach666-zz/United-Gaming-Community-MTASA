function getResourceScripts(resource)
    local scripts = {}
    local resourceName = getResourceName(resource)
    local theMeta = xmlLoadFile(":"..resourceName.."/meta.xml")
    for i, node in ipairs (xmlNodeGetChildren(theMeta)) do
        if (xmlNodeGetName(node) == "script") then
            local script = xmlNodeGetAttribute(node, "src")
			local stype =  xmlNodeGetAttribute(node, "type")
            if (script and stype == "client") then
                table.insert(scripts, script)
            end
        end
    end
    return scripts
end


addEventHandler("onResourceStart", root, function(res)
    for i, script in ipairs(getResourceScripts(res)) do
        local localFile = ":"..getResourceName(res).."/"..script
        local theScript = fileExists(localFile) and fileOpen(localFile, true)
        if theScript then
            local code = fileRead(theScript, fileGetSize(theScript)), fileClose(theScript)
            if not (string.byte(code) == 28) then
                if (fetchRemote("http://luac.mtasa.com/?compile=1&debug=0&obfuscate=1", myCallback, code, true, localFile, source)) then
                    
                else
                    --print("Unable to compile " .. getResourceName(res) .. "!")
                end
            end
        end
    end
    --print("Resource: " .. getResourceName(res) .. " is now compiled!")
end)

    
function myCallback(responseData, errno, localFile, source)
    if (errno == 0) and (responseData) then
        local localFileC = localFile.."c"
        if (string.find(responseData, "ERROR")) then
            --outputChatBox(localFile..": "..responseData, source, 255, 0, 0)
        else
            if (fileExists(localFileC)) then fileDelete(localFileC) end
            local theScriptC = fileCreate(localFileC)
            if (theScriptC) then
                fileWrite(theScriptC, responseData)
                fileClose(theScriptC)
                --outputChatBox(localFile..": Successfully compiled", source, 0, 255, 0)
            else
                --outputChatBox(localFile..": Failed to compiled", source, 255, 0, 0)
            end
        end
    else
        --outputChatBox(localFile..": Failed get compiled code", source, 255, 0, 0)
    end
end