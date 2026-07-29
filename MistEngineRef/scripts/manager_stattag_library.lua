local aCommonStatTags = {
    "wounded",
    "bruised",
    "bleeding",
    "burned",
    "poisoned",
    "sickened",
    "shocked",
    "tired",
    "exhausted",
    "hungry",
    "weakened",
    "prone",
    "off-balanced",
    "slowed",
    "restrained",
    "entangled",
    "trapped",
    "cornered",
    "surrounded",
    "exposed",
    "lost",
    "distracted",
    "surprised",
    "blinded",
    "confused",
    "stunned",
    "frightened",
    "panicked",
    "shaken",
    "distressed",
    "enraged",
    "convinced",
    "charmed",
    "threatened",
    "intoxicated",
    "aiming",
    "hidden",
    "guarded",
    "inspired",
    "stabilized",
};

function onInit()
    LibraryData.setRecordTypeInfo("stattag", {
        aDataMap = { "stattag", "reference.stattags" },
        sListDisplayClass = "masterindexitem",
        sRecordDisplayClass = "stattag",
        tOptions = {
            bExport = true,
            bNoCategories = false,
            bNoShare = false,
        },
    });
end

function onTabletopInit()
    if not Session.IsHost then
        return;
    end

    local tExisting = {};
    for _, nodeStatTag in pairs(DB.getChildren("stattag")) do
        local sName = StringManager.trim(DB.getValue(nodeStatTag, "name", "")):lower();
        if sName ~= "" then
            tExisting[sName] = true;
        end
    end

    for _, sName in ipairs(aCommonStatTags) do
        if not tExisting[sName:lower()] then
            local nodeStatTag = DB.createChild("stattag");
            if nodeStatTag then
                DB.setValue(nodeStatTag, "name", "string", sName);
                tExisting[sName:lower()] = true;
            end
        end
    end
end
