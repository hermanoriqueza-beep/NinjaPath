# =====================================================
# EXPANDED NPCs TEXTURE GENERATOR
# Generates 128x128 HD textures for 8 new NPCs
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

function Make-DetailedEntity($path, $skinCol, $hairCol, $topCol, $pantsCol, $shoeCol, $accentCol, $detailFunc) {
    $bmp = New-Object System.Drawing.Bitmap(128, 128)
    $bmp.SetResolution(72,72)

    # HEAD region
    Fill-Noisy $bmp 16 0 16 16 $hairCol 15
    Fill-Noisy $bmp 32 0 16 16 $skinCol 8
    Fill-Noisy $bmp 0 16 16 16 $skinCol 8
    Fill-Noisy $bmp 0 16 16 6 $hairCol 12
    Fill-Noisy $bmp 16 16 16 16 $skinCol 8
    Fill-Noisy $bmp 16 16 16 4 $hairCol 12
    Fill-Rect $bmp 20 24 3 2 (C 0 0 0)
    Fill-Rect $bmp 27 24 3 2 (C 0 0 0)
    Set-Px $bmp 21 24 (C 40 40 40)
    Set-Px $bmp 28 24 (C 40 40 40)
    Set-Px $bmp 24 26 (C 200 170 140)
    Fill-Rect $bmp 22 28 6 1 (C 180 120 100)
    Fill-Noisy $bmp 32 16 16 16 $skinCol 8
    Fill-Noisy $bmp 32 16 16 6 $hairCol 12
    Fill-Noisy $bmp 48 16 16 16 $hairCol 12

    # BODY region
    Fill-Noisy $bmp 40 32 16 8 $topCol 12
    Fill-Noisy $bmp 32 40 8 24 $topCol 10
    Fill-Noisy $bmp 40 40 16 24 $topCol 10
    Fill-Noisy $bmp 56 40 8 24 $topCol 10
    Fill-Noisy $bmp 64 40 16 24 $topCol 10

    # RIGHT ARM
    Fill-Noisy $bmp 88 32 8 8 $topCol 12
    Fill-Noisy $bmp 88 40 8 24 $topCol 10
    Fill-Noisy $bmp 80 40 8 24 $topCol 10
    Fill-Noisy $bmp 96 40 8 24 $topCol 10
    Fill-Noisy $bmp 104 40 8 24 $topCol 10
    Fill-Noisy $bmp 88 56 8 8 $skinCol 8
    Fill-Noisy $bmp 80 56 8 8 $skinCol 8
    Fill-Noisy $bmp 96 56 8 8 $skinCol 8
    Fill-Noisy $bmp 104 56 8 8 $skinCol 8

    # RIGHT LEG
    Fill-Noisy $bmp 8 32 8 8 $pantsCol 10
    Fill-Noisy $bmp 8 40 8 24 $pantsCol 10
    Fill-Noisy $bmp 0 40 8 24 $pantsCol 10
    Fill-Noisy $bmp 16 40 8 24 $pantsCol 10
    Fill-Noisy $bmp 24 40 8 24 $pantsCol 10
    Fill-Noisy $bmp 8 56 8 8 $shoeCol 8
    Fill-Noisy $bmp 0 56 8 8 $shoeCol 8
    Fill-Noisy $bmp 16 56 8 8 $shoeCol 8
    Fill-Noisy $bmp 24 56 8 8 $shoeCol 8

    # LEFT ARM
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

    if ($detailFunc) { & $detailFunc $bmp }
    Save-Png $bmp $path
}

Write-Host "=== Generating Expanded NPC Entity Textures (128x128) ==="

# Shikamaru Nara - dark ponytail, green lazy jacket, mesh shirt
Make-DetailedEntity "$entityDir\shikamaru.png" (C 255 220 180) (C 50 40 30) (C 60 90 60) (C 50 50 60) (C 40 40 50) (C 80 80 80) {
    param($bmp)
    # Ponytail (hair sticking up like pineapple)
    Fill-Noisy $bmp 20 10 8 6 (C 50 40 30) 8
    Fill-Noisy $bmp 22 6 4 6 (C 55 45 35) 10
    # Headband
    Fill-Rect $bmp 16 20 16 2 (C 25 25 80)
    Fill-Rect $bmp 22 20 6 2 (C 180 180 200)
    # Lazy expression (half-closed eyes)
    Fill-Rect $bmp 20 24 3 1 (C 0 0 0)
    Fill-Rect $bmp 27 24 3 1 (C 0 0 0)
    # Jounin vest
    Fill-Noisy $bmp 40 40 16 10 (C 60 90 60) 8
    Fill-Rect $bmp 42 44 4 3 (C 50 80 50)
    # Earring
    Set-Px $bmp 17 25 (C 200 200 200)
}

# Neji Hyuga - long brown hair, white eyes, white/beige robes
Make-DetailedEntity "$entityDir\neji.png" (C 255 220 180) (C 80 50 30) (C 200 195 180) (C 180 175 165) (C 60 60 70) (C 230 230 230) {
    param($bmp)
    # Long flowing hair on sides
    Fill-Noisy $bmp 0 16 16 16 (C 80 50 30) 12
    Fill-Noisy $bmp 32 16 16 16 (C 80 50 30) 12
    Fill-Noisy $bmp 48 16 16 16 (C 80 50 30) 10
    # Hair extends below head
    Fill-Noisy $bmp 64 40 16 16 (C 80 50 30) 10
    # Headband (on forehead, different style)
    Fill-Rect $bmp 16 20 16 2 (C 25 25 80)
    Fill-Rect $bmp 22 20 6 2 (C 180 180 200)
    # Byakugan eyes (white/lavender)
    Fill-Rect $bmp 20 24 3 2 (C 230 220 240)
    Fill-Rect $bmp 27 24 3 2 (C 230 220 240)
    Set-Px $bmp 21 24 (C 210 200 220)
    Set-Px $bmp 28 24 (C 210 200 220)
    # Chest wrapping detail
    Fill-Rect $bmp 40 42 16 1 (C 160 155 145)
    Fill-Rect $bmp 40 45 16 1 (C 160 155 145)
}

# Tenten - brown bun hairstyle, pink/red chinese top, dark pants
Make-DetailedEntity "$entityDir\tenten.png" (C 255 220 180) (C 90 55 25) (C 200 60 80) (C 50 50 60) (C 40 40 50) (C 255 120 140) {
    param($bmp)
    # Twin buns hairstyle
    Fill-Noisy $bmp 18 8 5 5 (C 90 55 25) 10
    Fill-Noisy $bmp 27 8 5 5 (C 90 55 25) 10
    # Headband
    Fill-Rect $bmp 16 20 16 2 (C 25 25 80)
    Fill-Rect $bmp 22 20 6 2 (C 180 180 200)
    # Brown eyes
    Set-Px $bmp 21 24 (C 80 50 20)
    Set-Px $bmp 28 24 (C 80 50 20)
    # Chinese-style top detail
    Fill-Rect $bmp 47 40 2 12 (C 180 50 60)
    # Scroll on back
    Fill-Rect $bmp 70 42 6 10 (C 210 190 150)
    Fill-Rect $bmp 70 42 6 1 (C 140 120 80)
    Fill-Rect $bmp 70 51 6 1 (C 140 120 80)
}

# Shino Aburame - dark sunglasses, high collar coat, mysterious
Make-DetailedEntity "$entityDir\shino.png" (C 255 220 180) (C 40 35 30) (C 50 55 50) (C 50 55 50) (C 40 40 45) (C 30 30 30) {
    param($bmp)
    # Sunglasses (covers eyes completely)
    Fill-Rect $bmp 19 23 12 3 (C 15 15 15)
    Fill-Rect $bmp 20 24 4 2 (C 25 25 30)
    Fill-Rect $bmp 27 24 4 2 (C 25 25 30)
    # High collar covering face
    Fill-Noisy $bmp 16 27 16 5 (C 50 55 50) 6
    # Hood/hair covers most of head
    Fill-Noisy $bmp 16 16 16 7 (C 40 35 30) 8
    # Headband barely visible
    Fill-Rect $bmp 16 20 16 1 (C 30 30 70)
    # Coat details (zipped up)
    for ($y=40; $y -le 63; $y++) { Set-Px $bmp 48 $y (C 35 35 35) }
    # Bug crawling detail
    Set-Px $bmp 86 50 (C 60 40 20)
    Set-Px $bmp 87 50 (C 60 40 20)
}

# Minato Namikaze - spiky blonde hair, white Hokage cloak with flames, blue inside
Make-DetailedEntity "$entityDir\minato.png" (C 255 220 180) (C 255 220 50) (C 30 100 200) (C 30 80 170) (C 40 40 50) (C 255 255 255) {
    param($bmp)
    # Spiky hair (Naruto-like but taller)
    Fill-Noisy $bmp 20 8 8 8 (C 255 220 50) 12
    Fill-Noisy $bmp 18 10 4 6 (C 255 210 40) 10
    Fill-Noisy $bmp 28 10 4 6 (C 255 210 40) 10
    # Headband
    Fill-Rect $bmp 16 20 16 2 (C 25 25 80)
    Fill-Rect $bmp 22 20 6 2 (C 180 180 200)
    # Blue eyes
    Set-Px $bmp 21 24 (C 30 100 200)
    Set-Px $bmp 28 24 (C 30 100 200)
    # Hokage cloak (white over blue)
    Fill-Noisy $bmp 40 40 16 24 (C 245 245 245) 4
    Fill-Noisy $bmp 32 40 8 24 (C 245 245 245) 4
    Fill-Noisy $bmp 56 40 8 24 (C 245 245 245) 4
    # Flame pattern at bottom of cloak
    for ($x=40; $x -lt 56; $x++) {
        $flameH = 3 + ($x % 3)
        for ($fy=0; $fy -lt $flameH; $fy++) {
            Set-Px $bmp $x (60-$fy) (C 255 (100+$fy*30) 0)
        }
    }
    # "Fourth Hokage" kanji symbol on back
    Fill-Rect $bmp 70 44 8 8 (C 200 30 30)
    Fill-Rect $bmp 72 46 4 4 (C 245 245 245)
}

# Orochimaru - pale skin, long black hair, purple rope belt, snake-like
Make-DetailedEntity "$entityDir\orochimaru.png" (C 240 235 220) (C 20 15 25) (C 200 195 175) (C 50 50 60) (C 40 40 50) (C 128 0 160) {
    param($bmp)
    # Very long black hair
    Fill-Noisy $bmp 0 16 16 16 (C 20 15 25) 5
    Fill-Noisy $bmp 32 16 16 16 (C 20 15 25) 5
    Fill-Noisy $bmp 48 16 16 16 (C 20 15 25) 5
    Fill-Noisy $bmp 64 40 16 24 (C 20 15 25) 5
    # Snake-like yellow eyes
    Set-Px $bmp 21 24 (C 200 180 0)
    Set-Px $bmp 28 24 (C 200 180 0)
    # Purple eye markings
    Set-Px $bmp 19 23 (C 128 0 160)
    Set-Px $bmp 26 23 (C 128 0 160)
    Set-Px $bmp 22 23 (C 128 0 160)
    Set-Px $bmp 29 23 (C 128 0 160)
    # Purple rope belt
    Fill-Rect $bmp 40 52 16 2 (C 128 0 160)
    Fill-Rect $bmp 56 52 6 6 (C 128 0 160)
    # No headband (rogue ninja)
    # Pale white robe details
    for ($y=40; $y -le 50; $y+=3) { Fill-Rect $bmp 40 $y 16 1 (C 180 175 160) }
}

# Might Guy - bowl cut, green jumpsuit, orange leg warmers, big eyebrows
Make-DetailedEntity "$entityDir\might_guy.png" (C 255 220 180) (C 15 15 20) (C 20 120 30) (C 20 120 30) (C 255 140 0) (C 200 30 30) {
    param($bmp)
    # Bowl cut (round, shiny)
    Fill-Noisy $bmp 16 16 16 5 (C 15 15 20) 4
    # Big thick eyebrows
    Fill-Rect $bmp 19 22 4 2 (C 10 10 10)
    Fill-Rect $bmp 27 22 4 2 (C 10 10 10)
    # Headband
    Fill-Rect $bmp 16 20 16 2 (C 25 25 80)
    Fill-Rect $bmp 22 20 6 2 (C 180 180 200)
    # Big smile
    Fill-Rect $bmp 21 28 8 1 (C 255 255 255)
    Set-Px $bmp 20 27 (C 180 120 100)
    Set-Px $bmp 29 27 (C 180 120 100)
    # Green jumpsuit - one piece
    Fill-Noisy $bmp 40 40 16 24 (C 20 120 30) 6
    Fill-Noisy $bmp 88 40 8 24 (C 20 120 30) 6
    Fill-Noisy $bmp 80 40 8 24 (C 20 120 30) 6
    # Orange leg warmers
    Fill-Noisy $bmp 0 50 8 14 (C 255 140 0) 10
    Fill-Noisy $bmp 8 50 8 14 (C 255 140 0) 10
    Fill-Noisy $bmp 16 50 8 14 (C 255 140 0) 10
    Fill-Noisy $bmp 24 50 8 14 (C 255 140 0) 10
    # Jounin vest over jumpsuit
    Fill-Noisy $bmp 40 40 16 8 (C 60 90 60) 8
}

# Konohamaru Sarutobi - brown spiky hair, blue scarf, goggles, young
Make-DetailedEntity "$entityDir\konohamaru.png" (C 255 220 180) (C 80 50 25) (C 40 40 50) (C 40 40 50) (C 40 40 50) (C 65 105 200) {
    param($bmp)
    # Spiky brown hair
    Fill-Noisy $bmp 20 10 8 6 (C 80 50 25) 12
    Fill-Noisy $bmp 18 12 4 4 (C 75 45 20) 10
    Fill-Noisy $bmp 28 12 4 4 (C 75 45 20) 10
    # Goggles on forehead (like young Naruto)
    Fill-Rect $bmp 18 19 4 3 (C 100 100 120)
    Fill-Rect $bmp 28 19 4 3 (C 100 100 120)
    Fill-Rect $bmp 19 20 2 1 (C 150 200 255)
    Fill-Rect $bmp 29 20 2 1 (C 150 200 255)
    Fill-Rect $bmp 22 19 6 1 (C 80 80 90)
    # Big blue scarf
    Fill-Noisy $bmp 40 52 16 6 (C 65 105 200) 10
    Fill-Noisy $bmp 32 54 8 10 (C 65 105 200) 10
    Fill-Noisy $bmp 56 54 8 10 (C 65 105 200) 10
    # Brown eyes (young, energetic)
    Set-Px $bmp 21 24 (C 80 50 20)
    Set-Px $bmp 28 24 (C 80 50 20)
    # Konoha headband (below goggles)
    Fill-Rect $bmp 16 22 16 1 (C 25 25 80)
}

Write-Host ""
Write-Host "=== All 8 Expanded NPC Textures Generated! ==="
Write-Host "New NPCs: Shikamaru, Neji, Tenten, Shino, Minato, Orochimaru, Might Guy, Konohamaru"
