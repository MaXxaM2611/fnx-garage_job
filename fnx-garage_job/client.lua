--M uwu

local vehiclespawned = {}
local CicloSleep = false

ESX = exports.es_extended:getSharedObject()

--Eventi 

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
    TriggerServerEvent("fnx-garage_job:GetConfig")
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

RegisterNetEvent("mxm_doublejob:updateJob")
AddEventHandler("mxm_doublejob:updateJob",function (job)
    PlayerJob_2 = job
end)


RegisterNetEvent("fnx-garage_job:UpdateConfig",function (cf)
    Config = cf
end)


--Loop 

Citizen.CreateThread(function()

    TriggerServerEvent("fnx-garage_job:GetConfig")
    RequestAnimDict("anim@mp_player_intmenu@key_fob@")
    while not HasAnimDictLoaded("anim@mp_player_intmenu@key_fob@") do
        Wait(0)
    end
    while Config == nil do Wait(10) end
    RegisterKeyMapping('fnx-lock', 'Chiudi il veicolo Aziendale', 'keyboard',Config.KeyLock) 



    while true do
        Wait(5)
        CicloSleep = true

        for k, v in pairs(Config) do 
            if v.coords then
                for a, b in pairs(v.coords) do
               
                    local Distanza = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),b.x, b.y, b.z, true)
                    local marker_config = v.marker_config[a]--coords 

                    if  Distanza <= marker_config.render_distance and v.public or Distanza <= marker_config.render_distance and ControllJob(v.jobsallowisted,v.using_mxm_double_job)  then
                        CicloSleep = false
                        if marker_config.show_marker then
                            DrawMarker(marker_config.type,b.x, b.y, b.z, 0, 0, 0, 0, 0, 0, marker_config.scale, marker_config.rgb, 200, true, true, true, true)
                        end
                        if marker_config.intercation then
                            if Distanza <= marker_config.interaction_distance then
                                if marker_config.text_notify then
                                    TestoDestra(marker_config.text)
                                end
                                if IsControlJustReleased(1, 51) then
                                    Function(k,a)
                                end
                            end
                        end
                    end
                end
            end
        end
        if CicloSleep then
            Wait(150)
        end
    end
end)






RegisterCommand("fnx-lock", function()
    

    local vehicle
	if IsPedInAnyVehicle(PlayerPedId(), false) then
		vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
	else
		vehicle = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 8.0, 0, 71)
	end
    if vehicle == nil then return end
    local myplate = GetVehicleNumberPlateText(vehicle)
	local vehcoords = GetEntityCoords(vehicle)
	local coords = GetEntityCoords(PlayerPedId())
	local isLocked = GetVehicleDoorLockStatus(vehicle)
    if DoesEntityExist(vehicle) and isOwnedVehicle(myplate) then
        if #(vehcoords - coords) < 5 then
            if (isLocked == 1) then
                PlaySoundFrontend(-1, "BUTTON", "MP_PROPERTIES_ELEVATOR_DOORS", 1)
                TaskPlayAnim(PlayerPedId(), "anim@mp_player_intmenu@key_fob@", "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
                SetVehicleDoorsLocked(vehicle, 2)
                Notifica("Hai chiuso il veicolo aziendale")
                SetVehicleLights(vehicle, 2)
                Wait (200)
                SetVehicleLights(vehicle, 0)
                Wait (200)
                SetVehicleLights(vehicle, 2)
                Wait (400)
                SetVehicleLights(vehicle, 0)
            else
                PlaySoundFrontend(-1, "BUTTON", "MP_PROPERTIES_ELEVATOR_DOORS", 1)
                TaskPlayAnim(PlayerPedId(), "anim@mp_player_intmenu@key_fob@", "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
                SetVehicleDoorsLocked(vehicle,1)
                Notifica("Hai aperto il veicolo aziendale")
                SetVehicleLights(vehicle, 2)
                Wait (200)
                SetVehicleLights(vehicle, 0)
                Wait (200)
                SetVehicleLights(vehicle, 2)
                Wait (400)
                SetVehicleLights(vehicle, 0)
            end
        else
            Notifica("Non puoi interagire con questo veicolo")
        end
    else
        Notifica("Non puoi interagire con questo veicolo")
    end
end)




-- Funzioni

function Notifica(msg)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(msg)
    DrawNotification(0,1)
end


function TestoDestra(msg)
    SetTextComponentFormat('STRING')
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

ControllJob = function (datajob,using_mxm_double_job)
    if not using_mxm_double_job then
        local myjob_name = ESX.GetPlayerData().job.name
        local myjob_grade = ESX.GetPlayerData().job.grade
        if datajob[myjob_name] and tonumber(datajob[myjob_name]) and (datajob[myjob_name] <= myjob_grade) then
            return true
        end
    else
        local myjob_name = ESX.GetPlayerData().job.name
        local myjob_grade = ESX.GetPlayerData().job.grade
        local myjob_name2 = exports["mxm_doublejob"]:getJob().name 
        local myjob_grade2 = exports["mxm_doublejob"]:getJob().grade    
        if (datajob[myjob_name] and tonumber(datajob[myjob_name]) and (datajob[myjob_name] <= myjob_grade)) or (datajob[myjob_name2] and tonumber(datajob[myjob_name2]) and (datajob[myjob_name2] <= myjob_grade2)) then
            return true
        end
    end
end


Function = function (index,ty)
    if ty == "ritiro" then
        if not IsPedInAnyVehicle(PlayerPedId(), false) then
            local coords = Config[index].coords["spawn"]
            local vehicle_list = Config[index].vehicle_list
            local prefix_plate = Config[index].prefix_plate
            local elements = {}
    
            for k, a in pairs(vehicle_list) do
                if a.limit then
                    table.insert(elements,{label = a.label.." | Veicoli Fuori: "..(a.veiclespawned or "NaN").." | Max Veicoli Spawnabili: "..(a.maxlimitspawn or "NaN"), value = k})
                else
                    table.insert(elements,{label = a.label, value = k})
                end
            end
    
            ESX.UI.Menu.CloseAll()
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fnx-garage-job', {
                title = 'Menu Garage '..(index or "Aziendale"),
                align = 'top-left',
                elements = elements
            }, function(data, menu)
                if data.current.value ~= nil then
                    if vehicle_list[data.current.value] then
                        if vehicle_list[data.current.value].limit then
                            if vehicle_list[data.current.value].veiclespawned < vehicle_list[data.current.value].maxlimitspawn then
    
                                if not ESX.Game.IsSpawnPointClear(coords, 3.0) then 
                                    Notifica("Si prega di spostare il veicolo che si trova sul garage prima di prenderne altri .")
                                    ESX.UI.Menu.CloseAll()
                                    return
                                end
    
                                TriggerServerEvent("fnx-garage_job:UpdateGarage",data.current.value,index,true)
                                SpawnVeH(data.current.value,coords,prefix_plate,vehicle_list[data.current.value])
                            else
                                Notifica("Non puoi spawnare altri veicoli di questo tipo finche non ne fai rientrare altri")
                            end
                        else
                            if not ESX.Game.IsSpawnPointClear(coords, 3.0) then 
                                Notifica("Si prega di spostare il veicolo che si trova sul garage prima di prenderne altri.")
                                ESX.UI.Menu.CloseAll()
                                return
                            end
                            SpawnVeH(data.current.value,coords,prefix_plate,vehicle_list[data.current.value])
                        end
                    end
                end
            end, function(data, menu)
                menu.close()
            end)
        else
            Notifica("Sei in un veicolo non puoi prenderne un altro!")
        end

    elseif ty == "spawn" then
        -- nulla
    elseif ty == "deposito" then
        if IsPedInAnyVehicle(PlayerPedId(), false) then
            local plate_prefix = Config[index].prefix_plate
            local veh = GetVehiclePedIsIn(PlayerPedId(), false)
            local myplate = GetVehicleNumberPlateText(veh)
            local vehicle_list = Config[index].vehicle_list
            if string.find(myplate,plate_prefix) and vehiclespawned[myplate] and vehicle_list[vehiclespawned[myplate]] then
                if veh then
                    TaskLeaveVehicle(PlayerPedId(), veh, 64)
                    Wait(1000)
                    ESX.Game.DeleteVehicle(veh)
                    TriggerServerEvent("fnx-garage_job:UpdateGarage",vehiclespawned[myplate],index,false)
                    vehiclespawned[myplate] = nil
                 end
                Notifica("Hai deposito il tuo veicolo")
            else
                Notifica("Non puoi depositare questo veicolo qui!")  
            end
        else
            Notifica("Non sei in nessun veicolo")
        end
    end
end


SpawnVeH = function (model,coords,prefix_plate,dataveh)
    ESX.UI.Menu.CloseAll()
    WaitForModel(model)
    ESX.Game.SpawnVehicle(GetHashKey(model),coords,coords[4] or 100, function(veh)
        NetworkFadeInEntity(veh, true, true)
        SetModelAsNoLongerNeeded(veh)
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        SetEntityAsMissionEntity(veh, true, true)

        local myplate = GetVehicleNumberPlateText(veh)

        if prefix_plate then
            SetVehicleNumberPlateText(veh, string.format("%s%s",prefix_plate,myplate))
            Wait(10)
            myplate = GetVehicleNumberPlateText(veh)
        end
        
        if dataveh then
            if dataveh.color1 then
                SetVehicleCustomPrimaryColour(veh,dataveh.color1[1],dataveh.color1[2],dataveh.color1[3])
            end
            if dataveh.color2 then
                SetVehicleCustomSecondaryColour(veh,dataveh.color2[1],dataveh.color2[2],dataveh.color2[3])
            end
            if dataveh.livery then
                SetVehicleLivery(veh,tonumber(dataveh.livery))
            end
        end
        vehiclespawned[myplate] = model
        Notifica("Hai preso il veicolo.")
    end)
end



function WaitForModel(model)
    local DrawScreenText = function(text, red, green, blue, alpha)
        SetTextFont(4)
        SetTextScale(0.0, 0.5)
        SetTextColour(red, green, blue, alpha)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(1, 0, 0, 0, 255)
        SetTextDropShadow()
        SetTextOutline()
        SetTextCentre(true)
        BeginTextCommandDisplayText("STRING")
        AddTextComponentSubstringPlayerName(text)
        EndTextCommandDisplayText(0.5, 0.5)
    end
    if not IsModelValid(model) then
        return Notifica("Quest'auto non esiste in gioco.")
    end
	if not HasModelLoaded(model) then
		RequestModel(model)
	end
	while not HasModelLoaded(model) do
		Wait(0)
		DrawScreenText("Caricamento modello " .. GetLabelText(GetDisplayNameFromVehicleModel(model)) .. "...", 255, 255, 255, 150)
	end
end


function isOwnedVehicle (plate)
    if plate then
        local prefixjob = plate:sub(1, #plate - 5)
        local myjob_name = ESX.GetPlayerData().job.name
        if exports["mxm_doublejob"] then
            myjob_name2 = exports["mxm_doublejob"]:getJob().name 
        end
        if Config then
            for k, v in pairs(Config.Jobs) do
                if k == prefixjob:lower() then
                    for s, g in pairs(v) do
                        if g == myjob_name or  myjob_name2 and g == myjob_name2 then
                            return true
                        end
                    end
                end
            end
        end 
    end
end
