ESX = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(30)-- dua holder
  end
end)


local isJudge = false
local isPolice = false
local isMedic = false
local isDoctor = false
local isNews = false
local isInstructorMode = false
local myJob = "unemployed"
local isHandcuffed = false
local isHandcuffedAndWalking = false
local hasOxygenTankOn = false
local gangNum = 0
local cuffStates = {}
 
rootMenuConfig =  {
    {
        id = "general",
        displayName = "General",
        icon = "#globe-europe",
        enableMenu = function()
         
            return not fuck
        end,
        subMenus = {"general:emotes", "kimlikgor", "kimlikgoster"}
    },
 
    {
        id = "menupakaian",
        displayName = "Menu Pakaian",
        icon = "#globe-europe",
        enableMenu = function()
         
            return not fuck
        end,
        subMenus = {"bajus", "celanas"}
    },
    {
        id = "motel",
        displayName = "Motel Interaction",
        icon = "#general-apart-givekey",
        enableMenu = function()
         
            return not fuck
        end,
        subMenus = {"motelanahtar", "motelanahtar1", "motelanahtar2", "motelanahtar3", "motelanahtar4", "motelanahtar5"}
    },	
    
    {
        id = "police-action",
        displayName = "Police Interaction",
        icon = "#police-action",
        enableMenu = function()
           local ped = PlayerPedId()
           PlayerData = ESX.GetPlayerData()
            
            if PlayerData.job.name == "police" and not fuck then
                return true
            end
        end,
        subMenus = {"esx_policejob:kelepce", "esx_policejob:kelepcecoz", "esx_policejob:tasi", "mdt:radialopen", "medic:revive", "st:ceza",}
    },
    {
        id = "police-vehicle",
        displayName = "K9 Unit",
        icon = "#police-vehicle",
        enableMenu = function()
           local ped = PlayerPedId()
           PlayerData = ESX.GetPlayerData()
            
            if PlayerData.job.name == "police" and not fuck then
                return true
            end
		end,
        subMenus = {"esx_policejob:putInVehicle", "esx_policejob:OutVehicle", "police:open", "police:impound"}
    },	
    {
        id = "blips",
        displayName = "GPS",
        icon = "#blips",
        enableMenu = function()
            return not isDead
        end,
        subMenus = { "blips:gasstations", --[["blips:trainstations",]] "blips:barbershop", "blips:tattooshop", "fk:karakol", "fk:hastane", "fk:galeri", "fk:motel"}
    },	
    {
        id = "policeDead",
        displayName = "10-13",
        icon = "#police-dead",
        functionName = "st:panicTrigger",
        enableMenu = function()
        local ped = PlayerPedId()
           PlayerData = ESX.GetPlayerData()
            
            if PlayerData.job.name == "police" and fuck then
                return true
            end
        end,
    },
    {
        id = "emsDead",
        displayName = "10-14",
        icon = "#ems-dead",
        functionName = "st:panicTriggerMedic",
        enableMenu = function()
        local ped = PlayerPedId()
           PlayerData = ESX.GetPlayerData()
            
            if PlayerData.job.name == "ambulance" and fuck then
                return true
            end
        end,
    },
    {
        id = "animations",
        displayName = "Walk style",
        icon = "#walking",
        enableMenu = function()
         
            return not fuck
        end,
        subMenus = { "animations:brave", "animations:hurry", "animations:business", "animations:tipsy", "animations:injured","animations:tough", "animations:default", "animations:hobo", "animations:money", "animations:swagger", "animations:shady", "animations:maneater", "animations:chichi", "animations:sassy", "animations:sad", "animations:posh", "animations:alien" }
    },	
    {
        id = "expressions",
        displayName = "BOWALEED GOT FUCKED",
        icon = "#animation-brave",
        enableMenu = function()
         
            return not fuck
        end,
        subMenus = { "expressions:normal", "expressions:drunk", "expressions:angry", "expressions:dumb", "expressions:electrocuted", "expressions:grumpy", "expressions:happy", "expressions:injured", "expressions:joyful", "expressions:mouthbreather", "expressions:oneeye", "expressions:shocked", "expressions:sleeping", "expressions:smug", "expressions:speculative", "expressions:stressed", "expressions:sulking", "expressions:weird", "expressions:weird2"}
    },
    {
        id = "judge-raid",
        displayName = "Judge Raid",
        icon = "#judge-raid",
        enableMenu = function()
            return (not isDead and isJudge)
        end,
        subMenus = { "judge-raid:checkowner", "judge-raid:seizeall", "judge-raid:takecash", "judge-raid:takedm"}
    },
    {
        id = "judge-licenses",
        displayName = "Judge Licenses",
        icon = "#judge-licenses",
        enableMenu = function()
            return (not isDead and isJudge)
        end,
        subMenus = { "police:checklicenses", "judge:grantDriver", "judge:grantBusiness", "judge:grantWeapon", "judge:grantHouse", "judge:grantBar", "judge:grantDA", "judge:removeDriver", "judge:removeBusiness", "judge:removeWeapon", "judge:removeHouse", "judge:removeBar", "judge:removeDA", "judge:denyWeapon", "judge:denyDriver", "judge:denyBusiness", "judge:denyHouse" }
    },
--[[     {
        id = "judge-actions",
        displayName = "Judge Actions",
        icon = "#judge-actions",
        enableMenu = function()
            return (not isDead and isJudge)
        end,
        subMenus = { "police:cuff", "cuffs:uncuff", "general:escort", "police:frisk", "cuffs:checkinventory", "police:checkbank"}
    }, ]]
    {
        id = "judge-actions",
        displayName = "Mekanik Aksiyonları",
        icon = "#police-vehicle",
        enableMenu = function()
            local ped = PlayerPedId()
           PlayerData = ESX.GetPlayerData()
            
            if PlayerData.job.name == "mechanic" and not fuck then
                return true
            end
        end,
        subMenus = { "mechanic:hijack", "mechanic:clean", "mechanic:impound"}
    },
    {
        id = "medic",
        displayName = "Doktor",
        icon = "#medic",
        enableMenu = function()
        local ped = PlayerPedId()
           PlayerData = ESX.GetPlayerData()
            
            if PlayerData.job.name == "ambulance" and not fuck then
                return true
            end
        end,
        subMenus = {"medic:revive", "medic:heal", "medic:bigheal"}
    },
    {
        id = "doctor",
        displayName = "Doctor",
        icon = "#doctor",
        enableMenu = function()
            return (not isDead and isDoctor)
        end,
        subMenus = { "general:escort", "medic:revive", "general:checktargetstates", "medic:heal" }
    },
    {
        id = "news",
        displayName = "News",
        icon = "#news",
        enableMenu = function()
            return (not isDead and isNews)
        end,
        subMenus = { "news:setCamera", "news:setMicrophone", "news:setBoom" }
    },
--[[     {
        id = "vehicle",
        displayName = "Vehicle",
        icon = "#vehicle-options-vehicle",
        functionName = "veh:options",
        enableMenu = function()
         
            if not fuck and IsPedInAnyVehicle(PlayerPedId(), false) then
                return true
            end
        end,
    }, ]]
    {
        id = "impound",
        displayName = "Impound Vehicle",
        icon = "#impound-vehicle",
        functionName = "impoundVehicle",
        enableMenu = function()
         
            if not fuck and myJob == "towtruck" and #(GetEntityCoords(PlayerPedId()) - vector3(549.47796630859, -55.197559356689, 71.069190979004)) < 10.599 then
                return true
            end
            return false
        end
    }, {
        id = "oxygentank",
        displayName = "Remove Oxygen Tank",
        icon = "#oxygen-mask",
        functionName = "RemoveOxyTank",
        enableMenu = function()
         
            return not fuck and hasOxygenTankOn
        end
    }, {
        id = "cocaine-status",
        displayName = "Request Status",
        icon = "#cocaine-status",
        functionName = "cocaine:currentStatusServer",
        enableMenu = function()
         
            if not fuck and gangNum == 2 and #(GetEntityCoords(PlayerPedId()) - vector3(1087.3937988281,-3194.2138671875,-38.993473052979)) < 0.5 then
                return true
            end
            return false
        end
    }, {
        id = "vehicle",
        displayName = "Kontrol Kendaraan",
        icon = "#vehicle-options-vehicle",
        functionName = "vehcontrol:openExternal",
        enableMenu = function()
            return (not isDead and IsPedInAnyVehicle(PlayerPedId(), false))
        end
    }, {
        id = "cocaine-crate",
        displayName = "Remove Crate",
        icon = "#cocaine-crate",
        functionName = "cocaine:methCrate",
        enableMenu = function()
         
            if not fuck and gangNum == 2 and #(GetEntityCoords(PlayerPedId()) - vector3(1087.3937988281,-3194.2138671875,-38.993473052979)) < 0.5 then
                return true
            end
            return false
        end
    }
}

newSubMenus = {
    ['general:emotes'] = {
        title = "Menu Emoji",
        icon = "#general-emotes",
        functionName = "dp:RecieveMenu"
    },
    ['bajus'] = {
        title = "Baju",
        icon = "#pakaian-act",
        functionName = "baju"
    },
    ['celanas'] = {
        title = "Celana",
        icon = "#celana",
        functionName = "celana"
    },
    ['general:putinvehicle'] = {
        title = "Seat Vehicle",
        icon = "#general-put-in-veh",
        functionName = "police:client:PutPlayerInVehicle"
    },
    ['clothes1'] = {
        title = "Take off your hat",
        icon = "#expressions",
        functionName = function() ToggleClothing("Hat") end,
    },
    ['clothes2'] = {
        title = "Remove Your Mask",
        icon = "#expressions",
        functionName = function() ToggleClothing("Mask") end,
    },
    ['clothes3'] = {
        title = "Take Off Your Gloves",
        icon = "#expressions",
        functionName = function() ToggleClothing("Gloves") end,
    },
    ['blips:gasstations'] = {
        title = "Gas Station",
        icon = "#blips-gasstations",
        functionName = "ygx:togglegas"
    },
   --[[ ['blips:trainstations'] = {
        title = "Tren istasyonları",
        icon = "#blips-trainstations",
        functionName = "Trains:ToggleTainsBlip"
    },--]]
    ['blips:garages'] = {
        title = "Garages",
        icon = "#blips-garages",
        functionName = "Garages:ToggleGarageBlip"
    },
    ['blips:barbershop'] = {
        title = "Barber",
        icon = "#blips-barbershop",
        functionName = "ygx:togglebarber"
    },    
    ['fk:karakol'] = {
        title = "Karakol",
        icon = "#police-action",
        functionName = "fk:karakol"
    },
    ['fk:hastane'] = {
        title = "Hastane",
        icon = "#medic",
        functionName = "fk:hastane"
    },
    ['fk:galeri'] = {
        title = "Showroom",
        icon = "#blips-garages",
        functionName = "fk:galeri"
    },	
    ['fk:motel'] = {
        title = "Motel",
        icon = "#animation-business",
        functionName = "fk:motel"
    },	
    ['blips:tattooshop'] = {
        title = "Tattoshop",
        icon = "#blips-tattooshop",
        functionName = "ygx:toggletattos"
    },	
    ['kiyafet4'] = {
        title = "Gözlüğünü Çıkart",
        icon = "#expressions",
        functionName = "kiyafet4"
    },
    ['kiyafet5'] = {
        title = "Aksesuarları Çıkart",
        icon = "#expressions",
        functionName = "kiyafet5"
    },
    ['kiyafet6'] = {
        title = "Çantanı Çıkart",
        icon = "#expressions",
        functionName = "kiyafet6"
    },	
    ['kiyafet7'] = {
        title = "Pantolonunu Çıkart",
        icon = "#expressions",
        functionName = "kiyafet7"
    },
    ['kiyafet8'] = {
        title = "Sağ Kolundakilerini Çıkart",
        icon = "#expressions",
        functionName = "kiyafet8"
    },
    ['kiyafet9'] = {
        title = "Sol Kolundakilerini Çıkart",
        icon = "#expressions",
        functionName = "kiyafet9"
    },
    ['kiyafet10'] = {
        title = "Kulağındakini çıkart",
        icon = "#expressions",
        functionName = "kiyafet10"
    },
    ['kiyafet11'] = {
        title = "Ayakkabını Çıkart",
        icon = "#expressions",
        functionName = "kiyafet11"
    },
    ['kiyafet13'] = {
        title = "Üstündekini Çıkart",
        icon = "#expressions",
        functionName = "kiyafet13"
    },
    ['tsandalye'] = {
        title = "Tekerlekli Sandalye",
        icon = "#animation-tough",
        functionName = "tsandalye"
    },	
    ['general:unseatnearest'] = {
        title = "Unseat Nearest",
        icon = "#general-unseat-nearest",
        functionName = "unseatPlayer"
    },     	
    ['animations:brave'] = {
        title = "Cesur",
        icon = "#animation-brave",
        functionName = "AnimSet:Brave"
    },
    ['animations:hurry'] = {
        title = "Hızlı",
        icon = "#animation-hurry",
        functionName = "AnimSet:Hurry"
    },
    ['animations:business'] = {
        title = "İş Adamı",
        icon = "#animation-business",
        functionName = "AnimSet:Business"
    },
    ['animations:tipsy'] = {
        title = "İçkili",
        icon = "#animation-tipsy",
        functionName = "AnimSet:Tipsy"
    },
    ['animations:injured'] = {
        title = "Yaralı",
        icon = "#animation-injured",
        functionName = "AnimSet:Injured"
    },
    ['animations:tough'] = {
        title = "Zorlu",
        icon = "#animation-tough",
        functionName = "AnimSet:ToughGuy"
    },	
    ['animations:sassy'] = {
        title = "Şımarık",
        icon = "#animation-sassy",
        functionName = "AnimSet:Sassy"
    },
    ['animations:sad'] = {
        title = "Üzgün",
        icon = "#animation-sad",
        functionName = "AnimSet:Sad"
    },
    ['animations:posh'] = {
        title = "Lüks",
        icon = "#animation-posh",
        functionName = "AnimSet:Posh"
    },
    ['motelanahtar'] = {
        title = "Anahtarlarını Gör",
        icon = "#general-apart-givekey",
        functionName = "motelanahtar"
    },
    ['motelanahtar1'] = {
        title = "Anahtarları Ver",
        icon = "#general-apart-givekey",
        functionName = "motelanahtar1"
    },	
    ['motelanahtar2'] = {
        title = "Kapı Kilidini Aç/Kapat",
        icon = "#judge-licenses-grant-house",
        functionName = "motelanahtar2"
    },	
    ['motelanahtar3'] = {
        title = "Depo Kilidini Aç/Kapat",
        icon = "#judge-licenses-grant-house",
        functionName = "motelanahtar3"
    },	
    ['motelanahtar4'] = {
        title = "Depoyu Aç/Kapa",
        icon = "#judge-licenses-grant-house",
        functionName = "motelanahtar4"
    },	
    ['motelanahtar5'] = {
        title = "Dolabını Gör",
        icon = "#judge-licenses-grant-house",
        functionName = "motelanahtar5"
    },		
    ['animations:alien'] = {
        title = "Uzaylı",
        icon = "#animation-alien",
        functionName = "AnimSet:Alien"
    },
    ['animations:nonchalant'] =
    {
        title = "Tesadüf",
        icon = "#animation-nonchalant",
        functionName = "AnimSet:NonChalant"
    },
    ['animations:hobo'] = {
        title = "Serseri",
        icon = "#animation-hobo",
        functionName = "AnimSet:Hobo"
    },
    ['animations:money'] = {
        title = "Para",
        icon = "#animation-money",
        functionName = "AnimSet:Money"
    },
    ['animations:swagger'] = {
        title = "Çalım",
        icon = "#animation-swagger",
        functionName = "AnimSet:Swagger"
    },
    ['animations:shady'] = {
        title = "Gangster",
        icon = "#animation-shady",
        functionName = "AnimSet:Shady"
    },
    ['animations:maneater'] = {
        title = "Kıvırtma",
        icon = "#animation-maneater",
        functionName = "AnimSet:ManEater"
    },
    ['animations:chichi'] = {
        title = "Gösterişli",
        icon = "#animation-chichi",
        functionName = "AnimSet:ChiChi"
    },
    ['animations:default'] = {
        title = "Normal",
        icon = "#animation-default",
        functionName = "AnimSet:default"
    },
    ['mechanic:hijack'] = {
        title = "Aracı Aç",
        icon = "#police-vehicle",
        functionName = "st:open"
    },
    ['mechanic:repair'] = {
        title = "Tamir Et",
        icon = "#police-vehicle",
        functionName = "st:mechrepair"
    },
    ['mechanic:clean'] = {
        title = "Temizle",
        icon = "#police-vehicle",
        functionName = "st:mechclean"
    },
    ['mechanic:impound'] = {
        title = "Çek",
        icon = "#police-vehicle",
        functionName = "st:menuimpound"
    },
    ['cuffs:cuff'] = {
        title = "Kelepçele",
        icon = "#cuffs-cuff",
        functionName = "police:client:CuffPlayerSoft"
    }, 
    ['cuffs:uncuff'] = {
        title = "Kelepçeyi Çöz",
        icon = "#cuffs-uncuff",
        functionName = "st:uncuff"
    },
    ['cuffs:unseat'] = {
        title = "Unseat",
        icon = "#cuffs-unseat-player",
        functionName = "esx_ambulancejob:pullOutVehicle"
    },
    ['cuffs:checkphone'] = {
        title = "Read Phone",
        icon = "#cuffs-check-phone",
        functionName = "police:checkPhone"
    },
    ['medic:revive'] = {
        title = "İyileştir",
        icon = "#medic-revive",
        functionName = "st:emsRevive"
    },
    ['medic:put'] = {
        title = "Kişiyi Arabadan Çıkar",
        icon = "#general-put-in-veh",
        functionName = "st:outv"
    },
    ['medic:out'] = {
        title = "Kişiyi Arabaya Koy",
        icon = "#general-unseat-nearest",
        functionName = "st:putv"
    },
    ['medic:heal'] = {
        title = "Küçük Yaraları Tedavi Et",
        icon = "#medic-heal",
        functionName = "st:emssmallheal"
    },
    ['medic:bigheal'] = {
        title = "Büyük Yaraları Tedavi Et",
        icon = "#medic-heal",
        functionName = "st:emsbigheal"
    },
    ['police:escort'] = {
        title = "Escort",
        icon = "#general-escort",
        functionName = "police:client:EscortPlayer"
    },
    ['mdt:radialopen'] = {
        title = "MDT",
        icon = "#mdt",
        functionName = "mdt:radialopen"
    },	
    ['police:cuff'] = {
        title = "Cuff",
        icon = "#cuffs-cuff",
        functionName = "police:client:CuffPlayerSoft"
    },
	['esx_policejob:putInVehicle'] = {
        title = "Put In vehicle",
        icon = "#general-put-in-veh",
        functionName = "police:client:PutPlayerInVehicle"
    },
	['esx_policejob:OutVehicle'] = {
        title = "Take Out Of Vehicle",
        icon = "#general-put-in-veh",
        functionName = "police:client:SetPlayerOutVehicle"
    },	
	['hirsiz:OutVehicle'] = {
        title = "Kişiyi Araçtan Çıkar",
        icon = "#general-put-in-veh",
        functionName = "hirsiz:OutVehicle"
    },	
	['hirsiz:putVehicle'] = {
        title = "Take Out Of Vehicle",
        icon = "#general-put-in-veh",
        functionName = "police:client:SetPlayerOutVehicle"
    },		
--[[     ['police:removeweapons'] = {
        title = "Remove Weapons License",esx_policejob:OutVehicle   			TriggerEvent("meeta_police:squadMenu")

        icon = "#police-action-remove-weapons",
        functionName = "police:removeWeapon"st:getid
    }, ]]
    ['st:ceza'] = {
        title = "Fatura Kes",
        icon = "#police-action-gsr",
        functionName = "st:ceza"
    },		
    ['police:getid'] = {
        title = "Ödenmemiş Faturalar",
        icon = "#police-vehicle-plate",
        functionName = "esx_policejob:odenmemisfatura"
    },
    ['esx_policejob:kelepce'] = {
        title = "Kelepçele",
        icon = "#cuffs",
        functionName = "st:handcuff"
    },
	['esx_policejob:tasi'] = {
        title = "Taşı",
        icon = "#general-put-in-veh",
        functionName = "st:escort"
    },
    ['esx_policejob:kelepcecoz'] = {
        title = "Kelepçele Çöz",
        icon = "#cuffs-uncuff",
        functionName = "st:uncuff"
    },	
	['kimlikgor'] = {
        title = "Give Contact Details",
        icon = "#news",
        functionName = "qb-phone:client:GiveContactDetails"
    },	
    ['kimlikgoster'] = {
        title = "Hot Dog Sell",
        icon = "#vehicle-options-vehicle",
        functionName = 'qb-hotdogjob:client:ToggleSell'
    },	
--[[     ['police:toggleradar'] = {
        title = "Toggle Radar",
        icon = "#police-vehicle-radar",
        functionName = "startSpeedo"
    }, ]]
--[[     ['police:frisk'] = {
        title = "Frisk",
        icon = "#police-action-frisk",
        functionName = "police:frisk"
    }, ]]
    ['judge:grantDriver'] = {
        title = "Grant Drivers",
        icon = "#judge-licenses-grant-drivers",
        functionName = "police:grantDriver"
    }, 
    ['judge:grantBusiness'] = {
        title = "Grant Business",
        icon = "#judge-licenses-grant-business",
        functionName = "police:grantBusiness"
    },  
    ['judge:grantWeapon'] = {
        title = "Grant Weapon",
        icon = "#judge-licenses-grant-weapon",
        functionName = "police:grantWeapon"
    },
    ['judge:grantHouse'] = {
        title = "Grant House",
        icon = "#judge-licenses-grant-house",
        functionName = "police:grantHouse"
    },
    ['judge:grantBar'] = {
        title = "Grant BAR",
        icon = "#judge-licenses-grant-bar",
        functionName = "police:grantBar"
    },
    ['judge:grantDA'] = {
        title = "Grant DA",
        icon = "#judge-licenses-grant-da",
        functionName = "police:grantDA"
    },
    ['judge:removeDriver'] = {
        title = "Remove Drivers",
        icon = "#judge-licenses-remove-drivers",
        functionName = "police:removeDriver"
    },
    ['judge:removeBusiness'] = {
        title = "Remove Business",
        icon = "#judge-licenses-remove-business",
        functionName = "police:removeBusiness"
    },
    ['judge:removeWeapon'] = {
        title = "Remove Weapon",
        icon = "#judge-licenses-remove-weapon",
        functionName = "police:removeWeapon"
    },
    ['judge:removeHouse'] = {
        title = "Remove House",
        icon = "#judge-licenses-remove-house",
        functionName = "police:removeHouse"
    },
    ['judge:removeBar'] = {
        title = "Remove BAR",
        icon = "#judge-licenses-remove-bar",
        functionName = "police:removeBar"
    },
    ['judge:removeDA'] = {
        title = "Remove DA",
        icon = "#judge-licenses-remove-da",
        functionName = "police:removeDA"
    },
    ['judge:denyWeapon'] = {
        title = "Deny Weapon",
        icon = "#judge-licenses-deny-weapon",
        functionName = "police:denyWeapon"
    },
    ['judge:denyDriver'] = {
        title = "Deny Drivers",
        icon = "#judge-licenses-deny-drivers",
        functionName = "police:denyDriver"
    },
    ['judge:denyBusiness'] = {
        title = "Deny Business",
        icon = "#judge-licenses-deny-business",
        functionName = "police:denyBusiness"
    },
    ['judge:denyHouse'] = {
        title = "Deny House",
        icon = "#judge-licenses-deny-house",
        functionName = "police:denyHouse"
    },
    ['news:setCamera'] = {
        title = "Camera",
        icon = "#news-job-news-camera",
        functionName = "camera:setCamera"
    },
    ['news:setMicrophone'] = {
        title = "Microphone",
        icon = "#news-job-news-microphone",
        functionName = "camera:setMic"
    },
    ['news:setBoom'] = {
        title = "Microphone Boom",
        icon = "#news-job-news-boom",
        functionName = "camera:setBoom"
    },
    ['weed:currentStatusServer'] = {
        title = "Request Status",
        icon = "#weed-cultivation-request-status",
        functionName = "weed:currentStatusServer"
    },   
    ['weed:weedCrate'] = {
        title = "Remove A Crate",
        icon = "#weed-cultivation-remove-a-crate",
        functionName = "weed:weedCrate"
    },
    ['cocaine:currentStatusServer'] = {
        title = "Request Status",
        icon = "#meth-manufacturing-request-status",
        functionName = "cocaine:currentStatusServer"
    },
    ['cocaine:methCrate'] = {
        title = "Remove A Crate",
        icon = "#meth-manufacturing-remove-a-crate",
        functionName = "cocaine:methCrate"
    },
    ["expressions:angry"] = {
        title="Sinirli",
        icon="#expressions-angry",
        functionName = "expressions",
        functionParameters =  { "mood_angry_1" }
    },
    ["expressions:drunk"] = {
        title="İçkili",
        icon="#expressions-drunk",
        functionName = "expressions",
        functionParameters =  { "mood_drunk_1" }
    },
    ["expressions:dumb"] = {
        title="Aptal",
        icon="#expressions-dumb",
        functionName = "expressions",
        functionParameters =  { "pose_injured_1" }
    },
    ["expressions:electrocuted"] = {
        title="Elektiriklenmiş",
        icon="#expressions-electrocuted",
        functionName = "expressions",
        functionParameters =  { "electrocuted_1" }
    },
    ["expressions:grumpy"] = {
        title="Huysuz",
        icon="#expressions-grumpy",
        functionName = "expressions", 
        functionParameters =  { "mood_drivefast_1" }
    },
    ["expressions:happy"] = {
        title="Mutlu",
        icon="#expressions-happy",
        functionName = "expressions",
        functionParameters =  { "mood_happy_1" }
    },
    ["expressions:injured"] = {
        title="Yaralı",
        icon="#expressions-injured",
        functionName = "expressions",
        functionParameters =  { "mood_injured_1" }
    },
    ["expressions:joyful"] = {
        title="Eğlenceli",
        icon="#expressions-joyful",
        functionName = "expressions",
        functionParameters =  { "mood_dancing_low_1" }
    },
    ["expressions:mouthbreather"] = {
        title="Ağızdan Nefes Alan",
        icon="#expressions-mouthbreather",
        functionName = "expressions",
        functionParameters = { "smoking_hold_1" }
    },
    ["expressions:normal"]  = {
        title="Normal",
        icon="#expressions-normal",
        functionName = "expressions:clear"
    },
    ["expressions:oneeye"]  = {
        title="Tek Göz",
        icon="#expressions-oneeye",
        functionName = "expressions",
        functionParameters = { "pose_aiming_1" }
    },
    ["expressions:shocked"]  = {
        title="Şok Geçirmiş",
        icon="#expressions-shocked",
        functionName = "expressions",
        functionParameters = { "shocked_1" }
    },
    ["expressions:sleeping"]  = {
        title="Uykulu",
        icon="#expressions-sleeping",
        functionName = "expressions",
        functionParameters = { "dead_1" }
    },
    ["expressions:smug"]  = {
        title="Kendini Beğenmiş",
        icon="#expressions-smug",
        functionName = "expressions",
        functionParameters = { "mood_smug_1" }
    },
    ["expressions:speculative"]  = {
        title="Spekülatif",
        icon="#expressions-speculative",
        functionName = "expressions",
        functionParameters = { "mood_aiming_1" }
    },
    ["expressions:stressed"]  = {
        title="Stressli",
        icon="#expressions-stressed",
        functionName = "expressions",
        functionParameters = { "mood_stressed_1" }
    },
    ["expressions:sulking"]  = {
        title="Somurtma",
        icon="#expressions-sulking",
        functionName = "expressions",
        functionParameters = { "mood_sulk_1" },
    },
    ["expressions:weird"]  = {
        title="Tuhaf",
        icon="#expressions-weird",
        functionName = "expressions",
        functionParameters = { "effort_2" }
    },
    ["expressions:weird2"]  = {
        title="Tuhaf 2",
        icon="#expressions-weird2",
        functionName = "expressions",
        functionParameters = { "effort_3" }
    }
}

RegisterNetEvent("menu:setCuffState")
AddEventHandler("menu:setCuffState", function(pTargetId, pState)
    cuffStates[pTargetId] = pState
end)


RegisterNetEvent("isJudge")
AddEventHandler("isJudge", function()
    isJudge = true
end)

RegisterNetEvent("isJudgeOff")
AddEventHandler("isJudgeOff", function()
    isJudge = false
end)

RegisterNetEvent('pd:deathcheck')
AddEventHandler('pd:deathcheck', function()
    if not isDead then
        isDead = true
    else
        isDead = false
    end
end)

RegisterNetEvent("drivingInstructor:instructorToggle")
AddEventHandler("drivingInstructor:instructorToggle", function(mode)
    if myJob == "driving instructor" then
        isInstructorMode = mode
    end
end)

RegisterNetEvent("police:currentHandCuffedState")
AddEventHandler("police:currentHandCuffedState", function(pIsHandcuffed, pIsHandcuffedAndWalking)
    isHandcuffedAndWalking = pIsHandcuffedAndWalking
    isHandcuffed = pIsHandcuffed
end)

RegisterNetEvent("menu:hasOxygenTank")
AddEventHandler("menu:hasOxygenTank", function(pHasOxygenTank)
    hasOxygenTankOn = pHasOxygenTank
end)

RegisterNetEvent('enablegangmember')
AddEventHandler('enablegangmember', function(pGangNum)
    gangNum = pGangNum
end)

function GetPlayers()
    local players = {}

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            players[#players+1]= i
        end
    end

    return players
end

function GetClosestPlayer()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local closestPed = -1
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply, 0)
    if not IsPedInAnyVehicle(PlayerPedId(), false) then
        for index,value in ipairs(players) do
            local target = GetPlayerPed(value)
            if(target ~= ply) then
                local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
                local distance = #(vector3(targetCoords["x"], targetCoords["y"], targetCoords["z"]) - vector3(plyCoords["x"], plyCoords["y"], plyCoords["z"]))
                if(closestDistance == -1 or closestDistance > distance) and not IsPedInAnyVehicle(target, false) then
                    closestPlayer = value
                    closestPed = target
                    closestDistance = distance
                end
            end
        end
        return closestPlayer, closestDistance, closestPed
    end
end

--Untuk lebih lanjut bisa pelajari / tanya tanya dm discord saya Sureking--