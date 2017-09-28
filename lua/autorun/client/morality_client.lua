
local MOR_PAN

net.Receive("Morality_Punishment", function(len)
  local lvl = net.ReadInt(8)

  local hp
  local dmg

  if lvl == 1 then
    hp = 90
    dmg = 90
  elseif lvl == 2 then
    hp = 70
    dmg = 70
  elseif lvl == 3 then
    hp = 50
    dmg = 50
  elseif lvl == 4 then
    hp = 50
    dmg = 30
  elseif lvl >= 5 then
    hp = 40
    dmg = 15
  end

  if IsValid(MOR_PAN) then
    MOR_PAN:Hide()
    MOR_PAN:Remove()
    MOR_PAN = nil
  end

  local pan = vgui.Create("DLabel")
  pan:SetText("Health reduction: -" .. hp .. "% | Damage reduction: -" .. dmg .. "%")
  pan:SetFont("Trebuchet18")
  pan:SetColor(Color(255, 0, 0))
  pan:SetPos(0, 16)
  pan:CenterHorizontal()
  pan:Show()
  MOR_PAN = pan
end)
