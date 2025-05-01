-----
-- Copyright [2018] [SKZ]
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at

--     http://www.apache.org/licenses/LICENSE-2.0
-- 
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
----

local Keys = { ["E"] = 38 }
local QBCore = exports['qb-core']:GetCoreObject()
local InVehicleMenu = false

function VehicleInFront() -- For diagnostics, get the vehicle in front of the ped
    local vehicle, distance = QBCore.Functions.GetClosestVehicle()
    if vehicle ~= 0 and distance < 3 then
        return vehicle
    else 
        return nil
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)

        if not IsPedInAnyVehicle(PlayerPedId(), false) then
            if InVehicleMenu then
                local Vehicle = VehicleInFront()

                if not DoesEntityExist(Vehicle) then
                    InVehicleMenu = false
                    exports['Bloody-menu']:closeMenu()
                end
            end

            if IsControlJustPressed(1, Keys['E']) then -- If E key pressed then
                local Vehicle = VehicleInFront()

                if DoesEntityExist(Vehicle) then
                    InVehicleMenu = true

                    local EngineHealth = GetVehicleEngineHealth(Vehicle)

                    local VehicleClass = GetVehicleClass(Vehicle)
                    local VehiclePlate = GetVehicleNumberPlateText(Vehicle)

                    local VehicleModel = GetEntityModel(Vehicle)
                    local VehicleName = GetDisplayNameFromVehicleModel(VehicleModel)

                    -- Classes:
                    if VehicleClass == 0 then VehicleClass = 'Compacts'
                    elseif VehicleClass == 1 then VehicleClass = 'Sedans'
                    elseif VehicleClass == 2 then VehicleClass = 'SUVs'
                    elseif VehicleClass == 3 then VehicleClass = 'Coupes'
                    elseif VehicleClass == 4 then VehicleClass = 'Muscle'
                    elseif VehicleClass == 5 then VehicleClass = 'Sports Classics'
                    elseif VehicleClass == 6 then VehicleClass = 'Sports'
                    elseif VehicleClass == 7 then VehicleClass = 'Super'
                    elseif VehicleClass == 8 then VehicleClass = 'Motorcycles'
                    elseif VehicleClass == 9 then VehicleClass = 'Off-road'
                    elseif VehicleClass == 10 then VehicleClass = 'Industrial'
                    elseif VehicleClass == 11 then VehicleClass = 'Utility'
                    elseif VehicleClass == 12 then VehicleClass = 'Vans'
                    elseif VehicleClass == 13 then VehicleClass = 'Cycles'
                    elseif VehicleClass == 14 then VehicleClass = 'Boats'
                    elseif VehicleClass == 15 then VehicleClass = 'Helicopters'
                    elseif VehicleClass == 16 then VehicleClass = 'Planes'
                    elseif VehicleClass == 17 then VehicleClass = 'Service'
                    elseif VehicleClass == 18 then VehicleClass = 'Emergency'
                    elseif VehicleClass == 19 then VehicleClass = 'Military'
                    elseif VehicleClass == 20 then VehicleClass = 'Commercial'
                    else VehicleClass = 'Unknown' end

                    local engineCondition
                    if EngineHealth >= 850 then
                        engineCondition = '~g~Very Good'
                    elseif EngineHealth >= 600 then
                        engineCondition = '~y~Good'
                    elseif EngineHealth >= 300 then
                        engineCondition = '~o~Medium'
                    else 
                        engineCondition = '~r~Bad'
                    end

                    local menuItems = {
                        {
                            header = "Vehicle Information",
                            icon = "fas fa-car",
                            isMenuHeader = true
                        },
                        {
                            header = "Model: " .. VehicleName,
                            txt = "",
                            icon = "fas fa-car",
                            disabled = true
                        },
                        {
                            header = "Category: " .. VehicleClass,
                            txt = "",
                            icon = "fas fa-list",
                            disabled = true
                        },
                        {
                            header = "Plate: " .. VehiclePlate,
                            txt = "",
                            icon = "fas fa-tag",
                            disabled = true
                        },
                        {
                            header = "Condition: " .. engineCondition,
                            txt = "",
                            icon = "fas fa-engine",
                            disabled = true
                        },
                        {
                            header = "Close Menu",
                            txt = "",
                            icon = "fas fa-times",
                            params = {
                                event = "Bloody-menu:closeMenu"
                            }
                        }
                    }

                    exports['Bloody-menu']:openMenu(menuItems)
                end
            end
        else
            Citizen.Wait(500)
        end
    end
end)