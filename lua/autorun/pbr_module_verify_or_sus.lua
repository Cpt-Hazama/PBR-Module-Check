local function CheckPBR()
    for _, v in pairs({"bin/game_shader_dx9.dll","shaders/fxc/pbr_ps20b.vcs","shaders/fxc/pbr_ps30.vcs","shaders/fxc/pbr_vs20b.vcs","shaders/fxc/pbr_vs30.vcs"}) do
        if not file.Exists(v,"GAME") then
            return false
        end
    end
    return true
end

VJ_PBR_INSTALLED = CheckPBR()

local string_find = string.find
local function ReplacePBRMaterials(ent)
    local Materials = ent:GetMaterials()
    for _, mat in pairs(Materials) do
        mat = select(1,Material(mat))
        local shader = mat:GetShader()
        if string_find(shader, "PBR") then
            ent:SetMaterial("models/cpthazama/pbr")
            local ply = ent.GetCreator && ent:GetCreator()
            if !IsValid(ply) then
                ply = Entity(1)
            end
            ply:ChatPrint("You did not install the PBR Module for this asset, please go install it. Check the console for details...")
            MsgC(Color(255,0,0), "PBR Module:\n")
            MsgC(Color(0,136,255), "https://github.com/Cpt-Hazama/GMod-PBR-Modules\n")
            MsgC(Color(255,255,255), "Installation instructions are on the webpage. If you are still experiencing issues after installation, make sure you are on the default Garry's Mod branch. The PBR shader does not load on 64-bit. Go pester Rubat to add it natively to GMod...\n")
            break
        end
    end
end

hook.Add("OnEntityCreated", "VJ_PBR_ReadTheDescription", function(ent)
    if not VJ_PBR_INSTALLED then
        ReplacePBRMaterials(ent)
    end
end)

print(VJ_PBR_INSTALLED && "PBR Module is installed successfully!" or "PBR Module is not installed! Either you didn't read the description or you didn't install it correctly.")