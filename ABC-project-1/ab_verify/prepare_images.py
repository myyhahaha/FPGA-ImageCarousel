"""Create simulator memories from the untouched user BMPs using stdlib only."""
from pathlib import Path
import struct,json,hashlib
base=Path(__file__).resolve().parent
out=base/'results';out.mkdir(exist_ok=True)
meta=[]
with (out/'bmp_bytes.hex').open('w') as raw,(out/'bmp_pixels.hex').open('w') as pixels:
    for i in range(1,9):
        p=base/'images'/f'IMAGE{i}.BMP';b=p.read_bytes()
        off=struct.unpack_from('<I',b,10)[0]
        width,height=struct.unpack_from('<ii',b,18)
        bpp=struct.unpack_from('<H',b,28)[0]
        compression=struct.unpack_from('<I',b,30)[0]
        assert b[:2]==b'BM' and (len(b),off,width,height,bpp,compression)==(921654,54,640,480,24,0)
        raw.write(''.join(f'{v:02x}\n' for v in b))
        # Golden bitmap is indexed in the BMP's bottom-up row order.
        vals=[]
        for n in range(307200):
            bl,g,r=b[off+n*3:off+n*3+3]
            vals.append(f'{r>>4:x}{g>>4:x}{bl>>4:x}\n')
        pixels.write(''.join(vals))
        meta.append({'file':p.name,'sha256':hashlib.sha256(b).hexdigest(),'pixels':307200})
(out/'input_images_sha256.json').write_text(json.dumps(meta,indent=2),encoding='utf-8')
print('PASS image assets: eight original 640x480 BMP24 files, exact byte and RGB444 memories')
