# =====================================================
# EXPANDED CONTENT GENERATOR - Boost to >2MB
# High-res textures, GUI, advancements, loot, structures
# =====================================================
Add-Type -AssemblyName System.Drawing

$base = "C:\Users\andra\MCreatorWorkspaces\projetokonoha\src\main\resources\assets\projetokonoha"
$dataBase = "C:\Users\andra\MCreatorWorkspaces\projetokonoha\src\main\resources"

$guiDir = "$base\textures\gui"
$entityDir = "$base\textures\entity"
$envDir = "$base\textures\environment"
$advDir = "$dataBase\data\projetokonoha\advancements"
$lootDir = "$dataBase\data\projetokonoha\loot_tables\entities"

foreach ($d in @($guiDir, $entityDir, $envDir, $advDir, $lootDir)) {
    if (!(Test-Path $d)) { New-Item -ItemType Directory -Path $d -Force | Out-Null }
}

function C([int]$r,[int]$g,[int]$b){ return [System.Drawing.Color]::FromArgb(255,$r,$g,$b) }
function CA([int]$a,[int]$r,[int]$g,[int]$b){ return [System.Drawing.Color]::FromArgb($a,$r,$g,$b) }

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

# Perlin-like noise fill (dithered)
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

# ============= HIGH-RES ENTITY TEXTURES (128x128) =============
Write-Host "=== Generating High-Resolution Entity Textures ==="

# Helper: full detailed skin at 128x128 (scaled Minecraft skin layout)
function Make-DetailedEntity($path, $skinCol, $hairCol, $topCol, $pantsCol, $shoeCol, $accentCol, $detailFunc) {
    $bmp = New-Object System.Drawing.Bitmap(128, 128)
    $bmp.SetResolution(72,72)

    # Scale = 2x of standard 64x64
    # HEAD region: (0,0)-(64,32) area
    # Top of head
    Fill-Noisy $bmp 16 0 16 16 $hairCol 15
    # Bottom of head
    Fill-Noisy $bmp 32 0 16 16 $skinCol 8
    # Right side of head
    Fill-Noisy $bmp 0 16 16 16 $skinCol 8
    Fill-Noisy $bmp 0 16 16 6 $hairCol 12     # hair
    # Front face
    Fill-Noisy $bmp 16 16 16 16 $skinCol 8
    Fill-Noisy $bmp 16 16 16 4 $hairCol 12    # bangs
    # Eyes (at scaled position)
    Fill-Rect $bmp 20 24 3 2 (C 0 0 0)        # left eye
    Fill-Rect $bmp 27 24 3 2 (C 0 0 0)        # right eye
    Set-Px $bmp 21 24 (C 40 40 40)            # pupil highlight
    Set-Px $bmp 28 24 (C 40 40 40)
    # Nose
    Set-Px $bmp 24 26 (C 200 170 140)
    # Mouth
    Fill-Rect $bmp 22 28 6 1 (C 180 120 100)
    # Left side of head
    Fill-Noisy $bmp 32 16 16 16 $skinCol 8
    Fill-Noisy $bmp 32 16 16 6 $hairCol 12
    # Back of head
    Fill-Noisy $bmp 48 16 16 16 $hairCol 12

    # BODY region
    # Top of body
    Fill-Noisy $bmp 40 32 16 8 $topCol 12
    # Right side
    Fill-Noisy $bmp 32 40 8 24 $topCol 10
    # Front
    Fill-Noisy $bmp 40 40 16 24 $topCol 10
    # Left side
    Fill-Noisy $bmp 56 40 8 24 $topCol 10
    # Back
    Fill-Noisy $bmp 64 40 16 24 $topCol 10

    # RIGHT ARM
    Fill-Noisy $bmp 88 32 8 8 $topCol 12      # top
    Fill-Noisy $bmp 88 40 8 24 $topCol 10     # right
    Fill-Noisy $bmp 80 40 8 24 $topCol 10     # front
    Fill-Noisy $bmp 96 40 8 24 $topCol 10     # left
    Fill-Noisy $bmp 104 40 8 24 $topCol 10    # back
    # Hands
    Fill-Noisy $bmp 88 56 8 8 $skinCol 8
    Fill-Noisy $bmp 80 56 8 8 $skinCol 8
    Fill-Noisy $bmp 96 56 8 8 $skinCol 8
    Fill-Noisy $bmp 104 56 8 8 $skinCol 8

    # RIGHT LEG
    Fill-Noisy $bmp 8 32 8 8 $pantsCol 10     # top
    Fill-Noisy $bmp 8 40 8 24 $pantsCol 10    # right
    Fill-Noisy $bmp 0 40 8 24 $pantsCol 10    # front
    Fill-Noisy $bmp 16 40 8 24 $pantsCol 10   # left
    Fill-Noisy $bmp 24 40 8 24 $pantsCol 10   # back
    # Shoes
    Fill-Noisy $bmp 8 56 8 8 $shoeCol 8
    Fill-Noisy $bmp 0 56 8 8 $shoeCol 8
    Fill-Noisy $bmp 16 56 8 8 $shoeCol 8
    Fill-Noisy $bmp 24 56 8 8 $shoeCol 8

    # LEFT ARM (64x64 format, lower half)
    Fill-Noisy $bmp 72 96 8 8 $topCol 12
    Fill-Noisy $bmp 72 104 8 24 $topCol 10
    Fill-Noisy $bmp 64 104 8 24 $topCol 10
    Fill-Noisy $bmp 80 104 8 24 $topCol 10
    Fill-Noisy $bmp 88 104 8 24 $topCol 10
    Fill-Noisy $bmp 72 120 8 8 $skinCol 8
    Fill-Noisy $bmp 64 120 8 8 $skinCol 8
    Fill-Noisy $bmp 80 120 8 8 $skinCol 8
    Fill-Noisy $bmp 88 120 8 8 $skinCol 8

    # LEFT LEG
    Fill-Noisy $bmp 40 96 8 8 $pantsCol 10
    Fill-Noisy $bmp 40 104 8 24 $pantsCol 10
    Fill-Noisy $bmp 32 104 8 24 $pantsCol 10
    Fill-Noisy $bmp 48 104 8 24 $pantsCol 10
    Fill-Noisy $bmp 56 104 8 24 $pantsCol 10
    Fill-Noisy $bmp 40 120 8 8 $shoeCol 8
    Fill-Noisy $bmp 32 120 8 8 $shoeCol 8
    Fill-Noisy $bmp 48 120 8 8 $shoeCol 8
    Fill-Noisy $bmp 56 120 8 8 $shoeCol 8

    # Apply custom details
    if ($detailFunc) { & $detailFunc $bmp }

    Save-Png $bmp $path
}

# Naruto entity (128x128)
Make-DetailedEntity "$entityDir\naruto.png" (C 255 220 180) (C 255 200 50) (C 255 140 0) (C 255 120 0) (C 30 100 200) (C 0 80 200) {
    param($bmp)
    # Headband (blue band across forehead)
    Fill-Rect $bmp 16 20 16 2 (C 30 100 200)
    Fill-Rect $bmp 22 20 6 2 (C 180 180 200)    # metal plate
    # Whisker marks
    for ($i=0; $i -lt 3; $i++) {
        Set-Px $bmp (18+$i) 27 (C 180 150 120)
        Set-Px $bmp (27+$i) 27 (C 180 150 120)
    }
    # Orange zipper
    for ($y=40; $y -le 63; $y++) { Set-Px $bmp 48 $y (C 80 80 80) }
    # Uzumaki swirl on back
    Fill-Rect $bmp 72 46 4 4 (C 200 30 30)
    Set-Px $bmp 73 47 (C 255 255 255)
}

# Sasuke entity (128x128)
Make-DetailedEntity "$entityDir\sasuke.png" (C 255 220 180) (C 20 20 40) (C 25 25 100) (C 240 240 250) (C 50 50 70) (C 128 0 128) {
    param($bmp)
    # Headband
    Fill-Rect $bmp 16 20 16 2 (C 25 25 80)
    Fill-Rect $bmp 22 20 6 2 (C 180 180 200)
    # Uchiha fan on back
    Fill-Rect $bmp 72 44 4 6 (C 200 30 30)      # top red
    Fill-Rect $bmp 72 50 4 4 (C 240 240 240)    # bottom white
    # Rope belt
    Fill-Rect $bmp 40 52 16 2 (C 128 0 160)
    # Darker eye tone (Sharingan hint)
    Set-Px $bmp 21 24 (C 180 0 0)
    Set-Px $bmp 28 24 (C 180 0 0)
}

# Kakashi entity (128x128)
Make-DetailedEntity "$entityDir\kakashi.png" (C 255 220 180) (C 200 200 210) (C 40 70 40) (C 50 50 60) (C 40 40 50) (C 60 90 60) {
    param($bmp)
    # Mask (covers lower face)
    Fill-Rect $bmp 16 26 16 6 (C 50 50 60)
    # Tilted headband (covers left eye)
    Fill-Rect $bmp 16 20 16 2 (C 25 25 80)
    Fill-Rect $bmp 22 20 6 2 (C 180 180 200)
    Set-Px $bmp 20 22 (C 180 0 0)   # Sharingan underneath
    # Jounin vest detail
    Fill-Noisy $bmp 40 40 16 10 (C 60 90 60) 8
    # Vest pockets
    Fill-Rect $bmp 42 44 4 3 (C 50 80 50)
    Fill-Rect $bmp 50 44 4 3 (C 50 80 50)
    # Silver hair emphasis
    Fill-Noisy $bmp 16 16 16 4 (C 210 210 220) 10
    Fill-Noisy $bmp 20 14 8 2 (C 220 220 230) 8   # Hair sticking up
}

# Sakura entity (128x128)
Make-DetailedEntity "$entityDir\sakura.png" (C 255 220 180) (C 255 120 170) (C 200 30 60) (C 50 50 60) (C 45 45 55) (C 255 20 100) {
    param($bmp)
    # Pink hair - longer on sides
    Fill-Noisy $bmp 0 16 16 12 (C 255 120 170) 15
    Fill-Noisy $bmp 32 16 16 12 (C 255 120 170) 15
    Fill-Noisy $bmp 48 16 16 12 (C 255 140 180) 12
    # Headband (red)
    Fill-Rect $bmp 16 20 16 2 (C 200 30 60)
    Fill-Rect $bmp 22 20 6 2 (C 180 180 200)
    # Green eyes
    Set-Px $bmp 21 24 (C 0 160 60)
    Set-Px $bmp 28 24 (C 0 160 60)
    # Medical cross on top
    Fill-Rect $bmp 46 44 2 6 (C 255 255 255)
    Fill-Rect $bmp 44 46 6 2 (C 255 255 255)
    # Gloves (healer)
    Fill-Noisy $bmp 80 52 8 12 (C 40 40 50) 5
    Fill-Noisy $bmp 64 116 8 12 (C 40 40 50) 5
}

# ============= GUI TEXTURES =============
Write-Host "=== Generating GUI Textures ==="

# Jutsu Menu Background (256x256)
$bmp = New-Object System.Drawing.Bitmap(256, 256)
$bmp.SetResolution(72,72)
# Dark background with border
Fill-Noisy $bmp 0 0 256 256 (C 20 15 35) 5
# Inner panel
Fill-Noisy $bmp 4 4 248 248 (C 30 25 55) 4
# Border decorations
for ($i=0; $i -lt 256; $i+=2) {
    Set-Px $bmp $i 0 (C 80 60 140); Set-Px $bmp $i 1 (C 60 40 120)
    Set-Px $bmp $i 254 (C 80 60 140); Set-Px $bmp $i 255 (C 60 40 120)
    Set-Px $bmp 0 $i (C 80 60 140); Set-Px $bmp 1 $i (C 60 40 120)
    Set-Px $bmp 254 $i (C 80 60 140); Set-Px $bmp 255 $i (C 60 40 120)
}
# Konoha leaf watermark in center
for ($y=100; $y -lt 156; $y++) {
    for ($x=100; $x -lt 156; $x++) {
        $dx = $x - 128; $dy = $y - 128
        $dist = [Math]::Sqrt($dx*$dx + $dy*$dy)
        if ($dist -lt 25) {
            $alpha = [Math]::Max(0, 40 - [int]$dist)
            $c = $bmp.GetPixel($x, $y)
            $nr = [Math]::Min(255, $c.R + $alpha)
            $ng = [Math]::Min(255, $c.G + $alpha)
            $nb = [Math]::Min(255, $c.B + $alpha + 5)
            $bmp.SetPixel($x, $y, (C $nr $ng $nb))
        }
    }
}
# Title area highlight
Fill-Noisy $bmp 8 8 240 24 (C 40 30 70) 3
# Section separators
Fill-Rect $bmp 8 34 240 1 (C 80 60 140)
Fill-Rect $bmp 8 200 240 1 (C 80 60 140)
Save-Png $bmp "$guiDir\jutsu_menu_bg.png"

# Chakra Bar Texture (256x32)
$bmp = New-Object System.Drawing.Bitmap(256, 32)
$bmp.SetResolution(72,72)
Fill-Noisy $bmp 0 0 256 32 (C 20 20 40) 3
# Bar background
Fill-Noisy $bmp 2 2 252 12 (C 10 10 25) 2
# Bar fill (gradient blue)
for ($x=2; $x -lt 200; $x++) {
    $ratio = ($x - 2) / 198.0
    $r = [int](20 + 30 * $ratio)
    $g = [int](80 + 100 * $ratio)
    $b = [int](200 + 55 * $ratio)
    Fill-Rect $bmp $x 3 1 10 (C $r $g $b)
}
# XP bar background
Fill-Noisy $bmp 2 18 252 12 (C 10 10 25) 2
# XP fill (gradient gold)
for ($x=2; $x -lt 200; $x++) {
    $ratio = ($x - 2) / 198.0
    $r = [int](200 + 55 * $ratio)
    $g = [int](150 + 65 * $ratio)
    $b = [int](0 + 50 * $ratio)
    Fill-Rect $bmp $x 19 1 10 (C $r $g $b)
}
Save-Png $bmp "$guiDir\chakra_bar.png"

# Scroll GUI background (256x256) 
$bmp = New-Object System.Drawing.Bitmap(256, 256)
$bmp.SetResolution(72,72)
# Parchment color with texture
Fill-Noisy $bmp 0 0 256 256 (C 210 190 150) 12
# Burnt edges
for ($i=0; $i -lt 256; $i++) {
    for ($j=0; $j -lt 8; $j++) {
        $dark = 8 - $j
        $c = $bmp.GetPixel($i, $j)
        Set-Px $bmp $i $j (C ([Math]::Max(0,$c.R-$dark*15)) ([Math]::Max(0,$c.G-$dark*15)) ([Math]::Max(0,$c.B-$dark*8)))
        $c = $bmp.GetPixel($i, (255-$j))
        Set-Px $bmp $i (255-$j) (C ([Math]::Max(0,$c.R-$dark*15)) ([Math]::Max(0,$c.G-$dark*15)) ([Math]::Max(0,$c.B-$dark*8)))
        $c = $bmp.GetPixel($j, $i)
        Set-Px $bmp $j $i (C ([Math]::Max(0,$c.R-$dark*15)) ([Math]::Max(0,$c.G-$dark*15)) ([Math]::Max(0,$c.B-$dark*8)))
        $c = $bmp.GetPixel((255-$j), $i)
        Set-Px $bmp (255-$j) $i (C ([Math]::Max(0,$c.R-$dark*15)) ([Math]::Max(0,$c.G-$dark*15)) ([Math]::Max(0,$c.B-$dark*8)))
    }
}
# Seal marks
for ($angle = 0; $angle -lt 360; $angle += 15) {
    $rad = $angle * [Math]::PI / 180
    $cx = 128 + [int](60 * [Math]::Cos($rad))
    $cy = 128 + [int](60 * [Math]::Sin($rad))
    Set-Px $bmp $cx $cy (C 120 80 40)
    Set-Px $bmp ($cx+1) $cy (C 120 80 40)
}
# Inner circle
for ($angle = 0; $angle -lt 360; $angle += 5) {
    $rad = $angle * [Math]::PI / 180
    $cx = 128 + [int](30 * [Math]::Cos($rad))
    $cy = 128 + [int](30 * [Math]::Sin($rad))
    Set-Px $bmp $cx $cy (C 100 60 30)
}
Save-Png $bmp "$guiDir\scroll_bg.png"

# Inventory overlay / status panel (256x256)
$bmp = New-Object System.Drawing.Bitmap(256, 256)
$bmp.SetResolution(72,72)
Fill-Noisy $bmp 0 0 256 256 (C 15 15 30) 4
# Panel border
for ($i=0; $i -lt 256; $i++) {
    Set-Px $bmp $i 0 (C 60 80 140); Set-Px $bmp $i 255 (C 60 80 140)
    Set-Px $bmp 0 $i (C 60 80 140); Set-Px $bmp 255 $i (C 60 80 140)
    Set-Px $bmp $i 1 (C 40 50 100); Set-Px $bmp $i 254 (C 40 50 100)
    Set-Px $bmp 1 $i (C 40 50 100); Set-Px $bmp 254 $i (C 40 50 100)
}
# Stat bars area
Fill-Noisy $bmp 8 8 240 30 (C 25 20 45) 3
Fill-Noisy $bmp 8 42 240 30 (C 25 20 45) 3
Fill-Noisy $bmp 8 76 240 30 (C 25 20 45) 3
# Jutsu slots area
for ($i=0; $i -lt 5; $i++) {
    Fill-Noisy $bmp (8 + $i * 48) 120 44 44 (C 35 30 60) 4
    Fill-Rect $bmp (8 + $i * 48) 120 44 1 (C 80 60 140)
    Fill-Rect $bmp (8 + $i * 48) 163 44 1 (C 80 60 140)
    Fill-Rect $bmp (8 + $i * 48) 120 1 44 (C 80 60 140)
    Fill-Rect $bmp (51 + $i * 48) 120 1 44 (C 80 60 140)
}
# Equipment display area
Fill-Noisy $bmp 8 175 240 73 (C 20 18 40) 3
Save-Png $bmp "$guiDir\status_panel.png"

# ============= ENVIRONMENT TEXTURES =============
Write-Host "=== Generating Environment Textures ==="

# Sky overlay for ninja dimension concept (256x256)
$bmp = New-Object System.Drawing.Bitmap(256, 256)
$bmp.SetResolution(72,72)
for ($y=0; $y -lt 256; $y++) {
    $ratio = $y / 255.0
    $r = [int](20 + 40 * $ratio)
    $g = [int](10 + 20 * $ratio)
    $b = [int](50 + 30 * (1 - $ratio))
    for ($x=0; $x -lt 256; $x++) {
        $rand = New-Object System.Random(($x*256+$y))
        $n = $rand.Next(-3,3)
        $bmp.SetPixel($x, $y, (C ([Math]::Max(0,[Math]::Min(255,$r+$n))) ([Math]::Max(0,[Math]::Min(255,$g+$n))) ([Math]::Max(0,[Math]::Min(255,$b+$n)))))
    }
}
# Stars
$rand = New-Object System.Random(12345)
for ($i=0; $i -lt 100; $i++) {
    $sx = $rand.Next(256); $sy = $rand.Next(128)
    $bright = $rand.Next(180,255)
    Set-Px $bmp $sx $sy (C $bright $bright $bright)
}
Save-Png $bmp "$envDir\ninja_sky.png"

# Moon texture (128x128)
$bmp = New-Object System.Drawing.Bitmap(128, 128)
$bmp.SetResolution(72,72)
for ($y=0; $y -lt 128; $y++) {
    for ($x=0; $x -lt 128; $x++) {
        $dx = $x - 64; $dy = $y - 64
        $dist = [Math]::Sqrt($dx*$dx + $dy*$dy)
        if ($dist -lt 50) {
            $shade = [int](220 - $dist * 1.5)
            $rand2 = New-Object System.Random(($x*128+$y))
            $n = $rand2.Next(-8,8)
            $shade = [Math]::Max(100,[Math]::Min(255,$shade+$n))
            $bmp.SetPixel($x, $y, (C $shade $shade ([int]($shade*0.9))))
        }
    }
}
# Craters
$craters = @(@(55,55,8), @(70,60,5), @(60,75,6), @(75,50,4), @(50,70,7))
foreach ($cr in $craters) {
    for ($y=($cr[1]-$cr[2]); $y -le ($cr[1]+$cr[2]); $y++) {
        for ($x=($cr[0]-$cr[2]); $x -le ($cr[0]+$cr[2]); $x++) {
            $dx = $x - $cr[0]; $dy = $y - $cr[1]
            if ([Math]::Sqrt($dx*$dx+$dy*$dy) -le $cr[2]) {
                if ($x -ge 0 -and $x -lt 128 -and $y -ge 0 -and $y -lt 128) {
                    $c = $bmp.GetPixel($x,$y)
                    if ($c.R -gt 50) {
                        $bmp.SetPixel($x,$y,(C ([Math]::Max(0,$c.R-30)) ([Math]::Max(0,$c.G-30)) ([Math]::Max(0,$c.B-25))))
                    }
                }
            }
        }
    }
}
Save-Png $bmp "$envDir\ninja_moon.png"

# ============= ADDITIONAL ITEM TEXTURES (32x32 HD) =============
Write-Host "=== Generating HD Item Textures ==="

$itemDir = "$base\textures\items"

# Large rasengan effect texture
$bmp = New-Object System.Drawing.Bitmap(32, 32)
$bmp.SetResolution(72,72)
for ($y=0; $y -lt 32; $y++) {
    for ($x=0; $x -lt 32; $x++) {
        $dx = $x - 16; $dy = $y - 16
        $dist = [Math]::Sqrt($dx*$dx + $dy*$dy)
        if ($dist -lt 14) {
            $angle = [Math]::Atan2($dy, $dx) + $dist * 0.3
            $swirl = [int](([Math]::Sin($angle * 3) + 1) * 40)
            $r = [Math]::Max(0, [Math]::Min(255, 50 + $swirl))
            $g = [Math]::Max(0, [Math]::Min(255, 120 + $swirl + [int]((14-$dist)*5)))
            $b = [Math]::Max(0, [Math]::Min(255, 255 - [int]($dist * 3)))
            $bmp.SetPixel($x, $y, (C $r $g $b))
        }
    }
}
Save-Png $bmp "$itemDir\rasengan_icon.png"

# Chidori effect
$bmp = New-Object System.Drawing.Bitmap(32, 32)
$bmp.SetResolution(72,72)
$rand = New-Object System.Random(777)
for ($y=0; $y -lt 32; $y++) {
    for ($x=0; $x -lt 32; $x++) {
        $dx = $x - 16; $dy = $y - 16
        $dist = [Math]::Sqrt($dx*$dx + $dy*$dy)
        if ($dist -lt 14) {
            $lightning = $rand.Next(0,100)
            if ($lightning -gt 70) {
                $bmp.SetPixel($x, $y, (C 255 255 ([Math]::Min(255, 200 + $rand.Next(55)))))
            } else {
                $b = [Math]::Max(0, [Math]::Min(255, 180 - [int]($dist * 8) + $rand.Next(-20,20)))
                $bmp.SetPixel($x, $y, (C ([int]($b*0.4)) ([int]($b*0.6)) $b))
            }
        }
    }
}
Save-Png $bmp "$itemDir\chidori_icon.png"

# Fireball icon
$bmp = New-Object System.Drawing.Bitmap(32, 32)
$bmp.SetResolution(72,72)
for ($y=0; $y -lt 32; $y++) {
    for ($x=0; $x -lt 32; $x++) {
        $dx = $x - 16; $dy = $y - 16
        $dist = [Math]::Sqrt($dx*$dx + $dy*$dy)
        if ($dist -lt 13) {
            $heat = (13 - $dist) / 13.0
            $r = [Math]::Min(255, [int](255 * $heat))
            $g = [Math]::Min(255, [int](200 * $heat * $heat))
            $b = [Math]::Min(255, [int](50 * $heat * $heat * $heat))
            $rand3 = New-Object System.Random(($x*32+$y))
            $n = $rand3.Next(-15,15)
            $bmp.SetPixel($x, $y, (C ([Math]::Max(0,[Math]::Min(255,$r+$n))) ([Math]::Max(0,[Math]::Min(255,$g+$n))) ([Math]::Max(0,$b))))
        }
    }
}
Save-Png $bmp "$itemDir\fireball_icon.png"

# ============= ADVANCEMENTS =============
Write-Host "=== Generating Advancements ==="

# Root advancement
$json = @"
{
    "display": {
        "icon": {"item": "projetokonoha:kunai"},
        "title": "Way of the Ninja",
        "description": "Begin your ninja journey in the Hidden Leaf Village",
        "frame": "task",
        "show_toast": true,
        "announce_to_chat": true,
        "background": "projetokonoha:textures/gui/scroll_bg.png"
    },
    "criteria": {
        "get_kunai": {
            "trigger": "minecraft:inventory_changed",
            "conditions": {
                "items": [{"item": "projetokonoha:kunai"}]
            }
        }
    }
}
"@
[System.IO.File]::WriteAllText("$advDir\root.json", $json)

# Weapon advancements
$advs = @(
    @{name="armed_ninja"; icon="projetokonoha:katana"; title="Armed and Dangerous"; desc="Craft a Katana"; item="projetokonoha:katana"; parent="root"; frame="task"},
    @{name="explosive_expert"; icon="projetokonoha:explosive_kunai"; title="Explosive Expert"; desc="Craft an Explosive Kunai"; item="projetokonoha:explosive_kunai"; parent="root"; frame="task"},
    @{name="senbon_rain"; icon="projetokonoha:senbon"; title="Needle in a Stack"; desc="Obtain Senbon needles"; item="projetokonoha:senbon"; parent="root"; frame="task"},
    @{name="scroll_collector"; icon="projetokonoha:blank_scroll"; title="Knowledge Seeker"; desc="Craft a Blank Scroll"; item="projetokonoha:blank_scroll"; parent="root"; frame="task"},
    @{name="rasengan_learned"; icon="projetokonoha:rasengan_scroll"; title="Spiraling Sphere"; desc="Obtain the Rasengan Scroll"; item="projetokonoha:rasengan_scroll"; parent="scroll_collector"; frame="goal"},
    @{name="chidori_learned"; icon="projetokonoha:chidori_scroll"; title="One Thousand Birds"; desc="Obtain the Chidori Scroll"; item="projetokonoha:chidori_scroll"; parent="scroll_collector"; frame="goal"},
    @{name="all_jutsus"; icon="projetokonoha:fireball_scroll"; title="Jutsu Master"; desc="Collect all 10 jutsu scrolls"; item="projetokonoha:fireball_scroll"; parent="scroll_collector"; frame="challenge"},
    @{name="ramen_lover"; icon="projetokonoha:ramen"; title="Ramen Ichiraku Fan"; desc="Eat Ichiraku Ramen"; item="projetokonoha:ramen"; parent="root"; frame="task"},
    @{name="soldier_pill_user"; icon="projetokonoha:soldier_pill"; title="Field Medic"; desc="Use a Soldier Pill"; item="projetokonoha:soldier_pill"; parent="root"; frame="task"},
    @{name="divine_fruit"; icon="projetokonoha:chakra_fruit"; title="Sage of Six Paths"; desc="Obtain the legendary Chakra Fruit"; item="projetokonoha:chakra_fruit"; parent="root"; frame="challenge"},
    @{name="konoha_protector"; icon="projetokonoha:konoha_armor_chestplate"; title="Village Protector"; desc="Wear the full Konoha Armor"; item="projetokonoha:konoha_armor_chestplate"; parent="root"; frame="goal"},
    @{name="akatsuki_member"; icon="projetokonoha:akatsuki_armor_chestplate"; title="Dawn Approaches"; desc="Don the Akatsuki cloak"; item="projetokonoha:akatsuki_armor_chestplate"; parent="root"; frame="goal"},
    @{name="anbu_operative"; icon="projetokonoha:anbu_armor_chestplate"; title="Shadow Operative"; desc="Equip ANBU armor"; item="projetokonoha:anbu_armor_chestplate"; parent="root"; frame="goal"},
    @{name="sage_mode"; icon="projetokonoha:sage_armor_chestplate"; title="Sage Mode Achieved"; desc="Attain Sage Mode armor"; item="projetokonoha:sage_armor_chestplate"; parent="root"; frame="challenge"},
    @{name="training_begins"; icon="projetokonoha:training_dummy"; title="Training Begins"; desc="Place a Training Dummy"; item="projetokonoha:training_dummy"; parent="root"; frame="task"},
    @{name="chakra_mastery"; icon="projetokonoha:chakra_altar"; title="Chakra Mastery"; desc="Build a Chakra Altar"; item="projetokonoha:chakra_altar"; parent="root"; frame="challenge"}
)

foreach ($adv in $advs) {
    $json = @"
{
    "display": {
        "icon": {"item": "$($adv.icon)"},
        "title": "$($adv.title)",
        "description": "$($adv.desc)",
        "frame": "$($adv.frame)",
        "show_toast": true,
        "announce_to_chat": true
    },
    "parent": "projetokonoha:$($adv.parent)",
    "criteria": {
        "get_item": {
            "trigger": "minecraft:inventory_changed",
            "conditions": {
                "items": [{"item": "$($adv.item)"}]
            }
        }
    }
}
"@
    [System.IO.File]::WriteAllText("$advDir\$($adv.name).json", $json)
}
Write-Host "  Created $($advs.Count + 1) advancements"

# ============= LOOT TABLES =============
Write-Host "=== Generating Loot Tables ==="

# Naruto NPC loot
$json = @"
{
    "type": "minecraft:entity",
    "pools": [
        {
            "rolls": {"min": 1, "max": 3},
            "entries": [
                {"type": "minecraft:item", "name": "projetokonoha:ramen", "weight": 5,
                 "functions": [{"function": "minecraft:set_count", "count": {"min": 1, "max": 3}}]},
                {"type": "minecraft:item", "name": "projetokonoha:rasengan_scroll", "weight": 1},
                {"type": "minecraft:item", "name": "projetokonoha:kunai", "weight": 3,
                 "functions": [{"function": "minecraft:set_count", "count": {"min": 2, "max": 5}}]},
                {"type": "minecraft:item", "name": "projetokonoha:shadow_clone_scroll", "weight": 2}
            ]
        }
    ]
}
"@
[System.IO.File]::WriteAllText("$lootDir\naruto_npc.json", $json)

$json = @"
{
    "type": "minecraft:entity",
    "pools": [
        {
            "rolls": {"min": 1, "max": 2},
            "entries": [
                {"type": "minecraft:item", "name": "projetokonoha:chidori_scroll", "weight": 1},
                {"type": "minecraft:item", "name": "projetokonoha:fireball_scroll", "weight": 2},
                {"type": "minecraft:item", "name": "projetokonoha:katana", "weight": 1},
                {"type": "minecraft:item", "name": "projetokonoha:shuriken", "weight": 4,
                 "functions": [{"function": "minecraft:set_count", "count": {"min": 4, "max": 16}}]}
            ]
        }
    ]
}
"@
[System.IO.File]::WriteAllText("$lootDir\sasuke_npc.json", $json)

$json = @"
{
    "type": "minecraft:entity",
    "pools": [
        {
            "rolls": {"min": 2, "max": 4},
            "entries": [
                {"type": "minecraft:item", "name": "projetokonoha:kunai", "weight": 3,
                 "functions": [{"function": "minecraft:set_count", "count": {"min": 3, "max": 8}}]},
                {"type": "minecraft:item", "name": "projetokonoha:wind_blade_scroll", "weight": 1},
                {"type": "minecraft:item", "name": "projetokonoha:water_dragon_scroll", "weight": 1},
                {"type": "minecraft:item", "name": "projetokonoha:earth_wall_scroll", "weight": 1},
                {"type": "minecraft:item", "name": "projetokonoha:soldier_pill", "weight": 2}
            ]
        }
    ]
}
"@
[System.IO.File]::WriteAllText("$lootDir\kakashi_npc.json", $json)

$json = @"
{
    "type": "minecraft:entity",
    "pools": [
        {
            "rolls": {"min": 1, "max": 3},
            "entries": [
                {"type": "minecraft:item", "name": "projetokonoha:healing_scroll", "weight": 3},
                {"type": "minecraft:item", "name": "projetokonoha:soldier_pill", "weight": 2,
                 "functions": [{"function": "minecraft:set_count", "count": {"min": 1, "max": 4}}]},
                {"type": "minecraft:item", "name": "projetokonoha:rice_ball", "weight": 4,
                 "functions": [{"function": "minecraft:set_count", "count": {"min": 2, "max": 5}}]},
                {"type": "minecraft:item", "name": "projetokonoha:dango", "weight": 3,
                 "functions": [{"function": "minecraft:set_count", "count": {"min": 1, "max": 6}}]}
            ]
        }
    ]
}
"@
[System.IO.File]::WriteAllText("$lootDir\sakura_npc.json", $json)

Write-Host "  Created 4 loot tables"

# ============= FINAL SIZE CHECK =============
Write-Host ""
Write-Host "=== FINAL CONTENT CHECK ==="
$root = "C:\Users\andra\MCreatorWorkspaces\projetokonoha\src"
$allFiles = Get-ChildItem $root -Recurse -File
$totalSize = ($allFiles | Measure-Object -Property Length -Sum).Sum

$javaSize = (Get-ChildItem $root -Recurse -Filter "*.java" | Measure-Object -Property Length -Sum).Sum
$pngSize = (Get-ChildItem $root -Recurse -Filter "*.png" | Measure-Object -Property Length -Sum).Sum  
$jsonSize = (Get-ChildItem $root -Recurse -Filter "*.json" | Measure-Object -Property Length -Sum).Sum
$langSize = (Get-ChildItem $root -Recurse -Filter "*.lang" | Measure-Object -Property Length -Sum).Sum

Write-Host "Java:  $([Math]::Round($javaSize/1024,1)) KB ($($(Get-ChildItem $root -Recurse -Filter '*.java').Count) files)"
Write-Host "PNG:   $([Math]::Round($pngSize/1024,1)) KB ($($(Get-ChildItem $root -Recurse -Filter '*.png').Count) files)"
Write-Host "JSON:  $([Math]::Round($jsonSize/1024,1)) KB ($($(Get-ChildItem $root -Recurse -Filter '*.json').Count) files)"
Write-Host "Lang:  $([Math]::Round($langSize/1024,1)) KB ($($(Get-ChildItem $root -Recurse -Filter '*.lang').Count) files)"
Write-Host ""
Write-Host "TOTAL: $($allFiles.Count) files, $([Math]::Round($totalSize/1024,1)) KB ($([Math]::Round($totalSize/1048576,2)) MB)"
