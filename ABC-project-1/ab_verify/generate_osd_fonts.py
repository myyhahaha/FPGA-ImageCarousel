from pathlib import Path
from PIL import Image,ImageFont,ImageDraw
import json
stage=Path(__file__).resolve().parent.parent
zhfont=ImageFont.truetype(r'C:\Windows\Fonts\msyhl.ttc',16)
dfont=ImageFont.truetype(r'C:\Windows\Fonts\consola.ttf',20)
def glyph(ch,font,w,h):
 im=Image.new('L',(w,h));box=font.getbbox(ch)
 ImageDraw.Draw(im).text(((w-(box[2]-box[0]))//2-box[0],(h-(box[3]-box[1]))//2-box[1]),ch,font=font,fill=255)
 return [[(im.getpixel((x,y))*15+127)//255 for x in range(w)] for y in range(h)]
zh=[glyph(c,zhfont,24,24) for c in '富婆孤傲炸鱼组']
digits=[glyph(c,dfont,12,20) for c in '0123456789:']
def module(name,chars,w,h):
 rows=[]
 for g in chars:
  for row in g:rows.append(sum(v<<(4*x) for x,v in enumerate(row)))
 rows+= [0]*(256-len(rows));bits=w*4
 s=f'module {name}(input clk,input [7:0] address,output reg [{bits-1}:0] row);\n reg [{bits-1}:0] rom[0:255];\n initial begin\n'
 s+=''.join(f"  rom[{i}]= {bits}'h{v:0{w}x};\n" for i,v in enumerate(rows))
 return s+' end\n always @(posedge clk) row<=rom[address];\nendmodule\n'
s='`timescale 1ns/1ps\n// Fixed antialiased coverage ROM, 4 bits/pixel. No external initialization path.\n'
s+=module('ab_osd_font_zh',zh,24,24)+module('ab_osd_font_digits',digits,12,20)
(stage/'RTL_1/a_core/ab_osd_font_rom.v').write_text(s)
data={'name':'富婆孤傲炸鱼组','zh':zh,'digits':digits,'zh_font':'Microsoft YaHei Light 16','digit_font':'Consolas 20','coverage_levels':16}
(stage/'ab_verify/osd_fonts.json').write_text(json.dumps(data,ensure_ascii=False),encoding='utf-8')
im=Image.new('RGB',(224,48),'#111314');d=ImageDraw.Draw(im)
for i,g in enumerate(zh):
 for y,row in enumerate(g):
  for x,v in enumerate(row):im.putpixel((8+i*30+x,12+y),tuple((bg*(15-v)+fg*v+7)//15 for bg,fg in zip((17,19,20),(216,222,219))))
preview=stage/'ab_verify/preview';preview.mkdir(exist_ok=True)
im.resize((896,192)).save(preview/'name_glyphs.png')
print('Seven Chinese glyphs and eleven numeric glyphs embedded in synchronous coverage ROMs.')
