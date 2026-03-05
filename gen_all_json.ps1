# =====================================================
# NARUTO MOD JSON GENERATOR
# Generates all model JSONs, blockstates, recipes, lang
# =====================================================

$base = "C:\Users\andra\MCreatorWorkspaces\projetokonoha\src\main\resources\assets\projetokonoha"
$dataBase = "C:\Users\andra\MCreatorWorkspaces\projetokonoha\src\main\resources"

$itemModelDir = "$base\models\item"
$blockModelDir = "$base\models\block"
$blockstateDir = "$base\blockstates"
$recipeDir = "$dataBase\data\projetokonoha\recipes"
$langDir = "$base\lang"

foreach ($d in @($itemModelDir, $blockModelDir, $blockstateDir, $recipeDir, $langDir)) {
    if (!(Test-Path $d)) { New-Item -ItemType Directory -Path $d -Force | Out-Null }
}

# ============= ITEM MODELS =============
Write-Host "=== Generating Item Models ==="

function Make-ItemModel($name) {
    $json = @"
{
    "parent": "item/generated",
    "textures": {
        "layer0": "projetokonoha:items/$name"
    }
}
"@
    $path = "$itemModelDir\$name.json"
    [System.IO.File]::WriteAllText($path, $json)
    Write-Host "  Created: $name.json"
}

# Weapon items
$items = @(
    "kunai", "shuriken", "katana", "explosive_kunai", "senbon",
    "blank_scroll",
    "rasengan_scroll", "chidori_scroll", "fireball_scroll",
    "water_dragon_scroll", "wind_blade_scroll", "earth_wall_scroll",
    "shadow_clone_scroll", "healing_scroll", "substitution_scroll", "body_flicker_scroll",
    "ramen", "soldier_pill", "rice_ball", "dango", "chakra_fruit",
    "konoha_armor_helmet", "konoha_armor_chestplate", "konoha_armor_leggings", "konoha_armor_boots",
    "akatsuki_armor_helmet", "akatsuki_armor_chestplate", "akatsuki_armor_leggings", "akatsuki_armor_boots",
    "anbu_armor_helmet", "anbu_armor_chestplate", "anbu_armor_leggings", "anbu_armor_boots",
    "sage_armor_helmet", "sage_armor_chestplate", "sage_armor_leggings", "sage_armor_boots"
)

foreach ($item in $items) {
    Make-ItemModel $item
}

# ============= BLOCK MODELS =============
Write-Host "=== Generating Block Models ==="

$blocks = @("training_dummy", "chakra_altar", "konoha_stone", "konoha_planks")
foreach ($block in $blocks) {
    # Block model
    $json = @"
{
    "parent": "block/cube_all",
    "textures": {
        "all": "projetokonoha:blocks/$block"
    }
}
"@
    [System.IO.File]::WriteAllText("$blockModelDir\$block.json", $json)
    Write-Host "  Block model: $block.json"

    # Item model for block item
    $itemJson = @"
{
    "parent": "projetokonoha:block/$block"
}
"@
    [System.IO.File]::WriteAllText("$itemModelDir\$block.json", $itemJson)
    Write-Host "  Block item model: $block.json"

    # Blockstate
    $bsJson = @"
{
    "variants": {
        "normal": { "model": "projetokonoha:$block" }
    }
}
"@
    [System.IO.File]::WriteAllText("$blockstateDir\$block.json", $bsJson)
    Write-Host "  Blockstate: $block.json"
}

# ============= RECIPES =============
Write-Host "=== Generating Recipes ==="

# Kunai recipe
$json = @"
{
    "type": "minecraft:crafting_shaped",
    "pattern": [" I ", " I ", " S "],
    "key": {
        "I": {"item": "minecraft:iron_ingot"},
        "S": {"item": "minecraft:stick"}
    },
    "result": {"item": "projetokonoha:kunai", "count": 4}
}
"@
[System.IO.File]::WriteAllText("$recipeDir\kunai.json", $json)

# Shuriken recipe
$json = @"
{
    "type": "minecraft:crafting_shaped",
    "pattern": [" I ", "I I", " I "],
    "key": {
        "I": {"item": "minecraft:iron_nugget"}
    },
    "result": {"item": "projetokonoha:shuriken", "count": 8}
}
"@
[System.IO.File]::WriteAllText("$recipeDir\shuriken.json", $json)

# Katana recipe
$json = @"
{
    "type": "minecraft:crafting_shaped",
    "pattern": ["  I", " I ", "GS "],
    "key": {
        "I": {"item": "minecraft:iron_ingot"},
        "S": {"item": "minecraft:stick"},
        "G": {"item": "minecraft:gold_ingot"}
    },
    "result": {"item": "projetokonoha:katana", "count": 1}
}
"@
[System.IO.File]::WriteAllText("$recipeDir\katana.json", $json)

# Explosive kunai
$json = @"
{
    "type": "minecraft:crafting_shapeless",
    "ingredients": [
        {"item": "projetokonoha:kunai"},
        {"item": "minecraft:tnt"},
        {"item": "minecraft:paper"}
    ],
    "result": {"item": "projetokonoha:explosive_kunai", "count": 2}
}
"@
[System.IO.File]::WriteAllText("$recipeDir\explosive_kunai.json", $json)

# Senbon
$json = @"
{
    "type": "minecraft:crafting_shaped",
    "pattern": ["  I", " I ", "I  "],
    "key": {
        "I": {"item": "minecraft:iron_nugget"}
    },
    "result": {"item": "projetokonoha:senbon", "count": 8}
}
"@
[System.IO.File]::WriteAllText("$recipeDir\senbon.json", $json)

# Blank scroll
$json = @"
{
    "type": "minecraft:crafting_shaped",
    "pattern": ["PPP", "PSP", "PPP"],
    "key": {
        "P": {"item": "minecraft:paper"},
        "S": {"item": "minecraft:stick"}
    },
    "result": {"item": "projetokonoha:blank_scroll", "count": 3}
}
"@
[System.IO.File]::WriteAllText("$recipeDir\blank_scroll.json", $json)

# Ramen
$json = @"
{
    "type": "minecraft:crafting_shaped",
    "pattern": ["WEW", " B "],
    "key": {
        "W": {"item": "minecraft:wheat"},
        "E": {"item": "minecraft:egg"},
        "B": {"item": "minecraft:bowl"}
    },
    "result": {"item": "projetokonoha:ramen", "count": 1}
}
"@
[System.IO.File]::WriteAllText("$recipeDir\ramen.json", $json)

# Soldier pill
$json = @"
{
    "type": "minecraft:crafting_shapeless",
    "ingredients": [
        {"item": "minecraft:golden_apple"},
        {"item": "minecraft:ghast_tear"},
        {"item": "minecraft:blaze_powder"}
    ],
    "result": {"item": "projetokonoha:soldier_pill", "count": 3}
}
"@
[System.IO.File]::WriteAllText("$recipeDir\soldier_pill.json", $json)

# Rice ball
$json = @"
{
    "type": "minecraft:crafting_shaped",
    "pattern": [" W ", "WWW", " K "],
    "key": {
        "W": {"item": "minecraft:wheat"},
        "K": {"item": "minecraft:dried_kelp", "data": 0}
    },
    "result": {"item": "projetokonoha:rice_ball", "count": 3}
}
"@
[System.IO.File]::WriteAllText("$recipeDir\rice_ball.json", $json)

# Dango
$json = @"
{
    "type": "minecraft:crafting_shaped",
    "pattern": [" W ", " W ", " S "],
    "key": {
        "W": {"item": "minecraft:wheat"},
        "S": {"item": "minecraft:stick"}
    },
    "result": {"item": "projetokonoha:dango", "count": 4}
}
"@
[System.IO.File]::WriteAllText("$recipeDir\dango.json", $json)

# Training dummy
$json = @"
{
    "type": "minecraft:crafting_shaped",
    "pattern": [" S ", "SWS", " S "],
    "key": {
        "S": {"item": "minecraft:stick"},
        "W": {"item": "minecraft:log"}
    },
    "result": {"item": "projetokonoha:training_dummy", "count": 1}
}
"@
[System.IO.File]::WriteAllText("$recipeDir\training_dummy.json", $json)

# Chakra altar
$json = @"
{
    "type": "minecraft:crafting_shaped",
    "pattern": ["DED", "ESE", "DED"],
    "key": {
        "D": {"item": "minecraft:diamond"},
        "E": {"item": "minecraft:emerald"},
        "S": {"item": "minecraft:nether_star"}
    },
    "result": {"item": "projetokonoha:chakra_altar", "count": 1}
}
"@
[System.IO.File]::WriteAllText("$recipeDir\chakra_altar.json", $json)

# Konoha stone
$json = @"
{
    "type": "minecraft:crafting_shaped",
    "pattern": ["SS", "SS"],
    "key": {
        "S": {"item": "minecraft:stone"}
    },
    "result": {"item": "projetokonoha:konoha_stone", "count": 4}
}
"@
[System.IO.File]::WriteAllText("$recipeDir\konoha_stone.json", $json)

# Konoha planks
$json = @"
{
    "type": "minecraft:crafting_shaped",
    "pattern": ["PP", "PP"],
    "key": {
        "P": {"item": "minecraft:planks"}
    },
    "result": {"item": "projetokonoha:konoha_planks", "count": 4}
}
"@
[System.IO.File]::WriteAllText("$recipeDir\konoha_planks.json", $json)

# Akatsuki armor
$armorSets = @(
    @{name="akatsuki_armor"; mat="minecraft:obsidian"; ingot="minecraft:nether_star"},
    @{name="anbu_armor"; mat="minecraft:iron_ingot"; ingot="minecraft:diamond"},
    @{name="sage_armor"; mat="minecraft:gold_ingot"; ingot="minecraft:emerald"}
)

foreach ($set in $armorSets) {
    $n = $set.name
    $m = $set.mat
    $ing = $set.ingot

    # Helmet
    $json = @"
{
    "type": "minecraft:crafting_shaped",
    "pattern": ["MMM", "M M"],
    "key": {"M": {"item": "$m"}},
    "result": {"item": "projetokonoha:${n}_helmet", "count": 1}
}
"@
    [System.IO.File]::WriteAllText("$recipeDir\${n}_helmet.json", $json)

    # Chestplate
    $json = @"
{
    "type": "minecraft:crafting_shaped",
    "pattern": ["M M", "MMM", "MMM"],
    "key": {"M": {"item": "$m"}},
    "result": {"item": "projetokonoha:${n}_chestplate", "count": 1}
}
"@
    [System.IO.File]::WriteAllText("$recipeDir\${n}_chestplate.json", $json)

    # Leggings
    $json = @"
{
    "type": "minecraft:crafting_shaped",
    "pattern": ["MMM", "M M", "M M"],
    "key": {"M": {"item": "$m"}},
    "result": {"item": "projetokonoha:${n}_leggings", "count": 1}
}
"@
    [System.IO.File]::WriteAllText("$recipeDir\${n}_leggings.json", $json)

    # Boots
    $json = @"
{
    "type": "minecraft:crafting_shaped",
    "pattern": ["M M", "M M"],
    "key": {"M": {"item": "$m"}},
    "result": {"item": "projetokonoha:${n}_boots", "count": 1}
}
"@
    [System.IO.File]::WriteAllText("$recipeDir\${n}_boots.json", $json)
}

Write-Host "  All recipes created."

# ============= LANGUAGE FILE =============
Write-Host "=== Generating Language File ==="

$lang = @"
tile.training_dummy.name=Training Dummy
tile.chakra_altar.name=Chakra Altar
tile.konoha_stone.name=Konoha Stone
tile.konoha_planks.name=Konoha Planks

item.kunai.name=Kunai
item.shuriken.name=Shuriken
item.katana.name=Katana
item.explosive_kunai.name=Explosive Kunai
item.senbon.name=Senbon

item.blank_scroll.name=Blank Scroll
item.rasengan_scroll.name=Rasengan Scroll
item.chidori_scroll.name=Chidori Scroll
item.fireball_scroll.name=Fireball Scroll
item.water_dragon_scroll.name=Water Dragon Scroll
item.wind_blade_scroll.name=Wind Blade Scroll
item.earth_wall_scroll.name=Earth Wall Scroll
item.shadow_clone_scroll.name=Shadow Clone Scroll
item.healing_scroll.name=Healing Scroll
item.substitution_scroll.name=Substitution Scroll
item.body_flicker_scroll.name=Body Flicker Scroll

item.ramen.name=Ichiraku Ramen
item.soldier_pill.name=Soldier Pill
item.rice_ball.name=Rice Ball
item.dango.name=Dango
item.chakra_fruit.name=Chakra Fruit

item.konoha_armor_helmet.name=Konoha Helmet
item.konoha_armor_chestplate.name=Konoha Chestplate
item.konoha_armor_leggings.name=Konoha Leggings
item.konoha_armor_boots.name=Konoha Boots

item.akatsuki_armor_helmet.name=Akatsuki Helmet
item.akatsuki_armor_chestplate.name=Akatsuki Chestplate
item.akatsuki_armor_leggings.name=Akatsuki Leggings
item.akatsuki_armor_boots.name=Akatsuki Boots

item.anbu_armor_helmet.name=ANBU Helmet
item.anbu_armor_chestplate.name=ANBU Chestplate
item.anbu_armor_leggings.name=ANBU Leggings
item.anbu_armor_boots.name=ANBU Boots

item.sage_armor_helmet.name=Sage Helmet
item.sage_armor_chestplate.name=Sage Chestplate
item.sage_armor_leggings.name=Sage Leggings
item.sage_armor_boots.name=Sage Boots

entity.projetokonoha.naruto_npc.name=Naruto Uzumaki
entity.projetokonoha.sasuke_npc.name=Sasuke Uchiha
entity.projetokonoha.kakashi_npc.name=Kakashi Hatake
entity.projetokonoha.sakura_npc.name=Sakura Haruno

itemGroup.tabkonoha=Konoha Ninja Mod
"@

[System.IO.File]::WriteAllText("$langDir\en_us.lang", $lang)
Write-Host "  Language file created."

# Also create pt_br
$langBr = @"
tile.training_dummy.name=Boneco de Treino
tile.chakra_altar.name=Altar de Chakra
tile.konoha_stone.name=Pedra de Konoha
tile.konoha_planks.name=Tabuas de Konoha

item.kunai.name=Kunai
item.shuriken.name=Shuriken
item.katana.name=Katana
item.explosive_kunai.name=Kunai Explosiva
item.senbon.name=Senbon

item.blank_scroll.name=Pergaminho em Branco
item.rasengan_scroll.name=Pergaminho de Rasengan
item.chidori_scroll.name=Pergaminho de Chidori
item.fireball_scroll.name=Pergaminho de Bola de Fogo
item.water_dragon_scroll.name=Pergaminho de Dragao de Agua
item.wind_blade_scroll.name=Pergaminho de Lamina de Vento
item.earth_wall_scroll.name=Pergaminho de Muro de Terra
item.shadow_clone_scroll.name=Pergaminho de Clone das Sombras
item.healing_scroll.name=Pergaminho de Cura
item.substitution_scroll.name=Pergaminho de Substituicao
item.body_flicker_scroll.name=Pergaminho de Corpo Cintilante

item.ramen.name=Ramen do Ichiraku
item.soldier_pill.name=Pilula do Soldado
item.rice_ball.name=Onigiri
item.dango.name=Dango
item.chakra_fruit.name=Fruta de Chakra

item.konoha_armor_helmet.name=Capacete de Konoha
item.konoha_armor_chestplate.name=Peitoral de Konoha
item.konoha_armor_leggings.name=Calcas de Konoha
item.konoha_armor_boots.name=Botas de Konoha

item.akatsuki_armor_helmet.name=Capacete Akatsuki
item.akatsuki_armor_chestplate.name=Peitoral Akatsuki
item.akatsuki_armor_leggings.name=Calcas Akatsuki
item.akatsuki_armor_boots.name=Botas Akatsuki

item.anbu_armor_helmet.name=Capacete ANBU
item.anbu_armor_chestplate.name=Peitoral ANBU
item.anbu_armor_leggings.name=Calcas ANBU
item.anbu_armor_boots.name=Botas ANBU

item.sage_armor_helmet.name=Capacete Sabio
item.sage_armor_chestplate.name=Peitoral Sabio
item.sage_armor_leggings.name=Calcas Sabio
item.sage_armor_boots.name=Botas Sabio

entity.projetokonoha.naruto_npc.name=Naruto Uzumaki
entity.projetokonoha.sasuke_npc.name=Sasuke Uchiha
entity.projetokonoha.kakashi_npc.name=Kakashi Hatake
entity.projetokonoha.sakura_npc.name=Sakura Haruno

itemGroup.tabkonoha=Mod Ninja de Konoha
"@

[System.IO.File]::WriteAllText("$langDir\pt_br.lang", $langBr)
Write-Host "  Portuguese language file created."

Write-Host ""
Write-Host "=== ALL JSON FILES GENERATED ==="
$totalFiles = 0
$totalSize = 0
foreach ($dir in @($itemModelDir, $blockModelDir, $blockstateDir, $recipeDir, $langDir)) {
    $files = Get-ChildItem $dir -File
    $totalFiles += $files.Count
    $totalSize += ($files | Measure-Object -Property Length -Sum).Sum
}
Write-Host "Total JSON/lang files: $totalFiles"
Write-Host "Total JSON/lang size: $([Math]::Round($totalSize/1024,1)) KB"
