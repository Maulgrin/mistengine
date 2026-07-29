local aCommonStatTagGroups = {
    {
        sCategory = "Physical Harm",
        aTags = {
            "wounded",
            "bruised",
            "bleeding",
            "battered",
            "burned",
            "frozen",
            "frostbitten",
            "poisoned",
            "sickened",
            "infected",
            "shocked",
            "electrocuted",
            "irradiated",
            "suffocating",
            "drowning",
            "weakened",
            "numb",
            "pained",
            "crippled",
            "dying",
        },
    },
    {
        sCategory = "Fatigue and Deprivation",
        aTags = {
            "tired",
            "winded",
            "exhausted",
            "hungry",
            "starving",
            "thirsty",
            "dehydrated",
            "sleep-deprived",
            "road-weary",
            "overworked",
            "light-headed",
            "short-on-supplies",
            "short-on-ingredients",
        },
    },
    {
        sCategory = "Movement and Position",
        aTags = {
            "prone",
            "off-balanced",
            "knocked-back",
            "slowed",
            "hobbled",
            "restrained",
            "entangled",
            "grappled",
            "pinned",
            "trapped",
            "cornered",
            "surrounded",
            "separated",
            "exposed",
            "caught-in-the-open",
            "lost",
            "stuck",
        },
    },
    {
        sCategory = "Awareness and Mental Impairment",
        aTags = {
            "distracted",
            "surprised",
            "blinded",
            "deafened",
            "dazzled",
            "confused",
            "dazed",
            "stunned",
            "disoriented",
            "forgetful",
            "mind-stung",
            "headache",
            "hallucinating",
            "unconscious",
        },
    },
    {
        sCategory = "Fear and Emotional Harm",
        aTags = {
            "frightened",
            "scared",
            "panicked",
            "shaken",
            "distressed",
            "angered",
            "enraged",
            "frustrated",
            "humiliated",
            "embarrassed",
            "disheartened",
            "despaired",
            "remorseful",
            "heartbroken",
            "homesick",
            "suspicious",
            "wary",
        },
    },
    {
        sCategory = "Social Influence",
        aTags = {
            "convinced",
            "friendly",
            "impressed",
            "inspired",
            "reassured",
            "charmed",
            "beguiled",
            "tempted",
            "threatened",
            "intimidated",
            "compliant",
            "trusting",
            "indebted",
            "disliked",
            "distrusted",
            "marked",
            "watched",
            "exposed",
            "intoxicated",
        },
    },
    {
        sCategory = "Helpful Combat Statuses",
        aTags = {
            "aiming",
            "focused",
            "prepared",
            "alert",
            "hidden",
            "unseen",
            "behind-cover",
            "well-positioned",
            "guarded",
            "protected",
            "shielded",
            "warded",
            "fortified",
            "enraged",
            "inspired",
            "courageous",
            "blessed",
            "rallied",
            "battle-ready",
        },
    },
    {
        sCategory = "Helpful General Statuses",
        aTags = {
            "rested",
            "well-rested",
            "invigorated",
            "hopeful",
            "confident",
            "calm",
            "clear-headed",
            "stabilized",
            "freshly-bandaged",
            "well-fed",
            "warm",
            "concealed",
            "disguised",
            "informed",
            "equipped",
            "organized",
            "reinforced",
        },
    },
    {
        sCategory = "Magic and Supernatural Conditions",
        aTags = {
            "cursed",
            "blessed",
            "enchanted",
            "warded",
            "possessed",
            "haunted",
            "hexed",
            "banished",
            "transformed",
            "invisible",
            "revealed",
            "magically-drained",
            "spellbound",
            "under-geas",
            "protected-from-evil",
            "resistant-to-magic",
            "corrupted",
            "soul-sapped",
        },
    },
    {
        sCategory = "Iron Gods Technology Statuses",
        aTags = {
            "shocked",
            "electrocuted",
            "irradiated",
            "nanite-infected",
            "technologically-confused",
            "scanned",
            "targeted",
            "tracked",
            "hacked",
            "overridden",
            "shorting-out",
            "malfunctioning",
            "jammed",
            "powered-down",
            "overcharged",
            "reactor-surging",
            "static-blinded",
            "restrained-by-machine",
            "anesthetized",
            "captured-for-procedure",
        },
    },
    {
        sCategory = "Equipment and Vehicle Statuses",
        aTags = {
            "worn",
            "chipped",
            "cracked",
            "damaged",
            "broken",
            "jammed",
            "overheated",
            "mucked-up",
            "waterlogged",
            "sabotaged",
            "unstable",
            "unbalanced",
            "low-on-ammunition",
            "low-on-fuel",
            "overloaded",
            "disabled",
        },
    },
    {
        sCategory = "Progress and Scene Tracks",
        aTags = {
            "alarm",
            "suspicion",
            "pursuit",
            "time-passes",
            "escape",
            "infiltrated",
            "discovered",
            "convinced",
            "calmed",
            "rescued",
            "repaired",
            "disabled",
            "destroyed",
            "deciphered",
            "tracked",
            "found",
            "contained",
            "stabilized",
            "cleansed",
            "restored",
            "making-progress",
        },
    },
};

local function getStatTagKey(sCategory, sName)
    return (sCategory or "") .. "\t" .. StringManager.trim(sName or ""):lower();
end

local function addExistingStatTag(tExisting, tExistingByName, nodeStatTag)
    local sName = StringManager.trim(DB.getValue(nodeStatTag, "name", ""));
    if sName == "" then
        return;
    end

    local sCategory = DB.getCategory(nodeStatTag) or "";
    local sLowerName = sName:lower();

    tExisting[getStatTagKey(sCategory, sName)] = nodeStatTag;

    if not tExistingByName[sLowerName] then
        tExistingByName[sLowerName] = {};
    end
    table.insert(tExistingByName[sLowerName], nodeStatTag);
end

local function findUncategorizedStatTag(tExistingByName, tUsedExisting, sName)
    local aExisting = tExistingByName[StringManager.trim(sName or ""):lower()];
    if not aExisting then
        return nil;
    end

    for _, nodeStatTag in ipairs(aExisting) do
        local sPath = nodeStatTag.getPath();
        if not tUsedExisting[sPath] and (DB.getCategory(nodeStatTag) or "") == "" then
            tUsedExisting[sPath] = true;
            return nodeStatTag;
        end
    end

    return nil;
end

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
    local tExistingByName = {};
    for _, nodeStatTag in pairs(DB.getChildren("stattag")) do
        addExistingStatTag(tExisting, tExistingByName, nodeStatTag);
    end

    local tUsedExisting = {};
    for _, tGroup in ipairs(aCommonStatTagGroups) do
        for _, sName in ipairs(tGroup.aTags) do
            local sKey = getStatTagKey(tGroup.sCategory, sName);
            if not tExisting[sKey] then
                local nodeStatTag = findUncategorizedStatTag(tExistingByName, tUsedExisting, sName);
                if not nodeStatTag then
                    nodeStatTag = DB.createChild("stattag");
                    if nodeStatTag then
                        DB.setValue(nodeStatTag, "name", "string", sName);
                    end
                end

                if nodeStatTag then
                    DB.setCategory(nodeStatTag.getPath(), tGroup.sCategory);
                    tExisting[sKey] = nodeStatTag;
                    addExistingStatTag(tExisting, tExistingByName, nodeStatTag);
                end
            end
        end
    end
end
