# =====================================================
# NARUTO MOD COMPLETE TEXTURE GENERATOR
# Generates ALL textures for the Projetokonoha mod
# =====================================================
Add-Type -AssemblyName System.Drawing

$base = "C:\Users\andra\MCreatorWorkspaces\projetokonoha\src\main\resources\assets\projetokonoha"
$itemDir  = "$base\textures\items"
$blockDir = "$base\textures\blocks"
$armorDir = "$base\textures\models\armor"
$entityDir = "$base\textures\entity"

# Create directories
foreach ($d in @($itemDir, $blockDir, $armorDir, $entityDir)) {
    if (!(Test-Path $d)) { New-Item -ItemType Directory -Path $d -Force | Out-Null }
}

# ============= COLOR DEFINITIONS =============
function C([int]$r,[int]$g,[int]$b){ return [System.Drawing.Color]::FromArgb(255,$r,$g,$b) }

# Naruto palette
$script:orange      = C 255 140 0
$script:darkOrange   = C 200 100 0
$script:gold         = C 255 215 0
$script:blue         = C 30 144 255
$script:darkBlue     = C 25 25 112
$script:navyBlue     = C 0 0 128
$script:red          = C 200 30 30
$script:darkRed      = C 139 0 0
$script:crimson      = C 220 20 60
$script:green        = C 34 139 34
$script:darkGreen    = C 0 100 0
$script:pink         = C 255 105 180
$script:hotPink      = C 255 20 147
$script:lightPink    = C 255 182 193
$script:purple       = C 128 0 128
$script:darkPurple   = C 75 0 130
$script:white        = C 255 255 255
$script:lightGray    = C 192 192 192
$script:gray         = C 128 128 128
$script:darkGray     = C 64 64 64
$script:black        = C 0 0 0
$script:brown        = C 139 69 19
$script:darkBrown    = C 100 50 10
$script:leather      = C 160 120 60
$script:steel        = C 180 180 200
$script:silver       = C 200 200 210
$script:skyBlue      = C 135 206 235
$script:cyan         = C 0 200 200
$script:yellow       = C 255 255 0
$script:tan          = C 210 180 140
$script:skin         = C 255 220 180
$script:darkSkin     = C 220 185 145
$script:transparent  = [System.Drawing.Color]::FromArgb(0,0,0,0)

# ============= HELPER FUNCTIONS =============
function New-Tex([int]$w,[int]$h) {
    $bmp = New-Object System.Drawing.Bitmap($w,$h)
    $bmp.SetResolution(72,72)
    return $bmp
}

function Fill-Rect($bmp,$x,$y,$w,$h,$color) {
    for ($py=$y; $py -lt ($y+$h); $py++) {
        for ($px=$x; $px -lt ($x+$w); $px++) {
            if ($px -ge 0 -and $px -lt $bmp.Width -and $py -ge 0 -and $py -lt $bmp.Height) {
                $bmp.SetPixel($px,$py,$color)
            }
        }
    }
}

function Set-Px($bmp,$x,$y,$color) {
    if ($x -ge 0 -and $x -lt $bmp.Width -and $y -ge 0 -and $y -lt $bmp.Height) {
        $bmp.SetPixel($x,$y,$color)
    }
}

function Save-Png($bmp,$path) {
    $bmp.Save($path, [System.Drawing.Imaging.ImageFormat]::Png)
    $bmp.Dispose()
    Write-Host "  Created: $path"
}

function Add-Noise($bmp,$intensity) {
    $rand = New-Object System.Random(42)
    for ($y=0; $y -lt $bmp.Height; $y++) {
        for ($x=0; $x -lt $bmp.Width; $x++) {
            $c = $bmp.GetPixel($x,$y)
            if ($c.A -gt 0) {
                $n = $rand.Next(-$intensity,$intensity)
                $nr = [Math]::Max(0,[Math]::Min(255,$c.R+$n))
                $ng = [Math]::Max(0,[Math]::Min(255,$c.G+$n))
                $nb = [Math]::Max(0,[Math]::Min(255,$c.B+$n))
                $bmp.SetPixel($x,$y,(C $nr $ng $nb))
            }
        }
    }
}

function Draw-Border($bmp,$color,[int]$thick=1) {
    for ($t=0; $t -lt $thick; $t++) {
        for ($x=$t; $x -lt ($bmp.Width-$t); $x++) {
            Set-Px $bmp $x $t $color
            Set-Px $bmp $x ($bmp.Height-1-$t) $color
        }
        for ($y=$t; $y -lt ($bmp.Height-$t); $y++) {
            Set-Px $bmp $t $y $color
            Set-Px $bmp ($bmp.Width-1-$t) $y $color
        }
    }
}

# ============= ITEM TEXTURES (16x16) =============
Write-Host "=== Generating Item Textures ==="

# KUNAI
$bmp = New-Tex 16 16
Fill-Rect $bmp 7 1 2 3 $script:steel       # blade tip
Fill-Rect $bmp 7 4 2 4 $script:silver       # blade body
Fill-Rect $bmp 6 4 1 3 $script:gray         # blade edge left
Fill-Rect $bmp 9 4 1 3 $script:gray         # blade edge right
Fill-Rect $bmp 7 8 2 1 $script:darkGray     # guard
Fill-Rect $bmp 6 8 4 1 $script:darkGray     # guard wide
Fill-Rect $bmp 7 9 2 4 $script:brown        # handle
Fill-Rect $bmp 7 13 2 1 $script:darkBrown   # pommel
Set-Px $bmp 6 13 $script:red                # ring
Set-Px $bmp 9 13 $script:red                # ring
Add-Noise $bmp 10
Save-Png $bmp "$itemDir\kunai.png"

# SHURIKEN
$bmp = New-Tex 16 16
Fill-Rect $bmp 7 7 2 2 $script:darkGray     # center hub
# Four blades
Fill-Rect $bmp 3 7 4 2 $script:steel        # left blade
Fill-Rect $bmp 9 7 4 2 $script:steel        # right blade
Fill-Rect $bmp 7 3 2 4 $script:steel        # top blade
Fill-Rect $bmp 7 9 2 4 $script:steel        # bottom blade
# Points
Set-Px $bmp 2 6 $script:silver; Set-Px $bmp 2 9 $script:silver
Set-Px $bmp 13 6 $script:silver; Set-Px $bmp 13 9 $script:silver
Set-Px $bmp 6 2 $script:silver; Set-Px $bmp 9 2 $script:silver
Set-Px $bmp 6 13 $script:silver; Set-Px $bmp 9 13 $script:silver
# Center hole
Set-Px $bmp 7 7 $script:black; Set-Px $bmp 8 8 $script:black
Add-Noise $bmp 8
Save-Png $bmp "$itemDir\shuriken.png"

# KATANA
$bmp = New-Tex 16 16
Fill-Rect $bmp 3 1 2 1 $script:white        # tip
Fill-Rect $bmp 4 2 2 2 $script:silver       # blade upper
Fill-Rect $bmp 5 4 2 3 $script:steel        # blade mid
Fill-Rect $bmp 6 7 2 2 $script:silver       # blade lower
Fill-Rect $bmp 7 9 2 1 $script:gold         # tsuba (guard)
Fill-Rect $bmp 6 9 4 1 $script:gold         # tsuba wide
Fill-Rect $bmp 7 10 2 3 $script:darkPurple  # handle wrap
Fill-Rect $bmp 8 13 2 2 $script:darkBrown   # handle end
Set-Px $bmp 7 11 $script:gold               # diamond wrap
Set-Px $bmp 8 12 $script:gold               # diamond wrap
Add-Noise $bmp 8
Save-Png $bmp "$itemDir\katana.png"

# EXPLOSIVE KUNAI
$bmp = New-Tex 16 16
Fill-Rect $bmp 7 3 2 3 $script:steel        # blade
Fill-Rect $bmp 6 3 1 2 $script:gray         # edge
Fill-Rect $bmp 9 3 1 2 $script:gray         # edge
Fill-Rect $bmp 7 6 2 1 $script:darkGray     # guard
Fill-Rect $bmp 7 7 2 3 $script:brown        # handle
# Explosive tag
Fill-Rect $bmp 5 10 6 4 $script:tan         # paper tag
Fill-Rect $bmp 6 11 4 2 $script:red         # kanji
Set-Px $bmp 7 11 $script:darkRed; Set-Px $bmp 8 12 $script:darkRed
# Fuse
Set-Px $bmp 8 14 $script:yellow; Set-Px $bmp 9 15 $script:orange
Add-Noise $bmp 10
Save-Png $bmp "$itemDir\explosive_kunai.png"

# SENBON
$bmp = New-Tex 16 16
Fill-Rect $bmp 7 1 2 1 $script:white        # tip
Fill-Rect $bmp 7 2 2 12 $script:silver      # needle body
Fill-Rect $bmp 7 14 2 1 $script:steel       # tail
Set-Px $bmp 6 14 $script:lightGray          # fletch
Set-Px $bmp 9 14 $script:lightGray          # fletch
Add-Noise $bmp 6
Save-Png $bmp "$itemDir\senbon.png"

# BLANK SCROLL
$bmp = New-Tex 16 16
Fill-Rect $bmp 3 3 10 10 $script:tan        # paper body
Fill-Rect $bmp 3 3 10 1 $script:brown       # top rod
Fill-Rect $bmp 3 12 10 1 $script:brown      # bottom rod
Fill-Rect $bmp 2 3 1 10 $script:darkBrown   # left knob
Fill-Rect $bmp 13 3 1 10 $script:darkBrown  # right knob
# Lines on scroll
for ($y=5; $y -le 10; $y+=2) {
    Fill-Rect $bmp 5 $y 6 1 $script:darkBrown
}
Add-Noise $bmp 8
Save-Png $bmp "$itemDir\blank_scroll.png"

# Function to create colored scroll
function Make-Scroll($name, $mainColor, $accentColor) {
    $bmp = New-Tex 16 16
    Fill-Rect $bmp 3 3 10 10 $script:tan        # paper
    Fill-Rect $bmp 3 3 10 1 $mainColor           # top rod
    Fill-Rect $bmp 3 12 10 1 $mainColor          # bottom rod
    Fill-Rect $bmp 2 3 1 10 $accentColor         # left knob
    Fill-Rect $bmp 13 3 1 10 $accentColor        # right knob
    # Symbol in center
    Fill-Rect $bmp 6 6 4 4 $mainColor
    Set-Px $bmp 7 7 $accentColor; Set-Px $bmp 8 8 $accentColor
    Set-Px $bmp 7 8 $mainColor; Set-Px $bmp 8 7 $mainColor
    Add-Noise $bmp 8
    Save-Png $bmp "$itemDir\${name}_scroll.png"
}

# Create all jutsu scrolls
Make-Scroll "rasengan" $script:blue $script:skyBlue
Make-Scroll "chidori" $script:skyBlue $script:white
Make-Scroll "fireball" $script:red $script:orange
Make-Scroll "water_dragon" $script:darkBlue $script:cyan
Make-Scroll "wind_blade" $script:lightGray $script:white
Make-Scroll "earth_wall" $script:brown $script:darkBrown
Make-Scroll "shadow_clone" $script:darkGray $script:gray
Make-Scroll "healing" $script:green $script:yellow
Make-Scroll "substitution" $script:darkGreen $script:brown
Make-Scroll "body_flicker" $script:yellow $script:gold

# RAMEN
$bmp = New-Tex 16 16
Fill-Rect $bmp 3 7 10 6 $script:white       # bowl
Fill-Rect $bmp 4 6 8 1 $script:lightGray    # rim
Fill-Rect $bmp 2 7 1 5 $script:lightGray    # side
Fill-Rect $bmp 13 7 1 5 $script:lightGray   # side
Fill-Rect $bmp 4 8 8 4 (C 255 200 100)      # broth
Fill-Rect $bmp 5 8 3 1 $script:tan          # noodles
Fill-Rect $bmp 8 9 3 1 $script:tan          # noodles
Fill-Rect $bmp 5 10 2 1 $script:tan         # noodles
# Toppings
Set-Px $bmp 6 8 $script:pink                # narutomaki
Set-Px $bmp 7 9 $script:green               # green onion
Set-Px $bmp 9 8 $script:darkRed             # chashu
Set-Px $bmp 10 9 $script:yellow             # egg
# Chopsticks
Set-Px $bmp 4 4 $script:brown; Set-Px $bmp 5 5 $script:brown; Set-Px $bmp 6 6 $script:brown
Set-Px $bmp 10 4 $script:brown; Set-Px $bmp 9 5 $script:brown; Set-Px $bmp 8 6 $script:brown
# Steam
Set-Px $bmp 6 3 $script:lightGray; Set-Px $bmp 8 2 $script:lightGray; Set-Px $bmp 10 3 $script:lightGray
Add-Noise $bmp 6
Save-Png $bmp "$itemDir\ramen.png"

# SOLDIER PILL
$bmp = New-Tex 16 16
Fill-Rect $bmp 5 5 6 6 $script:darkGreen    # pill body
Fill-Rect $bmp 6 4 4 1 $script:green        # top curve
Fill-Rect $bmp 6 11 4 1 $script:green       # bottom curve
Set-Px $bmp 7 6 (C 100 200 100)             # highlight
Set-Px $bmp 8 7 (C 100 200 100)             # highlight
Fill-Rect $bmp 7 7 2 2 $script:yellow       # center glow
Add-Noise $bmp 8
Save-Png $bmp "$itemDir\soldier_pill.png"

# RICE BALL
$bmp = New-Tex 16 16
# Triangle shape
Fill-Rect $bmp 5 4 6 2 $script:white
Fill-Rect $bmp 4 6 8 2 $script:white
Fill-Rect $bmp 3 8 10 2 $script:white
Fill-Rect $bmp 4 10 8 2 $script:white
# Nori wrap
Fill-Rect $bmp 4 9 8 3 $script:darkGreen
# Rice texture
Set-Px $bmp 6 5 $script:lightGray; Set-Px $bmp 8 6 $script:lightGray
Set-Px $bmp 5 7 $script:lightGray; Set-Px $bmp 9 7 $script:lightGray
Add-Noise $bmp 6
Save-Png $bmp "$itemDir\rice_ball.png"

# DANGO
$bmp = New-Tex 16 16
# Stick
Fill-Rect $bmp 7 2 2 12 $script:brown
# Three dango balls
Fill-Rect $bmp 5 3 6 3 $script:pink          # top ball
Fill-Rect $bmp 5 7 6 3 $script:white         # middle ball
Fill-Rect $bmp 5 11 6 3 $script:green        # bottom ball
# Highlights
Set-Px $bmp 6 4 $script:hotPink; Set-Px $bmp 6 8 $script:lightGray; Set-Px $bmp 6 12 $script:darkGreen
Add-Noise $bmp 6
Save-Png $bmp "$itemDir\dango.png"

# CHAKRA FRUIT
$bmp = New-Tex 16 16
Fill-Rect $bmp 5 3 6 8 $script:purple       # fruit body
Fill-Rect $bmp 4 5 1 4 $script:darkPurple   # left curve
Fill-Rect $bmp 11 5 1 4 $script:darkPurple  # right curve
Fill-Rect $bmp 6 2 4 1 $script:darkGreen    # stem
Set-Px $bmp 7 1 $script:green               # leaf
Set-Px $bmp 8 1 $script:green               # leaf
# Glow pattern
Set-Px $bmp 6 5 $script:skyBlue; Set-Px $bmp 9 7 $script:skyBlue
Set-Px $bmp 7 8 $script:cyan; Set-Px $bmp 8 6 $script:cyan
# Inner glow
Fill-Rect $bmp 7 6 2 2 (C 180 130 255)
Add-Noise $bmp 8
Save-Png $bmp "$itemDir\chakra_fruit.png"

# ============= ARMOR ITEM ICONS =============
Write-Host "=== Generating Armor Item Icons ==="

function Make-ArmorIcon($name, $mainColor, $accentColor, $trimColor) {
    # Helmet
    $bmp = New-Tex 16 16
    Fill-Rect $bmp 3 3 10 8 $mainColor
    Fill-Rect $bmp 4 2 8 1 $mainColor
    Fill-Rect $bmp 4 11 8 2 $accentColor
    Fill-Rect $bmp 5 5 6 4 $script:darkGray      # visor
    Set-Px $bmp 7 3 $trimColor; Set-Px $bmp 8 3 $trimColor  # forehead protector
    Draw-Border $bmp $script:darkGray
    Add-Noise $bmp 8
    Save-Png $bmp "$itemDir\${name}_helmet.png"

    # Chestplate
    $bmp = New-Tex 16 16
    Fill-Rect $bmp 2 2 12 11 $mainColor
    Fill-Rect $bmp 6 2 4 3 $accentColor           # collar
    Fill-Rect $bmp 2 2 3 8 $accentColor            # left shoulder
    Fill-Rect $bmp 11 2 3 8 $accentColor           # right shoulder
    Fill-Rect $bmp 5 7 6 3 $trimColor              # chest plate center
    Draw-Border $bmp $script:darkGray
    Add-Noise $bmp 8
    Save-Png $bmp "$itemDir\${name}_chestplate.png"

    # Leggings
    $bmp = New-Tex 16 16
    Fill-Rect $bmp 3 2 10 5 $mainColor             # waist
    Fill-Rect $bmp 3 7 4 7 $mainColor              # left leg
    Fill-Rect $bmp 9 7 4 7 $mainColor              # right leg
    Fill-Rect $bmp 3 2 10 2 $accentColor           # belt
    Set-Px $bmp 7 3 $trimColor; Set-Px $bmp 8 3 $trimColor  # belt buckle
    Draw-Border $bmp $script:darkGray
    Add-Noise $bmp 8
    Save-Png $bmp "$itemDir\${name}_leggings.png"

    # Boots
    $bmp = New-Tex 16 16
    Fill-Rect $bmp 3 4 4 8 $mainColor              # left boot
    Fill-Rect $bmp 9 4 4 8 $mainColor              # right boot
    Fill-Rect $bmp 2 10 5 3 $accentColor            # left sole
    Fill-Rect $bmp 9 10 5 3 $accentColor            # right sole
    Fill-Rect $bmp 3 4 4 2 $trimColor               # left cuff
    Fill-Rect $bmp 9 4 4 2 $trimColor               # right cuff
    Draw-Border $bmp $script:darkGray
    Add-Noise $bmp 8
    Save-Png $bmp "$itemDir\${name}_boots.png"
}

# Konoha armor icons
Make-ArmorIcon "konoha_armor" $script:darkGreen $script:green $script:gold

# Akatsuki armor icons
Make-ArmorIcon "akatsuki_armor" $script:black $script:darkRed $script:red

# ANBU armor icons
Make-ArmorIcon "anbu_armor" $script:darkGray $script:gray $script:white

# Sage armor icons
Make-ArmorIcon "sage_armor" $script:orange $script:red $script:darkRed

# ============= ARMOR LAYER TEXTURES (64x32) =============
Write-Host "=== Generating Armor Layer Textures ==="

function Make-ArmorLayers($name, $mainColor, $accentColor, $trimColor) {
    # Layer 1 (head, chest, right arm, left arm, right leg, left leg)
    $bmp = New-Tex 64 32
    # Head (0,0)-(32,16) area - 8x8 face
    Fill-Rect $bmp 0 0 32 16 $mainColor
    # Face opening
    Fill-Rect $bmp 8 8 8 8 $accentColor
    # Body (16,16)-(40,32) area - 8x12 torso
    Fill-Rect $bmp 16 16 24 16 $mainColor
    Fill-Rect $bmp 20 20 8 8 $accentColor   # chest symbol
    # Right arm (40,16)-(56,32) - 4x12
    Fill-Rect $bmp 40 16 16 16 $mainColor
    # Trim accents
    Fill-Rect $bmp 0 0 32 2 $trimColor      # hat brim
    Fill-Rect $bmp 16 16 24 2 $trimColor    # shoulder line
    Add-Noise $bmp 12
    Save-Png $bmp "$armorDir\${name}_layer_1.png"

    # Layer 2 (legs)
    $bmp = New-Tex 64 32
    # Leg area
    Fill-Rect $bmp 0 16 16 16 $mainColor     # right leg
    Fill-Rect $bmp 0 16 16 2 $accentColor    # belt
    # Left leg (mirrored)
    Fill-Rect $bmp 16 16 16 16 $mainColor
    Fill-Rect $bmp 16 16 16 2 $accentColor
    Add-Noise $bmp 12
    Save-Png $bmp "$armorDir\${name}_layer_2.png"
}

# Already have konoha_armor from before, but regenerate for consistency
Make-ArmorLayers "konoha_armor" $script:darkGreen $script:green $script:gold
Make-ArmorLayers "akatsuki_armor" $script:black $script:darkRed $script:red
Make-ArmorLayers "anbu_armor" $script:darkGray $script:gray $script:white
Make-ArmorLayers "sage_armor" $script:orange $script:darkRed $script:red

# ============= BLOCK TEXTURES (16x16) =============
Write-Host "=== Generating Block Textures ==="

# TRAINING DUMMY
$bmp = New-Tex 16 16
Fill-Rect $bmp 0 0 16 16 $script:brown       # wood background
Fill-Rect $bmp 6 1 4 3 $script:tan           # head
Fill-Rect $bmp 5 4 6 6 $script:leather       # body
Fill-Rect $bmp 3 5 2 5 $script:leather       # left arm
Fill-Rect $bmp 11 5 2 5 $script:leather      # right arm
Fill-Rect $bmp 6 10 2 4 $script:darkBrown    # left leg
Fill-Rect $bmp 8 10 2 4 $script:darkBrown    # right leg
# Target circles on body
Set-Px $bmp 7 6 $script:red; Set-Px $bmp 8 7 $script:red
Set-Px $bmp 7 7 $script:darkRed; Set-Px $bmp 8 6 $script:darkRed
Add-Noise $bmp 10
Save-Png $bmp "$blockDir\training_dummy.png"

# CHAKRA ALTAR
$bmp = New-Tex 16 16
Fill-Rect $bmp 0 0 16 16 (C 40 40 60)        # dark stone base
Fill-Rect $bmp 2 2 12 12 (C 50 50 80)        # inner stone
# Chakra glow pattern
Fill-Rect $bmp 6 6 4 4 $script:cyan
Set-Px $bmp 7 3 $script:blue; Set-Px $bmp 8 3 $script:blue
Set-Px $bmp 3 7 $script:blue; Set-Px $bmp 3 8 $script:blue
Set-Px $bmp 12 7 $script:blue; Set-Px $bmp 12 8 $script:blue
Set-Px $bmp 7 12 $script:blue; Set-Px $bmp 8 12 $script:blue
# Cross pattern
Fill-Rect $bmp 7 4 2 8 (C 80 150 255)       # vertical glow
Fill-Rect $bmp 4 7 8 2 (C 80 150 255)       # horizontal glow
# Center bright
Set-Px $bmp 7 7 $script:white; Set-Px $bmp 8 8 $script:white
Add-Noise $bmp 8
Save-Png $bmp "$blockDir\chakra_altar.png"

# KONOHA STONE
$bmp = New-Tex 16 16
Fill-Rect $bmp 0 0 16 16 (C 160 150 140)     # stone base
# Brick pattern
for ($y = 0; $y -lt 16; $y += 4) {
    Fill-Rect $bmp 0 $y 16 1 (C 130 120 110) # horizontal mortar
    $offset = if ($y % 8 -eq 0) { 0 } else { 4 }
    for ($x = $offset; $x -lt 16; $x += 8) {
        Fill-Rect $bmp $x $y 1 4 (C 130 120 110) # vertical mortar
    }
}
# Konoha leaf symbol
Set-Px $bmp 7 6 $script:darkGreen; Set-Px $bmp 8 6 $script:darkGreen
Set-Px $bmp 7 7 $script:green; Set-Px $bmp 8 7 $script:green
Set-Px $bmp 6 8 $script:darkGreen; Set-Px $bmp 9 8 $script:darkGreen
Add-Noise $bmp 8
Save-Png $bmp "$blockDir\konoha_stone.png"

# KONOHA PLANKS
$bmp = New-Tex 16 16
Fill-Rect $bmp 0 0 16 16 (C 180 140 90)      # wood base
# Plank lines
for ($y = 0; $y -lt 16; $y += 4) {
    Fill-Rect $bmp 0 $y 16 1 (C 150 110 60)
}
# Wood grain
for ($x = 0; $x -lt 16; $x += 3) {
    Set-Px $bmp $x 2 (C 160 120 70)
    Set-Px $bmp $x 6 (C 170 130 80)
    Set-Px $bmp $x 10 (C 160 120 70)
    Set-Px $bmp $x 14 (C 170 130 80)
}
Add-Noise $bmp 10
Save-Png $bmp "$blockDir\konoha_planks.png"

# ============= ENTITY TEXTURES (64x64) =============
Write-Host "=== Generating Entity Textures ==="

function Make-EntityBase($bmp, $skinColor, $hairColor, $topColor, $pantsColor, $shoeColor) {
    # Standard Minecraft player skin layout (64x64)
    # Head: top(8,0,8x8), bottom(16,0,8x8), right(0,8,8x8), front(8,8,8x8), left(16,8,8x8), back(24,8,8x8)

    # HEAD - top
    Fill-Rect $bmp 8 0 8 8 $hairColor
    # HEAD - bottom (chin)
    Fill-Rect $bmp 16 0 8 8 $skinColor
    # HEAD - right side
    Fill-Rect $bmp 0 8 8 8 $skinColor
    Fill-Rect $bmp 0 8 8 3 $hairColor          # hair on side
    # HEAD - front face
    Fill-Rect $bmp 8 8 8 8 $skinColor
    Fill-Rect $bmp 8 8 8 2 $hairColor           # bangs
    # Eyes
    Set-Px $bmp 10 12 $script:black; Set-Px $bmp 13 12 $script:black  # eyes
    Set-Px $bmp 11 14 $script:darkSkin           # mouth
    Set-Px $bmp 12 14 $script:darkSkin
    # HEAD - left side
    Fill-Rect $bmp 16 8 8 8 $skinColor
    Fill-Rect $bmp 16 8 8 3 $hairColor
    # HEAD - back
    Fill-Rect $bmp 24 8 8 8 $hairColor

    # BODY (upper) - right(16,20,4x12), front(20,20,8x12), left(28,20,4x12), back(32,20,8x12)
    # Top of body
    Fill-Rect $bmp 20 16 8 4 $topColor
    # Right side
    Fill-Rect $bmp 16 20 4 12 $topColor
    # Front
    Fill-Rect $bmp 20 20 8 12 $topColor
    # Left side
    Fill-Rect $bmp 28 20 4 12 $topColor
    # Back
    Fill-Rect $bmp 32 20 8 12 $topColor

    # RIGHT ARM - (40,16) top, (44,20) right(4x12), (40,20) front(4x12), (48,20) left(4x12), (52,20) back(4x12)
    Fill-Rect $bmp 44 16 4 4 $topColor           # arm top
    Fill-Rect $bmp 44 20 4 12 $topColor          # right
    Fill-Rect $bmp 40 20 4 12 $topColor          # front
    Fill-Rect $bmp 48 20 4 12 $topColor          # left
    Fill-Rect $bmp 52 20 4 12 $topColor          # back
    # Hands
    Fill-Rect $bmp 44 28 4 4 $skinColor
    Fill-Rect $bmp 40 28 4 4 $skinColor
    Fill-Rect $bmp 48 28 4 4 $skinColor
    Fill-Rect $bmp 52 28 4 4 $skinColor

    # RIGHT LEG - (0,16) top(4x4), right(4,20,4x12), front(0,20,4x12), left(8,20,4x12), back(12,20,4x12)
    # Actually in 64x64 format, legs are at different positions
    # Leg area (0,16)
    Fill-Rect $bmp 4 16 4 4 $pantsColor  # leg top
    Fill-Rect $bmp 4 20 4 12 $pantsColor # right
    Fill-Rect $bmp 0 20 4 12 $pantsColor # front
    Fill-Rect $bmp 8 20 4 12 $pantsColor # left
    Fill-Rect $bmp 12 20 4 12 $pantsColor # back
    # Shoes
    Fill-Rect $bmp 4 28 4 4 $shoeColor
    Fill-Rect $bmp 0 28 4 4 $shoeColor
    Fill-Rect $bmp 8 28 4 4 $shoeColor
    Fill-Rect $bmp 12 28 4 4 $shoeColor

    # LEFT ARM (mirror) - starts at (32,48) in 64x64
    Fill-Rect $bmp 36 48 4 4 $topColor
    Fill-Rect $bmp 36 52 4 12 $topColor
    Fill-Rect $bmp 32 52 4 12 $topColor
    Fill-Rect $bmp 40 52 4 12 $topColor
    Fill-Rect $bmp 44 52 4 12 $topColor
    Fill-Rect $bmp 36 60 4 4 $skinColor
    Fill-Rect $bmp 32 60 4 4 $skinColor
    Fill-Rect $bmp 40 60 4 4 $skinColor
    Fill-Rect $bmp 44 60 4 4 $skinColor

    # LEFT LEG (mirror) - starts at (16,48) in 64x64
    Fill-Rect $bmp 20 48 4 4 $pantsColor
    Fill-Rect $bmp 20 52 4 12 $pantsColor
    Fill-Rect $bmp 16 52 4 12 $pantsColor
    Fill-Rect $bmp 24 52 4 12 $pantsColor
    Fill-Rect $bmp 28 52 4 12 $pantsColor
    Fill-Rect $bmp 20 60 4 4 $shoeColor
    Fill-Rect $bmp 16 60 4 4 $shoeColor
    Fill-Rect $bmp 24 60 4 4 $shoeColor
    Fill-Rect $bmp 28 60 4 4 $shoeColor
}

# NARUTO
$bmp = New-Tex 64 64
Make-EntityBase $bmp $script:skin $script:gold $script:orange (C 255 120 0) $script:blue
# Naruto-specific details: whisker marks on face
Set-Px $bmp 9 13 $script:darkSkin; Set-Px $bmp 10 13 $script:darkSkin; Set-Px $bmp 11 13 $script:darkSkin  # left whiskers
Set-Px $bmp 12 13 $script:darkSkin; Set-Px $bmp 13 13 $script:darkSkin; Set-Px $bmp 14 13 $script:darkSkin # right whiskers
# Headband (blue on forehead)
Fill-Rect $bmp 8 10 8 1 $script:blue
Set-Px $bmp 11 10 $script:steel; Set-Px $bmp 12 10 $script:steel  # metal plate
# Konoha symbol on chest
Set-Px $bmp 23 23 $script:red; Set-Px $bmp 24 23 $script:red
# Zipper line
for ($y = 20; $y -le 31; $y++) { Set-Px $bmp 24 $y $script:darkGray }
Add-Noise $bmp 8
Save-Png $bmp "$entityDir\naruto.png"

# SASUKE
$bmp = New-Tex 64 64
Make-EntityBase $bmp $script:skin $script:darkBlue $script:navyBlue $script:white (C 60 60 80)
# Sasuke hair - spiky back
Fill-Rect $bmp 24 8 8 4 $script:black
# Uchiha fan on back
Set-Px $bmp 35 23 $script:red; Set-Px $bmp 36 23 $script:red
Set-Px $bmp 35 24 $script:white; Set-Px $bmp 36 24 $script:white
# Headband
Fill-Rect $bmp 8 10 8 1 $script:darkBlue
Set-Px $bmp 11 10 $script:steel; Set-Px $bmp 12 10 $script:steel
# Rope belt
Fill-Rect $bmp 20 25 8 1 $script:purple
Add-Noise $bmp 8
Save-Png $bmp "$entityDir\sasuke.png"

# KAKASHI
$bmp = New-Tex 64 64
Make-EntityBase $bmp $script:skin $script:silver $script:darkGreen $script:darkGray (C 50 50 60)
# Kakashi mask (covers lower face)
Fill-Rect $bmp 8 13 8 3 $script:darkGray
# Silver hair spiky
Fill-Rect $bmp 8 8 8 3 $script:silver
Fill-Rect $bmp 10 7 4 1 $script:lightGray   # hair sticks up
# Headband tilted (covering left eye)
Fill-Rect $bmp 8 10 8 1 $script:darkBlue
Set-Px $bmp 10 11 $script:red               # Sharingan eye
Set-Px $bmp 11 10 $script:steel; Set-Px $bmp 12 10 $script:steel
# Vest front
Fill-Rect $bmp 20 20 8 6 (C 60 90 60)
Add-Noise $bmp 8
Save-Png $bmp "$entityDir\kakashi.png"

# SAKURA
$bmp = New-Tex 64 64
Make-EntityBase $bmp $script:skin $script:pink $script:red $script:darkGray (C 50 50 60)
# Pink hair longer
Fill-Rect $bmp 0 8 8 6 $script:pink         # right side longer
Fill-Rect $bmp 16 8 8 6 $script:pink        # left side longer
Fill-Rect $bmp 24 8 8 6 $script:hotPink     # back longer
# Headband
Fill-Rect $bmp 8 10 8 1 $script:red
Set-Px $bmp 11 10 $script:steel; Set-Px $bmp 12 10 $script:steel
# Medical cross on top
Set-Px $bmp 23 22 $script:white; Set-Px $bmp 24 21 $script:white
Set-Px $bmp 24 22 $script:white; Set-Px $bmp 24 23 $script:white
Set-Px $bmp 25 22 $script:white
# Green eyes
Set-Px $bmp 10 12 $script:green; Set-Px $bmp 13 12 $script:green
Add-Noise $bmp 8
Save-Png $bmp "$entityDir\sakura.png"

Write-Host ""
Write-Host "=== ALL TEXTURES GENERATED SUCCESSFULLY ==="
$total = (Get-ChildItem -Path "$base\textures" -Recurse -Filter "*.png" | Measure-Object).Count
$totalSize = (Get-ChildItem -Path "$base\textures" -Recurse -Filter "*.png" | Measure-Object -Property Length -Sum).Sum
Write-Host "Total texture files: $total"
Write-Host "Total texture size: $([Math]::Round($totalSize/1024,1)) KB"
