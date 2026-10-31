"""Independent pixel reference and preview, using the rasterized glyph assets."""
from pathlib import Path
import json
from PIL import Image
base=Path(__file__).resolve().parent
fonts=json.loads((base/'osd_fonts.json').read_text(encoding='utf-8'))
caps={
'T':['11111','00100','00100','00100','00100','00100','00100'],
'E':['11111','10000','10000','11110','10000','10000','11111'],
'A':['01110','10001','10001','11111','10001','10001','10001'],
'M':['10001','11011','10101','10101','10001','10001','10001'],
'R':['11110','10001','10001','11110','10100','10010','10001'],
'U':['10001','10001','10001','10001','10001','10001','01110'],
'N':['10001','11001','11001','10101','10011','10011','10001'],
'I':['11111','00100','00100','00100','00100','00100','11111'],
'L':['10000','10000','10000','10000','10000','10000','11111']}
def rgb(v):return ((v>>16)&255,(v>>8)&255,v&255)
def packed(c):return c[0]<<16|c[1]<<8|c[2]
def mix(bg,fg,a):return tuple((b*(16-a)+f*a+8)//16 for b,f in zip(bg,fg))
def cov(v):return 16 if v==15 else v
def name_cov(pos,y):
    pos%=432
    if 390<=pos<=394 and 573<=y<=577 and not(pos in (390,394) and y in (573,577)):return 16,True
    return cov(fonts['title_pixels'][y-563][pos]),False
wave_levels=[int(s,16) for s in (base/'results/osd_wave_levels.hex').read_text().split()]

def render(x,y,bg,scroll,bcd,de=True):
    if not de:return (0,0,0)
    panel=x<80 or x>=720 or y<60 or y>=540
    matte=0x16191b
    if y<44:matte=0x1d2023
    elif y<48:matte=0x1b1e21
    elif y<52:matte=0x191c1f
    elif y<56:matte=0x171a1d
    if y>=544:matte=0x171a1d
    if y>=548:matte=0x191c1f
    if y>=552:matte=0x1b1e21
    if y>=556:matte=0x1d2023
    result=mix(bg,rgb(matte),12 if panel else 0)
    decor=(0,0,0);da=0
    if y==52 and 100<=x<680:decor=rgb(0x718080);da=2
    if x==520 and 17<=y<45:decor=rgb(0x8d9394);da=3
    if 702<=x<=706 and 32<=y<=36 and not(x in (702,706) and y in (32,36)):
        decor=rgb(0x9bafa5);da=8 if bcd&1 else 12
    if y==574 and 80<=x<720:decor=rgb(0x657275);da=3
    result=mix(result,decor,da)
    screen_y=y
    y=y+540 if y<60 else -1
    ink=rgb(0xd8dedb);a=0
    if 551<=y<558:
        ink=rgb(0x8f999e)
        for left,text in [(100,'TITLE'),(552,'RUN TIME')]:
            slot,col=divmod(x-left,6)
            if 0<=slot<len(text) and col<5 and text[slot]!=' ' and caps[text[slot]][y-551][col]=='1':a=10
    if 100<=x<496 and 563<=y<587:
        pos=x-100+scroll//4
        av,ad=name_cov(pos,y);bv,bd=name_cov(pos+1,y)
        ink=rgb(0xa8b6af) if ad or bd else rgb(0xd8dedb)
        a=(av*(4-scroll%4)+bv*(scroll%4)+2)//4
        a=(a*min(16,x-100,495-x)+8)//16
    if 565<=y<585:
        slot,col=divmod(x-552,14)
        if 0<=slot<9 and col<12:
            chars=f'{bcd:07x}'
            text=chars[:3]+':'+chars[3:5]+':'+chars[5:]
            ch=text[slot];glyph=10 if ch==':' else int(ch)
            a=cov(fonts['digits'][glyph][y-565][col]);ink=rgb(0xbac3c4)
    if 80<=x<720 and 552<=screen_y<592:
        level=wave_levels[x-80];hi=level>>5;lo=level&31;dy=screen_y-574
        ink=rgb(0x91b4ad);a=0
        if level and -hi<=dy<=lo:a=14 if dy in (-hi,lo) else 5
    return mix(result,ink,a)
def make_vectors():
    out=base/'results';out.mkdir(exist_ok=True)
    for name,key in [('osd_zh_pixels.hex','zh'),('osd_digit_pixels.hex','digits')]:
        (out/name).write_text(''.join(f'{v:x}\n' for glyph in fonts[key] for row in glyph for v in row))
    # All four fractional positions, period wrap, carries, and high hour digits.
    cases=[(0,0),(1,0x0000009),(2,0x0000059),(3,0x0005959),(111,0x0010000),(1726,0x1000000),(1727,0x9995959),(0,0x0071234)]
    count=0
    with (out/'osd_vectors.hex').open('w') as f:
        for scroll,bcd in cases:
            points=((x,y) for y in list(range(60))+list(range(540,600)) for x in range(800))
            for x,y in points:
                c=((x*13+y)&255,(y*19+x*3)&255,(x+y*7)&255)
                exp=render(x,y,c,scroll,bcd)
                value=(1<<109)|(scroll<<98)|(bcd<<70)|(x<<59)|(y<<48)|(packed(c)<<24)|packed(exp)
                f.write(f'{value:028x}\n');count+=1
        for y in range(600):
            for x in range(800):
                c=(x%256,y%256,(x+y)%256)
                exp=render(x,y,c,37,0x0010203)
                value=(1<<109)|(37<<98)|(0x0010203<<70)|(x<<59)|(y<<48)|(packed(c)<<24)|packed(exp)
                f.write(f'{value:028x}\n');count+=1
        for y in [0,60,270,539,600,627]:
            for x in range(1056):
                c=(x%256,y%256,(x+y)%256);de=x<800 and y<600
                exp=render(x,y,c,37,0x0010203,de)
                value=(1<<109)|(37<<98)|(0x0010203<<70)|(x<<59)|(y<<48)|(packed(c)<<24)|packed(exp)
                f.write(f'{value:028x}\n');count+=1
        for n in range(10000):
            x=n%800;y=[0,59,60,270,539,540,551,565,574,584,599,601,627][(n//800)%13]
            c=((n*7)&255,(n*11)&255,(n*19)&255)
            value=(80<<98)|(0x0071234<<70)|(x<<59)|(y<<48)|(packed(c)<<24)
            f.write(f'{value:028x}\n');count+=1
    (out/'osd_vector_count.txt').write_text(str(count))
    im=Image.new('RGB',(800,600))
    source=Image.open(base/'images/IMAGE7.BMP').convert('RGB')
    source=source.point(lambda v:v//16*16)
    im.paste(source,(80,60))
    for y in range(600):
        for x in range(800):im.putpixel((x,y),render(x,y,im.getpixel((x,y)),80,0x0071234))
    im.save(base/'preview/osd_preview.png')
    print('Prepared',count,'independent alpha/ROM/scroll/timer pixel vectors.')
if __name__=='__main__':make_vectors()
