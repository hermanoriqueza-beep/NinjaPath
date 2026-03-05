# =====================================================
# MASTER NPC TEXTURE GENERATOR - NaruCraft: Shinobi Path
# Generates 128x128 HD textures for 55 NPCs
# Quality: Material-specific noise, mandatory facial detail,
# hitai-ate village symbols, 3+ unique identifying details each
# =====================================================
Add-Type -AssemblyName System.Drawing

$base = "C:\Users\andra\MCreatorWorkspaces\projetokonoha\src\main\resources\assets\projetokonoha"
$entityDir = "$base\textures\entity"

if (!(Test-Path $entityDir)) { New-Item -ItemType Directory -Path $entityDir -Force | Out-Null }

function C([int]$r,[int]$g,[int]$b){ return [System.Drawing.Color]::FromArgb(255,$r,$g,$b) }

function Save-Png($bmp,$path) {
    $bmp.Save($path, [System.Drawing.Imaging.ImageFormat]::Png)
    $bmp.Dispose()
    Write-Host "  Created: $(Split-Path $path -Leaf) ($([Math]::Round((Get-Item $path).Length/1024,1)) KB)"
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

# Material-specific noise ranges: skin 6-12, hair 10-18, fabric 8-14, metal 3-6, leather 5-10
function Fill-Skin($bmp,$x,$y,$w,$h,$baseColor) { Fill-Noisy $bmp $x $y $w $h $baseColor 8 }
function Fill-Hair($bmp,$x,$y,$w,$h,$baseColor) { Fill-Noisy $bmp $x $y $w $h $baseColor 14 }
function Fill-Fabric($bmp,$x,$y,$w,$h,$baseColor) { Fill-Noisy $bmp $x $y $w $h $baseColor 10 }
function Fill-Metal($bmp,$x,$y,$w,$h,$baseColor) { Fill-Noisy $bmp $x $y $w $h $baseColor 4 }
function Fill-Leather($bmp,$x,$y,$w,$h,$baseColor) { Fill-Noisy $bmp $x $y $w $h $baseColor 7 }

function Fill-Noisy($bmp,$x,$y,$w,$h,$baseColor,$variation) {
    $rand = New-Object System.Random(($x*1000+$y*100+$w*10+$h))
    for ($py=$y; $py -lt ($y+$h); $py++) {
        for ($px=$x; $px -lt ($x+$w); $px++) {
            if ($px -ge 0 -and $px -lt $bmp.Width -and $py -ge 0 -and $py -lt $bmp.Height) {
                $n = $rand.Next(-$variation,$variation)
                $nr = [Math]::Max(0,[Math]::Min(255,$baseColor.R+$n))
                $ng = [Math]::Max(0,[Math]::Min(255,$baseColor.G+$n))
                $nb = [Math]::Max(0,[Math]::Min(255,$baseColor.B+$n))
                $bmp.SetPixel($px,$py,(C $nr $ng $nb))
            }
        }
    }
}

# === Headband drawing per village ===
function Draw-Headband($bmp, $village, $x, $y) {
    # Band base
    Fill-Metal $bmp $x $y 16 2 (C 25 25 80)
    # Metal plate
    Fill-Metal $bmp ($x+6) $y 6 2 (C 180 180 200)
    switch ($village) {
        "konoha" {
            # Leaf spiral symbol
            Set-Px $bmp ($x+8) ($y) (C 40 40 60)
            Set-Px $bmp ($x+9) ($y) (C 40 40 60)
            Set-Px $bmp ($x+8) ($y+1) (C 40 40 60)
        }
        "suna" {
            # Hourglass symbol
            Set-Px $bmp ($x+8) ($y) (C 40 40 60)
            Set-Px $bmp ($x+9) ($y+1) (C 40 40 60)
        }
        "kiri" {
            # Wave lines
            Set-Px $bmp ($x+7) ($y) (C 40 40 60)
            Set-Px $bmp ($x+9) ($y) (C 40 40 60)
            Set-Px $bmp ($x+8) ($y+1) (C 40 40 60)
            Set-Px $bmp ($x+10) ($y+1) (C 40 40 60)
        }
        "kumo" {
            # Cloud symbol
            Set-Px $bmp ($x+7) ($y+1) (C 40 40 60)
            Set-Px $bmp ($x+8) ($y) (C 40 40 60)
            Set-Px $bmp ($x+9) ($y) (C 40 40 60)
            Set-Px $bmp ($x+10) ($y+1) (C 40 40 60)
        }
        "iwa" {
            # Rock/stone symbol
            Set-Px $bmp ($x+8) ($y) (C 40 40 60)
            Set-Px $bmp ($x+7) ($y+1) (C 40 40 60)
            Set-Px $bmp ($x+8) ($y+1) (C 40 40 60)
            Set-Px $bmp ($x+9) ($y+1) (C 40 40 60)
        }
        "oto" {
            # Music note symbol
            Set-Px $bmp ($x+8) ($y) (C 40 40 60)
            Set-Px $bmp ($x+9) ($y) (C 40 40 60)
            Set-Px $bmp ($x+8) ($y+1) (C 40 40 60)
        }
        "ame" {
            # Rain drops
            Set-Px $bmp ($x+7) ($y) (C 40 40 60)
            Set-Px $bmp ($x+9) ($y) (C 40 40 60)
            Set-Px $bmp ($x+8) ($y+1) (C 40 40 60)
        }
        "akatsuki" {
            # Scratched through (slash across plate)
            Fill-Metal $bmp ($x+6) $y 6 2 (C 180 180 200)
            Set-Px $bmp ($x+7) ($y) (C 120 30 30)
            Set-Px $bmp ($x+8) ($y) (C 120 30 30)
            Set-Px $bmp ($x+9) ($y+1) (C 120 30 30)
            Set-Px $bmp ($x+10) ($y+1) (C 120 30 30)
        }
        default {
            # Generic plate
        }
    }
}

# === Standard face features (mandatory on every NPC) ===
function Draw-Face($bmp, $eyeColor, $skinColor) {
    # Eyes (3x2 each, dark outline + colored iris)
    Fill-Rect $bmp 20 24 3 2 (C 0 0 0)       # Right eye outline
    Fill-Rect $bmp 27 24 3 2 (C 0 0 0)       # Left eye outline
    Set-Px $bmp 21 24 $eyeColor               # Right iris
    Set-Px $bmp 28 24 $eyeColor               # Left iris
    # Nose
    Set-Px $bmp 24 26 (C ([Math]::Max(0,$skinColor.R-20)) ([Math]::Max(0,$skinColor.G-20)) ([Math]::Max(0,$skinColor.B-15)))
    # Mouth
    Fill-Rect $bmp 22 28 6 1 (C ([Math]::Max(0,$skinColor.R-30)) ([Math]::Max(0,$skinColor.G-50)) ([Math]::Max(0,$skinColor.B-40)))
}

# === Akatsuki Cloak overlay ===
function Draw-AkatsukiCloak($bmp) {
    # Black cloak base
    Fill-Fabric $bmp 40 40 16 24 (C 20 20 25) 
    Fill-Fabric $bmp 32 40 8 24 (C 20 20 25)
    Fill-Fabric $bmp 56 40 8 24 (C 20 20 25)
    # Arms in cloak
    Fill-Fabric $bmp 88 40 8 24 (C 20 20 25)
    Fill-Fabric $bmp 80 40 8 24 (C 20 20 25)
    Fill-Fabric $bmp 96 40 8 24 (C 20 20 25)
    Fill-Fabric $bmp 104 40 8 24 (C 20 20 25)
    # Red cloud patterns
    $clouds = @(@(42,44), @(50,48), @(44,56), @(92,44), @(86,52))
    foreach ($cloud in $clouds) {
        $cx = $cloud[0]; $cy = $cloud[1]
        Set-Px $bmp $cx $cy (C 180 30 30)
        Set-Px $bmp ($cx+1) $cy (C 200 40 40)
        Set-Px $bmp ($cx+2) $cy (C 180 30 30)
        Set-Px $bmp ($cx) ($cy+1) (C 200 40 40)
        Set-Px $bmp ($cx+1) ($cy+1) (C 220 50 50)
        Set-Px $bmp ($cx+2) ($cy+1) (C 200 40 40)
        # White outline
        Set-Px $bmp ($cx-1) $cy (C 200 200 200)
        Set-Px $bmp ($cx+3) $cy (C 200 200 200)
        Set-Px $bmp ($cx-1) ($cy+1) (C 200 200 200)
        Set-Px $bmp ($cx+3) ($cy+1) (C 200 200 200)
    }
    # High collar
    Fill-Fabric $bmp 16 28 16 4 (C 20 20 25)
}

# === Master entity template with proper material noise ===
function Make-Entity($path, $skinCol, $hairCol, $topCol, $pantsCol, $shoeCol, $accentCol, $detailFunc) {
    $bmp = New-Object System.Drawing.Bitmap(128, 128)
    $bmp.SetResolution(72,72)

    # HEAD region - hair uses hair noise, skin uses skin noise
    Fill-Hair $bmp 16 0 16 16 $hairCol                 # Top of head
    Fill-Skin $bmp 32 0 16 16 $skinCol                 # Head bottom cap
    Fill-Skin $bmp 0 16 16 16 $skinCol                 # Right face
    Fill-Hair $bmp 0 16 16 6 $hairCol                  # Right hair overlay
    Fill-Skin $bmp 16 16 16 16 $skinCol                # Front face
    Fill-Hair $bmp 16 16 16 4 $hairCol                 # Front hair/bangs
    Fill-Skin $bmp 32 16 16 16 $skinCol                # Left face
    Fill-Hair $bmp 32 16 16 6 $hairCol                 # Left hair overlay
    Fill-Hair $bmp 48 16 16 16 $hairCol                # Back of head

    # Default face features (will be colored by detail func)
    Draw-Face $bmp (C 40 40 40) $skinCol

    # BODY - fabric noise
    Fill-Fabric $bmp 40 32 16 8 $topCol                # Body top cap
    Fill-Fabric $bmp 32 40 8 24 $topCol                # Body right
    Fill-Fabric $bmp 40 40 16 24 $topCol               # Body front
    Fill-Fabric $bmp 56 40 8 24 $topCol                # Body left
    Fill-Fabric $bmp 64 40 16 24 $topCol               # Body back

    # RIGHT ARM
    Fill-Fabric $bmp 88 32 8 8 $topCol                 # Arm top cap
    Fill-Fabric $bmp 88 40 8 24 $topCol                # Arm front
    Fill-Fabric $bmp 80 40 8 24 $topCol                # Arm inner
    Fill-Fabric $bmp 96 40 8 24 $topCol                # Arm outer
    Fill-Fabric $bmp 104 40 8 24 $topCol               # Arm back
    Fill-Skin $bmp 88 56 8 8 $skinCol                  # Hand front
    Fill-Skin $bmp 80 56 8 8 $skinCol                  # Hand inner
    Fill-Skin $bmp 96 56 8 8 $skinCol                  # Hand outer
    Fill-Skin $bmp 104 56 8 8 $skinCol                 # Hand back

    # RIGHT LEG
    Fill-Fabric $bmp 8 32 8 8 $pantsCol                # Leg top cap
    Fill-Fabric $bmp 8 40 8 24 $pantsCol               # Leg front
    Fill-Fabric $bmp 0 40 8 24 $pantsCol               # Leg inner
    Fill-Fabric $bmp 16 40 8 24 $pantsCol              # Leg outer
    Fill-Fabric $bmp 24 40 8 24 $pantsCol              # Leg back
    Fill-Leather $bmp 8 56 8 8 $shoeCol                # Shoe front
    Fill-Leather $bmp 0 56 8 8 $shoeCol                # Shoe inner
    Fill-Leather $bmp 16 56 8 8 $shoeCol               # Shoe outer
    Fill-Leather $bmp 24 56 8 8 $shoeCol               # Shoe back

    # LEFT ARM
    Fill-Fabric $bmp 72 96 8 8 $topCol                 # Arm top cap
    Fill-Fabric $bmp 72 104 8 24 $topCol               # Arm front
    Fill-Fabric $bmp 64 104 8 24 $topCol               # Arm inner
    Fill-Fabric $bmp 80 104 8 24 $topCol               # Arm outer
    Fill-Fabric $bmp 88 104 8 24 $topCol               # Arm back
    Fill-Skin $bmp 72 120 8 8 $skinCol                 # Hand front
    Fill-Skin $bmp 64 120 8 8 $skinCol                 # Hand inner
    Fill-Skin $bmp 80 120 8 8 $skinCol                 # Hand outer
    Fill-Skin $bmp 88 120 8 8 $skinCol                 # Hand back

    # LEFT LEG
    Fill-Fabric $bmp 40 96 8 8 $pantsCol               # Leg top cap
    Fill-Fabric $bmp 40 104 8 24 $pantsCol             # Leg front
    Fill-Fabric $bmp 32 104 8 24 $pantsCol             # Leg inner
    Fill-Fabric $bmp 48 104 8 24 $pantsCol             # Leg outer
    Fill-Fabric $bmp 56 104 8 24 $pantsCol             # Leg back
    Fill-Leather $bmp 40 120 8 8 $shoeCol              # Shoe front
    Fill-Leather $bmp 32 120 8 8 $shoeCol              # Shoe inner
    Fill-Leather $bmp 48 120 8 8 $shoeCol              # Shoe outer
    Fill-Leather $bmp 56 120 8 8 $shoeCol              # Shoe back

    if ($detailFunc) { & $detailFunc $bmp }
    Save-Png $bmp $path
}

Write-Host "=============================================="
Write-Host " MASTER NPC TEXTURE GENERATOR - 55 NPCs"
Write-Host " 128x128 HD Pixel Art Textures"
Write-Host "=============================================="
Write-Host ""

# ======================================================================
# EXISTING NPCs - Regenerated with improved quality
# ======================================================================
Write-Host "=== CORE NPCs (Improved Quality) ==="

# 001 - Naruto Uzumaki
Make-Entity "$entityDir\naruto.png" (C 255 220 180) (C 255 200 40) (C 255 130 30) (C 255 130 30) (C 40 40 50) (C 30 90 200) {
    param($bmp)
    # Spiky blonde hair
    Fill-Hair $bmp 20 8 8 8 (C 255 210 50) 
    Fill-Hair $bmp 18 10 4 6 (C 255 200 40)
    Fill-Hair $bmp 28 10 4 6 (C 255 200 40)
    Fill-Hair $bmp 16 12 3 4 (C 255 195 35)
    Fill-Hair $bmp 31 12 3 4 (C 255 195 35)
    Draw-Headband $bmp "konoha" 16 20
    # Blue eyes
    Draw-Face $bmp (C 30 120 220) (C 255 220 180)
    # Whisker marks (3 lines each cheek)
    Set-Px $bmp 18 26 (C 200 170 140); Set-Px $bmp 18 27 (C 200 170 140); Set-Px $bmp 18 28 (C 200 170 140)
    Set-Px $bmp 31 26 (C 200 170 140); Set-Px $bmp 31 27 (C 200 170 140); Set-Px $bmp 31 28 (C 200 170 140)
    # Orange jumpsuit zipper line
    for ($y=40; $y -le 63; $y++) { Set-Px $bmp 48 $y (C 200 200 210) }
    # Blue collar/shoulder area
    Fill-Fabric $bmp 40 40 16 3 (C 30 90 200)
}

# 002 - Sasuke Uchiha
Make-Entity "$entityDir\sasuke.png" (C 255 225 190) (C 20 15 30) (C 240 240 245) (C 60 60 80) (C 40 40 50) (C 140 0 0) {
    param($bmp)
    # Dark spiky hair (back duck-butt style)
    Fill-Hair $bmp 20 8 8 6 (C 20 15 30)
    Fill-Hair $bmp 18 10 4 6 (C 25 20 35)
    Fill-Hair $bmp 28 10 4 6 (C 25 20 35)
    Fill-Hair $bmp 48 16 16 16 (C 20 15 30)  # Back spikes extend
    Fill-Hair $bmp 52 8 8 10 (C 25 20 35)    # Duck-butt spikes
    Draw-Headband $bmp "konoha" 16 20
    # Black eyes (Sharingan potential - dark)
    Draw-Face $bmp (C 20 20 30) (C 255 225 190)
    # High collar (white shirt)
    Fill-Fabric $bmp 16 28 16 4 (C 240 240 245)
    # Uchiha clan symbol on back (fan)
    Fill-Rect $bmp 70 44 6 8 (C 200 200 210)  # White bottom half
    Fill-Rect $bmp 70 44 6 4 (C 180 30 30)    # Red top half
    # Purple rope belt
    Fill-Fabric $bmp 40 52 16 2 (C 100 60 140)
}

# 003 - Kakashi Hatake
Make-Entity "$entityDir\kakashi.png" (C 255 220 180) (C 200 200 210) (C 30 50 80) (C 30 45 70) (C 40 40 50) (C 80 80 80) {
    param($bmp)
    # Silver/white spiky hair (gravity-defying)
    Fill-Hair $bmp 20 6 8 10 (C 200 200 210)
    Fill-Hair $bmp 16 8 6 8 (C 195 195 205)
    Fill-Hair $bmp 28 8 6 8 (C 195 195 205)
    Fill-Hair $bmp 22 4 6 4 (C 205 205 215)
    # Headband tilted over left eye
    Draw-Headband $bmp "konoha" 16 20
    # Mask covering lower face
    Fill-Fabric $bmp 16 26 16 6 (C 30 30 45)
    # One visible eye (right), left covered
    Fill-Rect $bmp 20 24 3 2 (C 0 0 0)
    Set-Px $bmp 21 24 (C 20 20 25)
    Fill-Rect $bmp 27 24 3 2 (C 25 25 80)  # Headband covers left
    # Jounin vest (green)
    Fill-Fabric $bmp 40 40 16 10 (C 60 90 60)
    Fill-Rect $bmp 42 44 4 3 (C 50 80 50)  # Vest pockets
    Fill-Rect $bmp 52 44 4 3 (C 50 80 50)
}

# 004 - Sakura Haruno
Make-Entity "$entityDir\sakura.png" (C 255 225 195) (C 255 130 160) (C 200 50 70) (C 50 50 60) (C 40 40 50) (C 255 130 160) {
    param($bmp)
    # Pink hair (short, shoulder length)
    Fill-Hair $bmp 16 16 16 8 (C 255 130 160)
    Fill-Hair $bmp 0 16 16 14 (C 255 125 155)
    Fill-Hair $bmp 32 16 16 14 (C 255 125 155)
    Draw-Headband $bmp "konoha" 16 20
    # Green eyes
    Draw-Face $bmp (C 50 180 80) (C 255 225 195)
    # Byakugou seal diamond on forehead
    Set-Px $bmp 24 19 (C 100 0 180)
    # Red top detail
    Fill-Fabric $bmp 40 40 16 4 (C 200 50 70)
    # Gloves (medic)
    Fill-Leather $bmp 88 48 8 16 (C 30 30 35)
    Fill-Leather $bmp 80 48 8 16 (C 30 30 35)
    Fill-Leather $bmp 96 48 8 16 (C 30 30 35)
    Fill-Leather $bmp 104 48 8 16 (C 30 30 35)
}

# 005 - Hinata Hyuga
Make-Entity "$entityDir\hinata.png" (C 255 225 195) (C 30 20 60) (C 200 195 230) (C 50 50 70) (C 40 40 50) (C 200 195 230) {
    param($bmp)
    # Dark blue/indigo hair (long, straight)
    Fill-Hair $bmp 0 16 16 16 (C 30 20 60)
    Fill-Hair $bmp 32 16 16 16 (C 30 20 60)
    Fill-Hair $bmp 48 16 16 16 (C 30 20 60)
    Fill-Hair $bmp 16 16 16 5 (C 35 25 65)  # Bangs
    Draw-Headband $bmp "konoha" 16 20
    # Byakugan white/lavender eyes
    Draw-Face $bmp (C 220 215 240) (C 255 225 195)
    # Lavender jacket
    Fill-Fabric $bmp 40 40 16 16 (C 200 195 230)
    # Blush marks
    Set-Px $bmp 19 27 (C 255 180 180)
    Set-Px $bmp 30 27 (C 255 180 180)
}

# 006 - Rock Lee
Make-Entity "$entityDir\rock_lee.png" (C 255 220 180) (C 10 10 15) (C 20 120 30) (C 20 120 30) (C 255 140 0) (C 200 30 30) {
    param($bmp)
    # Bowl cut (round, shiny black)
    Fill-Hair $bmp 16 16 16 6 (C 10 10 15)
    Draw-Headband $bmp "konoha" 16 20
    # Big round eyes
    Fill-Rect $bmp 19 23 4 3 (C 0 0 0)
    Fill-Rect $bmp 27 23 4 3 (C 0 0 0)
    Set-Px $bmp 20 24 (C 15 15 20)
    Set-Px $bmp 28 24 (C 15 15 20)
    # THICK eyebrows
    Fill-Rect $bmp 19 22 4 2 (C 5 5 5)
    Fill-Rect $bmp 27 22 4 2 (C 5 5 5)
    # Big smile with teeth
    Fill-Rect $bmp 21 28 8 1 (C 255 255 255)
    # Green jumpsuit
    Fill-Fabric $bmp 40 40 16 24 (C 20 120 30)
    # Orange leg warmers
    Fill-Noisy $bmp 0 50 8 14 (C 255 140 0) 10
    Fill-Noisy $bmp 8 50 8 14 (C 255 140 0) 10
    Fill-Noisy $bmp 16 50 8 14 (C 255 140 0) 10
    Fill-Noisy $bmp 24 50 8 14 (C 255 140 0) 10
    # Jounin vest (Shippuden)
    Fill-Fabric $bmp 40 40 16 8 (C 60 90 60)
}

# 007 - Gaara
Make-Entity "$entityDir\gaara.png" (C 255 220 180) (C 160 40 30) (C 120 60 50) (C 50 50 55) (C 40 40 50) (C 190 170 140) {
    param($bmp)
    # Red messy hair
    Fill-Hair $bmp 20 10 8 6 (C 160 40 30)
    Fill-Hair $bmp 16 12 4 4 (C 155 35 25)
    Fill-Hair $bmp 28 12 4 4 (C 155 35 25)
    # No eyebrows
    # Love kanji on forehead
    Set-Px $bmp 22 19 (C 130 30 30)
    Set-Px $bmp 23 19 (C 130 30 30)
    Set-Px $bmp 22 18 (C 130 30 30)
    # Dark-rimmed eyes (insomnia/Shukaku)
    Fill-Rect $bmp 19 23 5 3 (C 20 30 30)
    Fill-Rect $bmp 26 23 5 3 (C 20 30 30)
    Draw-Face $bmp (C 100 180 160) (C 255 220 180)
    # Sand gourd on back
    Fill-Noisy $bmp 66 40 12 20 (C 190 170 140) 12
    Fill-Rect $bmp 68 38 8 3 (C 140 120 80)  # Gourd strap
    # Red sash
    Fill-Fabric $bmp 40 50 16 2 (C 160 40 30)
}

# 008 - Itachi Uchiha
Make-Entity "$entityDir\itachi.png" (C 255 225 190) (C 15 10 20) (C 20 20 25) (C 20 20 25) (C 40 40 50) (C 180 30 30) {
    param($bmp)
    # Long black hair in ponytail
    Fill-Hair $bmp 0 16 16 16 (C 15 10 20)
    Fill-Hair $bmp 32 16 16 16 (C 15 10 20)
    Fill-Hair $bmp 48 16 16 16 (C 15 10 20)
    # Ponytail extending
    Fill-Hair $bmp 68 40 6 12 (C 15 10 20)
    Draw-Headband $bmp "akatsuki" 16 20
    # Sharingan red eyes + tear troughs
    Draw-Face $bmp (C 200 30 30) (C 255 225 190)
    Set-Px $bmp 20 26 (C 60 40 50)  # Under-eye line left
    Set-Px $bmp 29 26 (C 60 40 50)  # Under-eye line right
    # Akatsuki cloak
    Draw-AkatsukiCloak $bmp
    # Necklace
    Set-Px $bmp 23 31 (C 180 180 200)
    Set-Px $bmp 24 31 (C 180 180 200)
    Set-Px $bmp 25 31 (C 180 180 200)
}

# 009 - Jiraiya
Make-Entity "$entityDir\jiraiya.png" (C 255 220 180) (C 240 240 245) (C 60 100 60) (C 60 80 60) (C 50 50 55) (C 200 30 30) {
    param($bmp)
    # Long white spiky hair
    Fill-Hair $bmp 16 8 16 8 (C 240 240 245)
    Fill-Hair $bmp 0 16 16 16 (C 240 240 245)
    Fill-Hair $bmp 32 16 16 16 (C 240 240 245)
    Fill-Hair $bmp 48 16 16 16 (C 240 240 245)
    Fill-Hair $bmp 64 40 16 20 (C 240 240 245) # Hair extends down back
    # Horned forehead protector
    Fill-Metal $bmp 16 20 16 2 (C 180 180 200)
    Fill-Metal $bmp 18 18 3 2 (C 180 180 200)
    Fill-Metal $bmp 29 18 3 2 (C 180 180 200)
    # Red facial lines under eyes
    Set-Px $bmp 19 26 (C 200 30 30); Set-Px $bmp 19 27 (C 200 30 30)
    Set-Px $bmp 30 26 (C 200 30 30); Set-Px $bmp 30 27 (C 200 30 30)
    Draw-Face $bmp (C 30 30 30) (C 255 220 180)
    # Sage mode dots on nose (when teaching)
    Set-Px $bmp 23 26 (C 255 120 30)
    Set-Px $bmp 25 26 (C 255 120 30)
    # Red vest/haori
    Fill-Fabric $bmp 40 40 16 24 (C 200 30 30)
    Fill-Fabric $bmp 32 40 8 24 (C 200 30 30)
    Fill-Fabric $bmp 56 40 8 24 (C 200 30 30)
    # Scroll on back
    Fill-Rect $bmp 70 50 8 10 (C 210 190 150)
    Fill-Rect $bmp 70 50 8 1 (C 140 120 80)
    Fill-Rect $bmp 70 59 8 1 (C 140 120 80)
}

# 010 - Tsunade
Make-Entity "$entityDir\tsunade.png" (C 255 225 195) (C 240 210 140) (C 100 140 100) (C 30 40 50) (C 40 40 50) (C 100 0 180) {
    param($bmp)
    # Blonde hair in twin tails
    Fill-Hair $bmp 0 16 16 16 (C 240 210 140)
    Fill-Hair $bmp 32 16 16 16 (C 240 210 140)
    Fill-Hair $bmp 16 16 16 4 (C 245 215 145)
    # Pigtails extending down
    Fill-Hair $bmp 4 32 6 16 (C 240 210 140)
    Fill-Hair $bmp 38 32 6 16 (C 240 210 140)
    # Byakugou diamond seal
    Set-Px $bmp 24 19 (C 100 0 180)
    Set-Px $bmp 23 20 (C 100 0 180)
    Set-Px $bmp 25 20 (C 100 0 180)
    # Brown eyes
    Draw-Face $bmp (C 150 100 50) (C 255 225 195)
    # Green haori jacket
    Fill-Fabric $bmp 40 40 16 24 (C 100 140 100)
    Fill-Fabric $bmp 32 40 8 24 (C 100 140 100)
    Fill-Fabric $bmp 56 40 8 24 (C 100 140 100)
    # Kanji on back
    Fill-Rect $bmp 70 44 8 8 (C 200 30 30)
    Fill-Rect $bmp 72 46 4 4 (C 100 140 100)
}

Write-Host ""
Write-Host "=== EXPANDED KONOHA TEAM NPCs ==="

# 011 - Shikamaru Nara
Make-Entity "$entityDir\shikamaru.png" (C 255 220 180) (C 50 40 30) (C 60 90 60) (C 50 50 60) (C 40 40 50) (C 80 80 80) {
    param($bmp)
    # Ponytail (pineapple)
    Fill-Hair $bmp 20 10 8 6 (C 50 40 30)
    Fill-Hair $bmp 22 6 4 6 (C 55 45 35)
    Draw-Headband $bmp "konoha" 16 20
    # Lazy half-closed eyes
    Fill-Rect $bmp 20 24 3 1 (C 0 0 0); Fill-Rect $bmp 27 24 3 1 (C 0 0 0)
    Set-Px $bmp 24 26 (C 230 200 160)
    Fill-Rect $bmp 22 28 6 1 (C 180 130 100)
    # Jounin vest + earrings
    Fill-Fabric $bmp 40 40 16 10 (C 60 90 60)
    Fill-Rect $bmp 42 44 4 3 (C 50 80 50)
    Set-Px $bmp 17 25 (C 200 200 200)
}

# 012 - Neji Hyuga
Make-Entity "$entityDir\neji.png" (C 255 220 180) (C 80 50 30) (C 200 195 180) (C 180 175 165) (C 60 60 70) (C 230 230 230) {
    param($bmp)
    # Long brown flowing hair
    Fill-Hair $bmp 0 16 16 16 (C 80 50 30)
    Fill-Hair $bmp 32 16 16 16 (C 80 50 30)
    Fill-Hair $bmp 48 16 16 16 (C 80 50 30)
    Fill-Hair $bmp 64 40 16 16 (C 80 50 30)
    Draw-Headband $bmp "konoha" 16 20
    # Byakugan eyes
    Draw-Face $bmp (C 230 220 240) (C 255 220 180)
    # Chest wrapping
    Fill-Rect $bmp 40 42 16 1 (C 160 155 145)
    Fill-Rect $bmp 40 45 16 1 (C 160 155 145)
}

# 013 - Tenten
Make-Entity "$entityDir\tenten.png" (C 255 220 180) (C 90 55 25) (C 200 60 80) (C 50 50 60) (C 40 40 50) (C 255 120 140) {
    param($bmp)
    # Twin buns
    Fill-Hair $bmp 18 8 5 5 (C 90 55 25)
    Fill-Hair $bmp 27 8 5 5 (C 90 55 25)
    Draw-Headband $bmp "konoha" 16 20
    Draw-Face $bmp (C 80 50 20) (C 255 220 180)
    # Chinese top detail
    Fill-Rect $bmp 47 40 2 12 (C 180 50 60)
    # Scroll on back
    Fill-Rect $bmp 70 42 6 10 (C 210 190 150)
    Fill-Rect $bmp 70 42 6 1 (C 140 120 80)
    Fill-Rect $bmp 70 51 6 1 (C 140 120 80)
}

# 014 - Shino Aburame
Make-Entity "$entityDir\shino.png" (C 255 220 180) (C 40 35 30) (C 50 55 50) (C 50 55 50) (C 40 40 45) (C 30 30 30) {
    param($bmp)
    # Sunglasses
    Fill-Rect $bmp 19 23 12 3 (C 15 15 15)
    Fill-Rect $bmp 20 24 4 2 (C 25 25 30)
    Fill-Rect $bmp 27 24 4 2 (C 25 25 30)
    # High collar covering face
    Fill-Fabric $bmp 16 27 16 5 (C 50 55 50)
    Fill-Hair $bmp 16 16 16 7 (C 40 35 30)
    Draw-Headband $bmp "konoha" 16 20
    # Zipped coat
    for ($y=40; $y -le 63; $y++) { Set-Px $bmp 48 $y (C 35 35 35) }
    # Bug detail
    Set-Px $bmp 86 50 (C 60 40 20); Set-Px $bmp 87 50 (C 60 40 20)
}

# 015 - Minato Namikaze (4th Hokage)
Make-Entity "$entityDir\minato.png" (C 255 220 180) (C 255 220 50) (C 30 100 200) (C 30 80 170) (C 40 40 50) (C 255 255 255) {
    param($bmp)
    # Spiky blonde hair
    Fill-Hair $bmp 20 8 8 8 (C 255 220 50)
    Fill-Hair $bmp 18 10 4 6 (C 255 210 40)
    Fill-Hair $bmp 28 10 4 6 (C 255 210 40)
    Draw-Headband $bmp "konoha" 16 20
    Draw-Face $bmp (C 30 100 200) (C 255 220 180)
    # Hokage cloak (white with flames)
    Fill-Fabric $bmp 40 40 16 24 (C 245 245 245)
    Fill-Fabric $bmp 32 40 8 24 (C 245 245 245)
    Fill-Fabric $bmp 56 40 8 24 (C 245 245 245)
    for ($x=40; $x -lt 56; $x++) {
        $flameH = 3 + ($x % 3)
        for ($fy=0; $fy -lt $flameH; $fy++) { Set-Px $bmp $x (60-$fy) (C 255 (100+$fy*30) 0) }
    }
    # Kanji on back
    Fill-Rect $bmp 70 44 8 8 (C 200 30 30)
    Fill-Rect $bmp 72 46 4 4 (C 245 245 245)
}

# 016 - Orochimaru
Make-Entity "$entityDir\orochimaru.png" (C 240 235 220) (C 20 15 25) (C 200 195 175) (C 50 50 60) (C 40 40 50) (C 128 0 160) {
    param($bmp)
    # Very long black hair
    Fill-Hair $bmp 0 16 16 16 (C 20 15 25)
    Fill-Hair $bmp 32 16 16 16 (C 20 15 25)
    Fill-Hair $bmp 48 16 16 16 (C 20 15 25)
    Fill-Hair $bmp 64 40 16 24 (C 20 15 25)
    # Snake-like yellow eyes
    Draw-Face $bmp (C 200 180 0) (C 240 235 220)
    # Purple eye markings
    Set-Px $bmp 19 23 (C 128 0 160); Set-Px $bmp 26 23 (C 128 0 160)
    Set-Px $bmp 22 23 (C 128 0 160); Set-Px $bmp 29 23 (C 128 0 160)
    # Purple rope belt
    Fill-Rect $bmp 40 52 16 2 (C 128 0 160)
    Fill-Rect $bmp 56 52 6 6 (C 128 0 160)
    # No headband (rogue)
}

# 017 - Might Guy
Make-Entity "$entityDir\might_guy.png" (C 255 220 180) (C 15 15 20) (C 20 120 30) (C 20 120 30) (C 255 140 0) (C 200 30 30) {
    param($bmp)
    # Bowl cut
    Fill-Hair $bmp 16 16 16 5 (C 15 15 20)
    # THICK eyebrows
    Fill-Rect $bmp 19 22 4 2 (C 5 5 5)
    Fill-Rect $bmp 27 22 4 2 (C 5 5 5)
    Draw-Headband $bmp "konoha" 16 20
    Draw-Face $bmp (C 15 15 20) (C 255 220 180)
    # Big smile
    Fill-Rect $bmp 21 28 8 1 (C 255 255 255)
    # Green jumpsuit
    Fill-Fabric $bmp 40 40 16 24 (C 20 120 30)
    Fill-Fabric $bmp 88 40 8 24 (C 20 120 30)
    Fill-Fabric $bmp 80 40 8 24 (C 20 120 30)
    # Orange leg warmers
    Fill-Noisy $bmp 0 50 8 14 (C 255 140 0) 10
    Fill-Noisy $bmp 8 50 8 14 (C 255 140 0) 10
    Fill-Noisy $bmp 16 50 8 14 (C 255 140 0) 10
    Fill-Noisy $bmp 24 50 8 14 (C 255 140 0) 10
    # Jounin vest
    Fill-Fabric $bmp 40 40 16 8 (C 60 90 60)
}

# 018 - Konohamaru Sarutobi
Make-Entity "$entityDir\konohamaru.png" (C 255 220 180) (C 80 50 25) (C 40 40 50) (C 40 40 50) (C 40 40 50) (C 65 105 200) {
    param($bmp)
    # Spiky brown hair
    Fill-Hair $bmp 20 10 8 6 (C 80 50 25)
    Fill-Hair $bmp 18 12 4 4 (C 75 45 20)
    Fill-Hair $bmp 28 12 4 4 (C 75 45 20)
    # Goggles on forehead
    Fill-Rect $bmp 18 19 4 3 (C 100 100 120)
    Fill-Rect $bmp 28 19 4 3 (C 100 100 120)
    Fill-Rect $bmp 19 20 2 2 (C 150 200 255)
    Fill-Rect $bmp 29 20 2 2 (C 150 200 255)
    Draw-Face $bmp (C 40 40 40) (C 255 220 180)
    # Blue scarf (long)
    Fill-Fabric $bmp 16 30 16 2 (C 65 105 200)
    Fill-Fabric $bmp 40 60 4 4 (C 65 105 200)
}

Write-Host ""
Write-Host "=== NEW WAVE 1: KONOHA EXTENDED ==="

# 019 - Ino Yamanaka
Make-Entity "$entityDir\ino.png" (C 255 225 195) (C 240 220 100) (C 128 0 160) (C 50 50 60) (C 40 40 50) (C 128 0 160) {
    param($bmp)
    # Long blonde ponytail (one side)
    Fill-Hair $bmp 16 16 16 4 (C 240 220 100)
    Fill-Hair $bmp 0 16 16 16 (C 240 220 100)
    # Long side bang
    Fill-Hair $bmp 32 16 16 16 (C 240 220 100)
    Fill-Hair $bmp 38 32 4 12 (C 240 220 100) # Ponytail hanging
    Draw-Headband $bmp "konoha" 16 20
    # Blue eyes
    Draw-Face $bmp (C 60 160 200) (C 255 225 195)
    # Purple top
    Fill-Fabric $bmp 40 40 16 12 (C 128 0 160)
    # Flower shop apron accent
    Fill-Rect $bmp 40 52 16 2 (C 100 80 130)
}

# 020 - Choji Akimichi
Make-Entity "$entityDir\choji.png" (C 255 220 180) (C 100 60 25) (C 200 30 30) (C 50 70 50) (C 40 40 50) (C 200 200 200) {
    param($bmp)
    # Brown spiky hair
    Fill-Hair $bmp 20 10 8 6 (C 100 60 25)
    Fill-Hair $bmp 18 12 4 4 (C 95 55 20)
    Draw-Headband $bmp "konoha" 16 20
    Draw-Face $bmp (C 30 30 30) (C 255 220 180)
    # Swirl cheek marks
    Set-Px $bmp 19 27 (C 200 60 60)
    Set-Px $bmp 18 26 (C 200 60 60)
    Set-Px $bmp 30 27 (C 200 60 60)
    Set-Px $bmp 31 26 (C 200 60 60)
    # Red shirt/armor plate
    Fill-Fabric $bmp 40 40 16 12 (C 200 30 30)
    # Wider body impression -> use lighter shade bottom
    Fill-Fabric $bmp 40 52 16 12 (C 180 180 180) # Belly plate
    # Scarf
    Fill-Fabric $bmp 16 30 16 2 (C 220 220 220)
}

# 021 - Kiba Inuzuka
Make-Entity "$entityDir\kiba.png" (C 255 220 180) (C 70 45 20) (C 50 50 55) (C 50 50 55) (C 40 40 50) (C 180 30 30) {
    param($bmp)
    # Wild brown hair
    Fill-Hair $bmp 20 10 8 6 (C 70 45 20)
    Fill-Hair $bmp 16 12 6 6 (C 65 40 15)
    Fill-Hair $bmp 28 12 6 6 (C 65 40 15)
    Draw-Headband $bmp "konoha" 16 20
    Draw-Face $bmp (C 30 30 30) (C 255 220 180)
    # Red fang marks on cheeks
    Set-Px $bmp 19 25 (C 200 30 30); Set-Px $bmp 19 26 (C 200 30 30); Set-Px $bmp 19 27 (C 200 30 30)
    Set-Px $bmp 30 25 (C 200 30 30); Set-Px $bmp 30 26 (C 200 30 30); Set-Px $bmp 30 27 (C 200 30 30)
    # Fur-lined jacket
    Fill-Fabric $bmp 40 40 16 4 (C 80 80 80)  # Fur collar
    Fill-Fabric $bmp 40 44 16 20 (C 50 50 55)
    # Hood detail
    Fill-Fabric $bmp 48 16 16 8 (C 80 80 80)
}

# 022 - Kurenai Yuhi
Make-Entity "$entityDir\kurenai.png" (C 255 225 195) (C 15 10 20) (C 180 40 50) (C 200 200 210) (C 40 40 50) (C 180 40 50) {
    param($bmp)
    # Long wavy dark hair
    Fill-Hair $bmp 0 16 16 16 (C 15 10 20)
    Fill-Hair $bmp 32 16 16 16 (C 15 10 20)
    Fill-Hair $bmp 48 16 16 16 (C 15 10 20)
    Draw-Headband $bmp "konoha" 16 20
    # Red eyes (unique)
    Draw-Face $bmp (C 180 30 30) (C 255 225 195)
    # Red lips
    Fill-Rect $bmp 23 28 4 1 (C 200 50 60)
    # Bandage-like outfit
    Fill-Fabric $bmp 40 40 16 24 (C 200 200 210)
    for ($y=42; $y -le 60; $y+=3) { Fill-Rect $bmp 40 $y 16 1 (C 180 40 50) }
}

# 023 - Asuma Sarutobi
Make-Entity "$entityDir\asuma.png" (C 255 215 175) (C 25 20 15) (C 60 90 60) (C 30 30 40) (C 40 40 50) (C 200 200 200) {
    param($bmp)
    # Short dark hair + beard
    Fill-Hair $bmp 16 16 16 4 (C 25 20 15)
    Draw-Headband $bmp "konoha" 16 20
    Draw-Face $bmp (C 30 30 30) (C 255 215 175)
    # Beard
    Fill-Rect $bmp 21 28 8 3 (C 30 25 20)
    # Cigarette
    Set-Px $bmp 30 29 (C 240 230 210)
    Set-Px $bmp 31 29 (C 240 230 210)
    Set-Px $bmp 32 29 (C 255 100 30)  # Lit tip
    # Jounin vest
    Fill-Fabric $bmp 40 40 16 10 (C 60 90 60)
    Fill-Rect $bmp 42 44 4 3 (C 50 80 50)
    Fill-Rect $bmp 52 44 4 3 (C 50 80 50)
    # Sash/belt with Sarutobi clan mark
    Fill-Fabric $bmp 40 52 16 2 (C 200 200 200)
    Set-Px $bmp 48 52 (C 200 30 30)
}

# 024 - Anko Mitarashi
Make-Entity "$entityDir\anko.png" (C 255 225 195) (C 60 30 80) (C 200 180 150) (C 60 50 40) (C 40 40 50) (C 200 30 30) {
    param($bmp)
    # Wild purple/dark hair in ponytail
    Fill-Hair $bmp 16 16 16 5 (C 60 30 80)
    Fill-Hair $bmp 48 16 16 16 (C 60 30 80)
    Fill-Hair $bmp 52 10 6 8 (C 65 35 85)  # Ponytail tuft
    Draw-Headband $bmp "konoha" 16 20
    Draw-Face $bmp (C 80 50 30) (C 255 225 195)
    # Curse mark on neck (three dots)
    Set-Px $bmp 16 30 (C 40 0 0); Set-Px $bmp 17 29 (C 40 0 0); Set-Px $bmp 18 30 (C 40 0 0)
    # Mesh body + trench coat
    Fill-Fabric $bmp 40 40 16 6 (C 150 140 130)  # Mesh
    Fill-Fabric $bmp 40 46 16 18 (C 200 180 150) # Coat
    # Dango love - pouch detail
    Set-Px $bmp 94 48 (C 200 120 120)
    Set-Px $bmp 94 50 (C 200 120 120)
    Set-Px $bmp 94 52 (C 200 120 120)
}

# 025 - Iruka Umino
Make-Entity "$entityDir\iruka.png" (C 255 215 175) (C 50 35 20) (C 30 50 80) (C 30 45 70) (C 40 40 50) (C 200 200 200) {
    param($bmp)
    # Brown hair in high ponytail
    Fill-Hair $bmp 20 10 8 6 (C 50 35 20)
    Fill-Hair $bmp 48 10 8 6 (C 50 35 20)  # Ponytail
    Draw-Headband $bmp "konoha" 16 20
    Draw-Face $bmp (C 40 30 20) (C 255 215 175)
    # Scar across nose bridge
    Fill-Rect $bmp 22 26 6 1 (C 180 130 100)
    # Warm smile
    Fill-Rect $bmp 22 28 6 1 (C 200 150 120)
    Set-Px $bmp 21 28 (C 180 120 100)
    Set-Px $bmp 28 28 (C 180 120 100)
    # Chunin vest
    Fill-Fabric $bmp 40 40 16 10 (C 60 90 60)
}

# 026 - Yamato/Tenzo
Make-Entity "$entityDir\yamato.png" (C 255 215 175) (C 50 35 20) (C 30 50 50) (C 30 40 45) (C 40 40 50) (C 100 80 50) {
    param($bmp)
    # Short brown hair
    Fill-Hair $bmp 16 16 16 4 (C 50 35 20)
    Draw-Headband $bmp "konoha" 16 20
    Draw-Face $bmp (C 30 30 30) (C 255 215 175)
    # Scary face expression (wide eyes)
    Fill-Rect $bmp 19 23 4 3 (C 0 0 0)
    Fill-Rect $bmp 27 23 4 3 (C 0 0 0)
    Set-Px $bmp 20 24 (C 255 255 255)
    Set-Px $bmp 28 24 (C 255 255 255)
    # ANBU armor style
    Fill-Fabric $bmp 40 40 16 8 (C 140 140 150) # Chest plate
    Fill-Metal $bmp 42 42 12 4 (C 180 180 190)  # Metal front
    # Wood style brown arm wraps
    Fill-Leather $bmp 88 44 8 12 (C 100 80 50)
    Fill-Leather $bmp 80 44 8 12 (C 100 80 50)
}

# 027 - Sai
Make-Entity "$entityDir\sai.png" (C 245 235 220) (C 10 10 15) (C 20 20 25) (C 20 20 25) (C 40 40 50) (C 200 200 200) {
    param($bmp)
    # Short straight black hair  
    Fill-Hair $bmp 16 16 16 5 (C 10 10 15)
    # No headband (ROOT member later Konoha)
    Draw-Face $bmp (C 10 10 15) (C 245 235 220)
    # Fake smile
    Fill-Rect $bmp 22 28 6 1 (C 200 170 150)
    # Black midriff-baring top
    Fill-Fabric $bmp 40 40 16 10 (C 20 20 25)
    Fill-Skin $bmp 40 50 16 8 (C 245 235 220)  # Exposed midriff
    # Scroll and ink brush on back
    Fill-Rect $bmp 70 42 6 10 (C 230 220 200)
    Set-Px $bmp 68 44 (C 15 15 15)  # Ink brush
    Set-Px $bmp 68 45 (C 15 15 15)
    Set-Px $bmp 68 46 (C 15 15 15)
}

Write-Host ""
Write-Host "=== NEW WAVE 2: SAND VILLAGE ==="

# 028 - Kankuro
Make-Entity "$entityDir\kankuro.png" (C 255 215 175) (C 50 35 20) (C 30 30 35) (C 30 30 35) (C 40 40 50) (C 128 0 160) {
    param($bmp)
    # Hood covering hair
    Fill-Fabric $bmp 16 12 16 8 (C 30 30 35)
    Fill-Fabric $bmp 48 16 16 16 (C 30 30 35)
    Draw-Headband $bmp "suna" 16 20
    Draw-Face $bmp (C 30 30 30) (C 255 215 175)
    # Kabuki face paint (purple)
    Set-Px $bmp 19 25 (C 100 0 160); Set-Px $bmp 20 26 (C 100 0 160)
    Set-Px $bmp 30 25 (C 100 0 160); Set-Px $bmp 29 26 (C 100 0 160)
    # Cat ear hood points
    Set-Px $bmp 18 12 (C 30 30 35); Set-Px $bmp 30 12 (C 30 30 35)
    # Puppet scroll on back
    Fill-Rect $bmp 66 40 14 16 (C 100 80 60)
    Fill-Rect $bmp 66 40 14 2 (C 70 50 30)
}

# 029 - Temari
Make-Entity "$entityDir\temari.png" (C 255 225 195) (C 200 180 80) (C 100 80 120) (C 50 50 60) (C 40 40 50) (C 200 30 30) {
    param($bmp)
    # Four ponytails (spiky)
    Fill-Hair $bmp 18 8 4 6 (C 200 180 80)
    Fill-Hair $bmp 28 8 4 6 (C 200 180 80)
    Fill-Hair $bmp 10 12 4 4 (C 200 180 80)
    Fill-Hair $bmp 36 12 4 4 (C 200 180 80)
    Draw-Headband $bmp "suna" 16 20
    # Teal eyes
    Draw-Face $bmp (C 40 140 120) (C 255 225 195)
    # Purple/dark outfit
    Fill-Fabric $bmp 40 40 16 24 (C 100 80 120)
    # Giant fan on back
    Fill-Metal $bmp 64 38 16 22 (C 180 180 190)
    Fill-Rect $bmp 66 42 12 4 (C 128 0 160)
    Fill-Rect $bmp 66 50 12 4 (C 128 0 160)
    # Red sash
    Fill-Fabric $bmp 40 52 16 2 (C 200 30 30)
}

# 030 - Chiyo (Elder)
Make-Entity "$entityDir\chiyo.png" (C 230 200 170) (C 180 170 160) (C 50 50 55) (C 50 50 55) (C 40 40 50) (C 200 200 200) {
    param($bmp)
    # Gray hair in bun
    Fill-Hair $bmp 16 16 16 4 (C 180 170 160)
    Fill-Hair $bmp 22 10 6 6 (C 185 175 165) # Bun
    # Wrinkled face (extra lines)
    Draw-Face $bmp (C 60 50 40) (C 230 200 170)
    Set-Px $bmp 19 26 (C 190 160 130)
    Set-Px $bmp 30 26 (C 190 160 130)
    # Elder robes
    Fill-Fabric $bmp 40 40 16 24 (C 50 50 55)
    # Puppet strings from fingers
    for ($y=56; $y -le 63; $y++) { Set-Px $bmp 92 $y (C 180 200 220) }
    for ($y=56; $y -le 63; $y++) { Set-Px $bmp 94 $y (C 180 200 220) }
}

Write-Host ""
Write-Host "=== NEW WAVE 3: AKATSUKI ==="

# 031 - Pain/Nagato (Deva Path)
Make-Entity "$entityDir\pain.png" (C 255 220 180) (C 255 120 30) (C 20 20 25) (C 20 20 25) (C 40 40 50) (C 200 200 200) {
    param($bmp)
    # Orange spiky hair
    Fill-Hair $bmp 20 8 8 8 (C 255 120 30)
    Fill-Hair $bmp 16 10 6 6 (C 255 115 25)
    Fill-Hair $bmp 28 10 6 6 (C 255 115 25)
    # No headband but Ame slashed
    Draw-Headband $bmp "akatsuki" 16 20
    # Rinnegan eyes (concentric circles)
    Fill-Rect $bmp 20 24 3 2 (C 180 160 200)
    Set-Px $bmp 21 24 (C 160 140 180)
    Fill-Rect $bmp 27 24 3 2 (C 180 160 200)
    Set-Px $bmp 28 24 (C 160 140 180)
    # Piercings (orange dots)
    Set-Px $bmp 24 26 (C 180 180 190)  # Nose
    Set-Px $bmp 22 29 (C 180 180 190)  # Chin
    Set-Px $bmp 26 29 (C 180 180 190)
    Set-Px $bmp 17 25 (C 180 180 190)  # Ear
    Set-Px $bmp 32 25 (C 180 180 190)
    # Akatsuki cloak
    Draw-AkatsukiCloak $bmp
}

# 032 - Konan
Make-Entity "$entityDir\konan.png" (C 255 225 195) (C 40 50 120) (C 20 20 25) (C 20 20 25) (C 40 40 50) (C 200 200 200) {
    param($bmp)
    # Blue hair with paper flower
    Fill-Hair $bmp 0 16 16 16 (C 40 50 120)
    Fill-Hair $bmp 32 16 16 16 (C 40 50 120)
    Fill-Hair $bmp 16 16 16 4 (C 45 55 125)
    # Paper flower ornament
    Set-Px $bmp 30 17 (C 255 255 255)
    Set-Px $bmp 31 16 (C 255 255 255)
    Set-Px $bmp 31 17 (C 255 200 200)
    Set-Px $bmp 32 17 (C 255 255 255)
    Draw-Headband $bmp "akatsuki" 16 20
    # Amber eyes
    Draw-Face $bmp (C 200 160 50) (C 255 225 195)
    # Lip piercing
    Set-Px $bmp 24 29 (C 180 180 190)
    # Akatsuki cloak
    Draw-AkatsukiCloak $bmp
}

# 033 - Deidara
Make-Entity "$entityDir\deidara.png" (C 255 225 195) (C 240 220 100) (C 20 20 25) (C 20 20 25) (C 40 40 50) (C 200 200 200) {
    param($bmp)
    # Long blonde hair (one eye covered)
    Fill-Hair $bmp 16 16 16 6 (C 240 220 100)
    Fill-Hair $bmp 0 16 16 16 (C 240 220 100)
    # Hair covers left eye
    Fill-Hair $bmp 26 22 6 6 (C 240 220 100)
    Draw-Headband $bmp "akatsuki" 16 20
    # Blue visible eye (right only)
    Fill-Rect $bmp 20 24 3 2 (C 0 0 0)
    Set-Px $bmp 21 24 (C 60 140 200)
    Set-Px $bmp 24 26 (C 230 200 170)
    Fill-Rect $bmp 22 28 6 1 (C 200 150 130)
    # Mouth on palm detail (small detail on hand)
    Set-Px $bmp 91 58 (C 200 80 80)
    Set-Px $bmp 92 58 (C 200 80 80)
    # Akatsuki cloak
    Draw-AkatsukiCloak $bmp
    # Scope/eye device on left
    Set-Px $bmp 27 23 (C 120 120 130)
}

# 034 - Sasori
Make-Entity "$entityDir\sasori.png" (C 240 220 200) (C 180 60 40) (C 20 20 25) (C 20 20 25) (C 40 40 50) (C 200 200 200) {
    param($bmp)
    # Red messy hair
    Fill-Hair $bmp 20 10 8 6 (C 180 60 40)
    Fill-Hair $bmp 16 14 4 4 (C 175 55 35)
    Fill-Hair $bmp 28 14 4 4 (C 175 55 35)
    # Brown eyes (puppet-like gaze)
    Draw-Face $bmp (C 120 80 40) (C 240 220 200)
    # Puppet joint lines
    Set-Px $bmp 18 26 (C 160 140 120)
    Set-Px $bmp 31 26 (C 160 140 120)
    # Akatsuki cloak
    Draw-AkatsukiCloak $bmp
    # Core canister visible (heart container in chest)
    Set-Px $bmp 48 48 (C 160 30 30)
    Set-Px $bmp 48 49 (C 160 30 30)
}

# 035 - Hidan
Make-Entity "$entityDir\hidan.png" (C 255 220 180) (C 200 200 210) (C 20 20 25) (C 20 20 25) (C 40 40 50) (C 200 200 200) {
    param($bmp)
    # Slicked back silver hair
    Fill-Hair $bmp 16 16 16 4 (C 200 200 210)
    Fill-Hair $bmp 48 16 16 8 (C 200 200 210)
    Draw-Headband $bmp "akatsuki" 16 20
    # Pink/violet eyes
    Draw-Face $bmp (C 180 80 180) (C 255 220 180)
    # Jashin pendant (circle with triangle)
    Set-Px $bmp 24 31 (C 200 200 210)
    Set-Px $bmp 23 32 (C 200 200 210); Set-Px $bmp 25 32 (C 200 200 210)
    Set-Px $bmp 24 32 (C 200 30 30)
    # Akatsuki cloak (open showing chest)
    Draw-AkatsukiCloak $bmp
    # Scythe on back
    Fill-Metal $bmp 66 40 2 20 (C 160 160 170)  # Handle
    Fill-Metal $bmp 60 40 8 2 (C 200 30 30)     # Red blade
    Fill-Metal $bmp 58 42 10 2 (C 200 30 30)
    Fill-Metal $bmp 56 44 12 2 (C 200 30 30)
}

# 036 - Kakuzu
Make-Entity "$entityDir\kakuzu.png" (C 140 110 80) (C 30 25 20) (C 20 20 25) (C 20 20 25) (C 40 40 50) (C 200 200 200) {
    param($bmp)
    # Dark brown long hair
    Fill-Hair $bmp 0 16 16 16 (C 30 25 20)
    Fill-Hair $bmp 32 16 16 16 (C 30 25 20)
    Draw-Headband $bmp "akatsuki" 16 20
    # Green eyes (glowing)
    Draw-Face $bmp (C 50 200 50) (C 140 110 80)
    # Stitching/mask on face
    Fill-Rect $bmp 16 27 16 5 (C 50 50 50)  # Mask
    Set-Px $bmp 20 28 (C 80 80 80); Set-Px $bmp 24 28 (C 80 80 80); Set-Px $bmp 28 28 (C 80 80 80)
    # Akatsuki cloak
    Draw-AkatsukiCloak $bmp
    # Thread/tendril details on body
    Set-Px $bmp 44 50 (C 40 40 40); Set-Px $bmp 44 51 (C 40 40 40)
    Set-Px $bmp 50 50 (C 40 40 40); Set-Px $bmp 50 51 (C 40 40 40)
}

# 037 - Kisame Hoshigaki
Make-Entity "$entityDir\kisame.png" (C 100 130 180) (C 30 40 70) (C 20 20 25) (C 20 20 25) (C 40 40 50) (C 200 200 200) {
    param($bmp)
    # Tall spiky dark blue hair
    Fill-Hair $bmp 20 8 8 8 (C 30 40 70)
    Fill-Hair $bmp 16 12 6 6 (C 25 35 65)
    Fill-Hair $bmp 28 12 6 6 (C 25 35 65)
    Draw-Headband $bmp "akatsuki" 16 20
    # Small beady eyes
    Draw-Face $bmp (C 200 200 200) (C 100 130 180)
    # Gill marks on cheeks
    Set-Px $bmp 18 25 (C 60 80 130); Set-Px $bmp 18 26 (C 60 80 130); Set-Px $bmp 18 27 (C 60 80 130)
    Set-Px $bmp 31 25 (C 60 80 130); Set-Px $bmp 31 26 (C 60 80 130); Set-Px $bmp 31 27 (C 60 80 130)
    # Sharp teeth
    Fill-Rect $bmp 22 28 6 1 (C 255 255 255)
    # Akatsuki cloak
    Draw-AkatsukiCloak $bmp
    # Samehada (shark-skin sword) on back
    Fill-Rect $bmp 66 36 4 28 (C 80 100 140)
    Fill-Rect $bmp 64 38 2 24 (C 60 80 120)
    Fill-Rect $bmp 70 38 2 24 (C 60 80 120)
}

# 038 - Zetsu (White)
Make-Entity "$entityDir\zetsu.png" (C 220 230 200) (C 60 100 40) (C 20 20 25) (C 20 20 25) (C 40 40 50) (C 200 200 200) {
    param($bmp)
    # Venus flytrap framing head (green)
    Fill-Noisy $bmp 12 10 6 22 (C 60 100 40) 12
    Fill-Noisy $bmp 32 10 6 22 (C 60 100 40) 12
    Fill-Noisy $bmp 14 8 4 4 (C 50 90 30) 10
    Fill-Noisy $bmp 32 8 4 4 (C 50 90 30) 10
    # Split face (half white, half dark)
    Fill-Skin $bmp 16 16 8 16 (C 220 230 200) # White half
    Fill-Skin $bmp 24 16 8 16 (C 30 30 30)    # Black half
    # Yellow eyes
    Set-Px $bmp 21 24 (C 240 220 0)
    Set-Px $bmp 28 24 (C 240 220 0)
    # Akatsuki cloak
    Draw-AkatsukiCloak $bmp
}

# 039 - Tobi/Obito (Masked)
Make-Entity "$entityDir\tobi.png" (C 255 220 180) (C 20 15 25) (C 20 20 25) (C 20 20 25) (C 40 40 50) (C 255 120 30) {
    param($bmp)
    # Short spiky black hair
    Fill-Hair $bmp 20 10 8 6 (C 20 15 25)
    Fill-Hair $bmp 16 14 4 4 (C 25 20 30)
    Fill-Hair $bmp 28 14 4 4 (C 25 20 30)
    # Orange spiral mask covering whole face
    Fill-Noisy $bmp 16 16 16 16 (C 255 120 30) 6
    # Single eye hole (right eye)
    Set-Px $bmp 21 24 (C 0 0 0)
    Set-Px $bmp 22 24 (C 0 0 0)
    # Spiral pattern on mask
    Set-Px $bmp 24 22 (C 220 100 20)
    Set-Px $bmp 25 23 (C 220 100 20)
    Set-Px $bmp 26 24 (C 220 100 20)
    Set-Px $bmp 25 25 (C 220 100 20)
    Set-Px $bmp 24 26 (C 220 100 20)
    # Akatsuki cloak
    Draw-AkatsukiCloak $bmp
}

Write-Host ""
Write-Host "=== NEW WAVE 4: KAGE + LEGENDARY ==="

# 040 - Hashirama Senju (1st Hokage)
Make-Entity "$entityDir\hashirama.png" (C 255 215 175) (C 30 20 15) (C 200 30 30) (C 30 30 40) (C 40 40 50) (C 200 30 30) {
    param($bmp)
    # Long dark straight hair
    Fill-Hair $bmp 0 16 16 16 (C 30 20 15)
    Fill-Hair $bmp 32 16 16 16 (C 30 20 15)
    Fill-Hair $bmp 48 16 16 16 (C 30 20 15)
    Fill-Hair $bmp 64 40 16 16 (C 30 20 15)
    Draw-Headband $bmp "konoha" 16 20
    Draw-Face $bmp (C 50 35 20) (C 255 215 175)
    # Red armor (samurai-like)
    Fill-Metal $bmp 40 40 16 14 (C 180 30 30)
    Fill-Metal $bmp 32 40 8 14 (C 160 25 25)
    Fill-Metal $bmp 56 40 8 14 (C 160 25 25)
    # Shoulder guards
    Fill-Metal $bmp 88 40 8 6 (C 180 30 30)
    Fill-Metal $bmp 80 40 8 6 (C 160 25 25)
}

# 041 - Tobirama Senju (2nd Hokage)
Make-Entity "$entityDir\tobirama.png" (C 255 220 180) (C 200 200 210) (C 30 60 120) (C 30 50 100) (C 40 40 50) (C 200 200 200) {
    param($bmp)
    # White spiky hair
    Fill-Hair $bmp 20 10 8 6 (C 200 200 210)
    Fill-Hair $bmp 16 14 6 4 (C 195 195 205)
    Fill-Hair $bmp 28 14 6 4 (C 195 195 205)
    Draw-Headband $bmp "konoha" 16 20
    # Red lines on face (cheek marks)
    Draw-Face $bmp (C 180 30 30) (C 255 220 180)
    Set-Px $bmp 19 25 (C 180 30 30); Set-Px $bmp 18 26 (C 180 30 30)
    Set-Px $bmp 30 25 (C 180 30 30); Set-Px $bmp 31 26 (C 180 30 30)
    # Blue armor
    Fill-Metal $bmp 40 40 16 14 (C 30 60 120)
    Fill-Metal $bmp 32 40 8 14 (C 25 50 100)
    Fill-Metal $bmp 56 40 8 14 (C 25 50 100)
    # Fur collar
    Fill-Noisy $bmp 16 28 16 4 (C 200 190 170) 6
}

# 042 - Hiruzen Sarutobi (3rd Hokage)
Make-Entity "$entityDir\hiruzen.png" (C 230 200 170) (C 140 130 120) (C 200 30 30) (C 30 30 40) (C 40 40 50) (C 200 200 200) {
    param($bmp)
    # Gray hair (old)
    Fill-Hair $bmp 16 16 16 3 (C 140 130 120)
    # Hokage hat
    Fill-Fabric $bmp 14 10 20 8 (C 240 240 240)
    Fill-Fabric $bmp 18 6 12 4 (C 240 240 240)
    Fill-Rect $bmp 22 8 6 2 (C 200 30 30) # Fire kanji on hat
    Draw-Face $bmp (C 40 30 20) (C 230 200 170)
    # Goatee
    Fill-Rect $bmp 23 29 4 2 (C 120 110 100)
    # Red/white Hokage robes
    Fill-Fabric $bmp 40 40 16 24 (C 240 240 240)
    Fill-Fabric $bmp 32 40 8 24 (C 200 30 30)
    Fill-Fabric $bmp 56 40 8 24 (C 200 30 30)
    # Pipe
    Set-Px $bmp 31 29 (C 100 80 50)
    Set-Px $bmp 32 29 (C 100 80 50)
    Set-Px $bmp 33 28 (C 80 80 80)
}

# 043 - A/Raikage (4th)
Make-Entity "$entityDir\raikage.png" (C 160 110 60) (C 240 220 100) (C 30 30 80) (C 30 30 60) (C 40 40 50) (C 255 220 50) {
    param($bmp)
    # Blonde/white combed back hair
    Fill-Hair $bmp 16 16 16 4 (C 240 220 100)
    Fill-Hair $bmp 48 16 16 8 (C 240 220 100)
    Draw-Headband $bmp "kumo" 16 20
    Draw-Face $bmp (C 30 30 30) (C 160 110 60)
    # Stern expression
    Fill-Rect $bmp 19 22 4 1 (C 100 60 30) # Thick brows
    Fill-Rect $bmp 27 22 4 1 (C 100 60 30)
    # Massive muscular build -> wider chest
    Fill-Fabric $bmp 40 40 16 24 (C 30 30 80)
    # Lightning aura detail (yellow)
    Set-Px $bmp 36 42 (C 255 255 100); Set-Px $bmp 60 44 (C 255 255 100)
    Set-Px $bmp 38 56 (C 255 255 100); Set-Px $bmp 58 50 (C 255 255 100)
    # Bracers
    Fill-Metal $bmp 88 42 8 4 (C 200 200 210)
    Fill-Metal $bmp 80 42 8 4 (C 200 200 210)
}

# 044 - Mei Terumi (5th Mizukage)
Make-Entity "$entityDir\mei.png" (C 255 225 195) (C 160 60 40) (C 30 60 120) (C 30 50 100) (C 60 60 70) (C 30 60 120) {
    param($bmp)
    # Long auburn/red hair (covering right eye)
    Fill-Hair $bmp 0 16 16 16 (C 160 60 40)
    Fill-Hair $bmp 32 16 16 16 (C 160 60 40)
    Fill-Hair $bmp 48 16 16 16 (C 160 60 40)
    # Hair over right eye
    Fill-Hair $bmp 19 22 5 6 (C 160 60 40)
    Draw-Headband $bmp "kiri" 16 20
    # Green visible eye (left only)
    Fill-Rect $bmp 27 24 3 2 (C 0 0 0)
    Set-Px $bmp 28 24 (C 50 180 80)
    Set-Px $bmp 24 26 (C 230 195 175)
    Fill-Rect $bmp 22 28 6 1 (C 200 80 80) # Red lips
    # Blue dress
    Fill-Fabric $bmp 40 40 16 24 (C 30 60 120)
    # Mesh top visible
    Fill-Fabric $bmp 40 40 16 3 (C 120 110 100)
}

# 045 - Onoki (3rd Tsuchikage)
Make-Entity "$entityDir\onoki.png" (C 230 200 170) (C 180 170 160) (C 120 60 50) (C 80 70 60) (C 50 50 55) (C 200 30 30) {
    param($bmp)
    # Gray/white hair, balding with triangle goatee
    Fill-Hair $bmp 18 16 3 3 (C 180 170 160)
    Fill-Hair $bmp 29 16 3 3 (C 180 170 160)
    # Iwa headband
    Draw-Headband $bmp "iwa" 16 20
    Draw-Face $bmp (C 60 50 40) (C 230 200 170)
    # Big round nose
    Set-Px $bmp 23 26 (C 200 170 140); Set-Px $bmp 24 26 (C 200 170 140); Set-Px $bmp 25 26 (C 200 170 140)
    # Triangle goatee
    Set-Px $bmp 24 29 (C 160 150 140); Set-Px $bmp 23 30 (C 160 150 140); Set-Px $bmp 25 30 (C 160 150 140)
    # Red/brown Kage robes
    Fill-Fabric $bmp 40 40 16 24 (C 120 60 50)
    # Small stature (texture same, scale will be smaller)
}

# 046 - Killer B
Make-Entity "$entityDir\killer_b.png" (C 160 110 60) (C 240 240 245) (C 200 200 210) (C 30 30 40) (C 40 40 50) (C 255 255 255) {
    param($bmp)
    # White/blonde dreads/cornrows
    Fill-Hair $bmp 16 16 16 6 (C 240 240 245)
    Fill-Hair $bmp 0 16 16 16 (C 240 240 245)
    Fill-Hair $bmp 32 16 16 16 (C 240 240 245)
    # Sunglasses
    Fill-Rect $bmp 19 23 12 3 (C 15 15 15)
    Fill-Rect $bmp 20 24 4 2 (C 10 10 10)
    Fill-Rect $bmp 27 24 4 2 (C 10 10 10)
    Draw-Headband $bmp "kumo" 16 20
    Set-Px $bmp 24 26 (C 130 80 40)
    Fill-Rect $bmp 22 28 6 1 (C 130 80 40)
    # White combat vest
    Fill-Fabric $bmp 40 40 16 12 (C 200 200 210)
    # Seven swords holster on back
    for ($x=64; $x -le 78; $x+=2) {
        Fill-Metal $bmp $x 40 1 20 (C 180 180 190)
    }
    # Tattoos on shoulder
    Set-Px $bmp 90 42 (C 40 40 40); Set-Px $bmp 91 43 (C 40 40 40)
    Set-Px $bmp 90 44 (C 40 40 40); Set-Px $bmp 91 45 (C 40 40 40)
}

# 047 - Madara Uchiha
Make-Entity "$entityDir\madara.png" (C 255 220 180) (C 15 10 20) (C 180 20 20) (C 30 30 40) (C 40 40 50) (C 200 30 30) {
    param($bmp)
    # Very long wild black hair
    Fill-Hair $bmp 0 8 16 24 (C 15 10 20)
    Fill-Hair $bmp 32 8 16 24 (C 15 10 20)
    Fill-Hair $bmp 48 8 16 24 (C 15 10 20)
    Fill-Hair $bmp 64 36 16 28 (C 15 10 20)
    # Hair extends past shoulders
    Fill-Hair $bmp 16 8 16 8 (C 15 10 20)
    # Eternal Mangekyou Sharingan
    Fill-Rect $bmp 20 24 3 2 (C 200 30 30)
    Set-Px $bmp 21 24 (C 255 0 0)
    Fill-Rect $bmp 27 24 3 2 (C 200 30 30)
    Set-Px $bmp 28 24 (C 255 0 0)
    Set-Px $bmp 24 26 (C 230 190 160)
    Fill-Rect $bmp 22 28 6 1 (C 200 150 130)
    # Red samurai armor
    Fill-Metal $bmp 40 40 16 14 (C 180 20 20)
    Fill-Metal $bmp 32 40 8 14 (C 160 15 15)
    Fill-Metal $bmp 56 40 8 14 (C 160 15 15)
    # Gunbai fan on back
    Fill-Noisy $bmp 66 40 10 12 (C 180 160 120) 8
    Fill-Metal $bmp 70 52 2 12 (C 120 100 60)
}

# 048 - Obito Uchiha (Unmasked)
Make-Entity "$entityDir\obito.png" (C 255 220 180) (C 20 15 25) (C 30 30 40) (C 30 30 40) (C 40 40 50) (C 200 30 30) {
    param($bmp)
    # Short spiky black hair
    Fill-Hair $bmp 20 10 8 6 (C 20 15 25)
    Fill-Hair $bmp 16 12 6 4 (C 25 20 30)
    Fill-Hair $bmp 28 12 6 4 (C 25 20 30)
    Draw-Headband $bmp "konoha" 16 20
    # Sharingan in left eye, normal right
    Fill-Rect $bmp 20 24 3 2 (C 0 0 0)
    Set-Px $bmp 21 24 (C 30 30 30)              # Normal right eye
    Fill-Rect $bmp 27 24 3 2 (C 0 0 0)
    Set-Px $bmp 28 24 (C 200 30 30)              # Sharingan left
    Set-Px $bmp 24 26 (C 230 200 160)
    Fill-Rect $bmp 22 28 6 1 (C 200 150 130)
    # Scarred right side of face
    Set-Px $bmp 18 24 (C 200 160 140)
    Set-Px $bmp 18 25 (C 200 160 140)
    Set-Px $bmp 19 26 (C 200 160 140)
    # Orange goggles pushed up
    Fill-Rect $bmp 18 19 4 2 (C 255 140 30)
    Fill-Rect $bmp 28 19 4 2 (C 255 140 30)
    # Dark outfit with Uchiha crest
    Fill-Fabric $bmp 40 40 16 24 (C 30 30 40)
    Fill-Rect $bmp 70 44 6 8 (C 200 200 210)
    Fill-Rect $bmp 70 44 6 4 (C 180 30 30)
}

Write-Host ""
Write-Host "=== NEW WAVE 5: SOUND + ROGUE ==="

# 049 - Kabuto Yakushi
Make-Entity "$entityDir\kabuto.png" (C 255 220 180) (C 160 160 170) (C 120 100 140) (C 50 50 60) (C 40 40 50) (C 200 200 200) {
    param($bmp)
    # Gray hair in ponytail
    Fill-Hair $bmp 16 16 16 4 (C 160 160 170)
    Fill-Hair $bmp 48 16 16 12 (C 160 160 170) # Ponytail
    # No headband (later gains Oto)
    # Glasses
    Fill-Rect $bmp 18 23 6 3 (C 180 200 220)
    Fill-Rect $bmp 26 23 6 3 (C 180 200 220)
    Fill-Rect $bmp 24 24 2 1 (C 180 200 220)  # Bridge
    Set-Px $bmp 20 24 (C 20 20 30)
    Set-Px $bmp 28 24 (C 20 20 30)
    Set-Px $bmp 24 26 (C 230 200 160)
    Fill-Rect $bmp 22 28 6 1 (C 200 150 130)
    # Purple outfit (spy)
    Fill-Fabric $bmp 40 40 16 24 (C 120 100 140)
    # Healing chakra glow on hands
    Set-Px $bmp 91 58 (C 100 200 255)
    Set-Px $bmp 92 58 (C 100 200 255)
    Set-Px $bmp 75 122 (C 100 200 255)
    Set-Px $bmp 76 122 (C 100 200 255)
}

# 050 - Zabuza Momochi
Make-Entity "$entityDir\zabuza.png" (C 255 215 175) (C 20 15 25) (C 40 40 45) (C 40 40 45) (C 40 40 50) (C 120 120 130) {
    param($bmp)
    # Short spiky dark hair
    Fill-Hair $bmp 20 12 8 4 (C 20 15 25)
    # Kiri headband (tilted)
    Draw-Headband $bmp "kiri" 16 20
    # Bandaged face (lower)
    Fill-Fabric $bmp 16 26 16 6 (C 200 190 170)
    # Narrow eyes
    Fill-Rect $bmp 20 24 3 1 (C 10 10 15)
    Fill-Rect $bmp 27 24 3 1 (C 10 10 15)
    # No shirt - bare chest with bandages
    Fill-Skin $bmp 40 40 16 12 (C 255 215 175)
    Fill-Rect $bmp 40 44 16 1 (C 200 190 170) # Bandage wraps
    Fill-Rect $bmp 40 48 16 1 (C 200 190 170)
    # Kubikiribocho (giant cleaver) on back
    Fill-Metal $bmp 64 32 4 32 (C 180 180 190)
    Fill-Metal $bmp 62 34 2 28 (C 160 160 170)
    Fill-Metal $bmp 68 34 2 28 (C 160 160 170)
    Fill-Rect $bmp 65 38 2 6 (C 100 100 100) # Hole in blade
}

# 051 - Haku
Make-Entity "$entityDir\haku.png" (C 255 230 210) (C 20 15 25) (C 50 120 100) (C 30 80 70) (C 40 40 50) (C 100 180 220) {
    param($bmp)
    # Long black hair
    Fill-Hair $bmp 0 16 16 16 (C 20 15 25)
    Fill-Hair $bmp 32 16 16 16 (C 20 15 25)
    Fill-Hair $bmp 48 16 16 16 (C 20 15 25)
    # Hunter-nin mask covering face
    Fill-Noisy $bmp 16 16 16 16 (C 240 235 225) 3
    # Red wave marks on mask
    Set-Px $bmp 20 22 (C 200 50 50)
    Set-Px $bmp 21 23 (C 200 50 50)
    Set-Px $bmp 28 22 (C 200 50 50)
    Set-Px $bmp 29 23 (C 200 50 50)
    # Eye slits
    Fill-Rect $bmp 20 24 3 1 (C 10 10 10)
    Fill-Rect $bmp 27 24 3 1 (C 10 10 10)
    # Green kimono
    Fill-Fabric $bmp 40 40 16 24 (C 50 120 100)
    Fill-Fabric $bmp 32 40 8 24 (C 50 120 100)
    Fill-Fabric $bmp 56 40 8 24 (C 50 120 100)
    # Ice crystal detail
    Set-Px $bmp 46 48 (C 180 220 255)
    Set-Px $bmp 48 47 (C 180 220 255)
    Set-Px $bmp 50 48 (C 180 220 255)
}

# 052 - Danzo Shimura
Make-Entity "$entityDir\danzo.png" (C 230 200 170) (C 30 25 20) (C 50 50 55) (C 50 50 55) (C 40 40 50) (C 200 200 200) {
    param($bmp)
    # Short dark hair (elderly)
    Fill-Hair $bmp 16 16 16 3 (C 30 25 20)
    # X-shaped scar on chin
    Set-Px $bmp 23 30 (C 190 160 130); Set-Px $bmp 24 29 (C 190 160 130); Set-Px $bmp 25 30 (C 190 160 130)
    # Single visible eye (right bandaged)
    Fill-Rect $bmp 20 24 3 2 (C 0 0 0)
    Set-Px $bmp 21 24 (C 40 30 20)
    Fill-Fabric $bmp 26 22 6 6 (C 200 190 170) # Bandages over right eye
    Draw-Face $bmp (C 40 30 20) (C 230 200 170)
    # Dark robes
    Fill-Fabric $bmp 40 40 16 24 (C 50 50 55)
    # Bandaged arm (Sharingan arm - off-white wrapping)
    Fill-Fabric $bmp 88 40 8 24 (C 200 190 170)
    Fill-Fabric $bmp 80 40 8 24 (C 200 190 170)
    Fill-Fabric $bmp 96 40 8 24 (C 200 190 170)
    Fill-Fabric $bmp 104 40 8 24 (C 200 190 170)
    # Walking cane
    Set-Px $bmp 96 56 (C 100 80 50); Set-Px $bmp 96 57 (C 100 80 50)
    Set-Px $bmp 96 58 (C 100 80 50); Set-Px $bmp 96 59 (C 100 80 50)
}

# 053 - Suigetsu Hozuki
Make-Entity "$entityDir\suigetsu.png" (C 245 235 225) (C 180 200 230) (C 120 100 160) (C 50 50 60) (C 40 40 50) (C 80 130 200) {
    param($bmp)
    # White/light blue hair (messy)
    Fill-Hair $bmp 20 10 8 6 (C 180 200 230)
    Fill-Hair $bmp 16 12 6 4 (C 175 195 225)
    Fill-Hair $bmp 28 12 6 4 (C 175 195 225)
    # Purple eyes
    Draw-Face $bmp (C 140 80 200) (C 245 235 225)
    # Sharp teeth (like Zabuza's swordsmen)
    Fill-Rect $bmp 22 28 6 1 (C 255 255 255)
    Set-Px $bmp 23 28 (C 240 240 240)
    Set-Px $bmp 26 28 (C 240 240 240)
    # Purple outfit
    Fill-Fabric $bmp 40 40 16 24 (C 120 100 160)
    # Executioner's Blade on back (inherited from Zabuza)
    Fill-Metal $bmp 66 36 4 28 (C 180 180 190)
    Fill-Rect $bmp 67 42 2 6 (C 100 100 100)
    # Water dripping effect (liquid body)
    Set-Px $bmp 90 56 (C 120 180 220)
    Set-Px $bmp 90 57 (C 100 160 200)
}

# 054 - Karin Uzumaki
Make-Entity "$entityDir\karin.png" (C 255 225 195) (C 180 30 30) (C 120 80 130) (C 50 50 60) (C 40 40 50) (C 180 30 30) {
    param($bmp)
    # Long red hair
    Fill-Hair $bmp 0 16 16 16 (C 180 30 30)
    Fill-Hair $bmp 32 16 16 16 (C 180 30 30)
    Fill-Hair $bmp 16 16 16 4 (C 185 35 35) # Bangs
    # Glasses
    Fill-Rect $bmp 18 23 6 3 (C 20 20 20)
    Fill-Rect $bmp 26 23 6 3 (C 20 20 20)
    Fill-Rect $bmp 24 24 2 1 (C 40 40 40)
    Set-Px $bmp 20 24 (C 180 30 30) # Red eyes behind glasses
    Set-Px $bmp 28 24 (C 180 30 30)
    Set-Px $bmp 24 26 (C 230 200 170)
    Fill-Rect $bmp 22 28 6 1 (C 200 100 100)
    # Purple outfit
    Fill-Fabric $bmp 40 40 16 24 (C 120 80 130)
    # Bite marks on arms (healing ability)
    Set-Px $bmp 90 48 (C 200 100 100); Set-Px $bmp 91 48 (C 200 100 100)
    Set-Px $bmp 90 52 (C 200 100 100); Set-Px $bmp 91 52 (C 200 100 100)
}

# 055 - Jugo
Make-Entity "$entityDir\jugo.png" (C 255 215 175) (C 200 130 50) (C 50 50 55) (C 50 50 55) (C 40 40 50) (C 200 120 50) {
    param($bmp)
    # Orange/brown spiky hair
    Fill-Hair $bmp 20 8 8 8 (C 200 130 50)
    Fill-Hair $bmp 16 10 6 6 (C 195 125 45)
    Fill-Hair $bmp 28 10 6 6 (C 195 125 45)
    Draw-Face $bmp (C 200 120 50) (C 255 215 175)
    # Gentle expression (when calm)
    Fill-Rect $bmp 22 28 6 1 (C 200 160 130)
    # Curse mark activation spots (scattered dark patches)
    Set-Px $bmp 18 25 (C 80 50 30); Set-Px $bmp 31 26 (C 80 50 30)
    Set-Px $bmp 92 46 (C 80 50 30); Set-Px $bmp 93 48 (C 80 50 30)
    # Large muscular build -> indicated by darker shading on chest
    Fill-Fabric $bmp 40 40 16 24 (C 50 50 55)
    # Nature affinity (bird on shoulder)
    Set-Px $bmp 88 40 (C 200 200 100); Set-Px $bmp 89 40 (C 200 200 100)
    Set-Px $bmp 88 39 (C 200 200 100)
}

Write-Host ""
Write-Host "=============================================="
Write-Host " Generation Complete! 55 NPC textures created."
Write-Host "=============================================="
Write-Host ""
Write-Host "Summary:"
$files = Get-ChildItem "$entityDir\*.png" | Measure-Object
Write-Host "  Total entity textures: $($files.Count)"
$totalSize = (Get-ChildItem "$entityDir\*.png" | Measure-Object -Property Length -Sum).Sum / 1024
Write-Host "  Total size: $([Math]::Round($totalSize, 1)) KB"
