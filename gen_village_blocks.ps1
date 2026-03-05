# =====================================================
# KONOHA VILLAGE BLOCK TEXTURE GENERATOR
# Generates 16x16 textures for 35 village building blocks
# =====================================================
Add-Type -AssemblyName System.Drawing

$base = "C:\Users\andra\MCreatorWorkspaces\projetokonoha\src\main\resources\assets\projetokonoha"
$texDir = "$base\textures\blocks"
$bsDir  = "$base\blockstates"
$mdDir  = "$base\models\block"
$miDir  = "$base\models\item"

foreach ($d in @($texDir, $bsDir, $mdDir, $miDir)) {
    if (!(Test-Path $d)) { New-Item -ItemType Directory -Path $d -Force | Out-Null }
}

function C([int]$r,[int]$g,[int]$b){ [System.Drawing.Color]::FromArgb(255,$r,$g,$b) }

function Save-Tex($bmp,$name) {
    $path = "$texDir\$name.png"
    $bmp.Save($path, [System.Drawing.Imaging.ImageFormat]::Png)
    $bmp.Dispose()
    Write-Host "  TEX: $name.png"
}

function Fill($bmp,$x,$y,$w,$h,$color) {
    for ($py=$y; $py -lt ($y+$h); $py++) {
        for ($px=$x; $px -lt ($x+$w); $px++) {
            if ($px -ge 0 -and $px -lt 16 -and $py -ge 0 -and $py -lt 16) {
                $bmp.SetPixel($px,$py,$color)
            }
        }
    }
}

function Noise($bmp,$x,$y,$w,$h,$base_color,$variance) {
    $rand = New-Object System.Random
    for ($py=$y; $py -lt ($y+$h); $py++) {
        for ($px=$x; $px -lt ($x+$w); $px++) {
            if ($px -ge 0 -and $px -lt 16 -and $py -ge 0 -and $py -lt 16) {
                $r = [Math]::Max(0,[Math]::Min(255, $base_color.R + $rand.Next(-$variance,$variance)))
                $g = [Math]::Max(0,[Math]::Min(255, $base_color.G + $rand.Next(-$variance,$variance)))
                $b = [Math]::Max(0,[Math]::Min(255, $base_color.B + $rand.Next(-$variance,$variance)))
                $bmp.SetPixel($px,$py, (C $r $g $b))
            }
        }
    }
}

function Make-JSON($name) {
    # Blockstate
    $bs = @"
{
    "variants": {
        "normal": { "model": "projetokonoha:$name" }
    }
}
"@
    $bs | Out-File -FilePath "$bsDir\$name.json" -Encoding utf8

    # Block model
    $bm = @"
{
    "parent": "block/cube_all",
    "textures": {
        "all": "projetokonoha:blocks/$name"
    }
}
"@
    $bm | Out-File -FilePath "$mdDir\$name.json" -Encoding utf8

    # Item model
    $im = @"
{
    "parent": "projetokonoha:block/$name"
}
"@
    $im | Out-File -FilePath "$miDir\$name.json" -Encoding utf8
}

function Make-Block($name, $script) {
    $bmp = New-Object System.Drawing.Bitmap(16,16)
    & $script $bmp
    Save-Tex $bmp $name
    Make-JSON $name
}

Write-Host "=============================================="
Write-Host " KONOHA VILLAGE BLOCK TEXTURE GENERATOR"
Write-Host " 35 blocks - 16x16 textures + JSON"
Write-Host "=============================================="

# ===== WALL BLOCKS =====
Write-Host "`n=== WALL BLOCKS ==="

Make-Block "konoha_white_wall" {
    param($b)
    Noise $b 0 0 16 16 (C 235 230 220) 6
    # Subtle horizontal mortar lines
    Fill $b 0 4 16 1 (C 210 205 195)
    Fill $b 0 8 16 1 (C 210 205 195)
    Fill $b 0 12 16 1 (C 210 205 195)
}

Make-Block "konoha_clay_wall" {
    param($b)
    Noise $b 0 0 16 16 (C 195 165 130) 10
    Fill $b 0 5 16 1 (C 175 145 110)
    Fill $b 0 11 16 1 (C 175 145 110)
}

Make-Block "konoha_dark_wood_wall" {
    param($b)
    Noise $b 0 0 16 16 (C 60 40 25) 8
    # Wood grain vertical lines
    for ($x = 0; $x -lt 16; $x += 3) { Fill $b $x 0 1 16 (C 50 32 18) }
}

Make-Block "konoha_plaster_wall" {
    param($b)
    Noise $b 0 0 16 16 (C 220 215 200) 5
    # Crackle detail
    Fill $b 3 2 1 5 (C 200 195 180)
    Fill $b 10 8 1 4 (C 200 195 180)
}

Make-Block "konoha_stone_wall" {
    param($b)
    Noise $b 0 0 16 16 (C 140 140 145) 8
    # Stone block pattern
    Fill $b 0 4 16 1 (C 110 110 115)
    Fill $b 0 8 16 1 (C 110 110 115)
    Fill $b 0 12 16 1 (C 110 110 115)
    Fill $b 8 0 1 4 (C 110 110 115)
    Fill $b 4 4 1 4 (C 110 110 115)
    Fill $b 12 4 1 4 (C 110 110 115)
    Fill $b 8 8 1 4 (C 110 110 115)
    Fill $b 4 12 1 4 (C 110 110 115)
}

Make-Block "konoha_red_wall" {
    param($b)
    Noise $b 0 0 16 16 (C 165 45 40) 8
    Fill $b 0 7 16 1 (C 140 35 30)
    Fill $b 0 15 16 1 (C 140 35 30)
}

Make-Block "compound_wall" {
    param($b)
    Noise $b 0 0 16 16 (C 180 175 165) 6
    # Heavy mortar lines
    Fill $b 0 4 16 1 (C 150 145 135)
    Fill $b 0 8 16 1 (C 150 145 135)
    Fill $b 0 12 16 1 (C 150 145 135)
    Fill $b 7 0 2 16 (C 100 75 50) # Dark wood stripe
}

# ===== ROOF BLOCKS =====
Write-Host "`n=== ROOF BLOCKS ==="

Make-Block "konoha_roof_tile" {
    param($b)
    Noise $b 0 0 16 16 (C 120 70 50) 8
    # Tile pattern
    for ($y = 0; $y -lt 16; $y += 4) {
        Fill $b 0 $y 16 1 (C 90 50 35)
        $off = if ($y % 8 -eq 0) { 0 } else { 4 }
        for ($x = $off; $x -lt 16; $x += 8) { Fill $b $x ($y+1) 1 3 (C 90 50 35) }
    }
}

Make-Block "konoha_roof_tile_dark" {
    param($b)
    Noise $b 0 0 16 16 (C 55 50 55) 6
    for ($y = 0; $y -lt 16; $y += 4) {
        Fill $b 0 $y 16 1 (C 35 30 35)
        $off = if ($y % 8 -eq 0) { 0 } else { 4 }
        for ($x = $off; $x -lt 16; $x += 8) { Fill $b $x ($y+1) 1 3 (C 35 30 35) }
    }
}

Make-Block "konoha_roof_ridge" {
    param($b)
    Noise $b 0 0 16 16 (C 100 60 40) 6
    Fill $b 6 0 4 16 (C 140 85 55) # Central ridge
    Fill $b 7 0 2 16 (C 160 100 65)
}

Make-Block "konoha_thatch_roof" {
    param($b)
    Noise $b 0 0 16 16 (C 180 165 110) 12
    # Thatch pattern - diagonal streaks
    for ($i = 0; $i -lt 16; $i += 2) {
        $y = $i
        for ($x = 0; $x -lt 16; $x++) {
            $py = ($y + $x) % 16
            if ($px -ge 0 -and $px -lt 16) { $b.SetPixel($x, $py, (C 165 150 95)) }
        }
    }
}

# ===== FLOOR BLOCKS =====
Write-Host "`n=== FLOOR BLOCKS ==="

Make-Block "konoha_cobblestone" {
    param($b)
    Noise $b 0 0 16 16 (C 130 130 130) 10
    # Cobblestone pattern
    Fill $b 0 0 16 1 (C 100 100 100)
    Fill $b 0 5 16 1 (C 100 100 100)
    Fill $b 0 10 16 1 (C 100 100 100)
    Fill $b 0 15 16 1 (C 100 100 100)
    Fill $b 0 0 1 16 (C 100 100 100)
    Fill $b 5 0 1 16 (C 100 100 100)
    Fill $b 10 0 1 16 (C 100 100 100)
    Fill $b 15 0 1 16 (C 100 100 100)
}

Make-Block "konoha_path_stone" {
    param($b)
    Noise $b 0 0 16 16 (C 175 170 160) 7
    # Smooth flagstone pattern
    Fill $b 0 7 16 1 (C 145 140 130)
    Fill $b 7 0 1 8 (C 145 140 130)
    Fill $b 11 8 1 8 (C 145 140 130)
}

Make-Block "konoha_tatami_floor" {
    param($b)
    Noise $b 0 0 16 16 (C 190 185 145) 5
    # Tatami weave pattern
    for ($y = 0; $y -lt 16; $y += 2) {
        Fill $b 0 $y 16 1 (C 175 170 130)
    }
    # Border
    Fill $b 0 0 16 1 (C 80 65 30)
    Fill $b 0 15 16 1 (C 80 65 30)
    Fill $b 0 0 1 16 (C 80 65 30)
    Fill $b 15 0 1 16 (C 80 65 30)
}

Make-Block "konoha_polished_wood" {
    param($b)
    Noise $b 0 0 16 16 (C 140 100 60) 7
    # Wood grain
    for ($x = 0; $x -lt 16; $x += 4) { Fill $b $x 0 1 16 (C 120 82 45) }
    Fill $b 0 8 16 1 (C 125 88 50)
}

# ===== STRUCTURAL BLOCKS =====
Write-Host "`n=== STRUCTURAL BLOCKS ==="

Make-Block "konoha_pillar" {
    param($b)
    Noise $b 0 0 16 16 (C 85 60 35) 6
    # Pillar carved detail
    Fill $b 3 0 10 16 (C 95 68 40)
    Fill $b 5 0 6 16 (C 105 75 45)
    # Cap lines
    Fill $b 0 0 16 2 (C 70 48 28)
    Fill $b 0 14 16 2 (C 70 48 28)
}

Make-Block "konoha_beam" {
    param($b)
    Noise $b 0 0 16 16 (C 75 52 30) 6
    # Horizontal grain
    for ($y = 0; $y -lt 16; $y += 3) { Fill $b 0 $y 16 1 (C 60 40 22) }
}

Make-Block "konoha_foundation" {
    param($b)
    Noise $b 0 0 16 16 (C 120 115 110) 8
    # Heavy stone block
    Fill $b 0 0 16 1 (C 90 85 80)
    Fill $b 0 8 16 1 (C 90 85 80)
    Fill $b 8 0 1 8 (C 90 85 80)
    Fill $b 4 8 1 8 (C 90 85 80)
    Fill $b 12 8 1 8 (C 90 85 80)
}

Make-Block "konoha_fence_wood" {
    param($b)
    # Fence texture - mostly transparent-ish looking brown
    Noise $b 0 0 16 16 (C 100 70 40) 8
    Fill $b 6 0 4 16 (C 120 85 50)
    Fill $b 0 4 16 3 (C 110 78 45)
    Fill $b 0 11 16 3 (C 110 78 45)
}

Make-Block "konoha_stone_stairs_block" {
    param($b)
    Noise $b 0 0 16 16 (C 155 150 145) 6
    Fill $b 0 0 16 1 (C 130 125 120)
    Fill $b 0 8 16 1 (C 130 125 120)
    Fill $b 0 4 8 1 (C 130 125 120)
    Fill $b 8 12 8 1 (C 130 125 120)
}

# ===== DECORATIVE BLOCKS =====
Write-Host "`n=== DECORATIVE BLOCKS ==="

Make-Block "konoha_window" {
    param($b)
    # Paper window with wood frame
    Fill $b 0 0 16 16 (C 60 42 25) # Frame
    Noise $b 2 2 12 12 (C 230 225 210) 4 # Paper
    Fill $b 8 2 1 12 (C 60 42 25) # Cross bar V
    Fill $b 2 8 12 1 (C 60 42 25) # Cross bar H
}

Make-Block "konoha_lantern" {
    param($b)
    # Japanese paper lantern
    Noise $b 0 0 16 16 (C 220 180 120) 8
    # Top/bottom caps
    Fill $b 4 0 8 2 (C 40 25 15)
    Fill $b 4 14 8 2 (C 40 25 15)
    # Warm glow center
    Fill $b 4 5 8 6 (C 245 220 150)
    # Frame ribs
    Fill $b 4 0 1 16 (C 40 25 15)
    Fill $b 11 0 1 16 (C 40 25 15)
}

Make-Block "konoha_fire_brazier" {
    param($b)
    # Iron brazier with fire
    Noise $b 0 8 16 8 (C 70 70 75) 5 # Iron base
    Fill $b 2 0 12 4 (C 255 160 30) # Fire
    Fill $b 4 0 8 3 (C 255 200 50) # Bright flame
    Fill $b 6 0 4 2 (C 255 240 100) # White-hot
    # Iron rim
    Fill $b 1 7 14 2 (C 55 55 60)
}

Make-Block "konoha_flower_pot_block" {
    param($b)
    Noise $b 0 0 16 16 (C 180 175 165) 4 # Background
    # Pot
    Fill $b 4 8 8 8 (C 170 90 50)
    Fill $b 5 9 6 6 (C 150 78 42)
    # Green plant
    Fill $b 6 2 4 6 (C 60 140 50)
    Fill $b 4 4 2 3 (C 50 120 40)
    Fill $b 10 4 2 3 (C 50 120 40)
    # Flower
    $b.SetPixel(7, 2, (C 255 100 120))
    $b.SetPixel(8, 2, (C 255 100 120))
}

Make-Block "konoha_water_basin" {
    param($b)
    # Stone basin with water
    Noise $b 0 0 16 16 (C 140 135 130) 6 # Stone
    Fill $b 2 3 12 10 (C 60 120 180) # Water
    Noise $b 3 4 10 8 (C 80 140 200) 10 # Water surface
    # Rim
    Fill $b 1 2 14 1 (C 120 115 110)
    Fill $b 1 13 14 1 (C 120 115 110)
}

Make-Block "konoha_scroll_rack" {
    param($b)
    Noise $b 0 0 16 16 (C 100 72 42) 6 # Wood
    # Shelves
    Fill $b 0 5 16 1 (C 80 55 30)
    Fill $b 0 10 16 1 (C 80 55 30)
    # Scrolls on shelves
    Fill $b 2 1 3 4 (C 230 220 190) # Scroll 1
    Fill $b 6 1 3 4 (C 200 180 160) # Scroll 2
    Fill $b 11 1 3 4 (C 180 50 50)  # Red scroll
    Fill $b 3 6 3 4 (C 220 210 180)
    Fill $b 8 6 4 4 (C 60 120 60)   # Green scroll
    Fill $b 2 11 4 4 (C 100 100 180) # Blue scroll
    Fill $b 9 11 3 4 (C 230 220 190)
}

Make-Block "konoha_weapon_display" {
    param($b)
    Noise $b 0 0 16 16 (C 50 35 22) 5 # Dark wood back
    # Weapon rack bars
    Fill $b 0 5 16 1 (C 70 50 30)
    Fill $b 0 11 16 1 (C 70 50 30)
    # Kunai silhouette
    Fill $b 3 1 1 4 (C 180 180 185)
    Fill $b 2 2 3 1 (C 180 180 185)
    # Katana silhouette
    Fill $b 7 6 1 5 (C 200 200 210)
    Fill $b 6 6 3 1 (C 200 200 210)
    # Shuriken
    $b.SetPixel(12, 12, (C 180 180 185))
    $b.SetPixel(11, 13, (C 180 180 185))
    $b.SetPixel(13, 13, (C 180 180 185))
    $b.SetPixel(12, 14, (C 180 180 185))
}

# ===== VILLAGE-SPECIFIC =====
Write-Host "`n=== VILLAGE-SPECIFIC ==="

Make-Block "hokage_office_desk" {
    param($b)
    Noise $b 0 0 16 16 (C 110 78 45) 6 # Desk wood
    # Top surface polished
    Fill $b 1 1 14 6 (C 130 92 55)
    # Paper stack
    Fill $b 2 2 4 3 (C 240 235 220)
    # Ink pot
    Fill $b 10 3 2 2 (C 20 20 30)
    # Hokage hat (red+white)
    Fill $b 9 7 5 3 (C 200 40 40)
    Fill $b 10 6 3 1 (C 240 235 220)
}

Make-Block "academy_chalkboard" {
    param($b)
    # Dark green board
    Fill $b 0 0 16 16 (C 35 55 35)
    Noise $b 1 1 14 14 (C 40 65 40) 5
    # Wood frame
    Fill $b 0 0 16 1 (C 100 72 42)
    Fill $b 0 15 16 1 (C 100 72 42)
    Fill $b 0 0 1 16 (C 100 72 42)
    Fill $b 15 0 1 16 (C 100 72 42)
    # Chalk writing (kanji-esque marks)
    Fill $b 3 3 2 1 (C 220 220 220)
    Fill $b 4 4 1 2 (C 220 220 220)
    Fill $b 3 6 3 1 (C 220 220 220)
    Fill $b 8 3 1 5 (C 220 220 220)
    Fill $b 9 3 2 1 (C 220 220 220)
    Fill $b 9 5 2 1 (C 220 220 220)
    Fill $b 9 7 2 1 (C 220 220 220)
}

Make-Block "hospital_bed_block" {
    param($b)
    Fill $b 0 0 16 16 (C 220 220 225) # White sheets
    Noise $b 1 1 14 14 (C 230 230 235) 3
    # Pillow
    Fill $b 2 1 5 4 (C 240 240 245)
    # Blanket fold
    Fill $b 1 8 14 1 (C 200 200 210)
    # Medical cross
    Fill $b 10 10 2 4 (C 200 40 40)
    Fill $b 9 11 4 2 (C 200 40 40)
}

Make-Block "shop_sign" {
    param($b)
    Noise $b 0 0 16 16 (C 140 100 55) 7 # Wood
    # Sign face
    Fill $b 2 3 12 10 (C 230 220 190)
    # Border
    Fill $b 2 3 12 1 (C 160 50 40)
    Fill $b 2 12 12 1 (C 160 50 40)
    # Kanji-esque marks
    Fill $b 5 5 2 1 (C 30 30 30)
    Fill $b 6 5 1 4 (C 30 30 30)
    Fill $b 5 8 3 1 (C 30 30 30)
    Fill $b 9 5 1 5 (C 30 30 30)
    Fill $b 9 5 2 1 (C 30 30 30)
}

# ===== SPECIAL LARGE =====
Write-Host "`n=== SPECIAL / LARGE ==="

Make-Block "konoha_great_gate" {
    param($b)
    Noise $b 0 0 16 16 (C 90 62 35) 7
    # Heavy wood grain
    for ($x = 0; $x -lt 16; $x += 3) { Fill $b $x 0 1 16 (C 70 48 28) }
    # Iron bands
    Fill $b 0 2 16 2 (C 60 60 65)
    Fill $b 0 8 16 2 (C 60 60 65)
    Fill $b 0 13 16 2 (C 60 60 65)
    # Konoha symbol center (leaf spiral)
    $b.SetPixel(7, 6, (C 40 100 40))
    $b.SetPixel(8, 6, (C 40 100 40))
    $b.SetPixel(8, 5, (C 40 100 40))
    $b.SetPixel(7, 7, (C 40 100 40))
}

Make-Block "konoha_wall_fortification" {
    param($b)
    Noise $b 0 0 16 16 (C 160 155 145) 8
    # Large stone blocks
    Fill $b 0 0 16 1 (C 130 125 115)
    Fill $b 0 5 16 1 (C 130 125 115)
    Fill $b 0 10 16 1 (C 130 125 115)
    Fill $b 0 15 16 1 (C 130 125 115)
    Fill $b 8 0 1 5 (C 130 125 115)
    Fill $b 4 5 1 5 (C 130 125 115)
    Fill $b 12 5 1 5 (C 130 125 115)
    Fill $b 8 10 1 5 (C 130 125 115)
}

Make-Block "hokage_face_stone" {
    param($b)
    Noise $b 0 0 16 16 (C 170 165 155) 7
    # Carved stone face impression
    Fill $b 4 3 3 2 (C 140 135 125)  # Left eye
    Fill $b 9 3 3 2 (C 140 135 125)  # Right eye
    Fill $b 7 6 2 3 (C 145 140 130)  # Nose
    Fill $b 5 10 6 1 (C 140 135 125) # Mouth
    Fill $b 3 1 10 1 (C 150 145 135) # Headband
}

Make-Block "village_signal_tower" {
    param($b)
    Noise $b 0 0 16 16 (C 80 80 85) 5 # Iron
    # Central shaft
    Fill $b 5 0 6 16 (C 90 90 95)
    # Light at top
    Fill $b 6 0 4 3 (C 240 200 100)
    Fill $b 7 1 2 1 (C 255 240 150)
    # Brackets
    Fill $b 3 6 2 2 (C 70 70 75)
    Fill $b 11 6 2 2 (C 70 70 75)
    Fill $b 3 12 2 2 (C 70 70 75)
    Fill $b 11 12 2 2 (C 70 70 75)
}

Write-Host "`n=============================================="
Write-Host " Generation Complete! 35 block textures + JSON"
Write-Host "=============================================="

$count = (Get-ChildItem "$texDir\konoha_*.png","$texDir\compound_*.png","$texDir\hokage_office_desk.png","$texDir\academy_chalkboard.png","$texDir\hospital_bed_block.png","$texDir\shop_sign.png","$texDir\village_signal_tower.png" -ErrorAction SilentlyContinue).Count
Write-Host "  New block textures: $count"
