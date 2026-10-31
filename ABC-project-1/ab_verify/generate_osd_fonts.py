from pathlib import Path
from PIL import Image, ImageFont, ImageDraw
import json

stage=Path(__file__).resolve().parent.parent
TITLE='基于安路 EG4S20 的HDMI 多媒体播放系统'
PERIOD=432
zhfont=ImageFont.truetype(r'C:\Windows\Fonts\msyhl.ttc',16)
dfont=ImageFont.truetype(r'C:\Windows\Fonts\consola.ttf',20)

def glyph(ch,font,w,h):
    im=Image.new('L',(w,h));box=font.getbbox(ch)
    ImageDraw.Draw(im).text(((w-(box[2]-box[0]))//2-box[0],(h-(box[3]-box[1]))//2-box[1]),ch,font=font,fill=255)
    return [[(im.getpixel((x,y))*15+127)//255 for x in range(w)] for y in range(h)]

im=Image.new('L',(PERIOD,24));draw=ImageDraw.Draw(im)
x=0
for ch in TITLE:
    draw.text((round(x),-1),ch,font=zhfont,fill=255)
    x+=zhfont.getlength(ch)+2
assert x<380,x
pixels=[[(im.getpixel((x,y))*15+127)//255 for x in range(PERIOD)] for y in range(24)]
tiles=[[[pixels[y][(i*24+c)%PERIOD] for c in range(25)] for y in range(24)] for i in range(PERIOD//24)]
digits=[glyph(c,dfont,12,20) for c in '0123456789:']

def module(name,chars,w,h,aw):
    rows=[sum(v<<(4*x) for x,v in enumerate(row)) for g in chars for row in g]
    assert len(rows)<=1<<aw
    rows += [0]*((1<<aw)-len(rows));bits=w*4
    s=f'module {name}(input clk,input [{aw-1}:0] address,output reg [{bits-1}:0] row);\n reg [{bits-1}:0] rom[0:{(1<<aw)-1}];\n initial begin\n'
    s+=''.join(f"  rom[{i}]= {bits}'h{v:0{w}x};\n" for i,v in enumerate(rows))
    return s+' end\n always @(posedge clk) row<=rom[address];\nendmodule\n'

s='`timescale 1ns/1ps\n// Antialiased title coverage ROM, 4 bits/pixel; 24-pixel tiles with one lookahead pixel.\n'
s+=module('ab_osd_font_zh',tiles,25,24,9)+module('ab_osd_font_digits',digits,12,20,8)
(stage/'RTL_1/a_core/ab_osd_font_rom.v').write_text(s,encoding='utf-8')
data=dict(name=TITLE,title=TITLE,period=PERIOD,tile_width=24,tile_lookahead=1,title_pixels=pixels,zh=tiles,digits=digits,
          zh_font='Microsoft YaHei Light 16',digit_font='Consolas 20',coverage_levels=16)
(stage/'ab_verify/osd_fonts.json').write_text(json.dumps(data,ensure_ascii=False),encoding='utf-8')
preview=stage/'ab_verify/preview';preview.mkdir(exist_ok=True)
im.save(preview/'title_coverage.png')
print(f'Embedded title: {TITLE}; advance {x:.1f}px, period {PERIOD}px, {len(tiles)} ROM tiles.')
