function NotifyMsg(Msg)
    G_PlayerController:NotifyMsg(Msg)
end

function FormatTime(timestamp)
    return os.date("%Y-%m-%d %H:%M:%S", timestamp)
end

function Error(...)
    local args = {...}
    local InString = table.concat(args, "\t")
    NotifyMsg(InString)
    UE4.UKismetSystemLibrary.PrintString(G_PlayerController, InString, true, true, UE4.FLinearColor(1, 0, 0, 1), 2)
end