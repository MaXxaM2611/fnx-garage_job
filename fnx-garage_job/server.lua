ESX = exports.es_extended:getSharedObject()

RegisterServerEvent("fnx-garage_job:UpdateGarage",function (model,index,addremove)
    local src = source
    if Config[index] then
        if Config[index].vehicle_list[model] then
            if addremove then
                Config[index].vehicle_list[model].veiclespawned = Config[index].vehicle_list[model].veiclespawned + 1 
            else
               if (Config[index].vehicle_list[model].veiclespawned - 1) <= 0 then
                    Config[index].vehicle_list[model].veiclespawned = 0
               else
                    Config[index].vehicle_list[model].veiclespawned = Config[index].vehicle_list[model].veiclespawned - 1
               end
            end
            
        end
    end
    TriggerClientEvent("fnx-garage_job:UpdateConfig",-1,Config) -- TODO non mi piace sta cosa onesto
end)



RegisterServerEvent("fnx-garage_job:GetConfig",function ()
    local src = source
    TriggerClientEvent("fnx-garage_job:UpdateConfig",src,Config) 
end)