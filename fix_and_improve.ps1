Add-Type -AssemblyName System.Drawing
$root = "C:\Users\andra\MCreatorWorkspaces\projetokonoha\src\main\resources\assets\projetokonoha"

# ============================================================
# 1. COMPLETE LANG FILE (en_us and pt_br)
# ============================================================
Write-Host "Generating complete lang files..."

$en = @"
itemGroup.tabkonoha=Konoha Ninja Mod
item.kunai.name=Kunai
item.shuriken.name=Shuriken
item.katana.name=Katana
item.explosive_kunai.name=Explosive Kunai
item.senbon.name=Senbon
item.fuma_shuriken.name=Fuma Shuriken
item.tanto.name=Tanto
item.paper_bomb.name=Paper Bomb
item.smoke_bomb.name=Smoke Bomb
item.chakra_blade.name=Chakra Blade
item.kusarigama.name=Kusarigama
item.blank_scroll.name=Blank Scroll
item.scroll_rasengan.name=Rasengan Scroll
item.scroll_chidori.name=Chidori Scroll
item.scroll_fireball.name=Fireball Scroll
item.scroll_water_dragon.name=Water Dragon Scroll
item.scroll_wind_blade.name=Wind Blade Scroll
item.scroll_earth_wall.name=Earth Wall Scroll
item.scroll_shadow_clone.name=Shadow Clone Scroll
item.scroll_healing.name=Healing Scroll
item.scroll_substitution.name=Substitution Scroll
item.scroll_body_flicker.name=Body Flicker Scroll
item.amaterasu_scroll.name=Amaterasu Scroll
item.sand_coffin_scroll.name=Sand Coffin Scroll
item.eight_gates_scroll.name=Eight Gates Scroll
item.summoning_scroll.name=Summoning Scroll
item.gentle_fist_scroll.name=Gentle Fist Scroll
item.lightning_blade_scroll.name=Lightning Blade Scroll
item.ramen.name=Ichiraku Ramen
item.soldier_pill.name=Soldier Pill
item.rice_ball.name=Rice Ball
item.dango.name=Dango
item.chakra_fruit.name=Chakra Fruit
item.military_ration.name=Military Ration Pill
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
item.anbu_helmet.name=ANBU Mask
item.anbu_chestplate.name=ANBU Chestplate
item.anbu_leggings.name=ANBU Leggings
item.anbu_boots.name=ANBU Boots
item.sage_helmet.name=Sage Headband
item.sage_chestplate.name=Sage Robe
item.sage_leggings.name=Sage Leggings
item.sage_boots.name=Sage Sandals
item.hokage_helmet.name=Hokage Hat
item.hokage_chestplate.name=Hokage Robe
item.hokage_leggings.name=Hokage Pants
item.hokage_boots.name=Hokage Sandals
item.sound_helmet.name=Sound Headband
item.sound_chestplate.name=Sound Vest
item.sound_leggings.name=Sound Leggings
item.sound_boots.name=Sound Boots
item.chakra_crystal.name=Chakra Crystal
item.ninja_steel_ingot.name=Ninja Steel Ingot
item.chakra_dust.name=Chakra Dust
item.ninja_steel_nugget.name=Ninja Steel Nugget
item.sharingan_eye.name=Sharingan Eye
item.byakugan_eye.name=Byakugan Eye
item.ninja_headband.name=Ninja Headband
item.summoning_contract.name=Summoning Contract
item.bijuu_cloak.name=Bijuu Cloak
item.cursed_seal.name=Cursed Seal
item.chakra_paper.name=Chakra Paper
item.ninja_wire.name=Ninja Wire
item.chakra_pickaxe.name=Chakra Pickaxe
item.chakra_axe.name=Chakra Axe
item.chakra_shovel.name=Chakra Shovel
tile.chakra_altar.name=Chakra Altar
tile.training_dummy.name=Training Dummy
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
entity.projetokonoha.naruto_npc.name=Naruto Uzumaki
entity.projetokonoha.sasuke_npc.name=Sasuke Uchiha
entity.projetokonoha.kakashi_npc.name=Kakashi Hatake
entity.projetokonoha.sakura_npc.name=Sakura Haruno
entity.projetokonoha.hinata_npc.name=Hinata Hyuga
entity.projetokonoha.rocklee_npc.name=Rock Lee
entity.projetokonoha.gaara_npc.name=Gaara of the Sand
entity.projetokonoha.itachi_npc.name=Itachi Uchiha
entity.projetokonoha.jiraiya_npc.name=Jiraiya
entity.projetokonoha.tsunade_npc.name=Tsunade Senju
"@

$pt = @"
itemGroup.tabkonoha=Mod Ninja de Konoha
item.kunai.name=Kunai
item.shuriken.name=Shuriken
item.katana.name=Katana
item.explosive_kunai.name=Kunai Explosiva
item.senbon.name=Senbon
item.fuma_shuriken.name=Shuriken Fuma
item.tanto.name=Tanto
item.paper_bomb.name=Bomba de Papel
item.smoke_bomb.name=Bomba de Fumaca
item.chakra_blade.name=Lamina de Chakra
item.kusarigama.name=Kusarigama
item.blank_scroll.name=Pergaminho em Branco
item.scroll_rasengan.name=Pergaminho Rasengan
item.scroll_chidori.name=Pergaminho Chidori
item.scroll_fireball.name=Pergaminho Bola de Fogo
item.scroll_water_dragon.name=Pergaminho Dragao de Agua
item.scroll_wind_blade.name=Pergaminho Lamina de Vento
item.scroll_earth_wall.name=Pergaminho Muro de Terra
item.scroll_shadow_clone.name=Pergaminho Clone das Sombras
item.scroll_healing.name=Pergaminho de Cura
item.scroll_substitution.name=Pergaminho Substituicao
item.scroll_body_flicker.name=Pergaminho Corpo Cintilante
item.amaterasu_scroll.name=Pergaminho Amaterasu
item.sand_coffin_scroll.name=Pergaminho Caixao de Areia
item.eight_gates_scroll.name=Pergaminho Oito Portoes
item.summoning_scroll.name=Pergaminho de Invocacao
item.gentle_fist_scroll.name=Pergaminho Punho Gentil
item.lightning_blade_scroll.name=Pergaminho Lamina Relampago
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
item.sage_helmet.name=Bandana Sennin
item.sage_chestplate.name=Manto Sennin
item.sage_leggings.name=Calcas Sennin
item.sage_boots.name=Sandalias Sennin
item.hokage_helmet.name=Chapeu de Hokage
item.hokage_chestplate.name=Manto de Hokage
item.hokage_leggings.name=Calcas de Hokage
item.hokage_boots.name=Sandalias de Hokage
item.sound_helmet.name=Bandana do Som
item.sound_chestplate.name=Colete do Som
item.sound_leggings.name=Calcas do Som
item.sound_boots.name=Botas do Som
item.chakra_crystal.name=Cristal de Chakra
item.ninja_steel_ingot.name=Lingote de Aco Ninja
item.chakra_dust.name=Po de Chakra
item.ninja_steel_nugget.name=Pepita de Aco Ninja
item.sharingan_eye.name=Olho Sharingan
item.byakugan_eye.name=Olho Byakugan
item.ninja_headband.name=Bandana Ninja
item.summoning_contract.name=Contrato de Invocacao
item.bijuu_cloak.name=Manto Bijuu
item.cursed_seal.name=Selo Amaldicoado
item.chakra_paper.name=Papel de Chakra
item.ninja_wire.name=Fio Ninja
item.chakra_pickaxe.name=Picareta de Chakra
item.chakra_axe.name=Machado de Chakra
item.chakra_shovel.name=Pa de Chakra
tile.chakra_altar.name=Altar de Chakra
tile.training_dummy.name=Boneco de Treino
tile.konoha_stone.name=Pedra de Konoha
tile.konoha_planks.name=Tabuas de Konoha
tile.chakra_ore.name=Minerio de Chakra
tile.chakra_crystal_block.name=Bloco de Cristal de Chakra
tile.ninja_steel_block.name=Bloco de Aco Ninja
tile.ramen_shop_counter.name=Balcao de Ramen
tile.scroll_shelf.name=Estante de Pergaminhos
tile.tatami_mat.name=Tatami
tile.paper_wall.name=Parede de Papel
tile.red_torii.name=Torii Vermelho
tile.ninja_lamp.name=Lampada Ninja
tile.village_banner_block.name=Bandeira da Vila
tile.explosive_tag_block.name=Selo Explosivo
entity.projetokonoha.naruto_npc.name=Naruto Uzumaki
entity.projetokonoha.sasuke_npc.name=Sasuke Uchiha
entity.projetokonoha.kakashi_npc.name=Kakashi Hatake
entity.projetokonoha.sakura_npc.name=Sakura Haruno
entity.projetokonoha.hinata_npc.name=Hinata Hyuga
entity.projetokonoha.rocklee_npc.name=Rock Lee
entity.projetokonoha.gaara_npc.name=Gaara da Areia
entity.projetokonoha.itachi_npc.name=Itachi Uchiha
entity.projetokonoha.jiraiya_npc.name=Jiraiya
entity.projetokonoha.tsunade_npc.name=Tsunade Senju
"@

$langDir = "$root\lang"
if (!(Test-Path $langDir)) { New-Item $langDir -ItemType Directory -Force | Out-Null }
[System.IO.File]::WriteAllText("$langDir\en_us.lang", $en.Trim(), (New-Object System.Text.UTF8Encoding($false)))
[System.IO.File]::WriteAllText("$langDir\pt_br.lang", $pt.Trim(), (New-Object System.Text.UTF8Encoding($false)))
Write-Host "  Lang files complete (en_us + pt_br)"

# ============================================================
# 2. ADD ALL MISSING RECIPES
# ============================================================
Write-Host "Generating missing recipes..."
$recipeDir = "$root\recipes"

function MakeShapedRecipe($result, $count, $pattern, $keys) {
    $keyJson = ($keys | ForEach-Object { "`"$($_.k)`": {`"item`": `"$($_.v)`"}" }) -join ", "
    $patJson = ($pattern | ForEach-Object { "`"$_`"" }) -join ", "
    return "{`"type`":`"minecraft:crafting_shaped`",`"pattern`":[$patJson],`"key`":{$keyJson},`"result`":{`"item`":`"projetokonoha:$result`",`"count`":$count}}"
}

function MakeShapelessRecipe($result, $count, $ingredients) {
    $ingJson = ($ingredients | ForEach-Object { "{`"item`":`"$_`"}" }) -join ","
    return "{`"type`":`"minecraft:crafting_shapeless`",`"ingredients`":[$ingJson],`"result`":{`"item`":`"projetokonoha:$result`",`"count`":$count}}"
}

function MakeSmeltingRecipe($result, $ingredient, $xp) {
    return "{`"type`":`"minecraft:smelting`",`"ingredient`":{`"item`":`"$ingredient`"},`"result`":`"projetokonoha:$result`",`"experience`":$xp,`"cookingtime`":200}"
}

$recipes = @{}

# Weapons
$recipes["tanto"] = MakeShapedRecipe "tanto" 1 @(" I "," I "," S ") @(@{k="I";v="minecraft:iron_ingot"},@{k="S";v="minecraft:stick"})
$recipes["fuma_shuriken"] = MakeShapedRecipe "fuma_shuriken" 1 @(" I ","IXI"," I ") @(@{k="I";v="minecraft:iron_ingot"},@{k="X";v="projetokonoha:ninja_steel_ingot"})
$recipes["smoke_bomb"] = MakeShapedRecipe "smoke_bomb" 4 @(" P ","PGP"," P ") @(@{k="P";v="minecraft:gunpowder"},@{k="G";v="minecraft:clay_ball"})
$recipes["chakra_blade"] = MakeShapedRecipe "chakra_blade" 1 @("  C"," N "," S ") @(@{k="C";v="projetokonoha:chakra_crystal"},@{k="N";v="projetokonoha:ninja_steel_ingot"},@{k="S";v="minecraft:stick"})
$recipes["kusarigama"] = MakeShapedRecipe "kusarigama" 1 @("NI ","  S","  S") @(@{k="N";v="projetokonoha:ninja_steel_ingot"},@{k="I";v="minecraft:iron_ingot"},@{k="S";v="minecraft:string"})
$recipes["paper_bomb"] = MakeShapedRecipe "paper_bomb" 3 @("PPP","PGP","PPP") @(@{k="P";v="minecraft:paper"},@{k="G";v="minecraft:gunpowder"})
$recipes["kunai"] = MakeShapedRecipe "kunai" 2 @("  I"," I "," S ") @(@{k="I";v="minecraft:iron_ingot"},@{k="S";v="minecraft:stick"})
$recipes["shuriken"] = MakeShapedRecipe "shuriken" 4 @(" I ","INI"," I ") @(@{k="I";v="minecraft:iron_nugget"},@{k="N";v="minecraft:iron_ingot"})
$recipes["senbon"] = MakeShapedRecipe "senbon" 8 @("  I"," I "," I ") @(@{k="I";v="minecraft:iron_nugget"})

# Tools
$recipes["chakra_pickaxe"] = MakeShapedRecipe "chakra_pickaxe" 1 @("CCC"," S "," S ") @(@{k="C";v="projetokonoha:chakra_crystal"},@{k="S";v="minecraft:stick"})
$recipes["chakra_axe"] = MakeShapedRecipe "chakra_axe" 1 @("CC ","CS "," S ") @(@{k="C";v="projetokonoha:chakra_crystal"},@{k="S";v="minecraft:stick"})
$recipes["chakra_shovel"] = MakeShapedRecipe "chakra_shovel" 1 @(" C "," S "," S ") @(@{k="C";v="projetokonoha:chakra_crystal"},@{k="S";v="minecraft:stick"})

# Food
$recipes["ramen"] = MakeShapedRecipe "ramen" 1 @("WEW","BPB"," O ") @(@{k="W";v="minecraft:wheat"},@{k="E";v="minecraft:egg"},@{k="B";v="minecraft:cooked_beef"},@{k="P";v="minecraft:bowl"},@{k="O";v="minecraft:bone"})
$recipes["soldier_pill"] = MakeShapelessRecipe "soldier_pill" 3 @("projetokonoha:chakra_dust","minecraft:sugar","minecraft:spider_eye")
$recipes["rice_ball"] = MakeShapedRecipe "rice_ball" 2 @("   ","SWS","   ") @(@{k="S";v="minecraft:sugar_cane"},@{k="W";v="minecraft:wheat"})
$recipes["dango"] = MakeShapedRecipe "dango" 3 @("   ","WWW"," S ") @(@{k="W";v="minecraft:wheat"},@{k="S";v="minecraft:stick"})
$recipes["military_ration"] = MakeShapedRecipe "military_ration" 1 @("SCS","CDC","SCS") @(@{k="S";v="projetokonoha:soldier_pill"},@{k="C";v="projetokonoha:chakra_dust"},@{k="D";v="projetokonoha:dango"})
$recipes["curry_of_life"] = MakeShapedRecipe "curry_of_life" 1 @("MRM","BCB","   ") @(@{k="M";v="minecraft:red_mushroom"},@{k="R";v="projetokonoha:ramen"},@{k="B";v="minecraft:blaze_powder"},@{k="C";v="projetokonoha:chakra_fruit"})
$recipes["sweet_bean_paste"] = MakeShapelessRecipe "sweet_bean_paste" 2 @("minecraft:sugar","minecraft:cocoa_beans","minecraft:wheat")
$recipes["green_tea"] = MakeShapelessRecipe "green_tea" 2 @("minecraft:glass_bottle","projetokonoha:chakra_dust","minecraft:sugar")
$recipes["onigiri"] = MakeShapedRecipe "onigiri" 3 @("   ","SWS"," S ") @(@{k="S";v="minecraft:sugar_cane"},@{k="W";v="minecraft:wheat"})
$recipes["chakra_fruit"] = MakeShapedRecipe "chakra_fruit" 1 @(" C ","CAC"," C ") @(@{k="C";v="projetokonoha:chakra_crystal"},@{k="A";v="minecraft:apple"})

# Scrolls
$recipes["blank_scroll"] = MakeShapedRecipe "blank_scroll" 3 @("PPP","PIP","PPP") @(@{k="P";v="minecraft:paper"},@{k="I";v="minecraft:ink_sac"})
$recipes["scroll_rasengan"] = MakeShapelessRecipe "scroll_rasengan" 1 @("projetokonoha:blank_scroll","projetokonoha:chakra_crystal","minecraft:ghast_tear")
$recipes["scroll_chidori"] = MakeShapelessRecipe "scroll_chidori" 1 @("projetokonoha:blank_scroll","projetokonoha:chakra_crystal","minecraft:blaze_rod")
$recipes["scroll_fireball"] = MakeShapelessRecipe "scroll_fireball" 1 @("projetokonoha:blank_scroll","minecraft:fire_charge")
$recipes["scroll_water_dragon"] = MakeShapelessRecipe "scroll_water_dragon" 1 @("projetokonoha:blank_scroll","projetokonoha:chakra_crystal","minecraft:prismarine_shard")
$recipes["scroll_wind_blade"] = MakeShapelessRecipe "scroll_wind_blade" 1 @("projetokonoha:blank_scroll","projetokonoha:chakra_crystal","minecraft:feather")
$recipes["scroll_earth_wall"] = MakeShapelessRecipe "scroll_earth_wall" 1 @("projetokonoha:blank_scroll","projetokonoha:chakra_dust","minecraft:cobblestone")
$recipes["scroll_shadow_clone"] = MakeShapelessRecipe "scroll_shadow_clone" 1 @("projetokonoha:blank_scroll","projetokonoha:chakra_dust","minecraft:leather")
$recipes["scroll_healing"] = MakeShapelessRecipe "scroll_healing" 1 @("projetokonoha:blank_scroll","projetokonoha:chakra_dust","minecraft:golden_apple")
$recipes["scroll_substitution"] = MakeShapelessRecipe "scroll_substitution" 1 @("projetokonoha:blank_scroll","minecraft:log")
$recipes["scroll_body_flicker"] = MakeShapelessRecipe "scroll_body_flicker" 1 @("projetokonoha:blank_scroll","minecraft:sugar")
$recipes["amaterasu_scroll"] = MakeShapelessRecipe "amaterasu_scroll" 1 @("projetokonoha:blank_scroll","projetokonoha:sharingan_eye","minecraft:nether_star")
$recipes["sand_coffin_scroll"] = MakeShapelessRecipe "sand_coffin_scroll" 1 @("projetokonoha:blank_scroll","projetokonoha:chakra_crystal","minecraft:sand")
$recipes["eight_gates_scroll"] = MakeShapelessRecipe "eight_gates_scroll" 1 @("projetokonoha:blank_scroll","projetokonoha:bijuu_cloak","minecraft:nether_star")
$recipes["summoning_scroll"] = MakeShapelessRecipe "summoning_scroll" 1 @("projetokonoha:blank_scroll","projetokonoha:chakra_dust","minecraft:bone")
$recipes["gentle_fist_scroll"] = MakeShapelessRecipe "gentle_fist_scroll" 1 @("projetokonoha:blank_scroll","projetokonoha:byakugan_eye","projetokonoha:chakra_crystal")
$recipes["lightning_blade_scroll"] = MakeShapelessRecipe "lightning_blade_scroll" 1 @("projetokonoha:blank_scroll","projetokonoha:chakra_crystal","minecraft:blaze_powder")

# Blocks
$recipes["training_dummy"] = MakeShapedRecipe "training_dummy" 1 @(" W ","WSW"," S ") @(@{k="W";v="minecraft:planks"},@{k="S";v="minecraft:stick"})
$recipes["konoha_stone"] = MakeShapedRecipe "konoha_stone" 4 @("SS ","SS ","   ") @(@{k="S";v="minecraft:stone"})
$recipes["konoha_planks"] = MakeShapedRecipe "konoha_planks" 4 @("PP ","PP ","   ") @(@{k="P";v="minecraft:planks"})
$recipes["ramen_shop_counter"] = MakeShapedRecipe "ramen_shop_counter" 2 @("PPP","WBW","   ") @(@{k="P";v="minecraft:planks"},@{k="W";v="minecraft:planks"},@{k="B";v="minecraft:bowl"})
$recipes["scroll_shelf"] = MakeShapedRecipe "scroll_shelf" 1 @("PPP","BSB","PPP") @(@{k="P";v="minecraft:planks"},@{k="B";v="projetokonoha:blank_scroll"},@{k="S";v="minecraft:bookshelf"})
$recipes["tatami_mat"] = MakeShapedRecipe "tatami_mat" 3 @("   ","WWW","   ") @(@{k="W";v="minecraft:wheat"})
$recipes["paper_wall"] = MakeShapedRecipe "paper_wall" 4 @("SPS","SPS","SPS") @(@{k="S";v="minecraft:stick"},@{k="P";v="minecraft:paper"})
$recipes["red_torii"] = MakeShapedRecipe "red_torii" 2 @("PPP"," P "," P ") @(@{k="P";v="minecraft:planks"})
$recipes["ninja_lamp"] = MakeShapedRecipe "ninja_lamp" 1 @(" P ","PGP"," P ") @(@{k="P";v="minecraft:paper"},@{k="G";v="minecraft:glowstone_dust"})
$recipes["village_banner_block"] = MakeShapedRecipe "village_banner_block" 1 @("SSS","SRS","   ") @(@{k="S";v="minecraft:stick"},@{k="R";v="minecraft:wool"})

# Materials
$recipes["ninja_steel_ingot_from_block"] = MakeShapelessRecipe "ninja_steel_ingot" 9 @("projetokonoha:ninja_steel_block")
$recipes["ninja_steel_block"] = MakeShapedRecipe "ninja_steel_block" 1 @("NNN","NNN","NNN") @(@{k="N";v="projetokonoha:ninja_steel_ingot"})
$recipes["chakra_crystal_block"] = MakeShapedRecipe "chakra_crystal_block" 1 @("CCC","CCC","CCC") @(@{k="C";v="projetokonoha:chakra_crystal"})
$recipes["ninja_steel_ingot_smelt"] = MakeSmeltingRecipe "ninja_steel_ingot" "minecraft:iron_ingot" "1.0"
$recipes["ninja_steel_nugget"] = MakeShapelessRecipe "ninja_steel_nugget" 9 @("projetokonoha:ninja_steel_ingot")
$recipes["ninja_steel_from_nuggets"] = MakeShapedRecipe "ninja_steel_ingot" 1 @("NNN","NNN","NNN") @(@{k="N";v="projetokonoha:ninja_steel_nugget"})
$recipes["chakra_dust"] = MakeShapelessRecipe "chakra_dust" 3 @("projetokonoha:chakra_crystal")

# Special items
$recipes["ninja_headband"] = MakeShapedRecipe "ninja_headband" 1 @("   ","INI","LLL") @(@{k="I";v="minecraft:iron_ingot"},@{k="N";v="projetokonoha:ninja_steel_ingot"},@{k="L";v="minecraft:leather"})
$recipes["ninja_wire"] = MakeShapedRecipe "ninja_wire" 4 @("   ","NNN","   ") @(@{k="N";v="projetokonoha:ninja_steel_nugget"})
$recipes["chakra_paper"] = MakeShapelessRecipe "chakra_paper" 2 @("minecraft:paper","projetokonoha:chakra_dust")
$recipes["summoning_contract"] = MakeShapedRecipe "summoning_contract" 1 @("PPP","PIP","PPP") @(@{k="P";v="projetokonoha:chakra_paper"},@{k="I";v="minecraft:ink_sac"})

# Armor - ANBU
$recipes["anbu_helmet"] = MakeShapedRecipe "anbu_helmet" 1 @("NNN","N N","   ") @(@{k="N";v="projetokonoha:ninja_steel_ingot"})
$recipes["anbu_chestplate"] = MakeShapedRecipe "anbu_chestplate" 1 @("N N","NNN","NNN") @(@{k="N";v="projetokonoha:ninja_steel_ingot"})
$recipes["anbu_leggings"] = MakeShapedRecipe "anbu_leggings" 1 @("NNN","N N","N N") @(@{k="N";v="projetokonoha:ninja_steel_ingot"})
$recipes["anbu_boots"] = MakeShapedRecipe "anbu_boots" 1 @("   ","N N","N N") @(@{k="N";v="projetokonoha:ninja_steel_ingot"})

# Armor - Sage
$recipes["sage_helmet"] = MakeShapedRecipe "sage_helmet" 1 @("LCL","L L","   ") @(@{k="L";v="minecraft:leather"},@{k="C";v="projetokonoha:chakra_crystal"})
$recipes["sage_chestplate"] = MakeShapedRecipe "sage_chestplate" 1 @("L L","LCL","LLL") @(@{k="L";v="minecraft:leather"},@{k="C";v="projetokonoha:chakra_crystal"})
$recipes["sage_leggings"] = MakeShapedRecipe "sage_leggings" 1 @("LCL","L L","L L") @(@{k="L";v="minecraft:leather"},@{k="C";v="projetokonoha:chakra_crystal"})
$recipes["sage_boots"] = MakeShapedRecipe "sage_boots" 1 @("   ","L L","LCL") @(@{k="L";v="minecraft:leather"},@{k="C";v="projetokonoha:chakra_crystal"})

# Armor - Sound
$recipes["sound_helmet"] = MakeShapedRecipe "sound_helmet" 1 @("ICI","I I","   ") @(@{k="I";v="minecraft:iron_ingot"},@{k="C";v="projetokonoha:chakra_dust"})
$recipes["sound_chestplate"] = MakeShapedRecipe "sound_chestplate" 1 @("I I","ICI","III") @(@{k="I";v="minecraft:iron_ingot"},@{k="C";v="projetokonoha:chakra_dust"})
$recipes["sound_leggings"] = MakeShapedRecipe "sound_leggings" 1 @("ICI","I I","I I") @(@{k="I";v="minecraft:iron_ingot"},@{k="C";v="projetokonoha:chakra_dust"})
$recipes["sound_boots"] = MakeShapedRecipe "sound_boots" 1 @("   ","I I","ICI") @(@{k="I";v="minecraft:iron_ingot"},@{k="C";v="projetokonoha:chakra_dust"})

$recipeCount = 0
foreach ($r in $recipes.GetEnumerator()) {
    $path = "$recipeDir\$($r.Key).json"
    [System.IO.File]::WriteAllText($path, $r.Value, (New-Object System.Text.UTF8Encoding($false)))
    $recipeCount++
}
Write-Host "  $recipeCount recipes generated"

# ============================================================
# 3. IMPROVE ALL ITEM TEXTURES WITH DETAILED PIXEL ART
# ============================================================
Write-Host "Generating improved textures..."
$itemDir = "$root\textures\items"
$blockDir = "$root\textures\blocks"

function NewBmp { return New-Object System.Drawing.Bitmap(16, 16) }
function C($r,$g,$b,$a=255) { return [System.Drawing.Color]::FromArgb($a,$r,$g,$b) }
function Save($bmp, $path) { $bmp.Save($path, [System.Drawing.Imaging.ImageFormat]::Png); $bmp.Dispose() }

# --- KUNAI (silver blade, brown handle, ring at bottom) ---
$b = NewBmp
$blade = C 200 200 210; $edge = C 160 160 175; $handle = C 120 80 40; $ring = C 90 90 100
for ($y=0;$y-lt 5;$y++) { $b.SetPixel(10-$y,2+$y,$edge); $b.SetPixel(11-$y,2+$y,$blade); $b.SetPixel(12-$y,2+$y,$edge) }
for ($y=5;$y-lt 8;$y++) { $b.SetPixel(10-$y,2+$y,$blade); $b.SetPixel(11-$y,2+$y,(C 220 220 230)); $b.SetPixel(12-$y,2+$y,$blade) }
for ($y=8;$y-lt 12;$y++) { $b.SetPixel(7,2+$y,$handle); $b.SetPixel(8,2+$y,(C 140 95 50)) }
$b.SetPixel(7,14,$ring); $b.SetPixel(8,14,$ring); $b.SetPixel(6,13,$ring); $b.SetPixel(9,13,$ring); $b.SetPixel(6,15,$ring); $b.SetPixel(9,15,$ring)
Save $b "$itemDir\kunai.png"

# --- SHURIKEN (4 pointed star) ---
$b = NewBmp
$metal = C 180 180 195; $center = C 100 100 110; $shine = C 220 220 235
# Center
for ($x=6;$x-le 9;$x++) { for ($y=6;$y-le 9;$y++) { $b.SetPixel($x,$y,$center) } }
$b.SetPixel(7,7,$shine)
# Points
for ($i=1;$i-le 5;$i++) { $b.SetPixel(7,7-$i,$metal); $b.SetPixel(8,7-$i,$metal); $b.SetPixel(7,8+$i,$metal); $b.SetPixel(8,8+$i,$metal); $b.SetPixel(7-$i,7,$metal); $b.SetPixel(7-$i,8,$metal); $b.SetPixel(8+$i,7,$metal); $b.SetPixel(8+$i,8,$metal) }
# Diagonal blades
for ($i=1;$i-le 3;$i++) { $b.SetPixel(7-$i,7-$i,$edge); $b.SetPixel(8+$i,7-$i,$edge); $b.SetPixel(7-$i,8+$i,$edge); $b.SetPixel(8+$i,8+$i,$edge) }
Save $b "$itemDir\shuriken.png"

# --- KATANA (long blade with tsuba guard) ---
$b = NewBmp
$bladeW = C 210 215 225; $bladeE = C 180 185 195; $guard = C 180 160 50; $hiltC = C 60 30 80; $wrap = C 200 200 200
for ($i=0;$i-lt 10;$i++) { $b.SetPixel(12-$i, 1+$i, $bladeE); $b.SetPixel(13-$i, 1+$i, $bladeW); $b.SetPixel(13-$i, 2+$i, (C 230 235 240)) }
$b.SetPixel(3,10,$guard); $b.SetPixel(4,10,$guard); $b.SetPixel(2,11,$guard); $b.SetPixel(5,11,$guard)
for ($i=0;$i-lt 4;$i++) { $b.SetPixel(2-($i/2), 12+$i, $(if($i%2-eq 0){$wrap}else{$hiltC})) }
Save $b "$itemDir\katana.png"

# --- EXPLOSIVE KUNAI (kunai with red explosive tag) ---
$b = NewBmp
$tag = C 220 50 50; $tagD = C 180 30 30; $fuse = C 255 200 50
for ($y=0;$y-lt 5;$y++) { $b.SetPixel(10-$y,2+$y,$edge); $b.SetPixel(11-$y,2+$y,$blade); $b.SetPixel(12-$y,2+$y,$edge) }
for ($y=5;$y-lt 8;$y++) { $b.SetPixel(10-$y,2+$y,$blade); $b.SetPixel(11-$y,2+$y,(C 220 220 230)); $b.SetPixel(12-$y,2+$y,$blade) }
for ($y=8;$y-lt 12;$y++) { $b.SetPixel(7,2+$y,$handle); $b.SetPixel(8,2+$y,(C 140 95 50)) }
# Explosive tag
$b.SetPixel(9,6,$tag); $b.SetPixel(10,6,$tag); $b.SetPixel(11,6,$tagD); $b.SetPixel(9,7,$tagD); $b.SetPixel(10,7,$tag); $b.SetPixel(11,7,$tag)
$b.SetPixel(12,5,$fuse); $b.SetPixel(13,4,(C 255 230 100))
Save $b "$itemDir\explosive_kunai.png"

# --- SENBON (thin needle) ---
$b = NewBmp
$needle = C 200 200 210; $tip = C 240 240 250
for ($i=0;$i-lt 14;$i++) { $b.SetPixel(8, 1+$i, $needle) }
$b.SetPixel(8,0,$tip); $b.SetPixel(8,15,(C 170 170 180))
$b.SetPixel(7,14,(C 160 160 170)); $b.SetPixel(9,14,(C 160 160 170))
Save $b "$itemDir\senbon.png"

# --- FUMA SHURIKEN (large 4-blade windmill) ---
$b = NewBmp
$fm = C 170 170 185; $fc = C 130 130 145; $fh = C 210 210 225
for ($x=6;$x-le 9;$x++) { for ($y=6;$y-le 9;$y++) { $b.SetPixel($x,$y,$fc) } }
$b.SetPixel(7,7,$fh)
# Large blades curving
for ($i=1;$i-le 6;$i++) { 
    $b.SetPixel(8+$i, 7-$i, $fm); $b.SetPixel(7+$i, 7-$i, $fm)
    $b.SetPixel(7-$i, 7-$i, $fm); $b.SetPixel(6-$i, 8-$i, $fm)
    $b.SetPixel(7-$i, 8+$i, $fm); $b.SetPixel(8-$i, 8+$i, $fm)
    $b.SetPixel(8+$i, 8+$i, $fm); $b.SetPixel(9+$i, 7+$i, $fm)
}
Save $b "$itemDir\fuma_shuriken.png"

# --- TANTO (short dagger) ---
$b = NewBmp
$tBlade = C 200 205 215; $tHandle = C 80 50 30; $tGuard = C 160 140 40
for ($i=0;$i-lt 6;$i++) { $b.SetPixel(9-$i, 3+$i, $tBlade); $b.SetPixel(10-$i, 3+$i, (C 220 225 235)) }
$b.SetPixel(4,9,$tGuard); $b.SetPixel(3,9,$tGuard); $b.SetPixel(5,9,$tGuard)
for ($i=0;$i-lt 5;$i++) { $b.SetPixel(3, 10+$i, $tHandle); $b.SetPixel(4, 10+$i, (C 100 65 40)) }
Save $b "$itemDir\tanto.png"

# --- PAPER BOMB (paper tag with kanji symbol) ---
$b = NewBmp
$paper = C 240 235 210; $paperD = C 220 215 190; $ink = C 40 40 50
for ($x=3;$x-le 12;$x++) { for ($y=1;$y-le 14;$y++) { $b.SetPixel($x,$y,$(if(($x+$y)%7-eq 0){$paperD}else{$paper})) } }
# Red border
for ($x=3;$x-le 12;$x++) { $b.SetPixel($x,1,(C 180 40 40)); $b.SetPixel($x,14,(C 180 40 40)) }
for ($y=1;$y-le 14;$y++) { $b.SetPixel(3,$y,(C 180 40 40)); $b.SetPixel(12,$y,(C 180 40 40)) }
# Kanji-like symbol
for ($y=4;$y-le 11;$y++) { $b.SetPixel(7,$y,$ink) }
for ($x=5;$x-le 10;$x++) { $b.SetPixel($x,5,$ink); $b.SetPixel($x,8,$ink); $b.SetPixel($x,11,$ink) }
Save $b "$itemDir\paper_bomb.png"

# --- SMOKE BOMB (round gray sphere) ---
$b = NewBmp
$sm = C 140 140 150; $smL = C 170 170 180; $smD = C 100 100 110
for ($x=5;$x-le 10;$x++) { for ($y=5;$y-le 10;$y++) { $b.SetPixel($x,$y,$sm) } }
for ($x=6;$x-le 9;$x++) { $b.SetPixel($x,4,$sm); $b.SetPixel($x,11,$sm) }
for ($y=6;$y-le 9;$y++) { $b.SetPixel(4,$y,$sm); $b.SetPixel(11,$y,$sm) }
$b.SetPixel(6,6,$smL); $b.SetPixel(7,6,$smL); $b.SetPixel(6,7,$smL)
$b.SetPixel(9,9,$smD); $b.SetPixel(10,9,$smD); $b.SetPixel(9,10,$smD)
# Fuse on top
$b.SetPixel(7,3,(C 160 120 60)); $b.SetPixel(8,2,(C 180 140 70)); $b.SetPixel(9,1,(C 255 200 50))
Save $b "$itemDir\smoke_bomb.png"

# --- CHAKRA BLADE (glowing blue blade) ---
$b = NewBmp
$cb = C 80 160 255; $cbL = C 140 200 255; $cbD = C 40 100 200
for ($i=0;$i-lt 8;$i++) { $b.SetPixel(10-$i,1+$i,$cbD); $b.SetPixel(11-$i,1+$i,$cb); $b.SetPixel(12-$i,1+$i,$cbL) }
for ($i=0;$i-lt 2;$i++) { $b.SetPixel(3-$i,9+$i,(C 180 160 50)); $b.SetPixel(4-$i,9+$i,(C 200 180 60)) }
for ($i=0;$i-lt 4;$i++) { $b.SetPixel(2,11+$i,$handle); $b.SetPixel(3,11+$i,(C 140 95 50)) }
# Glow particles
$b.SetPixel(13,2,(C 100 180 255 180)); $b.SetPixel(6,5,(C 160 220 255 150))
Save $b "$itemDir\chakra_blade.png"

# --- KUSARIGAMA (sickle with chain) ---
$b = NewBmp
$sickle = C 190 190 200; $chain = C 160 150 80; $wHandle = C 100 60 30
# Sickle blade (curved)
$b.SetPixel(10,2,$sickle); $b.SetPixel(11,2,$sickle); $b.SetPixel(12,3,$sickle); $b.SetPixel(12,4,$sickle)
$b.SetPixel(11,5,$sickle); $b.SetPixel(10,5,$sickle); $b.SetPixel(9,4,$sickle)
# Handle
for ($i=0;$i-lt 6;$i++) { $b.SetPixel(8,5+$i,$wHandle); $b.SetPixel(9,5+$i,(C 120 75 35)) }
# Chain
for ($i=0;$i-lt 5;$i++) { $b.SetPixel(7-$i,11+($i%2),$chain) }
# Weight
$b.SetPixel(2,12,(C 100 100 110)); $b.SetPixel(2,13,(C 100 100 110)); $b.SetPixel(3,12,(C 120 120 130)); $b.SetPixel(3,13,(C 120 120 130))
Save $b "$itemDir\kusarigama.png"

# --- RAMEN (steaming bowl) ---
$b = NewBmp
$bowl = C 200 70 40; $bowlL = C 230 100 60; $broth = C 255 220 120; $noodle = C 255 240 180; $steam = C 200 200 200 120
# Bowl
for ($x=3;$x-le 12;$x++) { for ($y=8;$y-le 14;$y++) { $b.SetPixel($x,$y,$bowl) } }
for ($x=4;$x-le 11;$x++) { for ($y=9;$y-le 13;$y++) { $b.SetPixel($x,$y,$broth) } }
$b.SetPixel(4,9,$bowlL); $b.SetPixel(5,9,$bowlL)
# Noodles
for ($x=5;$x-le 10;$x++) { if($x%2-eq 0) { $b.SetPixel($x,10,$noodle); $b.SetPixel($x,12,$noodle) } }
# Egg
$b.SetPixel(9,10,(C 255 255 220)); $b.SetPixel(10,10,(C 255 200 50)); $b.SetPixel(9,11,(C 255 255 220))
# Naruto (pink swirl)
$b.SetPixel(6,11,(C 255 180 200)); $b.SetPixel(7,11,(C 255 255 255)); $b.SetPixel(6,12,(C 255 200 210))
# Chopsticks
$b.SetPixel(11,6,(C 160 110 50)); $b.SetPixel(12,5,(C 160 110 50)); $b.SetPixel(13,4,(C 160 110 50))
$b.SetPixel(10,6,(C 140 90 40)); $b.SetPixel(11,5,(C 140 90 40)); $b.SetPixel(12,4,(C 140 90 40))
# Steam
$b.SetPixel(6,6,$steam); $b.SetPixel(8,5,$steam); $b.SetPixel(7,4,$steam); $b.SetPixel(9,3,$steam)
Save $b "$itemDir\ramen.png"

# --- SOLDIER PILL (small round pill) ---
$b = NewBmp
$pill = C 120 50 50; $pillL = C 160 75 75; $pillD = C 90 30 30
for ($x=5;$x-le 10;$x++) { for ($y=5;$y-le 10;$y++) { $b.SetPixel($x,$y,$pill) } }
for ($x=6;$x-le 9;$x++) { $b.SetPixel($x,4,$pill); $b.SetPixel($x,11,$pill) }
$b.SetPixel(6,5,$pillL); $b.SetPixel(7,5,$pillL); $b.SetPixel(6,6,$pillL)
$b.SetPixel(9,10,$pillD); $b.SetPixel(10,9,$pillD)
Save $b "$itemDir\soldier_pill.png"

# --- RICE BALL ---
$b = NewBmp
$rice = C 245 245 240; $riceD = C 225 225 215; $seaweed = C 30 60 30
for ($x=4;$x-le 11;$x++) { for ($y=4;$y-le 12;$y++) { if($y -ge (12-($x-4)*0.7) -or $y -ge (12-(11-$x)*0.7)) {continue}; $b.SetPixel($x,$y,$(if(($x+$y)%3-eq 0){$riceD}else{$rice})) } }
# Triangle shape fill
for ($x=4;$x-le 11;$x++) { for ($y=3;$y-le 13;$y++) { $dist = [Math]::Abs($x-7.5); if ($y -ge (4+$dist*0.8) -and $y -le 13) { $b.SetPixel($x,$y,$(if(($x+$y)%3-eq 0){$riceD}else{$rice})) } } }
# Seaweed wrap bottom
for ($x=5;$x-le 10;$x++) { for ($y=10;$y-le 13;$y++) { $b.SetPixel($x,$y,$seaweed) } }
$b.SetPixel(6,10,(C 50 80 50)); $b.SetPixel(9,10,(C 50 80 50))
Save $b "$itemDir\rice_ball.png"

# --- DANGO (3 colored balls on stick) ---
$b = NewBmp
$pink = C 240 150 180; $white = C 245 245 240; $green = C 140 200 120; $stick = C 160 120 60
# Stick
for ($y=2;$y-le 14;$y++) { $b.SetPixel(7,$y,$stick); $b.SetPixel(8,$y,$stick) }
# Pink ball
for ($x=5;$x-le 10;$x++) { for ($y=2;$y-le 5;$y++) { $b.SetPixel($x,$y,$pink) } }
$b.SetPixel(6,2,(C 255 170 200)); $b.SetPixel(6,3,(C 255 180 210))
# White ball
for ($x=5;$x-le 10;$x++) { for ($y=6;$y-le 9;$y++) { $b.SetPixel($x,$y,$white) } }
$b.SetPixel(6,6,(C 255 255 255)); $b.SetPixel(6,7,(C 255 255 250))
# Green ball
for ($x=5;$x-le 10;$x++) { for ($y=10;$y-le 13;$y++) { $b.SetPixel($x,$y,$green) } }
$b.SetPixel(6,10,(C 160 220 140)); $b.SetPixel(6,11,(C 170 225 150))
Save $b "$itemDir\dango.png"

# --- CHAKRA FRUIT (glowing purple fruit) ---
$b = NewBmp
$fruit = C 160 80 200; $fruitL = C 200 120 240; $fruitD = C 120 50 160; $stem = C 80 140 50
for ($x=4;$x-le 11;$x++) { for ($y=5;$y-le 13;$y++) { $b.SetPixel($x,$y,$fruit) } }
for ($x=5;$x-le 10;$x++) { $b.SetPixel($x,4,$fruit); $b.SetPixel($x,14,$fruit) }
$b.SetPixel(5,5,$fruitL); $b.SetPixel(6,5,$fruitL); $b.SetPixel(5,6,$fruitL); $b.SetPixel(6,6,$fruitL)
$b.SetPixel(10,12,$fruitD); $b.SetPixel(11,12,$fruitD)
# Stem
$b.SetPixel(7,3,$stem); $b.SetPixel(8,2,$stem); $b.SetPixel(9,1,$stem); $b.SetPixel(10,1,(C 100 170 60))
# Glow
$b.SetPixel(6,8,(C 220 180 255)); $b.SetPixel(7,7,(C 230 190 255))
Save $b "$itemDir\chakra_fruit.png"

# --- MILITARY RATION ---
$b = NewBmp
$wrap = C 160 140 100; $wrapD = C 130 110 80; $pill = C 180 60 60
for ($x=3;$x-le 12;$x++) { for ($y=4;$y-le 11;$y++) { $b.SetPixel($x,$y,$(if(($x+$y)%2-eq 0){$wrap}else{$wrapD})) } }
# Red mark
for ($x=6;$x-le 9;$x++) { for ($y=6;$y-le 9;$y++) { $b.SetPixel($x,$y,$pill) } }
$b.SetPixel(7,7,(C 220 90 90))
Save $b "$itemDir\military_ration.png"

# --- CURRY OF LIFE ---
$b = NewBmp
$curryBowl = C 180 60 30; $curry = C 200 130 40; $curryL = C 230 160 60; $steamC = C 255 240 200 120
for ($x=3;$x-le 12;$x++) { for ($y=7;$y-le 14;$y++) { $b.SetPixel($x,$y,$curryBowl) } }
for ($x=4;$x-le 11;$x++) { for ($y=8;$y-le 13;$y++) { $b.SetPixel($x,$y,$curry) } }
$b.SetPixel(5,8,$curryL); $b.SetPixel(6,8,$curryL); $b.SetPixel(5,9,$curryL)
# Sparkles
$b.SetPixel(8,9,(C 255 220 100)); $b.SetPixel(6,10,(C 255 200 80))
# Steam
$b.SetPixel(6,5,$steamC); $b.SetPixel(8,4,$steamC); $b.SetPixel(10,5,$steamC); $b.SetPixel(7,3,$steamC)
Save $b "$itemDir\curry_of_life.png"

# --- SWEET BEAN PASTE ---
$b = NewBmp
$bean = C 120 60 40; $beanL = C 160 90 60; $beanD = C 90 40 25
for ($x=4;$x-le 11;$x++) { for ($y=5;$y-le 11;$y++) { $b.SetPixel($x,$y,$bean) } }
for ($x=5;$x-le 10;$x++) { $b.SetPixel($x,4,$bean); $b.SetPixel($x,12,$bean) }
$b.SetPixel(5,5,$beanL); $b.SetPixel(6,5,$beanL); $b.SetPixel(5,6,$beanL)
$b.SetPixel(10,11,$beanD); $b.SetPixel(11,10,$beanD)
# Topping swirl
$b.SetPixel(7,7,(C 200 150 100)); $b.SetPixel(8,7,(C 190 140 90))
Save $b "$itemDir\sweet_bean_paste.png"

# --- GREEN TEA ---
$b = NewBmp
$cup = C 220 220 210; $cupD = C 190 190 180; $tea = C 120 180 80; $teaL = C 150 210 100
for ($x=4;$x-le 11;$x++) { for ($y=6;$y-le 14;$y++) { $b.SetPixel($x,$y,$cup) } }
for ($x=5;$x-le 10;$x++) { for ($y=7;$y-le 13;$y++) { $b.SetPixel($x,$y,$tea) } }
$b.SetPixel(5,7,$teaL); $b.SetPixel(6,7,$teaL); $b.SetPixel(5,8,$teaL)
# Cup handle
$b.SetPixel(12,8,$cupD); $b.SetPixel(13,9,$cupD); $b.SetPixel(13,10,$cupD); $b.SetPixel(12,11,$cupD)
# Steam
$b.SetPixel(7,4,(C 180 220 160 100)); $b.SetPixel(8,3,(C 180 220 160 80)); $b.SetPixel(9,4,(C 180 220 160 100))
Save $b "$itemDir\green_tea.png"

# --- ONIGIRI ---
$b = NewBmp
$oRice = C 248 248 242; $oRiceD = C 228 228 218; $oNori = C 25 55 25; $oNoriL = C 45 80 45
# Triangle
for ($x=3;$x-le 12;$x++) { 
    $w = [Math]::Min($x-3, 12-$x)
    for ($y=(6-$w);$y-le 13;$y++) { 
        if ($y -ge 3 -and $y -le 13) { $b.SetPixel($x,$y,$(if(($x+$y)%3-eq 0){$oRiceD}else{$oRice})) }
    } 
}
# Nori wrap
for ($x=5;$x-le 10;$x++) { for ($y=9;$y-le 13;$y++) { $b.SetPixel($x,$y,$oNori) } }
$b.SetPixel(6,9,$oNoriL); $b.SetPixel(7,9,$oNoriL)
Save $b "$itemDir\onigiri.png"

# --- SHARINGAN EYE ---
$b = NewBmp
$sRed = C 200 30 30; $sRedL = C 240 60 60; $sPupil = C 20 20 20; $sWhite = C 240 240 240
# White eye
for ($x=3;$x-le 12;$x++) { for ($y=4;$y-le 11;$y++) { $dist=[Math]::Sqrt(($x-7.5)*($x-7.5)+($y-7.5)*($y-7.5)); if($dist -lt 5) { $b.SetPixel($x,$y,$sWhite)} } }
# Red iris
for ($x=4;$x-le 11;$x++) { for ($y=5;$y-le 10;$y++) { $dist=[Math]::Sqrt(($x-7.5)*($x-7.5)+($y-7.5)*($y-7.5)); if($dist -lt 3.5) { $b.SetPixel($x,$y,$sRed)} } }
# Pupil
for ($x=6;$x-le 9;$x++) { for ($y=6;$y-le 9;$y++) { $dist=[Math]::Sqrt(($x-7.5)*($x-7.5)+($y-7.5)*($y-7.5)); if($dist -lt 1.8) { $b.SetPixel($x,$y,$sPupil)} } }
# Tomoe (3 dots around iris)
$b.SetPixel(5,5,$sPupil); $b.SetPixel(10,5,$sPupil); $b.SetPixel(7,11,$sPupil)
$b.SetPixel(4,6,$sPupil); $b.SetPixel(10,6,$sPupil); $b.SetPixel(8,11,$sPupil)
# Highlight
$b.SetPixel(6,6,$sRedL)
Save $b "$itemDir\sharingan_eye.png"

# --- BYAKUGAN EYE ---
$b = NewBmp
$bPurp = C 200 190 230; $bPurpL = C 230 220 250; $bPupil = C 240 240 250
for ($x=3;$x-le 12;$x++) { for ($y=4;$y-le 11;$y++) { $dist=[Math]::Sqrt(($x-7.5)*($x-7.5)+($y-7.5)*($y-7.5)); if($dist -lt 5) { $b.SetPixel($x,$y,$sWhite)} } }
for ($x=4;$x-le 11;$x++) { for ($y=5;$y-le 10;$y++) { $dist=[Math]::Sqrt(($x-7.5)*($x-7.5)+($y-7.5)*($y-7.5)); if($dist -lt 3.5) { $b.SetPixel($x,$y,$bPurp)} } }
for ($x=6;$x-le 9;$x++) { for ($y=6;$y-le 9;$y++) { $dist=[Math]::Sqrt(($x-7.5)*($x-7.5)+($y-7.5)*($y-7.5)); if($dist -lt 1.5) { $b.SetPixel($x,$y,$bPupil)} } }
# Veins
$b.SetPixel(3,4,$bPurp); $b.SetPixel(2,3,$bPurp); $b.SetPixel(12,4,$bPurp); $b.SetPixel(13,3,$bPurp)
$b.SetPixel(6,6,$bPurpL)
Save $b "$itemDir\byakugan_eye.png"

# --- NINJA HEADBAND (metal plate with cloth) ---
$b = NewBmp
$cloth = C 30 50 120; $clothL = C 50 70 150; $plate = C 180 180 195; $plateL = C 210 210 225; $symbol = C 60 60 70
for ($x=1;$x-le 14;$x++) { for ($y=5;$y-le 10;$y++) { $b.SetPixel($x,$y,$cloth) } }
$b.SetPixel(2,5,$clothL); $b.SetPixel(3,5,$clothL)
# Metal plate center
for ($x=4;$x-le 11;$x++) { for ($y=5;$y-le 10;$y++) { $b.SetPixel($x,$y,$plate) } }
$b.SetPixel(5,6,$plateL); $b.SetPixel(6,6,$plateL)
# Konoha symbol (leaf)
$b.SetPixel(7,6,$symbol); $b.SetPixel(8,6,$symbol); $b.SetPixel(6,7,$symbol); $b.SetPixel(9,7,$symbol)
$b.SetPixel(7,8,$symbol); $b.SetPixel(8,8,$symbol); $b.SetPixel(7,9,$symbol)
# Tails
$b.SetPixel(0,7,$cloth); $b.SetPixel(0,8,$cloth); $b.SetPixel(15,7,$cloth); $b.SetPixel(15,8,$cloth)
Save $b "$itemDir\ninja_headband.png"

# --- SUMMONING CONTRACT (scroll with blood marks) ---
$b = NewBmp
$scroll = C 220 200 160; $scrollD = C 190 170 130; $blood = C 160 30 30; $rope = C 140 100 50
for ($x=3;$x-le 12;$x++) { for ($y=2;$y-le 13;$y++) { $b.SetPixel($x,$y,$(if($y%4-eq 0){$scrollD}else{$scroll})) } }
# End caps
for ($y=2;$y-le 13;$y++) { $b.SetPixel(2,$y,$rope); $b.SetPixel(13,$y,$rope) }
# Blood handprints
$b.SetPixel(5,5,$blood); $b.SetPixel(6,5,$blood); $b.SetPixel(7,5,$blood); $b.SetPixel(5,6,$blood); $b.SetPixel(7,6,$blood)
$b.SetPixel(8,9,$blood); $b.SetPixel(9,9,$blood); $b.SetPixel(10,9,$blood); $b.SetPixel(8,10,$blood); $b.SetPixel(10,10,$blood)
Save $b "$itemDir\summoning_contract.png"

# --- BIJUU CLOAK (orange/gold glowing cloak) ---
$b = NewBmp
$cloak = C 255 160 30; $cloakL = C 255 200 80; $cloakD = C 200 120 20; $glow = C 255 230 130 180
for ($x=4;$x-le 11;$x++) { for ($y=2;$y-le 14;$y++) { $b.SetPixel($x,$y,$cloak) } }
for ($x=5;$x-le 10;$x++) { $b.SetPixel($x,1,$cloak) }
$b.SetPixel(5,2,$cloakL); $b.SetPixel(6,2,$cloakL); $b.SetPixel(5,3,$cloakL)
$b.SetPixel(10,13,$cloakD); $b.SetPixel(11,12,$cloakD)
# Pattern lines (black seal marks)
for ($y=4;$y-le 12;$y+=2) { $b.SetPixel(7,$y,(C 30 30 30)); $b.SetPixel(8,$y,(C 30 30 30)) }
# Glow particles around
$b.SetPixel(3,4,$glow); $b.SetPixel(12,6,$glow); $b.SetPixel(3,10,$glow); $b.SetPixel(13,8,$glow)
Save $b "$itemDir\bijuu_cloak.png"

# --- CURSED SEAL (dark purple mark) ---
$b = NewBmp
$dark = C 60 20 80; $mark = C 140 40 180; $markL = C 180 80 220; $skin = C 220 190 160
for ($x=3;$x-le 12;$x++) { for ($y=3;$y-le 12;$y++) { $dist=[Math]::Sqrt(($x-7.5)*($x-7.5)+($y-7.5)*($y-7.5)); if($dist -lt 5) { $b.SetPixel($x,$y,$skin)} } }
# Curse marks (spreading from center)
$b.SetPixel(7,7,$dark); $b.SetPixel(8,7,$dark); $b.SetPixel(7,8,$dark); $b.SetPixel(8,8,$dark)
for ($i=1;$i-le 4;$i++) { $b.SetPixel(7+$i,7-$i,$mark); $b.SetPixel(7-$i,7+$i,$mark); $b.SetPixel(8+$i,8+$i,$mark); $b.SetPixel(7-$i,7-$i,$mark) }
$b.SetPixel(5,4,$markL); $b.SetPixel(10,4,$markL); $b.SetPixel(4,10,$markL); $b.SetPixel(11,10,$markL)
Save $b "$itemDir\cursed_seal.png"

# --- CHAKRA PAPER ---
$b = NewBmp
$cp = C 240 240 235; $cpD = C 220 220 212; $cpGlow = C 180 200 255
for ($x=3;$x-le 12;$x++) { for ($y=2;$y-le 13;$y++) { $b.SetPixel($x,$y,$(if(($x+$y)%5-eq 0){$cpD}else{$cp})) } }
# Blue chakra glow in center
$b.SetPixel(7,7,$cpGlow); $b.SetPixel(8,7,$cpGlow); $b.SetPixel(7,8,$cpGlow); $b.SetPixel(8,8,$cpGlow)
$b.SetPixel(6,7,(C 200 215 255)); $b.SetPixel(9,8,(C 200 215 255))
Save $b "$itemDir\chakra_paper.png"

# --- NINJA WIRE ---
$b = NewBmp
$wire = C 160 160 170; $wireL = C 190 190 200
for ($i=0;$i-lt 14;$i++) { $x = 3 + ($i%3); $b.SetPixel($x+3, 1+$i, $wire); $b.SetPixel($x+4, 1+$i, $wireL) }
Save $b "$itemDir\ninja_wire.png"

# --- CHAKRA CRYSTAL ---
$b = NewBmp
$crys = C 80 180 240; $crysL = C 140 220 255; $crysD = C 40 120 180
for ($x=5;$x-le 10;$x++) { for ($y=2;$y-le 13;$y++) { $h = 14 - [Math]::Abs($x-7.5)*2; if($y -le $h) { $b.SetPixel($x,$y,$crys) } } }
$b.SetPixel(6,3,$crysL); $b.SetPixel(7,3,$crysL); $b.SetPixel(6,4,$crysL)
$b.SetPixel(9,10,$crysD); $b.SetPixel(10,9,$crysD)
# Sparkle
$b.SetPixel(6,2,(C 255 255 255)); $b.SetPixel(11,5,(C 200 240 255))
Save $b "$itemDir\chakra_crystal.png"

# --- NINJA STEEL INGOT ---
$b = NewBmp
$steel = C 100 110 130; $steelL = C 140 150 170; $steelD = C 70 80 100
for ($x=2;$x-le 13;$x++) { for ($y=6;$y-le 11;$y++) { $b.SetPixel($x,$y,$steel) } }
for ($x=3;$x-le 12;$x++) { $b.SetPixel($x,5,$steel) }
$b.SetPixel(3,6,$steelL); $b.SetPixel(4,6,$steelL); $b.SetPixel(3,7,$steelL); $b.SetPixel(4,7,$steelL)
$b.SetPixel(12,10,$steelD); $b.SetPixel(13,10,$steelD)
Save $b "$itemDir\ninja_steel_ingot.png"

# --- CHAKRA DUST ---
$b = NewBmp
$dust = C 100 180 220; $dustL = C 150 210 240; $dustD = C 60 130 170
$spots = @(@(4,6),@(7,4),@(10,7),@(5,10),@(8,11),@(11,5),@(6,8),@(9,9),@(3,8),@(12,10))
foreach ($s in $spots) { $b.SetPixel($s[0],$s[1],$dust); $b.SetPixel($s[0]+1,$s[1],$dustL) }
Save $b "$itemDir\chakra_dust.png"

# --- NINJA STEEL NUGGET ---
$b = NewBmp
$nug = C 100 110 130; $nugL = C 140 150 170
for ($x=5;$x-le 10;$x++) { for ($y=6;$y-le 10;$y++) { $b.SetPixel($x,$y,$nug) } }
$b.SetPixel(6,6,$nugL); $b.SetPixel(6,7,$nugL); $b.SetPixel(7,6,$nugL)
Save $b "$itemDir\ninja_steel_nugget.png"

# --- CHAKRA TOOLS ---
foreach ($tool in @("chakra_pickaxe","chakra_axe","chakra_shovel")) {
    $b = NewBmp
    $tCrys = C 80 180 240; $tCrysL = C 140 220 255; $tStick = C 120 80 40
    switch ($tool) {
        "chakra_pickaxe" {
            for ($x=3;$x-le 12;$x++) { $b.SetPixel($x,3,$tCrys); $b.SetPixel($x,4,$tCrys) }
            $b.SetPixel(4,3,$tCrysL); $b.SetPixel(5,3,$tCrysL)
            for ($y=5;$y-le 14;$y++) { $b.SetPixel(7,$y,$tStick); $b.SetPixel(8,$y,$tStick) }
        }
        "chakra_axe" {
            for ($x=8;$x-le 12;$x++) { for ($y=2;$y-le 6;$y++) { $b.SetPixel($x,$y,$tCrys) } }
            $b.SetPixel(9,2,$tCrysL); $b.SetPixel(9,3,$tCrysL)
            for ($y=4;$y-le 14;$y++) { $b.SetPixel(7,$y,$tStick); $b.SetPixel(8,$y,$tStick) }
        }
        "chakra_shovel" {
            for ($x=6;$x-le 9;$x++) { for ($y=1;$y-le 5;$y++) { $b.SetPixel($x,$y,$tCrys) } }
            $b.SetPixel(6,2,$tCrysL); $b.SetPixel(7,1,$tCrysL)
            for ($y=6;$y-le 14;$y++) { $b.SetPixel(7,$y,$tStick); $b.SetPixel(8,$y,$tStick) }
        }
    }
    Save $b "$itemDir\$tool.png"
}

# --- BLANK SCROLL ---
$b = NewBmp
$scr = C 230 220 190; $scrD = C 200 190 160; $cap = C 160 120 70
for ($x=4;$x-le 11;$x++) { for ($y=3;$y-le 12;$y++) { $b.SetPixel($x,$y,$(if($y%3-eq 0){$scrD}else{$scr})) } }
for ($y=3;$y-le 12;$y++) { $b.SetPixel(3,$y,$cap); $b.SetPixel(12,$y,$cap) }
Save $b "$itemDir\blank_scroll.png"

# --- SCROLL TEXTURES (all 10 original + 6 new) ---
$scrollColors = @{
    "scroll_rasengan" = @(60,140,255); "scroll_chidori" = @(200,200,255);
    "scroll_fireball" = @(255,100,30); "scroll_water_dragon" = @(40,120,200);
    "scroll_wind_blade" = @(160,220,180); "scroll_earth_wall" = @(160,130,80);
    "scroll_shadow_clone" = @(100,100,120); "scroll_healing" = @(80,220,100);
    "scroll_substitution" = @(180,160,120); "scroll_body_flicker" = @(200,180,60);
    "amaterasu_scroll" = @(30,30,30); "sand_coffin_scroll" = @(200,180,120);
    "eight_gates_scroll" = @(50,200,50); "summoning_scroll" = @(180,80,180);
    "gentle_fist_scroll" = @(200,200,240); "lightning_blade_scroll" = @(255,255,140)
}
foreach ($sc in $scrollColors.GetEnumerator()) {
    $b = NewBmp
    $c = C $sc.Value[0] $sc.Value[1] $sc.Value[2]
    $cD = C ([Math]::Max(0,$sc.Value[0]-40)) ([Math]::Max(0,$sc.Value[1]-40)) ([Math]::Max(0,$sc.Value[2]-40))
    $cL = C ([Math]::Min(255,$sc.Value[0]+40)) ([Math]::Min(255,$sc.Value[1]+40)) ([Math]::Min(255,$sc.Value[2]+40))
    # Scroll body
    for ($x=4;$x-le 11;$x++) { for ($y=2;$y-le 13;$y++) { $b.SetPixel($x,$y,$scr) } }
    # Color band
    for ($x=4;$x-le 11;$x++) { $b.SetPixel($x,6,$c); $b.SetPixel($x,7,$c); $b.SetPixel($x,8,$cD) }
    # Color accent on caps
    for ($y=2;$y-le 13;$y++) { $b.SetPixel(3,$y,$c); $b.SetPixel(12,$y,$c) }
    # Symbol in center
    $b.SetPixel(7,7,$cL); $b.SetPixel(8,7,$cL)
    # Caps
    for ($y=2;$y-le 13;$y++) { $b.SetPixel(3,$y,$cD); $b.SetPixel(12,$y,$cD) }
    $b.SetPixel(5,3,$cL)
    Save $b "$itemDir\$($sc.Key).png"
}

# --- ALL ARMOR ITEM TEXTURES ---
$armorSets = @{
    "konoha" = @(@(20,80,40), @(40,120,60))     # Dark green, light green
    "akatsuki" = @(@(30,30,30), @(180,40,40))    # Black with red clouds  
    "anbu" = @(@(60,60,70), @(200,200,210))      # Dark gray, white mask
    "sage" = @(@(200,60,40), @(220,200,160))     # Red, beige
    "hokage" = @(@(220,220,220), @(180,40,40))   # White, red
    "sound" = @(@(120,100,160), @(80,60,120))    # Purple tones
}
foreach ($armor in $armorSets.GetEnumerator()) {
    $primary = C $armor.Value[0][0] $armor.Value[0][1] $armor.Value[0][2]
    $accent = C $armor.Value[1][0] $armor.Value[1][1] $armor.Value[1][2]
    $priL = C ([Math]::Min(255,$armor.Value[0][0]+30)) ([Math]::Min(255,$armor.Value[0][1]+30)) ([Math]::Min(255,$armor.Value[0][2]+30))
    
    foreach ($piece in @("helmet","chestplate","leggings","boots")) {
        $b = NewBmp
        switch ($piece) {
            "helmet" {
                for ($x=3;$x-le 12;$x++) { for ($y=2;$y-le 10;$y++) { $b.SetPixel($x,$y,$primary) } }
                for ($x=4;$x-le 11;$x++) { $b.SetPixel($x,1,$primary) }
                $b.SetPixel(4,3,$priL); $b.SetPixel(5,3,$priL); $b.SetPixel(4,4,$priL)
                # Accent band
                for ($x=3;$x-le 12;$x++) { $b.SetPixel($x,8,$accent) }
                # Eye holes
                $b.SetPixel(5,6,(C 20 20 30)); $b.SetPixel(10,6,(C 20 20 30))
            }
            "chestplate" {
                for ($x=2;$x-le 13;$x++) { for ($y=1;$y-le 14;$y++) { $b.SetPixel($x,$y,$primary) } }
                $b.SetPixel(3,2,$priL); $b.SetPixel(4,2,$priL); $b.SetPixel(3,3,$priL)
                # Collar
                for ($x=5;$x-le 10;$x++) { $b.SetPixel($x,1,$accent) }
                # Center line
                for ($y=2;$y-le 14;$y++) { $b.SetPixel(7,$y,$accent); $b.SetPixel(8,$y,$accent) }
            }
            "leggings" {
                for ($x=3;$x-le 6;$x++) { for ($y=1;$y-le 14;$y++) { $b.SetPixel($x,$y,$primary) } }
                for ($x=9;$x-le 12;$x++) { for ($y=1;$y-le 14;$y++) { $b.SetPixel($x,$y,$primary) } }
                # Belt
                for ($x=3;$x-le 12;$x++) { $b.SetPixel($x,1,$accent); $b.SetPixel($x,2,$accent) }
                $b.SetPixel(4,3,$priL); $b.SetPixel(10,3,$priL)
            }
            "boots" {
                for ($x=3;$x-le 6;$x++) { for ($y=5;$y-le 14;$y++) { $b.SetPixel($x,$y,$primary) } }
                for ($x=9;$x-le 12;$x++) { for ($y=5;$y-le 14;$y++) { $b.SetPixel($x,$y,$primary) } }
                # Soles
                for ($x=3;$x-le 6;$x++) { $b.SetPixel($x,14,$accent) }
                for ($x=9;$x-le 12;$x++) { $b.SetPixel($x,14,$accent) }
                $b.SetPixel(4,6,$priL); $b.SetPixel(10,6,$priL)
            }
        }
        Save $b "$itemDir\$($armor.Key)_$piece.png"
    }
}

Write-Host "  All item textures regenerated"

# ============================================================
# 4. IMPROVE BLOCK TEXTURES
# ============================================================
Write-Host "Generating improved block textures..."

# Chakra Ore
$b = New-Object System.Drawing.Bitmap(16,16)
$stone = C 128 128 128; $stoneD = C 110 110 110; $ore = C 60 180 240; $oreL = C 120 220 255
for ($x=0;$x-lt 16;$x++) { for ($y=0;$y-lt 16;$y++) { $b.SetPixel($x,$y,$(if(($x*7+$y*13)%5-eq 0){$stoneD}else{$stone})) } }
$oreSpots = @(@(3,4),@(4,3),@(4,4),@(5,4),@(10,8),@(11,8),@(11,9),@(10,9),@(6,11),@(7,11),@(7,12),@(2,10),@(13,3),@(12,4))
foreach ($s in $oreSpots) { $b.SetPixel($s[0],$s[1],$ore) }
$b.SetPixel(4,3,$oreL); $b.SetPixel(10,8,$oreL); $b.SetPixel(6,11,$oreL)
Save $b "$blockDir\chakra_ore.png"

# Chakra Crystal Block
$b = New-Object System.Drawing.Bitmap(16,16)
$cc = C 80 180 240; $ccL = C 140 220 255; $ccD = C 40 120 180
for ($x=0;$x-lt 16;$x++) { for ($y=0;$y-lt 16;$y++) { $v = ($x*3+$y*7)%4; $b.SetPixel($x,$y,$(if($v-eq 0){$ccL}elseif($v-eq 1){$ccD}else{$cc})) } }
# Crystal lines
for ($i=0;$i-lt 16;$i++) { $b.SetPixel($i,[Math]::Min(15,[Math]::Max(0,(8+[Math]::Sin($i*0.8)*3))),$ccL) }
Save $b "$blockDir\chakra_crystal_block.png"

# Ninja Steel Block
$b = New-Object System.Drawing.Bitmap(16,16)
$ns = C 100 110 130; $nsL = C 130 140 160; $nsD = C 70 80 100
for ($x=0;$x-lt 16;$x++) { for ($y=0;$y-lt 16;$y++) { $b.SetPixel($x,$y,$(if(($x+$y)%2-eq 0){$ns}else{$nsD})) } }
# Bolts at corners
foreach ($pos in @(@(2,2),@(13,2),@(2,13),@(13,13))) { $b.SetPixel($pos[0],$pos[1],$nsL) }
# Cross pattern
for ($i=0;$i-lt 16;$i++) { $b.SetPixel($i,7,$nsL); $b.SetPixel($i,8,$nsL); $b.SetPixel(7,$i,$nsL); $b.SetPixel(8,$i,$nsL) }
Save $b "$blockDir\ninja_steel_block.png"

# Ninja Lamp (warm glow)
$b = New-Object System.Drawing.Bitmap(16,16)
$lamp = C 255 220 150; $lampD = C 200 170 100; $frame = C 120 80 40
for ($x=0;$x-lt 16;$x++) { for ($y=0;$y-lt 16;$y++) { $b.SetPixel($x,$y,$lamp) } }
# Paper panel texture
for ($x=2;$x-le 13;$x++) { for ($y=2;$y-le 13;$y++) { if (($x+$y)%6 -eq 0) { $b.SetPixel($x,$y,$lampD) } } }
# Wooden frame borders
for ($i=0;$i-lt 16;$i++) { $b.SetPixel($i,0,$frame); $b.SetPixel($i,15,$frame); $b.SetPixel(0,$i,$frame); $b.SetPixel(15,$i,$frame) }
# Cross frame
for ($i=0;$i-lt 16;$i++) { $b.SetPixel(7,$i,$frame); $b.SetPixel(8,$i,$frame) }
Save $b "$blockDir\ninja_lamp.png"

# Red Torii
$b = New-Object System.Drawing.Bitmap(16,16)
$torii = C 200 40 30; $toriiL = C 230 70 50; $toriiD = C 160 25 20
for ($x=0;$x-lt 16;$x++) { for ($y=0;$y-lt 16;$y++) { $b.SetPixel($x,$y,(C 0 0 0 0)) } }
# Pillars
for ($y=4;$y-lt 16;$y++) { $b.SetPixel(2,$y,$torii); $b.SetPixel(3,$y,$toriiL); $b.SetPixel(12,$y,$torii); $b.SetPixel(13,$y,$toriiL) }
# Top beam
for ($x=0;$x-lt 16;$x++) { $b.SetPixel($x,2,$torii); $b.SetPixel($x,3,$toriiL); $b.SetPixel($x,4,$toriiD) }
# Second beam
for ($x=1;$x-lt 15;$x++) { $b.SetPixel($x,6,$toriiD); $b.SetPixel($x,7,$torii) }
Save $b "$blockDir\red_torii.png"

# Ramen Shop Counter
$b = New-Object System.Drawing.Bitmap(16,16)
$wood = C 160 110 60; $woodL = C 190 140 80; $woodD = C 130 85 40; $top = C 200 170 120
for ($x=0;$x-lt 16;$x++) { for ($y=0;$y-lt 16;$y++) { $b.SetPixel($x,$y,$wood) } }
for ($x=0;$x-lt 16;$x++) { for ($y=0;$y-le 3;$y++) { $b.SetPixel($x,$y,$top) } }
# Wood grain
for ($y=4;$y-lt 16;$y+=3) { for ($x=0;$x-lt 16;$x++) { $b.SetPixel($x,$y,$woodD) } }
$b.SetPixel(3,6,$woodL); $b.SetPixel(8,9,$woodL); $b.SetPixel(12,12,$woodL)
Save $b "$blockDir\ramen_shop_counter.png"

# Scroll Shelf
$b = New-Object System.Drawing.Bitmap(16,16)
$shelf = C 140 100 50; $shelfL = C 170 130 70; $scrollC = C 220 210 180
for ($x=0;$x-lt 16;$x++) { for ($y=0;$y-lt 16;$y++) { $b.SetPixel($x,$y,$shelf) } }
# Shelves
for ($x=0;$x-lt 16;$x++) { $b.SetPixel($x,0,$shelfL); $b.SetPixel($x,5,$shelfL); $b.SetPixel($x,10,$shelfL); $b.SetPixel($x,15,$shelfL) }
# Scrolls on shelves
$scrollColors2 = @((C 200 40 40),(C 40 100 200),(C 40 160 60),(C 200 180 60))
for ($i=0;$i-lt 4;$i++) {
    $sx = 2 + $i * 3
    $b.SetPixel($sx,2,$scrollColors2[$i]); $b.SetPixel($sx+1,2,$scrollColors2[$i])
    $b.SetPixel($sx,3,$scrollC); $b.SetPixel($sx+1,3,$scrollC)
    $b.SetPixel($sx,7,$scrollColors2[3-$i]); $b.SetPixel($sx+1,7,$scrollColors2[3-$i])
    $b.SetPixel($sx,8,$scrollC); $b.SetPixel($sx+1,8,$scrollC)
    $b.SetPixel($sx,12,$scrollColors2[$i]); $b.SetPixel($sx+1,12,$scrollColors2[$i])
    $b.SetPixel($sx,13,$scrollC); $b.SetPixel($sx+1,13,$scrollC)
}
Save $b "$blockDir\scroll_shelf.png"

# Tatami Mat
$b = New-Object System.Drawing.Bitmap(16,16)
$tatami = C 200 190 130; $tatamiD = C 170 160 100; $border = C 50 80 50
for ($x=0;$x-lt 16;$x++) { for ($y=0;$y-lt 16;$y++) { $b.SetPixel($x,$y,$(if($y%2-eq 0){$tatami}else{$tatamiD})) } }
# Border
for ($x=0;$x-lt 16;$x++) { $b.SetPixel($x,0,$border); $b.SetPixel($x,15,$border) }
for ($y=0;$y-lt 16;$y++) { $b.SetPixel(0,$y,$border); $b.SetPixel(15,$y,$border) }
# Center line
for ($x=0;$x-lt 16;$x++) { $b.SetPixel($x,7,$border); $b.SetPixel($x,8,$border) }
Save $b "$blockDir\tatami_mat.png"

# Paper Wall
$b = New-Object System.Drawing.Bitmap(16,16)
$paperW = C 240 235 220; $paperWD = C 220 215 200; $frameW = C 100 70 35
for ($x=0;$x-lt 16;$x++) { for ($y=0;$y-lt 16;$y++) { $b.SetPixel($x,$y,$(if(($x+$y)%7-eq 0){$paperWD}else{$paperW})) } }
# Wooden frame grid
for ($i=0;$i-lt 16;$i++) { $b.SetPixel($i,0,$frameW); $b.SetPixel($i,15,$frameW); $b.SetPixel(0,$i,$frameW); $b.SetPixel(15,$i,$frameW); $b.SetPixel(7,$i,$frameW); $b.SetPixel(8,$i,$frameW) }
Save $b "$blockDir\paper_wall.png"

# Village Banner
$b = New-Object System.Drawing.Bitmap(16,16)
$banner = C 240 240 230; $bannerD = C 210 210 200; $symbol2 = C 30 80 50; $pole = C 120 80 40
for ($x=0;$x-lt 16;$x++) { for ($y=0;$y-lt 16;$y++) { $b.SetPixel($x,$y,$banner) } }
# Pole
for ($y=0;$y-lt 16;$y++) { $b.SetPixel(0,$y,$pole); $b.SetPixel(1,$y,$pole) }
# Konoha symbol
$b.SetPixel(8,5,$symbol2); $b.SetPixel(9,5,$symbol2); $b.SetPixel(7,6,$symbol2); $b.SetPixel(10,6,$symbol2)
$b.SetPixel(8,7,$symbol2); $b.SetPixel(9,7,$symbol2); $b.SetPixel(8,8,$symbol2); $b.SetPixel(9,8,$symbol2)
$b.SetPixel(7,9,$symbol2); $b.SetPixel(10,9,$symbol2); $b.SetPixel(8,10,$symbol2); $b.SetPixel(9,10,$symbol2)
# Banner fringe
for ($x=2;$x-lt 16;$x++) { $b.SetPixel($x,14,$bannerD); $b.SetPixel($x,15,$bannerD) }
Save $b "$blockDir\village_banner_block.png"

# Explosive Tag Block
$b = New-Object System.Drawing.Bitmap(16,16)
$tagB = C 235 225 195; $tagBD = C 210 200 170; $redMark = C 180 40 40
for ($x=0;$x-lt 16;$x++) { for ($y=0;$y-lt 16;$y++) { $b.SetPixel($x,$y,$(if(($x+$y)%5-eq 0){$tagBD}else{$tagB})) } }
# Kanji marks
for ($y=3;$y-le 12;$y++) { $b.SetPixel(7,$y,$redMark); $b.SetPixel(8,$y,$redMark) }
for ($x=4;$x-le 11;$x++) { $b.SetPixel($x,4,$redMark); $b.SetPixel($x,7,$redMark); $b.SetPixel($x,10,$redMark) }
# Border
for ($i=0;$i-lt 16;$i++) { $b.SetPixel($i,0,$redMark); $b.SetPixel($i,15,$redMark); $b.SetPixel(0,$i,$redMark); $b.SetPixel(15,$i,$redMark) }
Save $b "$blockDir\explosive_tag_block.png"

# Training Dummy
$b = New-Object System.Drawing.Bitmap(16,16)
$dWood = C 160 120 70; $dWoodL = C 190 150 90; $dWoodD = C 120 85 45; $target = C 200 40 30
for ($x=0;$x-lt 16;$x++) { for ($y=0;$y-lt 16;$y++) { $b.SetPixel($x,$y,$dWood) } }
for ($y=0;$y-lt 16;$y+=4) { for ($x=0;$x-lt 16;$x++) { $b.SetPixel($x,$y,$dWoodD) } }
$b.SetPixel(4,5,$dWoodL); $b.SetPixel(10,10,$dWoodL)
# Target circle
for ($x=5;$x-le 10;$x++) { for ($y=5;$y-le 10;$y++) { $dist=[Math]::Sqrt(($x-7.5)*($x-7.5)+($y-7.5)*($y-7.5)); if($dist -lt 3) { $b.SetPixel($x,$y,$target) } } }
$b.SetPixel(7,7,(C 255 255 200)); $b.SetPixel(8,7,(C 255 255 200))
Save $b "$blockDir\training_dummy.png"

# Chakra Altar
$b = New-Object System.Drawing.Bitmap(16,16)
$altar = C 80 80 100; $altarL = C 110 110 130; $altarD = C 55 55 75; $glow2 = C 60 160 240
for ($x=0;$x-lt 16;$x++) { for ($y=0;$y-lt 16;$y++) { $b.SetPixel($x,$y,$altar) } }
# Stone pattern
for ($y=0;$y-lt 16;$y+=4) { for ($x=0;$x-lt 16;$x++) { $b.SetPixel($x,$y,$altarD) } }
for ($x=0;$x-lt 16;$x+=4) { for ($y=0;$y-lt 16;$y++) { $b.SetPixel($x,$y,$altarD) } }
# Glowing symbols
$b.SetPixel(4,4,$glow2); $b.SetPixel(11,4,$glow2); $b.SetPixel(4,11,$glow2); $b.SetPixel(11,11,$glow2)
$b.SetPixel(7,7,$glow2); $b.SetPixel(8,7,$glow2); $b.SetPixel(7,8,$glow2); $b.SetPixel(8,8,$glow2)
# Top surface highlight
for ($x=1;$x-le 14;$x++) { $b.SetPixel($x,0,$altarL); $b.SetPixel($x,1,$altarL) }
Save $b "$blockDir\chakra_altar.png"

# Konoha Stone
$b = New-Object System.Drawing.Bitmap(16,16)
$ks = C 140 140 130; $ksL = C 170 170 155; $ksD = C 110 110 100
for ($x=0;$x-lt 16;$x++) { for ($y=0;$y-lt 16;$y++) { $v = ($x*5+$y*11)%4; $b.SetPixel($x,$y,$(if($v-eq 0){$ksL}elseif($v-eq 3){$ksD}else{$ks})) } }
# Brick pattern
for ($y=0;$y-lt 16;$y+=4) { for ($x=0;$x-lt 16;$x++) { $b.SetPixel($x,$y,$ksD) } }
$offset = 0
for ($y=0;$y-lt 16;$y+=4) { for ($yy=$y;$yy-lt [Math]::Min($y+4,16);$yy++) { $b.SetPixel(($offset+8)%16,$yy,$ksD) }; $offset+=4 }
Save $b "$blockDir\konoha_stone.png"

# Konoha Planks
$b = New-Object System.Drawing.Bitmap(16,16)
$kp = C 170 140 80; $kpL = C 200 170 100; $kpD = C 140 110 60
for ($x=0;$x-lt 16;$x++) { for ($y=0;$y-lt 16;$y++) { $b.SetPixel($x,$y,$(if($x%4-eq 0){$kpD}else{$kp})) } }
# Wood grain
for ($x=0;$x-lt 16;$x++) { if (($x*7)%5-eq 0) { for ($y=0;$y-lt 16;$y++) { if($y%3-ne 0) { $b.SetPixel($x,$y,$kpL) } } } }
Save $b "$blockDir\konoha_planks.png"

Write-Host "  All block textures regenerated"
Write-Host ""
Write-Host "=== ALL FIXES AND IMPROVEMENTS COMPLETE ==="
$totalRecipes = (Get-ChildItem "$root\recipes" -Filter "*.json").Count
$totalModels = (Get-ChildItem "$root\models" -Recurse -Filter "*.json").Count
$totalTextures = (Get-ChildItem "$root\textures" -Recurse -Filter "*.png").Count
Write-Host "Recipes: $totalRecipes | Models: $totalModels | Textures: $totalTextures"
