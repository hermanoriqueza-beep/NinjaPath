$base = "C:\Users\andra\MCreatorWorkspaces\projetokonoha\src\main\resources\assets\projetokonoha"
$models = "$base\models\item"
$blockModels = "$base\models\block"
$blockStates = "$base\blockstates"
$recipePath = "$base\recipes"
$langPath = "$base\lang"

foreach($d in @($models,$blockModels,$blockStates,$recipePath,$langPath)) {
    if(!(Test-Path $d)) { New-Item -ItemType Directory -Path $d -Force | Out-Null }
}

# ===== CLEAR OLD ITEM MODELS AND RECREATE ALL =====
Write-Host "Generating item models..."

# All items that need item/generated models
$allItems = @(
    # Weapons
    "kunai","shuriken","katana","explosive_kunai","senbon",
    "fuma_shuriken","tanto","paper_bomb","smoke_bomb","chakra_blade","kusarigama",
    # Scrolls
    "rasengan_scroll","chidori_scroll","fireball_scroll","water_dragon_scroll",
    "wind_blade_scroll","earth_wall_scroll","shadow_clone_scroll","healing_scroll",
    "substitution_scroll","body_flicker_scroll","blank_scroll",
    "amaterasu_scroll","sand_coffin_scroll","eight_gates_scroll",
    "summoning_scroll","gentle_fist_scroll","lightning_blade_scroll",
    # Food
    "ramen","soldier_pill","rice_ball","dango","chakra_fruit",
    "military_ration","curry_of_life","sweet_bean_paste","green_tea","onigiri",
    # Armor items (correctly named to match registry names)
    "konoha_helmet","konoha_chestplate","konoha_leggings","konoha_boots",
    "akatsuki_helmet","akatsuki_chestplate","akatsuki_leggings","akatsuki_boots",
    "anbu_helmet","anbu_chestplate","anbu_leggings","anbu_boots",
    "sage_helmet","sage_chestplate","sage_leggings","sage_boots",
    "hokage_helmet","hokage_chestplate","hokage_leggings","hokage_boots",
    "sound_helmet","sound_chestplate","sound_leggings","sound_boots",
    # Ores & materials
    "chakra_crystal","ninja_steel_ingot","chakra_dust","ninja_steel_nugget",
    # Tools
    "chakra_pickaxe","chakra_axe","chakra_shovel",
    # Special items
    "sharingan_eye","byakugan_eye","ninja_headband","summoning_contract",
    "bijuu_cloak","cursed_seal","chakra_paper","ninja_wire"
)

foreach($item in $allItems) {
    $json = @"
{
    "parent": "item/generated",
    "textures": {
        "layer0": "projetokonoha:items/$item"
    }
}
"@
    Set-Content -Path "$models\$item.json" -Value $json -Encoding UTF8
}
Write-Host "  $($allItems.Count) item models generated"

# ===== BLOCK MODELS =====
Write-Host "Generating block models..."
$allBlocks = @(
    "training_dummy","chakra_altar","konoha_stone","konoha_planks",
    "chakra_ore","chakra_crystal_block","ninja_steel_block",
    "ramen_shop_counter","scroll_shelf","tatami_mat","paper_wall",
    "red_torii","ninja_lamp","village_banner_block","explosive_tag_block"
)

foreach($block in $allBlocks) {
    # Block model
    $json = @"
{
    "parent": "block/cube_all",
    "textures": {
        "all": "projetokonoha:blocks/$block"
    }
}
"@
    Set-Content -Path "$blockModels\$block.json" -Value $json -Encoding UTF8

    # Block item model
    $itemJson = @"
{
    "parent": "projetokonoha:block/$block"
}
"@
    Set-Content -Path "$models\$block.json" -Value $itemJson -Encoding UTF8

    # Blockstate
    $bsJson = @"
{
    "variants": {
        "normal": { "model": "projetokonoha:$block" }
    }
}
"@
    Set-Content -Path "$blockStates\$block.json" -Value $bsJson -Encoding UTF8
}
Write-Host "  $($allBlocks.Count) block models + blockstates generated"

# ===== RECIPES =====
Write-Host "Generating recipes..."

function Write-Recipe($name, $json) {
    Set-Content -Path "$recipePath\$name.json" -Value $json -Encoding UTF8
}

# Kunai recipe
Write-Recipe "kunai" @"
{"type":"minecraft:crafting_shaped","pattern":["  I"," I ","S  "],"key":{"I":{"item":"minecraft:iron_ingot"},"S":{"item":"minecraft:stick"}},"result":{"item":"projetokonoha:kunai","count":4}}
"@

# Shuriken
Write-Recipe "shuriken" @"
{"type":"minecraft:crafting_shaped","pattern":[" I ","III"," I "],"key":{"I":{"item":"minecraft:iron_nugget"}},"result":{"item":"projetokonoha:shuriken","count":8}}
"@

# Katana
Write-Recipe "katana" @"
{"type":"minecraft:crafting_shaped","pattern":["  I"," I ","S  "],"key":{"I":{"item":"minecraft:iron_ingot"},"S":{"item":"minecraft:stick"}},"result":{"item":"projetokonoha:katana"}}
"@

# Explosive kunai
Write-Recipe "explosive_kunai" @"
{"type":"minecraft:crafting_shapeless","ingredients":[{"item":"projetokonoha:kunai"},{"item":"minecraft:gunpowder"}],"result":{"item":"projetokonoha:explosive_kunai","count":1}}
"@

# Senbon
Write-Recipe "senbon" @"
{"type":"minecraft:crafting_shaped","pattern":["I","I","I"],"key":{"I":{"item":"minecraft:iron_nugget"}},"result":{"item":"projetokonoha:senbon","count":8}}
"@

# Fuma Shuriken
Write-Recipe "fuma_shuriken" @"
{"type":"minecraft:crafting_shaped","pattern":[" I ","ISI"," I "],"key":{"I":{"item":"minecraft:iron_ingot"},"S":{"item":"projetokonoha:shuriken"}},"result":{"item":"projetokonoha:fuma_shuriken","count":2}}
"@

# Tanto
Write-Recipe "tanto" @"
{"type":"minecraft:crafting_shaped","pattern":["I","I","S"],"key":{"I":{"item":"minecraft:iron_ingot"},"S":{"item":"minecraft:stick"}},"result":{"item":"projetokonoha:tanto"}}
"@

# Paper Bomb
Write-Recipe "paper_bomb" @"
{"type":"minecraft:crafting_shaped","pattern":["PGP","PRP","PPP"],"key":{"P":{"item":"minecraft:paper"},"G":{"item":"minecraft:gunpowder"},"R":{"item":"minecraft:redstone"}},"result":{"item":"projetokonoha:paper_bomb","count":4}}
"@

# Smoke Bomb
Write-Recipe "smoke_bomb" @"
{"type":"minecraft:crafting_shaped","pattern":[" G ","GIG"," G "],"key":{"G":{"item":"minecraft:gunpowder"},"I":{"item":"minecraft:ink_sac"}},"result":{"item":"projetokonoha:smoke_bomb","count":4}}
"@

# Chakra Blade
Write-Recipe "chakra_blade" @"
{"type":"minecraft:crafting_shaped","pattern":["C","C","S"],"key":{"C":{"item":"projetokonoha:chakra_crystal"},"S":{"item":"projetokonoha:ninja_steel_ingot"}},"result":{"item":"projetokonoha:chakra_blade"}}
"@

# Kusarigama
Write-Recipe "kusarigama" @"
{"type":"minecraft:crafting_shaped","pattern":["II ","SI ","  I"],"key":{"I":{"item":"minecraft:iron_ingot"},"S":{"item":"minecraft:stick"}},"result":{"item":"projetokonoha:kusarigama"}}
"@

# Ramen
Write-Recipe "ramen" @"
{"type":"minecraft:crafting_shaped","pattern":["W W","BMB","BBB"],"key":{"W":{"item":"minecraft:wheat"},"B":{"item":"minecraft:bowl"},"M":{"item":"minecraft:cooked_porkchop"}},"result":{"item":"projetokonoha:ramen"}}
"@

# Rice Ball
Write-Recipe "rice_ball" @"
{"type":"minecraft:crafting_shaped","pattern":["WWW","WKW","WWW"],"key":{"W":{"item":"minecraft:wheat"},"K":{"item":"minecraft:dried_kelp","data":32767}},"result":{"item":"projetokonoha:rice_ball","count":4}}
"@

# Dango
Write-Recipe "dango" @"
{"type":"minecraft:crafting_shaped","pattern":["W","W","S"],"key":{"W":{"item":"minecraft:wheat"},"S":{"item":"minecraft:stick"}},"result":{"item":"projetokonoha:dango","count":4}}
"@

# Soldier Pill
Write-Recipe "soldier_pill" @"
{"type":"minecraft:crafting_shapeless","ingredients":[{"item":"projetokonoha:chakra_crystal"},{"item":"minecraft:golden_apple"}],"result":{"item":"projetokonoha:soldier_pill","count":2}}
"@

# Military Ration
Write-Recipe "military_ration" @"
{"type":"minecraft:crafting_shaped","pattern":["CPC","PBP","CPC"],"key":{"C":{"item":"projetokonoha:chakra_dust"},"P":{"item":"minecraft:cooked_beef"},"B":{"item":"minecraft:bread"}},"result":{"item":"projetokonoha:military_ration","count":2}}
"@

# Curry of Life
Write-Recipe "curry_of_life" @"
{"type":"minecraft:crafting_shaped","pattern":["PPP","BMB","BBB"],"key":{"P":{"item":"minecraft:potato"},"B":{"item":"minecraft:bowl"},"M":{"item":"minecraft:cooked_beef"}},"result":{"item":"projetokonoha:curry_of_life"}}
"@

# Sweet Bean Paste
Write-Recipe "sweet_bean_paste" @"
{"type":"minecraft:crafting_shapeless","ingredients":[{"item":"minecraft:sugar"},{"item":"minecraft:cocoa_beans"}],"result":{"item":"projetokonoha:sweet_bean_paste","count":4}}
"@

# Green Tea
Write-Recipe "green_tea" @"
{"type":"minecraft:crafting_shapeless","ingredients":[{"item":"minecraft:glass_bottle"},{"item":"minecraft:sugar"},{"item":"projetokonoha:chakra_dust"}],"result":{"item":"projetokonoha:green_tea","count":2}}
"@

# Onigiri
Write-Recipe "onigiri" @"
{"type":"minecraft:crafting_shaped","pattern":["WW","WK"],"key":{"W":{"item":"minecraft:wheat"},"K":{"item":"minecraft:dried_kelp","data":32767}},"result":{"item":"projetokonoha:onigiri","count":4}}
"@

# Blank Scroll
Write-Recipe "blank_scroll" @"
{"type":"minecraft:crafting_shaped","pattern":["PPP","PSP","PPP"],"key":{"P":{"item":"minecraft:paper"},"S":{"item":"minecraft:stick"}},"result":{"item":"projetokonoha:blank_scroll","count":4}}
"@

# Ninja Headband
Write-Recipe "ninja_headband" @"
{"type":"minecraft:crafting_shaped","pattern":["LIL","I I"],"key":{"L":{"item":"minecraft:leather"},"I":{"item":"minecraft:iron_ingot"}},"result":{"item":"projetokonoha:ninja_headband"}}
"@

# Chakra Paper
Write-Recipe "chakra_paper" @"
{"type":"minecraft:crafting_shapeless","ingredients":[{"item":"minecraft:paper"},{"item":"projetokonoha:chakra_dust"}],"result":{"item":"projetokonoha:chakra_paper","count":4}}
"@

# Ninja Wire
Write-Recipe "ninja_wire" @"
{"type":"minecraft:crafting_shaped","pattern":["I  "," I ","  I"],"key":{"I":{"item":"minecraft:iron_nugget"}},"result":{"item":"projetokonoha:ninja_wire","count":8}}
"@

# Summoning Contract
Write-Recipe "summoning_contract" @"
{"type":"minecraft:crafting_shaped","pattern":["PPP","PRP","PPP"],"key":{"P":{"item":"minecraft:paper"},"R":{"item":"minecraft:redstone"}},"result":{"item":"projetokonoha:summoning_contract"}}
"@

# Ninja Steel Ingot (smelting chakra ore isn't easy in JSON, use crafting)
Write-Recipe "ninja_steel_ingot" @"
{"type":"minecraft:crafting_shaped","pattern":["CIC"],"key":{"C":{"item":"projetokonoha:chakra_dust"},"I":{"item":"minecraft:iron_ingot"}},"result":{"item":"projetokonoha:ninja_steel_ingot","count":2}}
"@

# Ninja Steel Block
Write-Recipe "ninja_steel_block" @"
{"type":"minecraft:crafting_shaped","pattern":["III","III","III"],"key":{"I":{"item":"projetokonoha:ninja_steel_ingot"}},"result":{"item":"projetokonoha:ninja_steel_block"}}
"@

# Chakra Crystal Block
Write-Recipe "chakra_crystal_block" @"
{"type":"minecraft:crafting_shaped","pattern":["CCC","CCC","CCC"],"key":{"C":{"item":"projetokonoha:chakra_crystal"}},"result":{"item":"projetokonoha:chakra_crystal_block"}}
"@

# Ninja Steel Nugget from Ingot
Write-Recipe "ninja_steel_nugget" @"
{"type":"minecraft:crafting_shapeless","ingredients":[{"item":"projetokonoha:ninja_steel_ingot"}],"result":{"item":"projetokonoha:ninja_steel_nugget","count":9}}
"@

# Blocks
Write-Recipe "training_dummy" @"
{"type":"minecraft:crafting_shaped","pattern":["WSW","WSW"," S "],"key":{"W":{"item":"minecraft:wool"},"S":{"item":"minecraft:stick"}},"result":{"item":"projetokonoha:training_dummy"}}
"@

Write-Recipe "chakra_altar" @"
{"type":"minecraft:crafting_shaped","pattern":["CSC","SES","CSC"],"key":{"C":{"item":"projetokonoha:chakra_crystal"},"S":{"item":"minecraft:stone"},"E":{"item":"minecraft:ender_pearl"}},"result":{"item":"projetokonoha:chakra_altar"}}
"@

Write-Recipe "ramen_shop_counter" @"
{"type":"minecraft:crafting_shaped","pattern":["PPP","W W","W W"],"key":{"P":{"item":"minecraft:wooden_slab"},"W":{"item":"minecraft:planks"}},"result":{"item":"projetokonoha:ramen_shop_counter"}}
"@

Write-Recipe "scroll_shelf" @"
{"type":"minecraft:crafting_shaped","pattern":["PPP","S S","PPP"],"key":{"P":{"item":"minecraft:planks"},"S":{"item":"projetokonoha:blank_scroll"}},"result":{"item":"projetokonoha:scroll_shelf"}}
"@

Write-Recipe "tatami_mat" @"
{"type":"minecraft:crafting_shaped","pattern":["WWW"],"key":{"W":{"item":"minecraft:wheat"}},"result":{"item":"projetokonoha:tatami_mat","count":6}}
"@

Write-Recipe "paper_wall" @"
{"type":"minecraft:crafting_shaped","pattern":["SPS","SPS","SPS"],"key":{"S":{"item":"minecraft:stick"},"P":{"item":"minecraft:paper"}},"result":{"item":"projetokonoha:paper_wall","count":4}}
"@

Write-Recipe "red_torii" @"
{"type":"minecraft:crafting_shaped","pattern":["PPP","P P","P P"],"key":{"P":{"item":"minecraft:planks"}},"result":{"item":"projetokonoha:red_torii","count":2}}
"@

Write-Recipe "ninja_lamp" @"
{"type":"minecraft:crafting_shaped","pattern":[" S ","SGS"," S "],"key":{"S":{"item":"minecraft:stick"},"G":{"item":"minecraft:glowstone"}},"result":{"item":"projetokonoha:ninja_lamp","count":4}}
"@

Write-Recipe "explosive_tag_block" @"
{"type":"minecraft:crafting_shapeless","ingredients":[{"item":"projetokonoha:paper_bomb"},{"item":"minecraft:redstone"}],"result":{"item":"projetokonoha:explosive_tag_block"}}
"@

Write-Recipe "village_banner_block" @"
{"type":"minecraft:crafting_shaped","pattern":["WSW","WRW","WSW"],"key":{"W":{"item":"minecraft:wool"},"S":{"item":"minecraft:stick"},"R":{"item":"minecraft:red_dye","data":32767}},"result":{"item":"projetokonoha:village_banner_block"}}
"@

# Tools
Write-Recipe "chakra_pickaxe" @"
{"type":"minecraft:crafting_shaped","pattern":["CCC"," S "," S "],"key":{"C":{"item":"projetokonoha:chakra_crystal"},"S":{"item":"minecraft:stick"}},"result":{"item":"projetokonoha:chakra_pickaxe"}}
"@

Write-Recipe "chakra_axe" @"
{"type":"minecraft:crafting_shaped","pattern":["CC","CS"," S"],"key":{"C":{"item":"projetokonoha:chakra_crystal"},"S":{"item":"minecraft:stick"}},"result":{"item":"projetokonoha:chakra_axe"}}
"@

Write-Recipe "chakra_shovel" @"
{"type":"minecraft:crafting_shaped","pattern":["C","S","S"],"key":{"C":{"item":"projetokonoha:chakra_crystal"},"S":{"item":"minecraft:stick"}},"result":{"item":"projetokonoha:chakra_shovel"}}
"@

# Armor Sets recipes
$armorRecipes = @{
    "konoha" = "projetokonoha:ninja_steel_ingot"
    "hokage" = "minecraft:gold_ingot"
    "sound" = "minecraft:iron_ingot"
}

foreach($set in $armorRecipes.Keys) {
    $mat = $armorRecipes[$set]
    Write-Recipe "${set}_helmet" "{`"type`":`"minecraft:crafting_shaped`",`"pattern`":[`"III`",`"I I`"],`"key`":{`"I`":{`"item`":`"$mat`"}},`"result`":{`"item`":`"projetokonoha:${set}_helmet`"}}"
    Write-Recipe "${set}_chestplate" "{`"type`":`"minecraft:crafting_shaped`",`"pattern`":[`"I I`",`"III`",`"III`"],`"key`":{`"I`":{`"item`":`"$mat`"}},`"result`":{`"item`":`"projetokonoha:${set}_chestplate`"}}"
    Write-Recipe "${set}_leggings" "{`"type`":`"minecraft:crafting_shaped`",`"pattern`":[`"III`",`"I I`",`"I I`"],`"key`":{`"I`":{`"item`":`"$mat`"}},`"result`":{`"item`":`"projetokonoha:${set}_leggings`"}}"
    Write-Recipe "${set}_boots" "{`"type`":`"minecraft:crafting_shaped`",`"pattern`":[`"I I`",`"I I`"],`"key`":{`"I`":{`"item`":`"$mat`"}},`"result`":{`"item`":`"projetokonoha:${set}_boots`"}}"
}

# Akatsuki armor (special material: diamond + wither skeleton skull)
Write-Recipe "akatsuki_helmet" '{"type":"minecraft:crafting_shaped","pattern":["DDD","D D"],"key":{"D":{"item":"minecraft:diamond"}},"result":{"item":"projetokonoha:akatsuki_helmet"}}'
Write-Recipe "akatsuki_chestplate" '{"type":"minecraft:crafting_shaped","pattern":["D D","DDD","DDD"],"key":{"D":{"item":"minecraft:diamond"}},"result":{"item":"projetokonoha:akatsuki_chestplate"}}'
Write-Recipe "akatsuki_leggings" '{"type":"minecraft:crafting_shaped","pattern":["DDD","D D","D D"],"key":{"D":{"item":"minecraft:diamond"}},"result":{"item":"projetokonoha:akatsuki_leggings"}}'
Write-Recipe "akatsuki_boots" '{"type":"minecraft:crafting_shaped","pattern":["D D","D D"],"key":{"D":{"item":"minecraft:diamond"}},"result":{"item":"projetokonoha:akatsuki_boots"}}'

# ANBU armor
Write-Recipe "anbu_helmet" '{"type":"minecraft:crafting_shaped","pattern":["III","I I"],"key":{"I":{"item":"projetokonoha:ninja_steel_ingot"}},"result":{"item":"projetokonoha:anbu_helmet"}}'
Write-Recipe "anbu_chestplate" '{"type":"minecraft:crafting_shaped","pattern":["I I","III","III"],"key":{"I":{"item":"projetokonoha:ninja_steel_ingot"}},"result":{"item":"projetokonoha:anbu_chestplate"}}'
Write-Recipe "anbu_leggings" '{"type":"minecraft:crafting_shaped","pattern":["III","I I","I I"],"key":{"I":{"item":"projetokonoha:ninja_steel_ingot"}},"result":{"item":"projetokonoha:anbu_leggings"}}'
Write-Recipe "anbu_boots" '{"type":"minecraft:crafting_shaped","pattern":["I I","I I"],"key":{"I":{"item":"projetokonoha:ninja_steel_ingot"}},"result":{"item":"projetokonoha:anbu_boots"}}'

# Sage armor
Write-Recipe "sage_helmet" '{"type":"minecraft:crafting_shaped","pattern":["CCC","C C"],"key":{"C":{"item":"projetokonoha:chakra_crystal"}},"result":{"item":"projetokonoha:sage_helmet"}}'
Write-Recipe "sage_chestplate" '{"type":"minecraft:crafting_shaped","pattern":["C C","CCC","CCC"],"key":{"C":{"item":"projetokonoha:chakra_crystal"}},"result":{"item":"projetokonoha:sage_chestplate"}}'
Write-Recipe "sage_leggings" '{"type":"minecraft:crafting_shaped","pattern":["CCC","C C","C C"],"key":{"C":{"item":"projetokonoha:chakra_crystal"}},"result":{"item":"projetokonoha:sage_leggings"}}'
Write-Recipe "sage_boots" '{"type":"minecraft:crafting_shaped","pattern":["C C","C C"],"key":{"C":{"item":"projetokonoha:chakra_crystal"}},"result":{"item":"projetokonoha:sage_boots"}}'

$recipeCount = (Get-ChildItem $recipePath -Filter "*.json").Count
Write-Host "  $recipeCount recipes generated"

# ===== LANGUAGE FILES =====
Write-Host "Generating language files..."

$enLang = @"
tile.training_dummy.name=Training Dummy
tile.chakra_altar.name=Chakra Altar
tile.konoha_stone.name=Konoha Stone
tile.konoha_planks.name=Konoha Planks
tile.chakra_ore.name=Chakra Ore
tile.chakra_crystal_block.name=Chakra Crystal Block
tile.ninja_steel_block.name=Ninja Steel Block
tile.ramen_shop_counter.name=Ramen Shop Counter
tile.scroll_shelf.name=Scroll Shelf
tile.tatami_mat.name=Tatami Mat
tile.paper_wall.name=Paper Wall
tile.red_torii.name=Red Torii Gate
tile.ninja_lamp.name=Ninja Lamp
tile.village_banner_block.name=Village Banner
tile.explosive_tag_block.name=Explosive Tag Block
item.kunai.name=Kunai
item.shuriken.name=Shuriken
item.katana.name=Katana
item.explosive_kunai.name=Explosive Kunai
item.senbon.name=Senbon Needle
item.fuma_shuriken.name=Fuma Shuriken
item.tanto.name=Tanto
item.paper_bomb.name=Paper Bomb
item.smoke_bomb.name=Smoke Bomb
item.chakra_blade.name=Chakra Blade
item.kusarigama.name=Kusarigama
item.rasengan_scroll.name=Scroll: Rasengan
item.chidori_scroll.name=Scroll: Chidori
item.fireball_scroll.name=Scroll: Fireball Jutsu
item.water_dragon_scroll.name=Scroll: Water Dragon
item.wind_blade_scroll.name=Scroll: Wind Blade
item.earth_wall_scroll.name=Scroll: Earth Wall
item.shadow_clone_scroll.name=Scroll: Shadow Clone
item.healing_scroll.name=Scroll: Healing Palm
item.substitution_scroll.name=Scroll: Substitution
item.body_flicker_scroll.name=Scroll: Body Flicker
item.blank_scroll.name=Blank Scroll
item.amaterasu_scroll.name=Scroll: Amaterasu
item.sand_coffin_scroll.name=Scroll: Sand Coffin
item.eight_gates_scroll.name=Scroll: Eight Gates
item.summoning_scroll.name=Scroll: Summoning Jutsu
item.gentle_fist_scroll.name=Scroll: Gentle Fist
item.lightning_blade_scroll.name=Scroll: Lightning Blade
item.ramen.name=Ichiraku Ramen
item.soldier_pill.name=Soldier Pill
item.rice_ball.name=Rice Ball
item.dango.name=Dango
item.chakra_fruit.name=Chakra Fruit
item.military_ration.name=Military Ration
item.curry_of_life.name=Curry of Life
item.sweet_bean_paste.name=Sweet Bean Paste
item.green_tea.name=Green Tea
item.onigiri.name=Onigiri
item.konoha_helmet.name=Konoha Helmet
item.konoha_chestplate.name=Konoha Chestplate
item.konoha_leggings.name=Konoha Leggings
item.konoha_boots.name=Konoha Boots
item.akatsuki_helmet.name=Akatsuki Helmet
item.akatsuki_chestplate.name=Akatsuki Chestplate
item.akatsuki_leggings.name=Akatsuki Leggings
item.akatsuki_boots.name=Akatsuki Boots
item.anbu_helmet.name=ANBU Helmet
item.anbu_chestplate.name=ANBU Chestplate
item.anbu_leggings.name=ANBU Leggings
item.anbu_boots.name=ANBU Boots
item.sage_helmet.name=Sage Helmet
item.sage_chestplate.name=Sage Chestplate
item.sage_leggings.name=Sage Leggings
item.sage_boots.name=Sage Boots
item.hokage_helmet.name=Hokage Hat
item.hokage_chestplate.name=Hokage Robe
item.hokage_leggings.name=Hokage Pants
item.hokage_boots.name=Hokage Sandals
item.sound_helmet.name=Sound Headband
item.sound_chestplate.name=Sound Chestplate
item.sound_leggings.name=Sound Leggings
item.sound_boots.name=Sound Boots
item.chakra_crystal.name=Chakra Crystal
item.ninja_steel_ingot.name=Ninja Steel Ingot
item.chakra_dust.name=Chakra Dust
item.ninja_steel_nugget.name=Ninja Steel Nugget
item.chakra_pickaxe.name=Chakra Pickaxe
item.chakra_axe.name=Chakra Axe
item.chakra_shovel.name=Chakra Shovel
item.sharingan_eye.name=Sharingan Eye
item.byakugan_eye.name=Byakugan Eye
item.ninja_headband.name=Ninja Headband
item.summoning_contract.name=Summoning Contract
item.bijuu_cloak.name=Bijuu Cloak
item.cursed_seal.name=Cursed Seal
item.chakra_paper.name=Chakra Paper
item.ninja_wire.name=Ninja Wire
entity.projetokonoha.naruto.name=Naruto Uzumaki
entity.projetokonoha.sasuke.name=Sasuke Uchiha
entity.projetokonoha.kakashi.name=Kakashi Hatake
entity.projetokonoha.sakura.name=Sakura Haruno
entity.projetokonoha.hinata.name=Hinata Hyuga
entity.projetokonoha.rock_lee.name=Rock Lee
entity.projetokonoha.gaara.name=Gaara of the Sand
entity.projetokonoha.itachi.name=Itachi Uchiha
entity.projetokonoha.jiraiya.name=Jiraiya the Toad Sage
entity.projetokonoha.tsunade.name=Tsunade Senju
itemGroup.konoha_ninja_mod=Konoha Ninja Mod
"@

$ptLang = @"
tile.training_dummy.name=Boneco de Treino
tile.chakra_altar.name=Altar de Chakra
tile.konoha_stone.name=Pedra de Konoha
tile.konoha_planks.name=Tabuas de Konoha
tile.chakra_ore.name=Minerio de Chakra
tile.chakra_crystal_block.name=Bloco de Cristal de Chakra
tile.ninja_steel_block.name=Bloco de Aco Ninja
tile.ramen_shop_counter.name=Balcao do Ichiraku
tile.scroll_shelf.name=Estante de Pergaminhos
tile.tatami_mat.name=Tatami
tile.paper_wall.name=Parede de Papel
tile.red_torii.name=Torii Vermelho
tile.ninja_lamp.name=Lampiao Ninja
tile.village_banner_block.name=Bandeira da Vila
tile.explosive_tag_block.name=Bloco de Selo Explosivo
item.kunai.name=Kunai
item.shuriken.name=Shuriken
item.katana.name=Katana
item.explosive_kunai.name=Kunai Explosiva
item.senbon.name=Agulha Senbon
item.fuma_shuriken.name=Fuma Shuriken
item.tanto.name=Tanto
item.paper_bomb.name=Bomba de Papel
item.smoke_bomb.name=Bomba de Fumaca
item.chakra_blade.name=Lamina de Chakra
item.kusarigama.name=Kusarigama
item.rasengan_scroll.name=Pergaminho: Rasengan
item.chidori_scroll.name=Pergaminho: Chidori
item.fireball_scroll.name=Pergaminho: Bola de Fogo
item.water_dragon_scroll.name=Pergaminho: Dragao de Agua
item.wind_blade_scroll.name=Pergaminho: Lamina de Vento
item.earth_wall_scroll.name=Pergaminho: Muralha de Terra
item.shadow_clone_scroll.name=Pergaminho: Clone das Sombras
item.healing_scroll.name=Pergaminho: Palma Curativa
item.substitution_scroll.name=Pergaminho: Substituicao
item.body_flicker_scroll.name=Pergaminho: Corpo Cintilante
item.blank_scroll.name=Pergaminho em Branco
item.amaterasu_scroll.name=Pergaminho: Amaterasu
item.sand_coffin_scroll.name=Pergaminho: Caixao de Areia
item.eight_gates_scroll.name=Pergaminho: Oito Portoes
item.summoning_scroll.name=Pergaminho: Jutsu de Invocacao
item.gentle_fist_scroll.name=Pergaminho: Punho Gentil
item.lightning_blade_scroll.name=Pergaminho: Lamina Relampago
item.ramen.name=Ramen do Ichiraku
item.soldier_pill.name=Pilula do Soldado
item.rice_ball.name=Bolinho de Arroz
item.dango.name=Dango
item.chakra_fruit.name=Fruta de Chakra
item.military_ration.name=Racao Militar
item.curry_of_life.name=Curry da Vida
item.sweet_bean_paste.name=Pasta de Feijao Doce
item.green_tea.name=Cha Verde
item.onigiri.name=Onigiri
item.konoha_helmet.name=Capacete de Konoha
item.konoha_chestplate.name=Peitoral de Konoha
item.konoha_leggings.name=Calcas de Konoha
item.konoha_boots.name=Botas de Konoha
item.akatsuki_helmet.name=Capacete Akatsuki
item.akatsuki_chestplate.name=Manto Akatsuki
item.akatsuki_leggings.name=Calcas Akatsuki
item.akatsuki_boots.name=Botas Akatsuki
item.anbu_helmet.name=Mascara ANBU
item.anbu_chestplate.name=Peitoral ANBU
item.anbu_leggings.name=Calcas ANBU
item.anbu_boots.name=Botas ANBU
item.sage_helmet.name=Capacete Sennin
item.sage_chestplate.name=Manto Sennin
item.sage_leggings.name=Calcas Sennin
item.sage_boots.name=Sandalia Sennin
item.hokage_helmet.name=Chapeu do Hokage
item.hokage_chestplate.name=Manto do Hokage
item.hokage_leggings.name=Calcas do Hokage
item.hokage_boots.name=Sandalias do Hokage
item.sound_helmet.name=Bandana do Som
item.sound_chestplate.name=Peitoral do Som
item.sound_leggings.name=Calcas do Som
item.sound_boots.name=Botas do Som
item.chakra_crystal.name=Cristal de Chakra
item.ninja_steel_ingot.name=Lingote de Aco Ninja
item.chakra_dust.name=Po de Chakra
item.ninja_steel_nugget.name=Pepita de Aco Ninja
item.chakra_pickaxe.name=Picareta de Chakra
item.chakra_axe.name=Machado de Chakra
item.chakra_shovel.name=Pa de Chakra
item.sharingan_eye.name=Olho Sharingan
item.byakugan_eye.name=Olho Byakugan
item.ninja_headband.name=Bandana Ninja
item.summoning_contract.name=Contrato de Invocacao
item.bijuu_cloak.name=Manto Bijuu
item.cursed_seal.name=Selo Amaldicoado
item.chakra_paper.name=Papel de Chakra
item.ninja_wire.name=Fio Ninja
entity.projetokonoha.naruto.name=Naruto Uzumaki
entity.projetokonoha.sasuke.name=Sasuke Uchiha
entity.projetokonoha.kakashi.name=Kakashi Hatake
entity.projetokonoha.sakura.name=Sakura Haruno
entity.projetokonoha.hinata.name=Hinata Hyuga
entity.projetokonoha.rock_lee.name=Rock Lee
entity.projetokonoha.gaara.name=Gaara da Areia
entity.projetokonoha.itachi.name=Itachi Uchiha
entity.projetokonoha.jiraiya.name=Jiraiya o Sennin dos Sapos
entity.projetokonoha.tsunade.name=Tsunade Senju
itemGroup.konoha_ninja_mod=Mod Ninja de Konoha
"@

Set-Content -Path "$langPath\en_us.lang" -Value $enLang -Encoding UTF8
Set-Content -Path "$langPath\pt_br.lang" -Value $ptLang -Encoding UTF8
Write-Host "  Language files generated (en_us + pt_br)"

Write-Host "`nAll assets generated successfully!"
$totalItems = (Get-ChildItem $models -Filter "*.json").Count
$totalBlocks = (Get-ChildItem $blockModels -Filter "*.json").Count
$totalBS = (Get-ChildItem $blockStates -Filter "*.json").Count
$totalRecipes = (Get-ChildItem $recipePath -Filter "*.json").Count
$totalTex = (Get-ChildItem "$base\textures" -Recurse -Filter "*.png").Count
Write-Host "Item models: $totalItems | Block models: $totalBlocks | Blockstates: $totalBS | Recipes: $totalRecipes | Textures: $totalTex"
