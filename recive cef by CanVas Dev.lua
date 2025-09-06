require 'lib.moonloader'
require 'lib.samp.events'

local isActive = false

function onReceivePacket(id, bs)
    if not isActive then return end

    if id == 215 then
        raknetBitStreamReadInt8(bs)
        local style = raknetBitStreamReadInt16(bs)
        local types = raknetBitStreamReadInt32(bs)

        if style == 2 then
            raknetBitStreamReadInt8(bs)

            local len1 = raknetBitStreamReadInt32(bs)
            local str1 = raknetBitStreamReadString(bs, len1):gsub("[\r\n]", "")

            local len2 = raknetBitStreamReadInt32(bs)
            local str2 = raknetBitStreamReadString(bs, len2):gsub("[\r\n]", "")

            if str1 ~= "" then
                print(str1 .. (str2 ~= "" and (" " .. str2) or ""))
            elseif str2 ~= "" then
                print(str2)
            end
        end
    end
end

function main()
    while not isSampAvailable() do wait(0) end
    sampAddChatMessage('{ff0000}[RC CEF] {ffffff}By "CanVas Dev" Активация F4', 0x404040)
    printStringNow("[RC CEF by CanVas Dev] [Activate - F4]", 2500)

    while true do
        wait(0)
        if wasKeyPressed(VK_F4) then
            isActive = not isActive
            printStringNow(isActive and "[RC CEF Status] [Active]" or "[RC CEF Status] [Inactive]", 2500)
        end
    end
end