function NotifyMsg(Msg)
    G_PlayerController:NotifyMsg(Msg)
end

function FormatTime(timestamp)
    return os.date("%Y-%m-%d %H:%M:%S", timestamp)
end