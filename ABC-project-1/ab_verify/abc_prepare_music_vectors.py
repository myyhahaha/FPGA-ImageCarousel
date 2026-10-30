from pathlib import Path
import wave,json,struct
base=Path(__file__).resolve().parent;wav=(base.parent/'TF-card/MUSIC.WAV').read_bytes();pcm=wav[44:]
assert wav[:4]==b'RIFF' and wav[8:12]==b'WAVE' and wav[36:40]==b'data'
assert struct.unpack_from('<I',wav,24)[0]==48000 and struct.unpack_from('<H',wav,22)[0]==1
out=base/'results';out.mkdir(exist_ok=True)
with (out/'music_bytes.hex').open('w') as f:
 for i in range(0,len(wav),65536):f.write(''.join(f'{x:02x}\n' for x in wav[i:i+65536]))
with (out/'music_pcm.hex').open('w') as f:
 for i in range(0,len(pcm),65536):f.write(''.join(f'{x[0]:04x}\n' for x in struct.iter_unpack('<H',pcm[i:i+65536])))
(out/'music_first.hex').write_text(''.join(f'{x[0]:04x}\n' for x in struct.iter_unpack('<H',pcm[:65536*2])),encoding='ascii')
(out/'music_test_config.vh').write_text(f'localparam MUSIC_BYTES={len(wav)},MUSIC_SAMPLES={len(pcm)//2};\n')
print(f'Prepared exact soundtrack reference: {len(pcm)//2} PCM16 frames, {len(pcm)/96000:.6f} seconds.')
