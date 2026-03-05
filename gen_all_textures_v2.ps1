Add-Type -AssemblyName System.Drawing

$base = "C:\Users\andra\MCreatorWorkspaces\projetokonoha\src\main\resources\assets\projetokonoha"
$texItems = "$base\textures\items"
$texBlocks = "$base\textures\blocks"
$texEntity = "$base\textures\entity"
$texArmor = "$base\textures\models\armor"
$texGui = "$base\textures\gui"
$models = "$base\models\item"
$blockModels = "$base\models\block"
$blockStates = "$base\blockstates"
$recipes = "$base\..\..\..\..\..\..\recipes"

# Ensure directories
foreach($d in @($texItems,$texBlocks,$texEntity,$texArmor,$texGui,$models,$blockModels,$blockStates)) {
    if(!(Test-Path $d)) { New-Item -ItemType Directory -Path $d -Force | Out-Null }
}
$recipePath = "C:\Users\andra\MCreatorWorkspaces\projetokonoha\src\main\resources\assets\projetokonoha\recipes"
if(!(Test-Path $recipePath)) { New-Item -ItemType Directory -Path $recipePath -Force | Out-Null }

# Helper: create 16x16 PNG
function New-Texture16($path, [scriptblock]$drawFunc) {
    $bmp = New-Object System.Drawing.Bitmap(16,16)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.Clear([System.Drawing.Color]::FromArgb(0,0,0,0))
    & $drawFunc $bmp $g
    $g.Dispose()
    $bmp.Save($path, [System.Drawing.Imaging.ImageFormat]::Png)
    $bmp.Dispose()
}

# Helper: create 64x32 armor layer PNG
function New-ArmorTexture($path, [scriptblock]$drawFunc) {
    $bmp = New-Object System.Drawing.Bitmap(64,32)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.Clear([System.Drawing.Color]::FromArgb(0,0,0,0))
    & $drawFunc $bmp $g
    $g.Dispose()
    $bmp.Save($path, [System.Drawing.Imaging.ImageFormat]::Png)
    $bmp.Dispose()
}

# Helper: create 64x64 entity texture
function New-EntityTexture($path, [scriptblock]$drawFunc) {
    $bmp = New-Object System.Drawing.Bitmap(64,64)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.Clear([System.Drawing.Color]::FromArgb(0,0,0,0))
    & $drawFunc $bmp $g
    $g.Dispose()
    $bmp.Save($path, [System.Drawing.Imaging.ImageFormat]::Png)
    $bmp.Dispose()
}

function Set-Pixel($bmp, $x, $y, $color) {
    if($x -ge 0 -and $x -lt $bmp.Width -and $y -ge 0 -and $y -lt $bmp.Height) {
        $bmp.SetPixel($x, $y, $color)
    }
}

function Fill-Rect($bmp, $x1, $y1, $w, $h, $color) {
    for($y=$y1; $y -lt ($y1+$h); $y++) {
        for($x=$x1; $x -lt ($x1+$w); $x++) {
            Set-Pixel $bmp $x $y $color
        }
    }
}

# ===== COLORS =====
$C = @{
    Orange = [System.Drawing.Color]::FromArgb(255,140,0)
    DarkOrange = [System.Drawing.Color]::FromArgb(200,100,0)
    Blue = [System.Drawing.Color]::FromArgb(30,90,255)
    DarkBlue = [System.Drawing.Color]::FromArgb(25,25,112)
    NavyBlue = [System.Drawing.Color]::FromArgb(0,0,128)
    Red = [System.Drawing.Color]::FromArgb(200,0,0)
    DarkRed = [System.Drawing.Color]::FromArgb(139,0,0)
    BrightRed = [System.Drawing.Color]::FromArgb(255,0,0)
    Green = [System.Drawing.Color]::FromArgb(34,139,34)
    DarkGreen = [System.Drawing.Color]::FromArgb(0,100,0)
    LightGreen = [System.Drawing.Color]::FromArgb(144,238,144)
    Yellow = [System.Drawing.Color]::FromArgb(255,215,0)
    Gold = [System.Drawing.Color]::FromArgb(218,165,32)
    Purple = [System.Drawing.Color]::FromArgb(128,0,128)
    DarkPurple = [System.Drawing.Color]::FromArgb(75,0,130)
    Pink = [System.Drawing.Color]::FromArgb(255,105,180)
    White = [System.Drawing.Color]::FromArgb(240,240,240)
    LightGray = [System.Drawing.Color]::FromArgb(192,192,192)
    Gray = [System.Drawing.Color]::FromArgb(128,128,128)
    DarkGray = [System.Drawing.Color]::FromArgb(64,64,64)
    Black = [System.Drawing.Color]::FromArgb(32,32,32)
    Brown = [System.Drawing.Color]::FromArgb(139,90,43)
    DarkBrown = [System.Drawing.Color]::FromArgb(80,50,20)
    LightBrown = [System.Drawing.Color]::FromArgb(194,154,108)
    Tan = [System.Drawing.Color]::FromArgb(210,180,140)
    Skin = [System.Drawing.Color]::FromArgb(255,220,185)
    Steel = [System.Drawing.Color]::FromArgb(176,196,222)
    DarkSteel = [System.Drawing.Color]::FromArgb(100,120,140)
    Cyan = [System.Drawing.Color]::FromArgb(0,200,200)
    Teal = [System.Drawing.Color]::FromArgb(0,128,128)
    Sand = [System.Drawing.Color]::FromArgb(194,178,128)
    Cream = [System.Drawing.Color]::FromArgb(255,253,208)
    Lavender = [System.Drawing.Color]::FromArgb(230,230,250)
}

Write-Host "Generating item textures..."

# ===== WEAPONS =====
# Kunai - metallic blade with handle
New-Texture16 "$texItems\kunai.png" {
    param($b,$g)
    Fill-Rect $b 6 1 2 2 $C.Steel       # tip
    Set-Pixel $b 7 0 $C.White
    Fill-Rect $b 6 3 3 5 $C.LightGray   # blade
    Fill-Rect $b 7 3 1 5 $C.White        # blade highlight
    Fill-Rect $b 6 8 3 2 $C.DarkGray    # guard
    Fill-Rect $b 7 10 1 4 $C.Brown       # handle
    Fill-Rect $b 7 14 1 1 $C.DarkBrown   # pommel
    Set-Pixel $b 6 10 $C.DarkBrown       # wrap
    Set-Pixel $b 8 11 $C.DarkBrown
    Set-Pixel $b 6 12 $C.DarkBrown
}

# Shuriken - four-pointed star
New-Texture16 "$texItems\shuriken.png" {
    param($b,$g)
    Fill-Rect $b 7 7 2 2 $C.DarkGray    # center
    Fill-Rect $b 7 2 2 5 $C.Steel       # top blade
    Set-Pixel $b 7 1 $C.LightGray
    Fill-Rect $b 7 9 2 5 $C.Steel       # bottom blade
    Set-Pixel $b 8 14 $C.LightGray
    Fill-Rect $b 2 7 5 2 $C.Steel       # left blade
    Set-Pixel $b 1 7 $C.LightGray
    Fill-Rect $b 9 7 5 2 $C.Steel       # right blade
    Set-Pixel $b 14 8 $C.LightGray
    Set-Pixel $b 7 7 $C.Black           # center hole
}

# Katana - long elegant blade
New-Texture16 "$texItems\katana.png" {
    param($b,$g)
    Set-Pixel $b 3 0 $C.White           # tip gleam
    Set-Pixel $b 4 1 $C.Steel
    for($i=0; $i -lt 8; $i++) {
        Set-Pixel $b (4+[int]($i/3)) (2+$i) $C.LightGray
        Set-Pixel $b (5+[int]($i/3)) (2+$i) $C.White
    }
    Fill-Rect $b 7 9 2 1 $C.Gold        # tsuba guard
    Fill-Rect $b 6 9 1 1 $C.Gold
    Fill-Rect $b 9 9 1 1 $C.Gold
    Fill-Rect $b 8 10 1 4 $C.DarkPurple # handle
    Fill-Rect $b 7 10 1 4 $C.Purple
    Set-Pixel $b 8 14 $C.Gold           # pommel cap
    Set-Pixel $b 7 14 $C.Gold
}

# Explosive kunai - kunai with paper bomb tag
New-Texture16 "$texItems\explosive_kunai.png" {
    param($b,$g)
    Fill-Rect $b 6 1 2 2 $C.Steel
    Fill-Rect $b 6 3 3 4 $C.LightGray
    Fill-Rect $b 6 7 3 2 $C.DarkGray
    Fill-Rect $b 7 9 1 3 $C.Brown
    # paper bomb tag
    Fill-Rect $b 9 5 4 5 $C.Cream
    Fill-Rect $b 10 6 2 3 $C.Red
    Set-Pixel $b 11 7 $C.Black
}

# Senbon - thin needle
New-Texture16 "$texItems\senbon.png" {
    param($b,$g)
    Set-Pixel $b 8 1 $C.White
    for($i=0; $i -lt 12; $i++) {
        Set-Pixel $b 8 (2+$i) $C.Steel
    }
    Set-Pixel $b 8 14 $C.LightGray
    Set-Pixel $b 7 2 $C.LightGray  # gleam
}

# Fuma Shuriken - large 4-bladed
New-Texture16 "$texItems\fuma_shuriken.png" {
    param($b,$g)
    Fill-Rect $b 7 7 2 2 $C.DarkGray
    for($i=0; $i -lt 6; $i++) {
        Set-Pixel $b (7-$i) (7-$i) $C.Steel
        Set-Pixel $b (8+$i) (7-$i) $C.Steel
        Set-Pixel $b (7-$i) (8+$i) $C.Steel
        Set-Pixel $b (8+$i) (8+$i) $C.Steel
    }
    Set-Pixel $b 7 7 $C.Red  # center ring
    Set-Pixel $b 8 8 $C.Red
}

# Tanto - short blade
New-Texture16 "$texItems\tanto.png" {
    param($b,$g)
    Set-Pixel $b 6 2 $C.White
    Fill-Rect $b 6 3 2 5 $C.Steel
    Fill-Rect $b 7 3 1 5 $C.LightGray
    Fill-Rect $b 5 8 4 1 $C.Gold      # guard
    Fill-Rect $b 6 9 2 4 $C.DarkBrown # handle
    Set-Pixel $b 6 9 $C.Brown
    Set-Pixel $b 7 10 $C.Brown
    Set-Pixel $b 6 11 $C.Brown
}

# Paper Bomb
New-Texture16 "$texItems\paper_bomb.png" {
    param($b,$g)
    Fill-Rect $b 3 2 10 12 $C.Cream
    Fill-Rect $b 4 3 8 10 $C.White
    # kanji-like symbol
    Fill-Rect $b 6 4 4 1 $C.Black
    Fill-Rect $b 7 5 2 3 $C.Black
    Fill-Rect $b 6 8 4 1 $C.Black
    Fill-Rect $b 8 9 1 2 $C.Black
    Fill-Rect $b 5 11 6 1 $C.Red
    Set-Pixel $b 3 2 $C.DarkBrown  # corners
    Set-Pixel $b 12 2 $C.DarkBrown
}

# Smoke Bomb - round ball
New-Texture16 "$texItems\smoke_bomb.png" {
    param($b,$g)
    Fill-Rect $b 5 5 6 6 $C.DarkGray
    Fill-Rect $b 6 4 4 1 $C.Gray
    Fill-Rect $b 6 11 4 1 $C.Gray
    Fill-Rect $b 4 6 1 4 $C.Gray
    Fill-Rect $b 11 6 1 4 $C.Gray
    Fill-Rect $b 6 6 4 4 $C.Gray
    Fill-Rect $b 7 6 2 2 $C.LightGray
    # fuse
    Set-Pixel $b 8 3 $C.Brown
    Set-Pixel $b 8 2 $C.Orange
    Set-Pixel $b 9 1 $C.Yellow
}

# Chakra Blade - glowing blue sword
New-Texture16 "$texItems\chakra_blade.png" {
    param($b,$g)
    Set-Pixel $b 5 0 $C.Cyan
    Set-Pixel $b 5 1 $C.Cyan
    for($i=0; $i -lt 7; $i++) {
        Set-Pixel $b (5+[int]($i/3)) (2+$i) $C.Blue
        Set-Pixel $b (6+[int]($i/3)) (2+$i) $C.Cyan
    }
    Fill-Rect $b 7 9 3 1 $C.Steel     # guard
    Fill-Rect $b 8 10 1 4 $C.DarkBlue # handle
    Set-Pixel $b 8 14 $C.Blue
    Set-Pixel $b 7 3 $C.White  # gleam
}

# Kusarigama - chain sickle
New-Texture16 "$texItems\kusarigama.png" {
    param($b,$g)
    Fill-Rect $b 3 1 2 4 $C.Steel     # sickle blade
    Set-Pixel $b 2 2 $C.LightGray
    Set-Pixel $b 5 3 $C.LightGray
    Fill-Rect $b 4 5 1 4 $C.Brown     # handle
    # chain
    for($i=0; $i -lt 5; $i++) {
        Set-Pixel $b (5+$i) (9+[int]($i/2)) $C.Gray
        Set-Pixel $b (6+$i) (9+[int]($i/2)) $C.DarkGray
    }
    Fill-Rect $b 11 12 3 3 $C.DarkGray # weight
    Set-Pixel $b 12 12 $C.Steel
}

Write-Host "  Weapons done"

# ===== SCROLLS (ALL) =====
$scrollColors = @{
    "rasengan_scroll" = @($C.Blue, $C.Cyan)
    "chidori_scroll" = @($C.Yellow, $C.White)
    "fireball_scroll" = @($C.Red, $C.Orange)
    "water_dragon_scroll" = @($C.Blue, $C.Teal)
    "wind_blade_scroll" = @($C.LightGreen, $C.White)
    "earth_wall_scroll" = @($C.Brown, $C.DarkBrown)
    "shadow_clone_scroll" = @($C.DarkGray, $C.Gray)
    "healing_scroll" = @($C.Green, $C.LightGreen)
    "substitution_scroll" = @($C.Brown, $C.LightBrown)
    "body_flicker_scroll" = @($C.Yellow, $C.Gold)
    "blank_scroll" = @($C.Cream, $C.White)
    "amaterasu_scroll" = @($C.Black, $C.DarkRed)
    "sand_coffin_scroll" = @($C.Sand, $C.Brown)
    "eight_gates_scroll" = @($C.Green, $C.Red)
    "summoning_scroll" = @($C.Purple, $C.Gold)
    "gentle_fist_scroll" = @($C.Lavender, $C.DarkPurple)
    "lightning_blade_scroll" = @($C.Yellow, $C.Blue)
}

foreach($sn in $scrollColors.Keys) {
    $cols = $scrollColors[$sn]
    $primary = $cols[0]
    $accent = $cols[1]
    New-Texture16 "$texItems\$sn.png" {
        param($b,$g)
        # scroll body
        Fill-Rect $b 3 3 10 10 $primary
        Fill-Rect $b 4 4 8 8 ([System.Drawing.Color]::FromArgb(255, [Math]::Min(255,[int]($primary.R*0.8+50)), [Math]::Min(255,[int]($primary.G*0.8+50)), [Math]::Min(255,[int]($primary.B*0.8+50))))
        # roll ends
        Fill-Rect $b 3 2 10 1 $accent
        Fill-Rect $b 3 13 10 1 $accent
        Fill-Rect $b 2 3 1 10 $accent
        Fill-Rect $b 13 3 1 10 $accent
        # center symbol
        Fill-Rect $b 6 6 4 4 $accent
        Fill-Rect $b 7 7 2 2 $primary
        # seal marks
        Set-Pixel $b 5 5 $C.Black
        Set-Pixel $b 10 5 $C.Black
        Set-Pixel $b 5 10 $C.Black
        Set-Pixel $b 10 10 $C.Black
    }
}
Write-Host "  Scrolls done"

# ===== FOOD =====
# Ramen
New-Texture16 "$texItems\ramen.png" {
    param($b,$g)
    Fill-Rect $b 2 8 12 5 $C.White     # bowl
    Fill-Rect $b 3 7 10 1 $C.LightGray # rim
    Fill-Rect $b 3 8 10 4 $C.Yellow    # noodle broth
    Fill-Rect $b 4 8 8 3 $C.Gold       # broth color
    # noodles wavy lines
    for($x=4; $x -lt 12; $x++) { Set-Pixel $b $x (8+($x%2)) $C.Cream }
    # naruto fishcake
    Fill-Rect $b 7 8 3 2 $C.Pink
    Set-Pixel $b 8 8 $C.White
    # chopsticks
    Set-Pixel $b 10 5 $C.Brown; Set-Pixel $b 11 6 $C.Brown; Set-Pixel $b 12 7 $C.Brown
    Set-Pixel $b 9 4 $C.Brown; Set-Pixel $b 10 5 $C.DarkBrown; Set-Pixel $b 11 6 $C.DarkBrown
    Fill-Rect $b 4 13 8 1 $C.LightGray  # bowl base
}

# Soldier Pill
New-Texture16 "$texItems\soldier_pill.png" {
    param($b,$g)
    Fill-Rect $b 5 5 6 6 $C.DarkRed
    Fill-Rect $b 6 4 4 1 $C.Red
    Fill-Rect $b 6 11 4 1 $C.Red
    Fill-Rect $b 4 6 1 4 $C.Red
    Fill-Rect $b 11 6 1 4 $C.Red
    Fill-Rect $b 6 6 4 4 $C.Red
    Fill-Rect $b 7 7 2 2 $C.BrightRed
    Set-Pixel $b 7 6 $C.White  # gleam
}

# Rice Ball
New-Texture16 "$texItems\rice_ball.png" {
    param($b,$g)
    Fill-Rect $b 4 3 8 9 $C.White
    Fill-Rect $b 5 2 6 1 $C.White
    Fill-Rect $b 5 12 6 1 $C.White
    Fill-Rect $b 3 5 1 5 $C.White
    Fill-Rect $b 12 5 1 5 $C.White
    # nori seaweed wrap
    Fill-Rect $b 4 8 8 4 $C.DarkGreen
    Fill-Rect $b 5 7 6 1 ([System.Drawing.Color]::FromArgb(255,0,80,0))
    Set-Pixel $b 7 4 $C.LightGray  # rice texture
    Set-Pixel $b 9 5 $C.LightGray
}

# Dango
New-Texture16 "$texItems\dango.png" {
    param($b,$g)
    Set-Pixel $b 8 2 $C.Brown; Set-Pixel $b 8 14 $C.Brown  # stick
    for($y=3; $y -lt 14; $y++) { Set-Pixel $b 8 $y $C.LightBrown }
    # dango balls
    Fill-Rect $b 6 3 4 3 $C.Pink
    Set-Pixel $b 7 3 $C.White  # highlight
    Fill-Rect $b 6 7 4 3 $C.White
    Set-Pixel $b 7 7 $C.Cream
    Fill-Rect $b 6 11 4 3 $C.LightGreen
    Set-Pixel $b 7 11 $C.Green
}

# Chakra Fruit
New-Texture16 "$texItems\chakra_fruit.png" {
    param($b,$g)
    Fill-Rect $b 5 3 6 8 $C.Purple
    Fill-Rect $b 6 2 4 1 $C.DarkPurple
    Fill-Rect $b 6 11 4 1 $C.DarkPurple
    Fill-Rect $b 4 5 1 4 $C.DarkPurple
    Fill-Rect $b 11 5 1 4 $C.DarkPurple
    Fill-Rect $b 6 4 4 6 ([System.Drawing.Color]::FromArgb(255,180,0,255))
    Fill-Rect $b 7 5 2 4 $C.Cyan  # inner glow
    Set-Pixel $b 7 5 $C.White     # gleam
    # stem
    Set-Pixel $b 8 1 $C.Green
    Set-Pixel $b 8 2 $C.DarkGreen
    Set-Pixel $b 9 1 $C.LightGreen
}

# Military Ration
New-Texture16 "$texItems\military_ration.png" {
    param($b,$g)
    Fill-Rect $b 3 4 10 8 $C.DarkGreen
    Fill-Rect $b 4 3 8 1 $C.Green
    Fill-Rect $b 4 12 8 1 $C.Green
    Fill-Rect $b 4 5 8 6 $C.Green
    Fill-Rect $b 5 6 6 4 $C.LightGreen
    # cross symbol
    Fill-Rect $b 7 6 2 4 $C.White
    Fill-Rect $b 6 7 4 2 $C.White
}

# Curry of Life
New-Texture16 "$texItems\curry_of_life.png" {
    param($b,$g)
    Fill-Rect $b 2 7 12 6 $C.White
    Fill-Rect $b 3 6 10 1 $C.LightGray
    Fill-Rect $b 3 7 10 5 $C.DarkOrange
    Fill-Rect $b 4 7 8 4 $C.Orange
    Fill-Rect $b 5 8 2 2 $C.Yellow  # potato
    Fill-Rect $b 8 8 2 2 $C.Brown  # meat
    Fill-Rect $b 4 13 8 1 $C.LightGray
    # steam
    Set-Pixel $b 6 4 $C.LightGray; Set-Pixel $b 8 3 $C.LightGray; Set-Pixel $b 10 5 $C.LightGray
}

# Sweet Bean Paste
New-Texture16 "$texItems\sweet_bean_paste.png" {
    param($b,$g)
    Fill-Rect $b 4 5 8 7 $C.DarkRed
    Fill-Rect $b 5 4 6 1 $C.Red
    Fill-Rect $b 5 12 6 1 $C.Red
    Fill-Rect $b 5 6 6 5 ([System.Drawing.Color]::FromArgb(255,160,40,40))
    Fill-Rect $b 6 7 4 3 $C.Red
    Set-Pixel $b 6 6 $C.White
}

# Green Tea
New-Texture16 "$texItems\green_tea.png" {
    param($b,$g)
    Fill-Rect $b 4 6 8 7 $C.Cream     # cup
    Fill-Rect $b 5 5 6 1 $C.LightGray # rim
    Fill-Rect $b 5 6 6 6 $C.DarkGreen # tea
    Fill-Rect $b 6 7 4 4 $C.Green     # tea highlight
    Fill-Rect $b 5 13 6 1 $C.LightGray # base
    # steam
    Set-Pixel $b 7 3 $C.LightGray; Set-Pixel $b 9 4 $C.LightGray
}

# Onigiri
New-Texture16 "$texItems\onigiri.png" {
    param($b,$g)
    # triangle rice ball
    Fill-Rect $b 6 3 4 2 $C.White
    Fill-Rect $b 5 5 6 2 $C.White
    Fill-Rect $b 4 7 8 2 $C.White
    Fill-Rect $b 3 9 10 2 $C.White
    Fill-Rect $b 3 11 10 2 $C.DarkGreen  # nori
    Set-Pixel $b 7 5 $C.LightGray  # rice grain
    Set-Pixel $b 9 7 $C.LightGray
}

Write-Host "  Food done"

# ===== ARMOR ITEM ICONS =====
$armorSets = @{
    "konoha" = @{ h=$C.Blue; c=$C.Green; l=$C.Green; b=$C.Blue }
    "akatsuki" = @{ h=$C.Black; c=$C.Black; l=$C.Black; b=$C.Black; acc=$C.Red }
    "anbu" = @{ h=$C.LightGray; c=$C.DarkGray; l=$C.DarkGray; b=$C.DarkGray }
    "sage" = @{ h=$C.Orange; c=$C.Red; l=$C.Red; b=$C.DarkBrown }
    "hokage" = @{ h=$C.White; c=$C.White; l=$C.White; b=$C.White; acc=$C.Red }
    "sound" = @{ h=$C.DarkPurple; c=$C.Purple; l=$C.Purple; b=$C.DarkPurple }
}

foreach($set in $armorSets.Keys) {
    $colors = $armorSets[$set]
    $accent = if($colors.ContainsKey("acc")) { $colors.acc } else { $C.Gold }

    # Helmet
    New-Texture16 "$texItems\${set}_helmet.png" {
        param($b,$g)
        Fill-Rect $b 3 3 10 8 $colors.h
        Fill-Rect $b 4 2 8 1 $colors.h
        Fill-Rect $b 4 4 8 6 ([System.Drawing.Color]::FromArgb(255,[Math]::Min(255,$colors.h.R+30),[Math]::Min(255,$colors.h.G+30),[Math]::Min(255,$colors.h.B+30)))
        Fill-Rect $b 6 11 4 2 $colors.h  # chin guard
        Fill-Rect $b 5 5 2 2 $accent     # emblem
        Set-Pixel $b 4 3 $C.White        # gleam
    }

    # Chestplate
    New-Texture16 "$texItems\${set}_chestplate.png" {
        param($b,$g)
        Fill-Rect $b 2 2 12 11 $colors.c
        Fill-Rect $b 3 3 10 9 ([System.Drawing.Color]::FromArgb(255,[Math]::Min(255,$colors.c.R+20),[Math]::Min(255,$colors.c.G+20),[Math]::Min(255,$colors.c.B+20)))
        Fill-Rect $b 2 2 3 3 $colors.c   # shoulder L
        Fill-Rect $b 11 2 3 3 $colors.c  # shoulder R
        Fill-Rect $b 6 4 4 3 $accent     # chest symbol
        Set-Pixel $b 3 3 $C.White        # gleam
    }

    # Leggings
    New-Texture16 "$texItems\${set}_leggings.png" {
        param($b,$g)
        Fill-Rect $b 3 2 10 5 $colors.l
        Fill-Rect $b 3 7 4 7 $colors.l   # left leg
        Fill-Rect $b 9 7 4 7 $colors.l   # right leg
        Fill-Rect $b 4 3 8 3 ([System.Drawing.Color]::FromArgb(255,[Math]::Min(255,$colors.l.R+20),[Math]::Min(255,$colors.l.G+20),[Math]::Min(255,$colors.l.B+20)))
        Fill-Rect $b 6 3 4 1 $accent     # belt
    }

    # Boots
    New-Texture16 "$texItems\${set}_boots.png" {
        param($b,$g)
        Fill-Rect $b 2 5 5 8 $colors.b
        Fill-Rect $b 9 5 5 8 $colors.b
        Fill-Rect $b 2 12 6 2 $colors.b  # sole L
        Fill-Rect $b 9 12 6 2 $colors.b  # sole R
        Fill-Rect $b 3 6 3 6 ([System.Drawing.Color]::FromArgb(255,[Math]::Min(255,$colors.b.R+20),[Math]::Min(255,$colors.b.G+20),[Math]::Min(255,$colors.b.B+20)))
        Fill-Rect $b 10 6 3 6 ([System.Drawing.Color]::FromArgb(255,[Math]::Min(255,$colors.b.R+20),[Math]::Min(255,$colors.b.G+20),[Math]::Min(255,$colors.b.B+20)))
    }
}
Write-Host "  Armor items done"

# ===== SPECIAL ITEMS =====
# Sharingan Eye
New-Texture16 "$texItems\sharingan_eye.png" {
    param($b,$g)
    Fill-Rect $b 4 4 8 8 $C.Red
    Fill-Rect $b 5 3 6 1 $C.DarkRed
    Fill-Rect $b 5 12 6 1 $C.DarkRed
    Fill-Rect $b 3 5 1 6 $C.DarkRed
    Fill-Rect $b 12 5 1 6 $C.DarkRed
    Fill-Rect $b 6 6 4 4 $C.BrightRed
    Fill-Rect $b 7 7 2 2 $C.Black  # pupil
    Set-Pixel $b 6 5 $C.Black     # tomoe 1
    Set-Pixel $b 10 7 $C.Black    # tomoe 2
    Set-Pixel $b 7 10 $C.Black    # tomoe 3
}

# Byakugan Eye
New-Texture16 "$texItems\byakugan_eye.png" {
    param($b,$g)
    Fill-Rect $b 4 4 8 8 $C.White
    Fill-Rect $b 5 3 6 1 $C.LightGray
    Fill-Rect $b 5 12 6 1 $C.LightGray
    Fill-Rect $b 3 5 1 6 $C.LightGray
    Fill-Rect $b 12 5 1 6 $C.LightGray
    Fill-Rect $b 6 6 4 4 $C.Lavender
    Fill-Rect $b 7 7 2 2 $C.White
    Set-Pixel $b 7 7 $C.LightGray  # subtle pupil
    # veins
    Set-Pixel $b 3 4 $C.Lavender; Set-Pixel $b 12 4 $C.Lavender
}

# Ninja Headband
New-Texture16 "$texItems\ninja_headband.png" {
    param($b,$g)
    Fill-Rect $b 1 5 14 5 $C.Blue
    Fill-Rect $b 2 6 12 3 $C.NavyBlue
    Fill-Rect $b 4 5 8 5 $C.Steel    # metal plate
    Fill-Rect $b 5 6 6 3 $C.LightGray
    # konoha symbol on plate
    Fill-Rect $b 7 6 2 3 $C.DarkGray
    Set-Pixel $b 6 7 $C.DarkGray
    Set-Pixel $b 9 7 $C.DarkGray
    Set-Pixel $b 5 6 $C.White  # gleam
}

# Summoning Contract
New-Texture16 "$texItems\summoning_contract.png" {
    param($b,$g)
    Fill-Rect $b 2 1 12 14 $C.Tan
    Fill-Rect $b 3 2 10 12 $C.Cream
    # blood seal
    Fill-Rect $b 5 4 6 6 $C.Red
    Fill-Rect $b 6 5 4 4 $C.DarkRed
    Fill-Rect $b 7 6 2 2 $C.BrightRed
    # text lines
    Fill-Rect $b 4 11 8 1 $C.DarkGray
    Fill-Rect $b 5 13 6 1 $C.DarkGray
}

# Bijuu Cloak
New-Texture16 "$texItems\bijuu_cloak.png" {
    param($b,$g)
    Fill-Rect $b 3 2 10 12 $C.Orange
    Fill-Rect $b 4 3 8 10 $C.Yellow
    Fill-Rect $b 5 4 6 8 $C.Gold
    # flame effect at bottom
    for($x=3; $x -lt 13; $x++) {
        Set-Pixel $b $x 14 $C.Orange
        Set-Pixel $b $x 13 $C.Yellow
    }
    # seal mark on chest
    Fill-Rect $b 6 5 4 4 $C.Black
    Fill-Rect $b 7 6 2 2 $C.Orange
    Set-Pixel $b 5 3 $C.White  # gleam
}

# Cursed Seal
New-Texture16 "$texItems\cursed_seal.png" {
    param($b,$g)
    Fill-Rect $b 4 4 8 8 $C.DarkPurple
    Fill-Rect $b 5 3 6 1 $C.Purple
    Fill-Rect $b 5 12 6 1 $C.Purple
    Fill-Rect $b 3 5 1 6 $C.Purple
    Fill-Rect $b 12 5 1 6 $C.Purple
    # cursed mark pattern
    Set-Pixel $b 6 5 $C.Black; Set-Pixel $b 9 5 $C.Black
    Set-Pixel $b 5 7 $C.Black; Set-Pixel $b 10 7 $C.Black
    Set-Pixel $b 6 9 $C.Black; Set-Pixel $b 9 9 $C.Black
    Fill-Rect $b 7 7 2 2 $C.DarkRed
    Set-Pixel $b 7 7 $C.BrightRed
}

# Chakra Paper
New-Texture16 "$texItems\chakra_paper.png" {
    param($b,$g)
    Fill-Rect $b 4 1 8 14 $C.White
    Fill-Rect $b 5 2 6 12 $C.Cream
    Set-Pixel $b 4 1 $C.LightGray
    Set-Pixel $b 11 1 $C.LightGray
    # subtle lines
    for($y=4; $y -lt 12; $y+=2) { Fill-Rect $b 5 $y 6 1 $C.LightGray }
}

# Ninja Wire
New-Texture16 "$texItems\ninja_wire.png" {
    param($b,$g)
    # coil of wire
    Fill-Rect $b 4 4 8 8 $C.LightGray
    Fill-Rect $b 5 3 6 1 $C.Steel
    Fill-Rect $b 5 12 6 1 $C.Steel
    Fill-Rect $b 6 5 4 6 $C.DarkGray  # hole in center
    Fill-Rect $b 5 5 1 6 $C.White     # wire gleam
    Set-Pixel $b 8 3 $C.LightGray     # wire end
    Set-Pixel $b 9 2 $C.LightGray
}

# Chakra Crystal
New-Texture16 "$texItems\chakra_crystal.png" {
    param($b,$g)
    Fill-Rect $b 6 2 4 10 $C.Cyan
    Fill-Rect $b 5 4 6 6 $C.Teal
    Fill-Rect $b 7 3 2 8 ([System.Drawing.Color]::FromArgb(255,100,255,255))
    Set-Pixel $b 7 3 $C.White
    Set-Pixel $b 8 5 $C.White
    Fill-Rect $b 7 12 2 2 $C.Teal  # base
}

# Ninja Steel Ingot
New-Texture16 "$texItems\ninja_steel_ingot.png" {
    param($b,$g)
    Fill-Rect $b 2 7 12 5 $C.DarkSteel
    Fill-Rect $b 3 6 10 1 $C.Steel
    Fill-Rect $b 3 8 10 3 $C.Steel
    Fill-Rect $b 4 8 8 2 $C.LightGray
    Set-Pixel $b 4 7 $C.White
}

# Chakra Dust
New-Texture16 "$texItems\chakra_dust.png" {
    param($b,$g)
    $rand = New-Object Random(42)
    for($i=0; $i -lt 30; $i++) {
        $x = $rand.Next(3,13); $y = $rand.Next(3,13)
        $col = if($rand.Next(2) -eq 0) { $C.Cyan } else { $C.Teal }
        Set-Pixel $b $x $y $col
    }
    Set-Pixel $b 8 7 $C.White; Set-Pixel $b 7 8 $C.White
}

# Ninja Steel Nugget
New-Texture16 "$texItems\ninja_steel_nugget.png" {
    param($b,$g)
    Fill-Rect $b 5 5 6 6 $C.DarkSteel
    Fill-Rect $b 6 4 4 1 $C.Steel
    Fill-Rect $b 6 11 4 1 $C.Steel
    Fill-Rect $b 6 6 4 4 $C.Steel
    Fill-Rect $b 7 7 2 2 $C.LightGray
    Set-Pixel $b 6 5 $C.White
}

# Chakra Pickaxe
New-Texture16 "$texItems\chakra_pickaxe.png" {
    param($b,$g)
    Fill-Rect $b 2 2 10 2 $C.Cyan
    Fill-Rect $b 3 2 8 1 $C.Teal
    Set-Pixel $b 1 2 $C.Blue
    Set-Pixel $b 12 2 $C.Blue
    Fill-Rect $b 7 4 2 10 $C.Brown
    Fill-Rect $b 7 4 1 10 $C.DarkBrown
    Set-Pixel $b 4 2 $C.White
}

# Chakra Axe
New-Texture16 "$texItems\chakra_axe.png" {
    param($b,$g)
    Fill-Rect $b 3 2 5 6 $C.Cyan
    Fill-Rect $b 4 3 4 4 $C.Teal
    Fill-Rect $b 3 2 2 2 $C.Blue
    Set-Pixel $b 3 2 $C.White
    Fill-Rect $b 7 4 2 10 $C.Brown
    Fill-Rect $b 7 4 1 10 $C.DarkBrown
}

# Chakra Shovel
New-Texture16 "$texItems\chakra_shovel.png" {
    param($b,$g)
    Fill-Rect $b 6 1 4 5 $C.Cyan
    Fill-Rect $b 7 2 2 3 $C.Teal
    Set-Pixel $b 7 1 $C.White
    Fill-Rect $b 7 6 2 8 $C.Brown
    Fill-Rect $b 7 6 1 8 $C.DarkBrown
}

Write-Host "  Special items + tools done"

# ===== BLOCK TEXTURES =====
# Training Dummy
New-Texture16 "$texBlocks\training_dummy.png" {
    param($b,$g)
    Fill-Rect $b 0 0 16 16 $C.LightBrown
    Fill-Rect $b 5 0 6 4 $C.Brown      # head
    Fill-Rect $b 6 4 4 8 $C.Tan        # body
    Fill-Rect $b 3 5 3 6 $C.Brown      # left arm
    Fill-Rect $b 10 5 3 6 $C.Brown     # right arm
    Fill-Rect $b 6 12 2 4 $C.DarkBrown # left leg
    Fill-Rect $b 8 12 2 4 $C.DarkBrown # right leg
    # target on chest
    Fill-Rect $b 7 6 2 2 $C.Red
}

# Chakra Altar
New-Texture16 "$texBlocks\chakra_altar.png" {
    param($b,$g)
    Fill-Rect $b 0 0 16 16 $C.DarkGray
    Fill-Rect $b 1 1 14 14 $C.Gray
    Fill-Rect $b 2 2 12 12 $C.DarkGray
    # glowing chakra symbol
    Fill-Rect $b 5 5 6 6 $C.Cyan
    Fill-Rect $b 6 6 4 4 $C.Teal
    Fill-Rect $b 7 7 2 2 $C.White
    # corner runes
    Set-Pixel $b 2 2 $C.Cyan; Set-Pixel $b 13 2 $C.Cyan
    Set-Pixel $b 2 13 $C.Cyan; Set-Pixel $b 13 13 $C.Cyan
    Set-Pixel $b 3 3 $C.Blue; Set-Pixel $b 12 3 $C.Blue
}

# Konoha Stone
New-Texture16 "$texBlocks\konoha_stone.png" {
    param($b,$g)
    Fill-Rect $b 0 0 16 16 $C.LightGray
    # stone texture
    for($y=0; $y -lt 16; $y+=4) {
        $offset = if(($y/4) % 2 -eq 0) { 0 } else { 4 }
        for($x=0; $x -lt 16; $x+=8) {
            Fill-Rect $b ($x+$offset) $y 8 4 ([System.Drawing.Color]::FromArgb(255, (180+($x*3)%40), (180+($y*3)%40), (180+($x*3)%40)))
            # mortar lines
            if($y -gt 0) { Fill-Rect $b 0 $y 16 1 $C.Gray }
        }
    }
    # konoha leaf symbol
    Set-Pixel $b 7 7 $C.DarkGreen; Set-Pixel $b 8 7 $C.DarkGreen
    Set-Pixel $b 7 8 $C.DarkGreen; Set-Pixel $b 8 8 $C.Green
}

# Konoha Planks
New-Texture16 "$texBlocks\konoha_planks.png" {
    param($b,$g)
    Fill-Rect $b 0 0 16 16 $C.LightBrown
    for($y=0; $y -lt 16; $y+=4) {
        $shade = if($y % 8 -eq 0) { $C.Brown } else { $C.LightBrown }
        Fill-Rect $b 0 $y 16 4 $shade
        Fill-Rect $b 0 $y 16 1 ([System.Drawing.Color]::FromArgb(255,160,120,60))
    }
    # wood grain
    Set-Pixel $b 3 2 $C.DarkBrown; Set-Pixel $b 10 6 $C.DarkBrown
    Set-Pixel $b 5 10 $C.DarkBrown; Set-Pixel $b 12 14 $C.DarkBrown
}

# New blocks
# Chakra Ore
New-Texture16 "$texBlocks\chakra_ore.png" {
    param($b,$g)
    Fill-Rect $b 0 0 16 16 $C.Gray
    # stone base
    for($y=0; $y -lt 16; $y+=2) {
        for($x=0; $x -lt 16; $x+=2) {
            $v = 110 + (($x*7+$y*13)%30)
            Set-Pixel $b $x $y ([System.Drawing.Color]::FromArgb(255,$v,$v,$v))
        }
    }
    # cyan crystal deposits
    Fill-Rect $b 2 3 3 3 $C.Cyan; Set-Pixel $b 3 3 $C.White
    Fill-Rect $b 9 7 4 3 $C.Teal; Set-Pixel $b 10 7 $C.Cyan
    Fill-Rect $b 4 11 3 3 $C.Cyan; Set-Pixel $b 5 11 $C.White
    Fill-Rect $b 11 1 3 2 $C.Teal
}

# Chakra Crystal Block
New-Texture16 "$texBlocks\chakra_crystal_block.png" {
    param($b,$g)
    Fill-Rect $b 0 0 16 16 $C.Teal
    Fill-Rect $b 1 1 14 14 $C.Cyan
    Fill-Rect $b 3 3 10 10 ([System.Drawing.Color]::FromArgb(255,100,255,255))
    Fill-Rect $b 5 5 6 6 $C.White
    Set-Pixel $b 4 4 $C.White; Set-Pixel $b 11 4 $C.White
    # crystal facets
    for($i=0; $i -lt 5; $i++) {
        Set-Pixel $b (3+$i) (3+$i) $C.White
        Set-Pixel $b (12-$i) (3+$i) ([System.Drawing.Color]::FromArgb(255,150,255,255))
    }
}

# Ninja Steel Block
New-Texture16 "$texBlocks\ninja_steel_block.png" {
    param($b,$g)
    Fill-Rect $b 0 0 16 16 $C.DarkSteel
    Fill-Rect $b 1 1 14 14 $C.Steel
    Fill-Rect $b 2 2 12 12 $C.LightGray
    # rivets
    Set-Pixel $b 2 2 $C.DarkGray; Set-Pixel $b 13 2 $C.DarkGray
    Set-Pixel $b 2 13 $C.DarkGray; Set-Pixel $b 13 13 $C.DarkGray
    # cross pattern
    Fill-Rect $b 7 1 2 14 $C.DarkSteel
    Fill-Rect $b 1 7 14 2 $C.DarkSteel
    Set-Pixel $b 3 3 $C.White  # gleam
}

# Ramen Shop Counter
New-Texture16 "$texBlocks\ramen_shop_counter.png" {
    param($b,$g)
    Fill-Rect $b 0 0 16 16 $C.Brown
    Fill-Rect $b 0 0 16 3 $C.LightBrown  # top surface
    Fill-Rect $b 1 1 14 1 $C.Tan
    Fill-Rect $b 0 3 16 13 $C.DarkBrown  # front
    # wood panel
    Fill-Rect $b 1 4 14 11 $C.Brown
    for($x=0; $x -lt 16; $x+=4) { Fill-Rect $b $x 3 1 13 $C.DarkBrown }
}

# Scroll Shelf
New-Texture16 "$texBlocks\scroll_shelf.png" {
    param($b,$g)
    Fill-Rect $b 0 0 16 16 $C.DarkBrown  # shelf frame
    Fill-Rect $b 1 1 14 6 $C.Black        # upper shelf
    Fill-Rect $b 1 9 14 6 $C.Black        # lower shelf
    # scrolls on shelves
    Fill-Rect $b 2 2 3 5 $C.Red; Fill-Rect $b 6 2 3 5 $C.Blue
    Fill-Rect $b 10 2 4 5 $C.Green
    Fill-Rect $b 2 10 4 5 $C.Yellow; Fill-Rect $b 7 10 3 5 $C.Purple
    Fill-Rect $b 11 10 3 5 $C.White
}

# Tatami Mat
New-Texture16 "$texBlocks\tatami_mat.png" {
    param($b,$g)
    $base = [System.Drawing.Color]::FromArgb(255,200,180,100)
    $stripe = [System.Drawing.Color]::FromArgb(255,180,160,80)
    Fill-Rect $b 0 0 16 16 $base
    for($y=0; $y -lt 16; $y+=2) { Fill-Rect $b 0 $y 16 1 $stripe }
    Fill-Rect $b 7 0 2 16 $C.DarkBrown  # border
}

# Paper Wall
New-Texture16 "$texBlocks\paper_wall.png" {
    param($b,$g)
    Fill-Rect $b 0 0 16 16 $C.Cream
    Fill-Rect $b 0 0 16 16 ([System.Drawing.Color]::FromArgb(255,245,240,220))
    # wooden frame
    Fill-Rect $b 0 0 1 16 $C.Brown; Fill-Rect $b 15 0 1 16 $C.Brown
    Fill-Rect $b 0 0 16 1 $C.Brown; Fill-Rect $b 0 15 16 1 $C.Brown
    Fill-Rect $b 7 0 2 16 $C.Brown  # center vertical
    Fill-Rect $b 0 7 16 2 $C.Brown  # center horizontal
}

# Red Torii
New-Texture16 "$texBlocks\red_torii.png" {
    param($b,$g)
    Fill-Rect $b 0 0 16 16 $C.Red
    Fill-Rect $b 0 0 16 3 $C.DarkRed  # top beam
    Fill-Rect $b 0 5 16 2 $C.DarkRed  # second beam
    Fill-Rect $b 1 1 14 1 $C.BrightRed  # highlight
    Fill-Rect $b 2 7 3 9 $C.Red        # left pillar
    Fill-Rect $b 11 7 3 9 $C.Red       # right pillar
    Fill-Rect $b 3 0 1 16 $C.DarkRed   # pillar shadow
    Fill-Rect $b 12 0 1 16 $C.DarkRed
}

# Ninja Lamp
New-Texture16 "$texBlocks\ninja_lamp.png" {
    param($b,$g)
    Fill-Rect $b 4 0 8 16 $C.DarkBrown  # frame
    Fill-Rect $b 5 1 6 14 $C.Yellow     # light
    Fill-Rect $b 6 2 4 12 $C.Gold       # warm glow
    Fill-Rect $b 7 4 2 8 $C.White       # bright center
    Set-Pixel $b 7 6 $C.White          # extra bright
    Fill-Rect $b 3 0 10 1 $C.Brown     # top cap
    Fill-Rect $b 3 15 10 1 $C.Brown    # bottom cap
}

# Village Banner Block
New-Texture16 "$texBlocks\village_banner_block.png" {
    param($b,$g)
    Fill-Rect $b 4 0 8 16 $C.Red
    Fill-Rect $b 5 1 6 14 $C.DarkRed
    # Konoha leaf symbol
    Fill-Rect $b 6 4 4 4 $C.White
    Fill-Rect $b 7 3 2 1 $C.White
    Set-Pixel $b 8 8 $C.White
    Set-Pixel $b 7 9 $C.White
    # triangular bottom
    Fill-Rect $b 5 13 6 1 $C.Red
    Fill-Rect $b 6 14 4 1 $C.DarkRed
    Fill-Rect $b 7 15 2 1 $C.Red
}

# Explosive Tag Block
New-Texture16 "$texBlocks\explosive_tag_block.png" {
    param($b,$g)
    Fill-Rect $b 0 0 16 16 $C.Cream
    Fill-Rect $b 1 1 14 14 $C.White
    # warning kanji
    Fill-Rect $b 5 3 6 2 $C.Black
    Fill-Rect $b 7 5 2 4 $C.Black
    Fill-Rect $b 5 9 6 2 $C.Black
    Fill-Rect $b 6 11 4 2 $C.Red
    # border danger marks
    Fill-Rect $b 0 0 16 1 $C.Red; Fill-Rect $b 0 15 16 1 $C.Red
    Fill-Rect $b 0 0 1 16 $C.Red; Fill-Rect $b 15 0 1 16 $C.Red
}

Write-Host "  Block textures done"

# ===== ARMOR LAYER TEXTURES (64x32) =====
$armorLayerSets = @{
    "konoha_armor" = @(@($C.Green, $C.DarkGreen, $C.Blue), @($C.Green, $C.DarkGreen, $C.Blue))
    "akatsuki_armor" = @(@($C.Black, $C.DarkGray, $C.Red), @($C.Black, $C.DarkGray, $C.Red))
    "anbu_armor" = @(@($C.DarkGray, $C.Gray, $C.White), @($C.DarkGray, $C.Gray, $C.White))
    "sage_armor" = @(@($C.Red, $C.DarkRed, $C.Orange), @($C.Red, $C.DarkRed, $C.Orange))
    "hokage_armor" = @(@($C.White, $C.Cream, $C.Red), @($C.White, $C.Cream, $C.Red))
    "sound_armor" = @(@($C.Purple, $C.DarkPurple, $C.Gray), @($C.Purple, $C.DarkPurple, $C.Gray))
}

foreach($aName in $armorLayerSets.Keys) {
    for($layer=1; $layer -le 2; $layer++) {
        $cols = $armorLayerSets[$aName][$layer-1]
        $main = $cols[0]; $dark = $cols[1]; $accent = $cols[2]
        New-ArmorTexture "$texArmor\${aName}_layer_${layer}.png" {
            param($b,$g)
            # Layer 1: helmet + chestplate + boots; Layer 2: leggings
            if($layer -eq 1) {
                # Head (8x8 at 0,0 to various positions)
                Fill-Rect $b 0 0 32 16 $main
                Fill-Rect $b 0 0 64 8 $dark
                Fill-Rect $b 8 0 16 16 $main  # head top+sides
                Fill-Rect $b 40 0 16 16 $main # body
                # Accent stripes
                Fill-Rect $b 8 8 16 1 $accent
                Fill-Rect $b 40 8 16 1 $accent
            } else {
                Fill-Rect $b 0 0 64 32 $main
                Fill-Rect $b 0 0 64 8 $dark
                Fill-Rect $b 0 16 64 1 $accent  # belt line
            }
        }
    }
}
# Remove old broken layer files
if(Test-Path "$texArmor\_layer_1.png") { Remove-Item "$texArmor\_layer_1.png" -Force }
if(Test-Path "$texArmor\_layer_2.png") { Remove-Item "$texArmor\_layer_2.png" -Force }
Write-Host "  Armor layers done"

# ===== ENTITY TEXTURES (64x64) =====
function Draw-HumanoidEntity($path, $skinColor, $hairColor, $shirtColor, $pantsColor, $shoeColor, $accentColor) {
    New-EntityTexture $path {
        param($b,$g)
        # Standard Minecraft skin layout (64x64)
        # Head: top 8x8 at (8,0), front 8x8 at (8,8), sides etc.
        # Body: front 8x12 at (20,20), etc.
        # Arms: 4x12 at (44,20) and (36,52)
        # Legs: 4x12 at (4,20) and (20,52)

        # HEAD skin (top: 8,0 size 8x8, front: 8,8 size 8x8)
        Fill-Rect $b 0 0 32 16 $skinColor
        Fill-Rect $b 8 0 8 8 $hairColor     # head top = hair
        Fill-Rect $b 8 8 8 8 $skinColor     # head front = face

        # Hair on top/sides
        Fill-Rect $b 0 8 8 8 $hairColor     # head right side
        Fill-Rect $b 16 8 8 8 $hairColor    # head left side
        Fill-Rect $b 24 8 8 8 $hairColor    # head back

        # Eyes on face (front at 8,8)
        Set-Pixel $b 10 11 $C.Black
        Set-Pixel $b 13 11 $C.Black

        # BODY (front: 20,20 size 8x12)
        Fill-Rect $b 16 16 24 16 $shirtColor
        Fill-Rect $b 20 20 8 12 $shirtColor  # body front
        # Accent on shirt
        Fill-Rect $b 22 20 4 2 $accentColor

        # RIGHT ARM (44,20 size 4x12)
        Fill-Rect $b 40 16 16 16 $shirtColor
        Fill-Rect $b 44 20 4 12 $skinColor   # arm front - lower part skin
        Fill-Rect $b 44 20 4 6 $shirtColor   # sleeve

        # LEFT ARM (36,52 size 4x12)
        Fill-Rect $b 32 48 16 16 $shirtColor
        Fill-Rect $b 36 52 4 12 $skinColor
        Fill-Rect $b 36 52 4 6 $shirtColor

        # RIGHT LEG (4,20 size 4x12)
        Fill-Rect $b 0 16 16 16 $pantsColor
        Fill-Rect $b 4 20 4 12 $pantsColor
        Fill-Rect $b 4 28 4 4 $shoeColor    # shoes

        # LEFT LEG (20,52 size 4x12)
        Fill-Rect $b 16 48 16 16 $pantsColor
        Fill-Rect $b 20 52 4 12 $pantsColor
        Fill-Rect $b 20 60 4 4 $shoeColor
    }
}

Draw-HumanoidEntity "$texEntity\naruto.png" $C.Skin $C.Yellow $C.Orange $C.Orange $C.Blue $C.Blue
Draw-HumanoidEntity "$texEntity\sasuke.png" $C.Skin $C.DarkBlue $C.White $C.White $C.DarkBlue $C.Purple
Draw-HumanoidEntity "$texEntity\kakashi.png" $C.Skin $C.LightGray $C.DarkGray $C.DarkGray $C.DarkBlue $C.Steel
Draw-HumanoidEntity "$texEntity\sakura.png" $C.Skin $C.Pink $C.Red $C.Pink $C.DarkBlue $C.Red
Draw-HumanoidEntity "$texEntity\hinata.png" $C.Skin $C.DarkBlue $C.Lavender $C.DarkBlue $C.DarkBlue $C.Lavender
Draw-HumanoidEntity "$texEntity\rock_lee.png" $C.Skin $C.Black $C.Green $C.Green $C.DarkGreen $C.Orange
Draw-HumanoidEntity "$texEntity\gaara.png" $C.Skin $C.Red $C.DarkBrown $C.DarkBrown $C.DarkBrown $C.Sand
Draw-HumanoidEntity "$texEntity\itachi.png" $C.Skin $C.Black $C.Black $C.Black $C.Black $C.Red
Draw-HumanoidEntity "$texEntity\jiraiya.png" $C.Skin $C.White $C.DarkGreen $C.DarkGreen $C.DarkGreen $C.Red
Draw-HumanoidEntity "$texEntity\tsunade.png" $C.Skin $C.Yellow $C.LightGray $C.DarkGray $C.DarkBlue $C.Gold

Write-Host "  Entity textures done"

# ===== REMOVE OLD MISNAMED FILES =====
Write-Host "Cleaning up old misnamed files..."
$oldNames = @(
    "akatsuki_armor_boots","akatsuki_armor_chestplate","akatsuki_armor_helmet","akatsuki_armor_leggings",
    "anbu_armor_boots","anbu_armor_chestplate","anbu_armor_helmet","anbu_armor_leggings",
    "sage_armor_boots","sage_armor_chestplate","sage_armor_helmet","sage_armor_leggings",
    "konoha_armor_boots","konoha_armor_chestplate","konoha_armor_helmet","konoha_armor_leggings",
    "textura_armadura_roxa_escura"
)
foreach($old in $oldNames) {
    $f = "$texItems\$old.png"; if(Test-Path $f) { Remove-Item $f -Force }
    $f = "$models\$old.json"; if(Test-Path $f) { Remove-Item $f -Force }
}
Write-Host "  Cleanup done"

Write-Host "`nAll textures generated!"
Write-Host "Total texture files created."
