# Update .mcreator with all new mod elements
$mcPath = "C:\Users\andra\MCreatorWorkspaces\projetokonoha\projetokonoha.mcreator"
$mc = Get-Content $mcPath -Raw | ConvertFrom-Json

# Define all new mod elements 
$newElements = @(
    @{name="ChakraSystem"; type="code"; sortid=3},
    @{name="ChakraOverlay"; type="code"; sortid=4},
    @{name="Keybinds"; type="code"; sortid=5},
    @{name="NinjaWeapons"; type="code"; sortid=10},
    @{name="Projectiles"; type="code"; sortid=11},
    @{name="JutsuRegistry"; type="code"; sortid=12},
    @{name="JutsuScrolls"; type="code"; sortid=15},
    @{name="NinjaFood"; type="code"; sortid=16},
    @{name="AkatsukiArmor"; type="armor"; sortid=20},
    @{name="AnbuArmor"; type="armor"; sortid=21},
    @{name="SageArmor"; type="armor"; sortid=22},
    @{name="NinjaBlocks"; type="code"; sortid=30},
    @{name="NPCEntities"; type="code"; sortid=40},
    @{name="JutsuMenu"; type="code"; sortid=50}
)

$modElements = @($mc.mod_elements)

foreach ($elem in $newElements) {
    $exists = $false
    foreach ($existing in $modElements) {
        if ($existing.name -eq $elem.name) { $exists = $true; break }
    }
    if (-not $exists) {
        $newEntry = [PSCustomObject]@{
            name = $elem.name
            type = $elem.type
            sortid = $elem.sortid
            compiles = $true
            locked_code = $true
            path = "~"
        }
        $modElements += $newEntry
    }
}

$mc.mod_elements = $modElements

# Update language map with ALL entries
$langMap = @{
    "tile.training_dummy.name" = "Training Dummy"
    "tile.chakra_altar.name" = "Chakra Altar"
    "tile.konoha_stone.name" = "Konoha Stone"
    "tile.konoha_planks.name" = "Konoha Planks"
    "item.kunai.name" = "Kunai"
    "item.shuriken.name" = "Shuriken"
    "item.katana.name" = "Katana"
    "item.explosive_kunai.name" = "Explosive Kunai"
    "item.senbon.name" = "Senbon"
    "item.blank_scroll.name" = "Blank Scroll"
    "item.rasengan_scroll.name" = "Rasengan Scroll"
    "item.chidori_scroll.name" = "Chidori Scroll"
    "item.fireball_scroll.name" = "Fireball Scroll"
    "item.water_dragon_scroll.name" = "Water Dragon Scroll"
    "item.wind_blade_scroll.name" = "Wind Blade Scroll"
    "item.earth_wall_scroll.name" = "Earth Wall Scroll"
    "item.shadow_clone_scroll.name" = "Shadow Clone Scroll"
    "item.healing_scroll.name" = "Healing Scroll"
    "item.substitution_scroll.name" = "Substitution Scroll"
    "item.body_flicker_scroll.name" = "Body Flicker Scroll"
    "item.ramen.name" = "Ichiraku Ramen"
    "item.soldier_pill.name" = "Soldier Pill"
    "item.rice_ball.name" = "Rice Ball"
    "item.dango.name" = "Dango"
    "item.chakra_fruit.name" = "Chakra Fruit"
    "item.konoha_armor_helmet.name" = "Konoha Helmet"
    "item.konoha_armor_chestplate.name" = "Konoha Chestplate"
    "item.konoha_armor_leggings.name" = "Konoha Leggings"
    "item.konoha_armor_boots.name" = "Konoha Boots"
    "item.akatsuki_armor_helmet.name" = "Akatsuki Helmet"
    "item.akatsuki_armor_chestplate.name" = "Akatsuki Chestplate"
    "item.akatsuki_armor_leggings.name" = "Akatsuki Leggings"
    "item.akatsuki_armor_boots.name" = "Akatsuki Boots"
    "item.anbu_armor_helmet.name" = "ANBU Helmet"
    "item.anbu_armor_chestplate.name" = "ANBU Chestplate"
    "item.anbu_armor_leggings.name" = "ANBU Leggings"
    "item.anbu_armor_boots.name" = "ANBU Boots"
    "item.sage_armor_helmet.name" = "Sage Helmet"
    "item.sage_armor_chestplate.name" = "Sage Chestplate"
    "item.sage_armor_leggings.name" = "Sage Leggings"
    "item.sage_armor_boots.name" = "Sage Boots"
    "entity.projetokonoha.naruto_npc.name" = "Naruto Uzumaki"
    "entity.projetokonoha.sasuke_npc.name" = "Sasuke Uchiha"
    "entity.projetokonoha.kakashi_npc.name" = "Kakashi Hatake"
    "entity.projetokonoha.sakura_npc.name" = "Sakura Haruno"
    "itemGroup.tabkonoha" = "Konoha Ninja Mod"
}

$mc.language_map.en_us = [PSCustomObject]$langMap

$json = $mc | ConvertTo-Json -Depth 10
[System.IO.File]::WriteAllText($mcPath, $json)
Write-Host ".mcreator file updated with all mod elements and language entries."
