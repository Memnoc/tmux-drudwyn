"""Convert the approved PNG alpha mask into a standalone monochrome font.

Requires fonttools and Pillow. The source PNG is read only and stays unchanged.
"""
from pathlib import Path
from PIL import Image
from fontTools.fontBuilder import FontBuilder
from fontTools.pens.ttGlyphPen import TTGlyphPen

ROOT = Path(__file__).resolve().parents[2]
alpha = Image.open(ROOT / 'assets/brand/drudwyn-white.png').getchannel('A')
# Sample the alpha mask for a compact font outline; discard faint edge noise.
mask = alpha.resize((128, 128), Image.Resampling.LANCZOS)
filled = {(x, y) for y in range(128) for x in range(128) if mask.getpixel((x, y)) >= 160}
# Keep the main connected silhouette, excluding isolated export speckles.
components = []
while filled:
    pending = [filled.pop()]
    component = set(pending)
    while pending:
        x, y = pending.pop()
        for p in [(x-1,y),(x+1,y),(x,y-1),(x,y+1)]:
            if p in filled:
                filled.remove(p); component.add(p); pending.append(p)
    components.append(component)
filled = max(components, key=len)
# Trace the boundary of the occupied pixels, including negative-space contours.
edges = set()
for x,y in filled:
    for a,b in [((x,y),(x+1,y)),((x+1,y),(x+1,y+1)),((x+1,y+1),(x,y+1)),((x,y+1),(x,y))]:
        if (b,a) in edges: edges.remove((b,a))
        else: edges.add((a,b))
paths = []
while edges:
    a,b = min(edges); edges.remove((a,b)); path = [a,b]
    while b != a:
        edge = min(e for e in edges if e[0] == b)
        edges.remove(edge); b = edge[1]; path.append(b)
    paths.append(path[:-1])
x0 = min(x for x,y in filled); x1 = max(x for x,y in filled)+1
y0 = min(y for x,y in filled); y1 = max(y for x,y in filled)+1
# A terminal-cell aspect ratio keeps the hound readable beside text.
def point(p):
    x,y=p
    return round(30+(x-x0)*540/(x1-x0)), round(800-(y-y0)*900/(y1-y0))
pen = TTGlyphPen(None)
for path in paths:
    pen.moveTo(point(path[0]))
    for p in path[1:]: pen.lineTo(point(p))
    pen.closePath()
fb=FontBuilder(1000,isTTF=True)
fb.setupGlyphOrder(['.notdef','space','drudwyn'])
fb.setupCharacterMap({32:'space',0xF0000:'drudwyn'})
empty=TTGlyphPen(None).glyph()
fb.setupGlyf({'.notdef':empty,'space':empty,'drudwyn':pen.glyph()})
fb.setupHorizontalMetrics({name:(600,0 if name!='drudwyn' else 30) for name in ['.notdef','space','drudwyn']})
fb.setupHorizontalHeader(ascent=850,descent=-150)
fb.setupNameTable({'familyName':'Drudwyn Symbols','styleName':'Regular','uniqueFontIdentifier':'DrudwynSymbols-Regular-1','fullName':'Drudwyn Symbols Regular','psName':'DrudwynSymbols-Regular','version':'Version 1.000'})
fb.setupOS2(sTypoAscender=850,sTypoDescender=-150,usWinAscent=850,usWinDescent=150)
fb.setupPost(isFixedPitch=1)
fb.font['head'].created=fb.font['head'].modified=3871497600
fb.font.recalcTimestamp=False
fb.save(ROOT/'assets/brand/DrudwynSymbols-Regular.ttf')
print('Generated Drudwyn Symbols: U+F0000')
