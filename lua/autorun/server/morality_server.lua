
Morality = {}
Morality.players = {}

util.AddNetworkString("Morality_Punishment")

hook.Add("PlayerDeath", "Morality-OnDeath", function(vic, inf, att)
  if IsPlayer(att) then
    if team.GetName(vic:Team()) == "Innocents" and team.GetName(att:Team()) == "Innocents" then
      if not Morality.players[att:SteamID64()] then
        Morality.players[att:SteamID64()] = 1
      else
        Morality.players[att:SteamID64()] = Morality.players[att:SteamID64()] + 1
      end
      if Morality.players[att:SteamID64()] >= 5 then
        att:Kill()
        for k, v in pairs(player.GetAll()) do
          v:ChatPrint(att:GetName() .. " couldn't take the guilt of killing so many innocent people.")
        end
      end
    end
  end
end)

hook.Add("TTTPrepareRound", "Morality-SetDamageDampener", function()
  for k, v in pairs(player.GetAll()) do
    v.MDamageMulti = nil
    if Morality.players[v:SteamID64()] then
      local a = Morality.players[v:SteamID64()]
      if a == 1 then
        v.MDamageMulti = 0.9
        v:SetHealth(90)
      elseif a == 2 then
        v.MDamageMulti = 0.7
        v:SetHealth(70)
      elseif a == 3 then
        v.MDamageMulti = 0.5
        v:SetHealth(50)
      elseif a == 4 then
        v.MDamageMulti = 0.3
        v:SetHealth(50)
      elseif a >= 5 then
        v.MDamageMulti = 0.15
        v:SetHealth(40)
      end
      net.Start("Morality_Punishment")
      net.WriteInt(a, 8)
      net.Send(v)
      Morality.players[att:SteamID64()] = math.max(Morality.players[att:SteamID64()] - 1, 0)
    end
  end
end)

hook.Add("ScalePlayerDamage", "Morality-ScaleDamage", function(ply, hg, dmg)
  local att = dmg:GetAttacker()
  if IsPlayer(att) then
    if att.MDamageMulti then
      dmg:ScaleDamage(att.MDamageMulti)
    end
  end
end)
