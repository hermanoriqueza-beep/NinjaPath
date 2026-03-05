Add-Type -AssemblyName System.Drawing
$base = "C:\Users\andra\MCreatorWorkspaces\projetokonoha\src\main\resources\assets\projetokonoha"
$modelsItem = "$base\models\item"
$modelsBlock = "$base\models\block"
$texItems = "$base\textures\items"
$texBlocks = "$base\textures\blocks"
$blockstates = "$base\blockstates"
$recipes = "$base\recipes"
$lang = "$base\lang"

# Ensure directories exist
@($modelsItem,$modelsBlock,$texItems,$texBlocks,$blockstates,$recipes,$lang) | ForEach-Object {
    if (!(Test-Path $_)) { New-Item -ItemType Directory -Path $_ -Force | Out-Null }
}

# Helper: create item model JSON
function Make-ItemModel($name) {
    $json = '{"parent":"item/generated","textures":{"layer0":"projetokonoha:items/' + $name + '"}}'
    [System.IO.File]::WriteAllText("$modelsItem\$name.json", $json)
}

# Helper: create block model JSON
function Make-BlockModel($name) {
    $json = '{"parent":"block/cube_all","textures":{"all":"projetokonoha:blocks/' + $name + '"}}'
    [System.IO.File]::WriteAllText("$modelsBlock\$name.json", $json)
}

# Helper: create block item model JSON (pointing to block model)
function Make-BlockItemModel($name) {
    $json = '{"parent":"projetokonoha:block/' + $name + '"}'
    [System.IO.File]::WriteAllText("$modelsItem\$name.json", $json)
}

# Helper: create blockstate JSON
function Make-Blockstate($name) {
    $json = '{"variants":{"normal":{"model":"projetokonoha:' + $name + '"}}}'
    [System.IO.File]::WriteAllText("$blockstates\$name.json", $json)
}

# Helper: set pixel with bounds check
function SP($bmp, $x, $y, $c) {
    if ($x -ge 0 -and $x -lt 16 -and $y -ge 0 -and $y -lt 16) { $bmp.SetPixel($x, $y, $c) }
}

# Helper: fill rectangle
function FR($bmp, $x1, $y1, $x2, $y2, $c) {
    for ($y = $y1; $y -le $y2; $y++) { for ($x = $x1; $x -le $x2; $x++) { SP $bmp $x $y $c } }
}

# Helper: draw border
function DB($bmp, $x1, $y1, $x2, $y2, $c) {
    for ($x = $x1; $x -le $x2; $x++) { SP $bmp $x $y1 $c; SP $bmp $x $y2 $c }
    for ($y = $y1; $y -le $y2; $y++) { SP $bmp $x1 $y $c; SP $bmp $x2 $y $c }
}

function Save-Tex($bmp, $folder, $name) {
    $bmp.Save("$folder\$name.png", [System.Drawing.Imaging.ImageFormat]::Png)
    $bmp.Dispose()
}

# ============================================================
# TAILED BEAST SEALS - 9 items
# ============================================================
Write-Host "Generating Tailed Beast assets..."
$bijuuColors = @(
    @{name="one_tail_seal";   bg=[System.Drawing.Color]::FromArgb(255,210,180,120); fg=[System.Drawing.Color]::FromArgb(255,139,90,43);  acc=[System.Drawing.Color]::FromArgb(255,80,50,20)},
    @{name="two_tails_seal";  bg=[System.Drawing.Color]::FromArgb(255,100,100,200); fg=[System.Drawing.Color]::FromArgb(255,30,30,150);  acc=[System.Drawing.Color]::FromArgb(255,200,200,255)},
    @{name="three_tails_seal";bg=[System.Drawing.Color]::FromArgb(255,100,180,180); fg=[System.Drawing.Color]::FromArgb(255,30,100,100); acc=[System.Drawing.Color]::FromArgb(255,200,255,255)},
    @{name="four_tails_seal"; bg=[System.Drawing.Color]::FromArgb(255,200,80,80);   fg=[System.Drawing.Color]::FromArgb(255,150,30,30);  acc=[System.Drawing.Color]::FromArgb(255,255,200,50)},
    @{name="five_tails_seal"; bg=[System.Drawing.Color]::FromArgb(255,200,200,200); fg=[System.Drawing.Color]::FromArgb(255,100,100,100);acc=[System.Drawing.Color]::FromArgb(255,255,255,255)},
    @{name="six_tails_seal";  bg=[System.Drawing.Color]::FromArgb(255,180,180,220); fg=[System.Drawing.Color]::FromArgb(255,100,100,180);acc=[System.Drawing.Color]::FromArgb(255,220,220,255)},
    @{name="seven_tails_seal";bg=[System.Drawing.Color]::FromArgb(255,100,200,100); fg=[System.Drawing.Color]::FromArgb(255,30,130,30);  acc=[System.Drawing.Color]::FromArgb(255,200,255,100)},
    @{name="eight_tails_seal";bg=[System.Drawing.Color]::FromArgb(255,80,80,120);   fg=[System.Drawing.Color]::FromArgb(255,40,40,80);   acc=[System.Drawing.Color]::FromArgb(255,180,180,220)},
    @{name="nine_tails_seal"; bg=[System.Drawing.Color]::FromArgb(255,255,140,0);   fg=[System.Drawing.Color]::FromArgb(255,200,80,0);   acc=[System.Drawing.Color]::FromArgb(255,255,50,50)}
)

$tailNum = 1
foreach ($b in $bijuuColors) {
    $bmp = New-Object System.Drawing.Bitmap(16,16)
    # Seal paper background
    FR $bmp 3 1 12 14 $b.bg
    # Border
    DB $bmp 3 1 12 14 $b.fg
    # Spiral seal pattern in center
    $cx = 7; $cy = 7
    SP $bmp $cx $cy $b.acc
    SP $bmp ($cx+1) $cy $b.fg; SP $bmp ($cx+1) ($cy-1) $b.fg; SP $bmp $cx ($cy-1) $b.fg
    SP $bmp ($cx-1) ($cy-1) $b.fg; SP $bmp ($cx-1) $cy $b.fg; SP $bmp ($cx-1) ($cy+1) $b.fg
    SP $bmp $cx ($cy+1) $b.fg; SP $bmp ($cx+1) ($cy+1) $b.fg; SP $bmp ($cx+2) ($cy+1) $b.fg
    SP $bmp ($cx+2) $cy $b.fg; SP $bmp ($cx+2) ($cy-1) $b.fg; SP $bmp ($cx+2) ($cy-2) $b.fg
    # Tail count indicator (dots at bottom)
    $dotStart = [math]::Max(4, 8 - [math]::Floor($tailNum / 2))
    for ($t = 0; $t -lt $tailNum; $t++) {
        $dx = $dotStart + $t
        if ($dx -le 12) { SP $bmp $dx 13 $b.acc }
    }
    # Kanji-like mark at top
    SP $bmp 6 3 $b.fg; SP $bmp 7 3 $b.fg; SP $bmp 8 3 $b.fg; SP $bmp 9 3 $b.fg
    SP $bmp 7 4 $b.fg; SP $bmp 8 4 $b.fg
    # Glow corners
    SP $bmp 4 2 $b.acc; SP $bmp 11 2 $b.acc; SP $bmp 4 13 $b.acc; SP $bmp 11 13 $b.acc

    Make-ItemModel $b.name
    Save-Tex $bmp $texItems $b.name
    $tailNum++
}
Write-Host "  9 Tailed Beast seals done"

# ============================================================
# CLAN ITEMS - 8 items
# ============================================================
Write-Host "Generating Clan Item assets..."

# Uchiha Fan
$bmp = New-Object System.Drawing.Bitmap(16,16)
FR $bmp 4 2 11 13 ([System.Drawing.Color]::FromArgb(255,200,200,200))
FR $bmp 4 2 11 7 ([System.Drawing.Color]::FromArgb(255,220,30,30))
FR $bmp 4 8 11 13 ([System.Drawing.Color]::FromArgb(255,250,250,250))
DB $bmp 4 2 11 13 ([System.Drawing.Color]::FromArgb(255,50,50,50))
SP $bmp 7 14 ([System.Drawing.Color]::FromArgb(255,100,60,30))
SP $bmp 8 14 ([System.Drawing.Color]::FromArgb(255,100,60,30))
SP $bmp 7 15 ([System.Drawing.Color]::FromArgb(255,80,50,20))
SP $bmp 8 15 ([System.Drawing.Color]::FromArgb(255,80,50,20))
Make-ItemModel "uchiha_fan"
Save-Tex $bmp $texItems "uchiha_fan"

# Hyuga Scroll
$bmp = New-Object System.Drawing.Bitmap(16,16)
FR $bmp 4 3 11 12 ([System.Drawing.Color]::FromArgb(255,230,230,245))
DB $bmp 4 3 11 12 ([System.Drawing.Color]::FromArgb(255,160,160,200))
FR $bmp 4 3 11 4 ([System.Drawing.Color]::FromArgb(255,180,160,220))
FR $bmp 4 11 11 12 ([System.Drawing.Color]::FromArgb(255,180,160,220))
SP $bmp 7 7 ([System.Drawing.Color]::FromArgb(255,200,200,255))
SP $bmp 8 7 ([System.Drawing.Color]::FromArgb(255,200,200,255))
SP $bmp 6 8 ([System.Drawing.Color]::FromArgb(255,160,140,200))
SP $bmp 9 8 ([System.Drawing.Color]::FromArgb(255,160,140,200))
SP $bmp 7 6 ([System.Drawing.Color]::FromArgb(255,160,140,200))
SP $bmp 8 9 ([System.Drawing.Color]::FromArgb(255,160,140,200))
Make-ItemModel "hyuga_scroll"
Save-Tex $bmp $texItems "hyuga_scroll"

# Uzumaki Chain
$bmp = New-Object System.Drawing.Bitmap(16,16)
$gold = [System.Drawing.Color]::FromArgb(255,220,180,50)
$dgold = [System.Drawing.Color]::FromArgb(255,180,140,30)
$red = [System.Drawing.Color]::FromArgb(255,200,30,30)
for ($i = 0; $i -lt 5; $i++) {
    $cx = 3 + $i * 2; $cy = 5 + ($i % 2) * 3
    FR $bmp $cx $cy ($cx+2) ($cy+2) $gold
    SP $bmp ($cx+1) ($cy+1) $dgold
}
# Uzumaki spiral
SP $bmp 7 12 $red; SP $bmp 8 12 $red; SP $bmp 6 13 $red; SP $bmp 9 13 $red
SP $bmp 7 14 $red; SP $bmp 8 14 $red
Make-ItemModel "uzumaki_chain"
Save-Tex $bmp $texItems "uzumaki_chain"

# Nara Shadow Kunai
$bmp = New-Object System.Drawing.Bitmap(16,16)
$dk = [System.Drawing.Color]::FromArgb(255,30,30,40)
$dg = [System.Drawing.Color]::FromArgb(255,60,60,80)
$purple = [System.Drawing.Color]::FromArgb(255,80,40,120)
SP $bmp 7 1 $dk; SP $bmp 8 1 $dk
SP $bmp 7 2 $dk; SP $bmp 8 2 $dg
for ($y = 3; $y -le 9; $y++) { SP $bmp 7 $y $dk; SP $bmp 8 $y $dg }
SP $bmp 6 10 $purple; SP $bmp 7 10 $dk; SP $bmp 8 10 $dk; SP $bmp 9 10 $purple
SP $bmp 7 11 $dk; SP $bmp 8 11 $dk
SP $bmp 7 12 $dg; SP $bmp 8 12 $dg
SP $bmp 7 13 $dg; SP $bmp 8 13 $dg
SP $bmp 5 14 $purple; SP $bmp 10 14 $purple
Make-ItemModel "nara_shadow_kunai"
Save-Tex $bmp $texItems "nara_shadow_kunai"

# Aburame Hive
$bmp = New-Object System.Drawing.Bitmap(16,16)
$brown = [System.Drawing.Color]::FromArgb(255,120,80,30)
$dbr = [System.Drawing.Color]::FromArgb(255,80,50,20)
$yel = [System.Drawing.Color]::FromArgb(255,200,180,50)
FR $bmp 4 4 11 13 $brown
DB $bmp 4 4 11 13 $dbr
for ($y = 5; $y -le 12; $y += 2) {
    SP $bmp 6 $y $yel; SP $bmp 9 $y $yel
}
SP $bmp 7 3 $dbr; SP $bmp 8 3 $dbr
SP $bmp 7 2 $dbr; SP $bmp 8 2 $dbr
Make-ItemModel "aburame_hive"
Save-Tex $bmp $texItems "aburame_hive"

# Inuzuka Fang
$bmp = New-Object System.Drawing.Bitmap(16,16)
$wh = [System.Drawing.Color]::FromArgb(255,240,240,240)
$gry = [System.Drawing.Color]::FromArgb(255,200,200,200)
$rdm = [System.Drawing.Color]::FromArgb(255,200,50,50)
SP $bmp 7 1 $wh; SP $bmp 8 1 $wh
SP $bmp 7 2 $wh; SP $bmp 8 2 $gry
for ($y = 3; $y -le 10; $y++) { SP $bmp 7 $y $wh; SP $bmp 8 $y $gry }
SP $bmp 7 11 $gry; SP $bmp 8 11 $gry
SP $bmp 6 4 $rdm; SP $bmp 9 4 $rdm
SP $bmp 5 5 $rdm; SP $bmp 10 5 $rdm
# Handle
SP $bmp 7 12 $brown; SP $bmp 8 12 $brown
SP $bmp 7 13 $brown; SP $bmp 8 13 $brown
SP $bmp 7 14 $dbr; SP $bmp 8 14 $dbr
Make-ItemModel "inuzuka_fang"
Save-Tex $bmp $texItems "inuzuka_fang"

# Akimichi Pill
$bmp = New-Object System.Drawing.Bitmap(16,16)
$grn = [System.Drawing.Color]::FromArgb(255,50,180,50)
$dgrn = [System.Drawing.Color]::FromArgb(255,30,130,30)
$yp = [System.Drawing.Color]::FromArgb(255,200,200,50)
FR $bmp 5 5 10 10 $grn
SP $bmp 6 4 $grn; SP $bmp 7 4 $grn; SP $bmp 8 4 $grn; SP $bmp 9 4 $grn
SP $bmp 6 11 $grn; SP $bmp 7 11 $grn; SP $bmp 8 11 $grn; SP $bmp 9 11 $grn
SP $bmp 4 6 $grn; SP $bmp 4 7 $grn; SP $bmp 4 8 $grn; SP $bmp 4 9 $grn
SP $bmp 11 6 $grn; SP $bmp 11 7 $grn; SP $bmp 11 8 $grn; SP $bmp 11 9 $grn
SP $bmp 7 7 $yp; SP $bmp 8 7 $yp; SP $bmp 7 8 $yp; SP $bmp 8 8 $yp
DB $bmp 5 5 10 10 $dgrn
Make-ItemModel "akimichi_pill"
Save-Tex $bmp $texItems "akimichi_pill"

# Yamanaka Flower
$bmp = New-Object System.Drawing.Bitmap(16,16)
$stem = [System.Drawing.Color]::FromArgb(255,50,140,50)
$petal = [System.Drawing.Color]::FromArgb(255,180,100,220)
$ctr = [System.Drawing.Color]::FromArgb(255,255,220,50)
SP $bmp 7 10 $stem; SP $bmp 8 10 $stem
SP $bmp 7 11 $stem; SP $bmp 8 11 $stem
SP $bmp 7 12 $stem; SP $bmp 8 12 $stem
SP $bmp 7 13 $stem; SP $bmp 8 13 $stem
SP $bmp 6 14 $stem; SP $bmp 9 14 $stem
SP $bmp 5 15 $stem; SP $bmp 10 15 $stem
# Petals
SP $bmp 7 4 $petal; SP $bmp 8 4 $petal
SP $bmp 6 5 $petal; SP $bmp 9 5 $petal
SP $bmp 5 6 $petal; SP $bmp 10 6 $petal
SP $bmp 5 7 $petal; SP $bmp 10 7 $petal
SP $bmp 5 8 $petal; SP $bmp 10 8 $petal
SP $bmp 6 9 $petal; SP $bmp 9 9 $petal
SP $bmp 7 9 $petal; SP $bmp 8 9 $petal
# Center
SP $bmp 7 6 $ctr; SP $bmp 8 6 $ctr; SP $bmp 7 7 $ctr; SP $bmp 8 7 $ctr
Make-ItemModel "yamanaka_flower"
Save-Tex $bmp $texItems "yamanaka_flower"

Write-Host "  8 Clan items done"

# ============================================================
# ADVANCED JUTSU - 8 items
# ============================================================
Write-Host "Generating Advanced Jutsu assets..."

# Rasenshuriken: blue-white spinning star
$bmp = New-Object System.Drawing.Bitmap(16,16)
$wb = [System.Drawing.Color]::FromArgb(255,200,220,255)
$bl = [System.Drawing.Color]::FromArgb(255,50,100,255)
$wh2 = [System.Drawing.Color]::FromArgb(255,255,255,255)
FR $bmp 5 5 10 10 $bl
SP $bmp 7 7 $wh2; SP $bmp 8 7 $wh2; SP $bmp 7 8 $wh2; SP $bmp 8 8 $wh2
# Star points
SP $bmp 7 3 $wb; SP $bmp 8 3 $wb; SP $bmp 7 12 $wb; SP $bmp 8 12 $wb
SP $bmp 3 7 $wb; SP $bmp 3 8 $wb; SP $bmp 12 7 $wb; SP $bmp 12 8 $wb
SP $bmp 4 4 $wb; SP $bmp 11 4 $wb; SP $bmp 4 11 $wb; SP $bmp 11 11 $wb
SP $bmp 6 4 $bl; SP $bmp 9 4 $bl; SP $bmp 6 11 $bl; SP $bmp 9 11 $bl
SP $bmp 4 6 $bl; SP $bmp 4 9 $bl; SP $bmp 11 6 $bl; SP $bmp 11 9 $bl
Make-ItemModel "rasenshuriken"
Save-Tex $bmp $texItems "rasenshuriken"

# Susanoo Rib: purple ribcage
$bmp = New-Object System.Drawing.Bitmap(16,16)
$pur = [System.Drawing.Color]::FromArgb(255,120,50,180)
$lpur = [System.Drawing.Color]::FromArgb(255,180,120,255)
for ($y = 3; $y -le 12; $y++) { SP $bmp 3 $y $pur; SP $bmp 12 $y $pur }
for ($y = 5; $y -le 10; $y += 2) { for ($x = 4; $x -le 11; $x++) { SP $bmp $x $y $lpur } }
SP $bmp 4 3 $pur; SP $bmp 5 2 $pur; SP $bmp 6 2 $pur; SP $bmp 7 2 $pur
SP $bmp 8 2 $pur; SP $bmp 9 2 $pur; SP $bmp 10 2 $pur; SP $bmp 11 3 $pur
Make-ItemModel "susanoo_rib"
Save-Tex $bmp $texItems "susanoo_rib"

# Tsukuyomi Eye: red sharingan
$bmp = New-Object System.Drawing.Bitmap(16,16)
$rd = [System.Drawing.Color]::FromArgb(255,200,0,0)
$bk = [System.Drawing.Color]::FromArgb(255,20,20,20)
FR $bmp 4 4 11 11 $rd
DB $bmp 4 4 11 11 $bk
SP $bmp 7 7 $bk; SP $bmp 8 7 $bk; SP $bmp 7 8 $bk; SP $bmp 8 8 $bk
SP $bmp 5 5 $bk; SP $bmp 10 5 $bk; SP $bmp 5 10 $bk; SP $bmp 10 10 $bk
SP $bmp 7 5 $bk; SP $bmp 5 7 $bk; SP $bmp 10 8 $bk; SP $bmp 8 10 $bk
SP $bmp 6 3 $bk; SP $bmp 7 3 $bk; SP $bmp 8 3 $bk; SP $bmp 9 3 $bk
SP $bmp 6 12 $bk; SP $bmp 7 12 $bk; SP $bmp 8 12 $bk; SP $bmp 9 12 $bk
SP $bmp 3 6 $bk; SP $bmp 3 7 $bk; SP $bmp 3 8 $bk; SP $bmp 3 9 $bk
SP $bmp 12 6 $bk; SP $bmp 12 7 $bk; SP $bmp 12 8 $bk; SP $bmp 12 9 $bk
Make-ItemModel "tsukuyomi_eye"
Save-Tex $bmp $texItems "tsukuyomi_eye"

# Kamui Mask: spiral mask
$bmp = New-Object System.Drawing.Bitmap(16,16)
$org = [System.Drawing.Color]::FromArgb(255,220,120,30)
$dorg = [System.Drawing.Color]::FromArgb(255,180,80,20)
FR $bmp 3 3 12 12 $org
DB $bmp 3 3 12 12 $dorg
# Eye hole spiral
SP $bmp 8 7 $bk; SP $bmp 9 7 $bk; SP $bmp 9 8 $bk; SP $bmp 8 8 $bk
SP $bmp 7 7 $bk; SP $bmp 7 8 $bk; SP $bmp 7 9 $bk
# Spiral lines
for ($x = 4; $x -le 11; $x++) { SP $bmp $x 5 $dorg }
for ($x = 4; $x -le 11; $x++) { SP $bmp $x 10 $dorg }
SP $bmp 5 6 $dorg; SP $bmp 5 7 $dorg; SP $bmp 5 8 $dorg; SP $bmp 5 9 $dorg
SP $bmp 10 6 $dorg; SP $bmp 10 7 $dorg; SP $bmp 10 8 $dorg; SP $bmp 10 9 $dorg
Make-ItemModel "kamui_mask"
Save-Tex $bmp $texItems "kamui_mask"

# Sage Art Scroll: green scroll
$bmp = New-Object System.Drawing.Bitmap(16,16)
$sg = [System.Drawing.Color]::FromArgb(255,80,180,80)
$dsg = [System.Drawing.Color]::FromArgb(255,40,120,40)
$sgy = [System.Drawing.Color]::FromArgb(255,200,220,100)
FR $bmp 4 3 11 12 $sg
DB $bmp 4 3 11 12 $dsg
FR $bmp 4 3 11 4 $dsg
FR $bmp 4 11 11 12 $dsg
SP $bmp 7 7 $sgy; SP $bmp 8 7 $sgy
SP $bmp 6 7 $dsg; SP $bmp 9 7 $dsg
SP $bmp 7 6 $dsg; SP $bmp 8 6 $dsg
SP $bmp 7 8 $dsg; SP $bmp 8 8 $dsg
Make-ItemModel "sage_art_scroll"
Save-Tex $bmp $texItems "sage_art_scroll"

# Reaper Death Seal: dark crimson seal
$bmp = New-Object System.Drawing.Bitmap(16,16)
$drk = [System.Drawing.Color]::FromArgb(255,60,10,10)
$crim = [System.Drawing.Color]::FromArgb(255,150,20,20)
$bld = [System.Drawing.Color]::FromArgb(255,200,0,0)
FR $bmp 3 2 12 13 $drk
DB $bmp 3 2 12 13 $crim
# Death mark pattern
SP $bmp 7 5 $bld; SP $bmp 8 5 $bld
SP $bmp 6 6 $bld; SP $bmp 9 6 $bld
SP $bmp 6 7 $bld; SP $bmp 9 7 $bld
SP $bmp 7 8 $bld; SP $bmp 8 8 $bld
SP $bmp 7 9 $bld; SP $bmp 8 9 $bld
SP $bmp 6 10 $bld; SP $bmp 9 10 $bld
SP $bmp 5 11 $bld; SP $bmp 10 11 $bld
Make-ItemModel "reaper_death_seal"
Save-Tex $bmp $texItems "reaper_death_seal"

# Creation Rebirth: green diamond
$bmp = New-Object System.Drawing.Bitmap(16,16)
$teal = [System.Drawing.Color]::FromArgb(255,50,200,180)
$dteal = [System.Drawing.Color]::FromArgb(255,30,150,130)
$diamond = [System.Drawing.Color]::FromArgb(255,180,255,200)
FR $bmp 5 5 10 10 $teal
DB $bmp 5 5 10 10 $dteal
# Diamond in center
SP $bmp 7 4 $diamond; SP $bmp 8 4 $diamond
SP $bmp 6 5 $diamond; SP $bmp 9 5 $diamond
SP $bmp 7 6 $diamond; SP $bmp 8 6 $diamond
# Glow effect
SP $bmp 4 7 $teal; SP $bmp 11 7 $teal
SP $bmp 4 8 $teal; SP $bmp 11 8 $teal
SP $bmp 7 11 $teal; SP $bmp 8 11 $teal
SP $bmp 7 3 $dteal; SP $bmp 8 3 $dteal
Make-ItemModel "creation_rebirth"
Save-Tex $bmp $texItems "creation_rebirth"

# Flying Thunder God: yellow kunai with mark
$bmp = New-Object System.Drawing.Bitmap(16,16)
$yel2 = [System.Drawing.Color]::FromArgb(255,255,220,50)
$dyel = [System.Drawing.Color]::FromArgb(255,200,170,30)
$mk = [System.Drawing.Color]::FromArgb(255,50,50,50)
SP $bmp 7 1 $yel2; SP $bmp 8 1 $yel2
SP $bmp 7 2 $yel2; SP $bmp 8 2 $dyel
for ($y = 3; $y -le 8; $y++) { SP $bmp 7 $y $yel2; SP $bmp 8 $y $dyel }
SP $bmp 6 9 $mk; SP $bmp 7 9 $mk; SP $bmp 8 9 $mk; SP $bmp 9 9 $mk
# Handle with marks
for ($y = 10; $y -le 14; $y++) { SP $bmp 7 $y $mk; SP $bmp 8 $y $mk }
SP $bmp 6 11 $yel2; SP $bmp 9 11 $yel2
SP $bmp 6 13 $yel2; SP $bmp 9 13 $yel2
Make-ItemModel "flying_thunder_god"
Save-Tex $bmp $texItems "flying_thunder_god"

Write-Host "  8 Advanced Jutsu items done"

# ============================================================
# LEGENDARY WEAPONS - 6 items
# ============================================================
Write-Host "Generating Legendary Weapon assets..."

# Samehada: blue shark-skin sword
$bmp = New-Object System.Drawing.Bitmap(16,16)
$sbl = [System.Drawing.Color]::FromArgb(255,40,60,120)
$slbl = [System.Drawing.Color]::FromArgb(255,80,100,180)
$swh = [System.Drawing.Color]::FromArgb(255,180,180,200)
# Wide blade
for ($y = 1; $y -le 9; $y++) { SP $bmp 6 $y $sbl; SP $bmp 7 $y $sbl; SP $bmp 8 $y $slbl; SP $bmp 9 $y $sbl }
# Spikes on sides
SP $bmp 5 2 $sbl; SP $bmp 10 3 $sbl; SP $bmp 5 4 $sbl; SP $bmp 10 5 $sbl
SP $bmp 5 6 $sbl; SP $bmp 10 7 $sbl; SP $bmp 5 8 $sbl
# Handle
for ($y = 10; $y -le 14; $y++) { SP $bmp 7 $y $swh; SP $bmp 8 $y $swh }
SP $bmp 6 10 $sbl; SP $bmp 9 10 $sbl
Make-ItemModel "samehada"
Save-Tex $bmp $texItems "samehada"

# Kubikiribocho: large grey cleaver
$bmp = New-Object System.Drawing.Bitmap(16,16)
$stl = [System.Drawing.Color]::FromArgb(255,160,160,170)
$dstl = [System.Drawing.Color]::FromArgb(255,120,120,130)
$hnd = [System.Drawing.Color]::FromArgb(255,80,60,40)
# Wide blade
for ($y = 0; $y -le 8; $y++) {
    for ($x = 5; $x -le 10; $x++) { SP $bmp $x $y $stl }
}
DB $bmp 5 0 10 8 $dstl
# Half-circle cutout
SP $bmp 7 2 ([System.Drawing.Color]::Transparent); SP $bmp 8 2 ([System.Drawing.Color]::Transparent)
SP $bmp 7 3 ([System.Drawing.Color]::Transparent); SP $bmp 8 3 ([System.Drawing.Color]::Transparent)
# Handle
for ($y = 9; $y -le 15; $y++) { SP $bmp 7 $y $hnd; SP $bmp 8 $y $hnd }
SP $bmp 6 9 $dstl; SP $bmp 9 9 $dstl
Make-ItemModel "kubikiribocho"
Save-Tex $bmp $texItems "kubikiribocho"

# Totsuka Blade: ethereal purple sword
$bmp = New-Object System.Drawing.Bitmap(16,16)
$epur = [System.Drawing.Color]::FromArgb(200,140,60,200)
$lepur = [System.Drawing.Color]::FromArgb(180,200,150,255)
$epurh = [System.Drawing.Color]::FromArgb(255,100,40,150)
for ($y = 1; $y -le 9; $y++) { SP $bmp 7 $y $epur; SP $bmp 8 $y $lepur }
SP $bmp 7 0 $lepur; SP $bmp 8 0 $lepur
SP $bmp 6 4 $lepur; SP $bmp 9 4 $lepur
SP $bmp 6 6 $lepur; SP $bmp 9 6 $lepur
# Guard
SP $bmp 5 10 $epurh; SP $bmp 6 10 $epurh; SP $bmp 7 10 $epurh; SP $bmp 8 10 $epurh; SP $bmp 9 10 $epurh; SP $bmp 10 10 $epurh
# Handle
for ($y = 11; $y -le 14; $y++) { SP $bmp 7 $y $epurh; SP $bmp 8 $y $epurh }
Make-ItemModel "totsuka_blade"
Save-Tex $bmp $texItems "totsuka_blade"

# Sword of Kusanagi: green-glowing blade
$bmp = New-Object System.Drawing.Bitmap(16,16)
$ksg = [System.Drawing.Color]::FromArgb(255,100,200,100)
$dksg = [System.Drawing.Color]::FromArgb(255,50,130,50)
$khnd = [System.Drawing.Color]::FromArgb(255,120,100,60)
for ($y = 1; $y -le 9; $y++) { SP $bmp 7 $y $ksg; SP $bmp 8 $y $dksg }
SP $bmp 7 0 $ksg
SP $bmp 5 10 $khnd; SP $bmp 6 10 $dksg; SP $bmp 7 10 $dksg; SP $bmp 8 10 $dksg; SP $bmp 9 10 $dksg; SP $bmp 10 10 $khnd
for ($y = 11; $y -le 14; $y++) { SP $bmp 7 $y $khnd; SP $bmp 8 $y $khnd }
SP $bmp 6 3 $ksg; SP $bmp 9 5 $ksg; SP $bmp 6 7 $ksg
Make-ItemModel "sword_of_kusanagi"
Save-Tex $bmp $texItems "sword_of_kusanagi"

# Gunbai: large war fan
$bmp = New-Object System.Drawing.Bitmap(16,16)
$gwood = [System.Drawing.Color]::FromArgb(255,160,120,60)
$dgwood = [System.Drawing.Color]::FromArgb(255,100,70,30)
$gpaper = [System.Drawing.Color]::FromArgb(255,230,220,200)
# Fan head
FR $bmp 2 1 13 8 $gpaper
DB $bmp 2 1 13 8 $dgwood
# Tomoe pattern
SP $bmp 5 4 $dgwood; SP $bmp 6 5 $dgwood; SP $bmp 10 4 $dgwood; SP $bmp 9 5 $dgwood
SP $bmp 7 3 $dgwood; SP $bmp 8 3 $dgwood
# Handle
for ($y = 9; $y -le 15; $y++) { SP $bmp 7 $y $gwood; SP $bmp 8 $y $gwood }
Make-ItemModel "gunbai"
Save-Tex $bmp $texItems "gunbai"

# Hiramekarei: twin-blade sword
$bmp = New-Object System.Drawing.Bitmap(16,16)
$hbl = [System.Drawing.Color]::FromArgb(255,150,200,220)
$dhbl = [System.Drawing.Color]::FromArgb(255,100,150,180)
$hhnd = [System.Drawing.Color]::FromArgb(255,80,60,40)
# Two blades
for ($y = 1; $y -le 8; $y++) {
    SP $bmp 6 $y $hbl; SP $bmp 7 $y $dhbl; SP $bmp 8 $y $dhbl; SP $bmp 9 $y $hbl
}
SP $bmp 6 0 $hbl; SP $bmp 9 0 $hbl
# Gap in middle
SP $bmp 7 2 ([System.Drawing.Color]::Transparent); SP $bmp 8 2 ([System.Drawing.Color]::Transparent)
SP $bmp 7 4 ([System.Drawing.Color]::Transparent); SP $bmp 8 4 ([System.Drawing.Color]::Transparent)
SP $bmp 7 6 ([System.Drawing.Color]::Transparent); SP $bmp 8 6 ([System.Drawing.Color]::Transparent)
# Guard and handle
SP $bmp 5 9 $dhbl; SP $bmp 6 9 $dhbl; SP $bmp 7 9 $dhbl; SP $bmp 8 9 $dhbl; SP $bmp 9 9 $dhbl; SP $bmp 10 9 $dhbl
for ($y = 10; $y -le 14; $y++) { SP $bmp 7 $y $hhnd; SP $bmp 8 $y $hhnd }
Make-ItemModel "hiramekarei"
Save-Tex $bmp $texItems "hiramekarei"

Write-Host "  6 Legendary Weapons done"

# ============================================================
# VILLAGE BLOCKS - 7 blocks
# ============================================================
Write-Host "Generating Village Block assets..."

$villageBlocks = @(
    @{name="hot_spring_water"; c1=[System.Drawing.Color]::FromArgb(180,100,180,220); c2=[System.Drawing.Color]::FromArgb(160,80,150,200); c3=[System.Drawing.Color]::FromArgb(200,200,230,255)},
    @{name="ninja_academy_brick"; c1=[System.Drawing.Color]::FromArgb(255,180,160,130); c2=[System.Drawing.Color]::FromArgb(255,150,130,100); c3=[System.Drawing.Color]::FromArgb(255,130,110,85)},
    @{name="anbu_hq_block"; c1=[System.Drawing.Color]::FromArgb(255,50,50,60); c2=[System.Drawing.Color]::FromArgb(255,40,40,50); c3=[System.Drawing.Color]::FromArgb(255,70,70,80)},
    @{name="hokage_monument_stone"; c1=[System.Drawing.Color]::FromArgb(255,180,170,150); c2=[System.Drawing.Color]::FromArgb(255,160,150,130); c3=[System.Drawing.Color]::FromArgb(255,200,190,170)},
    @{name="ichiraku_neon"; c1=[System.Drawing.Color]::FromArgb(255,255,200,50); c2=[System.Drawing.Color]::FromArgb(255,255,180,30); c3=[System.Drawing.Color]::FromArgb(255,255,255,200)},
    @{name="konoha_gate_block"; c1=[System.Drawing.Color]::FromArgb(255,160,80,30); c2=[System.Drawing.Color]::FromArgb(255,130,60,20); c3=[System.Drawing.Color]::FromArgb(255,50,130,50)},
    @{name="mission_board"; c1=[System.Drawing.Color]::FromArgb(255,140,100,50); c2=[System.Drawing.Color]::FromArgb(255,110,80,35); c3=[System.Drawing.Color]::FromArgb(255,230,220,180)}
)

foreach ($vb in $villageBlocks) {
    # Block texture
    $bmp = New-Object System.Drawing.Bitmap(16,16)
    FR $bmp 0 0 15 15 $vb.c1
    # Pattern - brick-like for most
    for ($y = 0; $y -le 15; $y += 4) {
        for ($x = 0; $x -le 15; $x++) { SP $bmp $x $y $vb.c2 }
    }
    for ($x = 0; $x -le 15; $x += 4) {
        for ($y = 0; $y -le 15; $y++) { SP $bmp $x $y $vb.c2 }
    }
    # Accent spots
    SP $bmp 3 3 $vb.c3; SP $bmp 11 3 $vb.c3; SP $bmp 7 7 $vb.c3; SP $bmp 3 11 $vb.c3; SP $bmp 11 11 $vb.c3
    SP $bmp 7 13 $vb.c3; SP $bmp 13 7 $vb.c3

    Save-Tex $bmp $texBlocks $vb.name
    Make-BlockModel $vb.name
    Make-BlockItemModel $vb.name
    Make-Blockstate $vb.name
}

Write-Host "  7 Village Blocks done"

# ============================================================
# RECIPES for new items
# ============================================================
Write-Host "Generating recipes..."

function Make-ShapedRecipe($name, $pattern, $keys, $result, $count) {
    if (!$count) { $count = 1 }
    $keysJson = ""
    foreach ($k in $keys.GetEnumerator()) {
        if ($keysJson) { $keysJson += "," }
        $keysJson += "`"$($k.Key)`":{`"item`":`"$($k.Value)`"}"
    }
    $json = "{`"type`":`"minecraft:crafting_shaped`",`"pattern`":[$($pattern -join ',')],`"key`":{$keysJson},`"result`":{`"item`":`"projetokonoha:$result`",`"count`":$count}}"
    [System.IO.File]::WriteAllText("$recipes\$name.json", $json)
}

function Make-ShapelessRecipe($name, $ingredients, $result, $count) {
    if (!$count) { $count = 1 }
    $ingJson = ($ingredients | ForEach-Object { "{`"item`":`"$_`"}" }) -join ","
    $json = "{`"type`":`"minecraft:crafting_shapeless`",`"ingredients`":[$ingJson],`"result`":{`"item`":`"projetokonoha:$result`",`"count`":$count}}"
    [System.IO.File]::WriteAllText("$recipes\$name.json", $json)
}

# Tailed Beast Seal recipes (expensive - nether star + bijuu cloak)
$sealItems = @("one_tail_seal","two_tails_seal","three_tails_seal","four_tails_seal","five_tails_seal","six_tails_seal","seven_tails_seal","eight_tails_seal","nine_tails_seal")
foreach ($seal in $sealItems) {
    Make-ShapelessRecipe $seal @("minecraft:nether_star","projetokonoha:bijuu_cloak","projetokonoha:chakra_crystal","projetokonoha:blank_scroll") $seal 1
}

# Clan item recipes
Make-ShapedRecipe "uchiha_fan" @('`" I `"','`"ISI`"','`" I `"') @{I="minecraft:iron_ingot";S="projetokonoha:sharingan_eye"} "uchiha_fan"
Make-ShapedRecipe "hyuga_scroll" @('`" P `"','`"PBP`"','`" P `"') @{P="minecraft:paper";B="projetokonoha:byakugan_eye"} "hyuga_scroll"
Make-ShapelessRecipe "uzumaki_chain" @("minecraft:gold_ingot","minecraft:gold_ingot","minecraft:gold_ingot","projetokonoha:chakra_crystal") "uzumaki_chain" 1
Make-ShapedRecipe "nara_shadow_kunai" @('`" N `"','`" N `"','`" S `"') @{N="projetokonoha:ninja_steel_ingot";S="minecraft:ink_sac"} "nara_shadow_kunai"
Make-ShapelessRecipe "aburame_hive" @("minecraft:log","minecraft:log","projetokonoha:chakra_dust","minecraft:spider_eye") "aburame_hive" 1
Make-ShapelessRecipe "inuzuka_fang" @("minecraft:bone","minecraft:bone","projetokonoha:ninja_steel_ingot") "inuzuka_fang" 1
Make-ShapelessRecipe "akimichi_pill" @("projetokonoha:soldier_pill","projetokonoha:chakra_fruit","minecraft:golden_apple") "akimichi_pill" 1
Make-ShapelessRecipe "yamanaka_flower" @("minecraft:red_flower","projetokonoha:chakra_dust","minecraft:diamond") "yamanaka_flower" 1

# Advanced Jutsu recipes (very expensive)
Make-ShapelessRecipe "rasenshuriken" @("projetokonoha:scroll_rasengan","projetokonoha:chakra_crystal","projetokonoha:chakra_crystal","minecraft:nether_star") "rasenshuriken" 1
Make-ShapelessRecipe "susanoo_rib" @("projetokonoha:sharingan_eye","projetokonoha:sharingan_eye","projetokonoha:chakra_crystal","minecraft:nether_star") "susanoo_rib" 1
Make-ShapelessRecipe "tsukuyomi_eye" @("projetokonoha:sharingan_eye","minecraft:nether_star","minecraft:ender_eye") "tsukuyomi_eye" 1
Make-ShapelessRecipe "kamui_mask" @("projetokonoha:sharingan_eye","minecraft:nether_star","minecraft:ender_pearl","projetokonoha:ninja_steel_ingot") "kamui_mask" 1
Make-ShapelessRecipe "sage_art_scroll" @("projetokonoha:blank_scroll","projetokonoha:chakra_fruit","projetokonoha:chakra_crystal","minecraft:emerald") "sage_art_scroll" 1
Make-ShapelessRecipe "reaper_death_seal" @("projetokonoha:blank_scroll","minecraft:nether_star","minecraft:nether_star","minecraft:wither_skeleton_skull") "reaper_death_seal" 1
Make-ShapelessRecipe "creation_rebirth" @("projetokonoha:chakra_crystal","minecraft:diamond","minecraft:emerald","minecraft:golden_apple") "creation_rebirth" 1
Make-ShapelessRecipe "flying_thunder_god" @("projetokonoha:kunai","minecraft:nether_star","projetokonoha:chakra_crystal","minecraft:ender_pearl") "flying_thunder_god" 1

# Legendary Weapon recipes (super expensive)
Make-ShapedRecipe "samehada" @('`"NNN`"','`"NCN`"','`" S `"') @{N="projetokonoha:ninja_steel_ingot";C="projetokonoha:chakra_crystal";S="minecraft:stick"} "samehada"
Make-ShapedRecipe "kubikiribocho" @('`"NNN`"','`"N N`"','`" S `"') @{N="projetokonoha:ninja_steel_ingot";S="minecraft:stick"} "kubikiribocho"
Make-ShapelessRecipe "totsuka_blade" @("projetokonoha:katana","minecraft:nether_star","projetokonoha:sharingan_eye","minecraft:ender_eye") "totsuka_blade" 1
Make-ShapelessRecipe "sword_of_kusanagi" @("projetokonoha:katana","minecraft:spider_eye","projetokonoha:chakra_crystal","minecraft:emerald") "sword_of_kusanagi" 1
Make-ShapedRecipe "gunbai" @('`"PPP`"','`"PCP`"','`" S `"') @{P="minecraft:planks";C="projetokonoha:chakra_crystal";S="minecraft:stick"} "gunbai"
Make-ShapelessRecipe "hiramekarei" @("projetokonoha:katana","projetokonoha:katana","projetokonoha:chakra_crystal","minecraft:diamond") "hiramekarei" 1

# Village Block recipes
Make-ShapelessRecipe "hot_spring_water" @("minecraft:water_bucket","projetokonoha:chakra_dust") "hot_spring_water" 1
Make-ShapedRecipe "ninja_academy_brick" @('`"SS`"','`"SS`"') @{S="projetokonoha:konoha_stone"} "ninja_academy_brick" 4
Make-ShapedRecipe "anbu_hq_block" @('`"NN`"','`"NN`"') @{N="projetokonoha:ninja_steel_ingot"} "anbu_hq_block" 4
Make-ShapedRecipe "hokage_monument_stone" @('`"SCS`"','`"SSS`"') @{S="minecraft:stone";C="projetokonoha:chakra_dust"} "hokage_monument_stone" 4
Make-ShapedRecipe "ichiraku_neon" @('`"GGG`"','`"GCG`"','`"GGG`"') @{G="minecraft:glowstone_dust";C="projetokonoha:chakra_crystal"} "ichiraku_neon" 1
Make-ShapedRecipe "konoha_gate_block" @('`"PPP`"','`"PCP`"','`"PPP`"') @{P="projetokonoha:konoha_planks";C="projetokonoha:chakra_dust"} "konoha_gate_block" 4
Make-ShapedRecipe "mission_board" @('`"PPP`"','`"PIP`"','`"PPP`"') @{P="projetokonoha:konoha_planks";I="minecraft:writable_book"} "mission_board" 1

Write-Host "  All recipes generated"

# ============================================================
# UPDATE LANG FILES
# ============================================================
Write-Host "Updating language files..."

$newEnglish = @"
item.one_tail_seal.name=Shukaku Seal (One-Tail)
item.two_tails_seal.name=Matatabi Seal (Two-Tails)
item.three_tails_seal.name=Isobu Seal (Three-Tails)
item.four_tails_seal.name=Son Goku Seal (Four-Tails)
item.five_tails_seal.name=Kokuo Seal (Five-Tails)
item.six_tails_seal.name=Saiken Seal (Six-Tails)
item.seven_tails_seal.name=Chomei Seal (Seven-Tails)
item.eight_tails_seal.name=Gyuki Seal (Eight-Tails)
item.nine_tails_seal.name=Kurama Seal (Nine-Tails)
item.uchiha_fan.name=Uchiha Clan Fan
item.hyuga_scroll.name=Hyuga Clan Scroll
item.uzumaki_chain.name=Uzumaki Adamantine Chain
item.nara_shadow_kunai.name=Nara Shadow Kunai
item.aburame_hive.name=Aburame Insect Hive
item.inuzuka_fang.name=Inuzuka Beast Fang
item.akimichi_pill.name=Akimichi Expansion Pill
item.yamanaka_flower.name=Yamanaka Mind Flower
item.rasenshuriken.name=Rasenshuriken
item.susanoo_rib.name=Susanoo Ribcage
item.tsukuyomi_eye.name=Tsukuyomi Eye
item.kamui_mask.name=Kamui Mask
item.sage_art_scroll.name=Sage Art Scroll
item.reaper_death_seal.name=Reaper Death Seal
item.creation_rebirth.name=Creation Rebirth
item.flying_thunder_god.name=Flying Thunder God Kunai
item.samehada.name=Samehada
item.kubikiribocho.name=Kubikiribocho
item.totsuka_blade.name=Totsuka Blade
item.sword_of_kusanagi.name=Sword of Kusanagi
item.gunbai.name=Gunbai
item.hiramekarei.name=Hiramekarei
tile.hot_spring_water.name=Hot Spring Water
tile.ninja_academy_brick.name=Ninja Academy Brick
tile.anbu_hq_block.name=ANBU HQ Block
tile.hokage_monument_stone.name=Hokage Monument Stone
tile.ichiraku_neon.name=Ichiraku Neon Sign
tile.konoha_gate_block.name=Konoha Gate Block
tile.mission_board.name=Mission Board
"@

$newPortuguese = @"
item.one_tail_seal.name=Selo do Shukaku (Uma Cauda)
item.two_tails_seal.name=Selo do Matatabi (Duas Caudas)
item.three_tails_seal.name=Selo do Isobu (Tres Caudas)
item.four_tails_seal.name=Selo do Son Goku (Quatro Caudas)
item.five_tails_seal.name=Selo do Kokuo (Cinco Caudas)
item.six_tails_seal.name=Selo do Saiken (Seis Caudas)
item.seven_tails_seal.name=Selo do Chomei (Sete Caudas)
item.eight_tails_seal.name=Selo do Gyuki (Oito Caudas)
item.nine_tails_seal.name=Selo do Kurama (Nove Caudas)
item.uchiha_fan.name=Leque do Cla Uchiha
item.hyuga_scroll.name=Pergaminho do Cla Hyuga
item.uzumaki_chain.name=Corrente Adamantina Uzumaki
item.nara_shadow_kunai.name=Kunai das Sombras Nara
item.aburame_hive.name=Colmeia de Insetos Aburame
item.inuzuka_fang.name=Presa Bestial Inuzuka
item.akimichi_pill.name=Pilula de Expansao Akimichi
item.yamanaka_flower.name=Flor Mental Yamanaka
item.rasenshuriken.name=Rasenshuriken
item.susanoo_rib.name=Costela do Susanoo
item.tsukuyomi_eye.name=Olho do Tsukuyomi
item.kamui_mask.name=Mascara do Kamui
item.sage_art_scroll.name=Pergaminho Arte Sennin
item.reaper_death_seal.name=Selo do Shinigami
item.creation_rebirth.name=Renascimento da Criacao
item.flying_thunder_god.name=Kunai do Deus Trovao Voador
item.samehada.name=Samehada
item.kubikiribocho.name=Kubikiribocho
item.totsuka_blade.name=Espada de Totsuka
item.sword_of_kusanagi.name=Espada de Kusanagi
item.gunbai.name=Gunbai
item.hiramekarei.name=Hiramekarei
tile.hot_spring_water.name=Agua Termal
tile.ninja_academy_brick.name=Tijolo da Academia Ninja
tile.anbu_hq_block.name=Bloco do QG ANBU
tile.hokage_monument_stone.name=Pedra do Monumento Hokage
tile.ichiraku_neon.name=Neon do Ichiraku
tile.konoha_gate_block.name=Bloco do Portao de Konoha
tile.mission_board.name=Quadro de Missoes
"@

# Append to existing lang files
Add-Content -Path "$lang\en_us.lang" -Value "`n$newEnglish" -Encoding UTF8
Add-Content -Path "$lang\pt_br.lang" -Value "`n$newPortuguese" -Encoding UTF8

Write-Host "  Lang files updated"

# ============================================================
# FINAL COUNTS
# ============================================================
$itemTexCount = (Get-ChildItem "$texItems\*.png").Count
$itemModelCount = (Get-ChildItem "$modelsItem\*.json").Count
$blockTexCount = (Get-ChildItem "$texBlocks\*.png").Count
$blockModelCount = (Get-ChildItem "$modelsBlock\*.json").Count
$bsCount = (Get-ChildItem "$blockstates\*.json").Count
$recipeCount = (Get-ChildItem "$recipes\*.json").Count

Write-Host ""
Write-Host "=== FINAL ASSET COUNTS ==="
Write-Host "Item textures: $itemTexCount"
Write-Host "Item models:   $itemModelCount"
Write-Host "Block textures: $blockTexCount"
Write-Host "Block models:  $blockModelCount"
Write-Host "Blockstates:   $bsCount"
Write-Host "Recipes:       $recipeCount"
Write-Host "==========================="
Write-Host "ALL DONE!"
