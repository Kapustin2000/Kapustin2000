#!/usr/bin/env python3
"""Derive yaml/{de,bg,ua,eu} from the eu sources (yaml/eu is the source of truth).
Markets differ only in header location and the closing summary sentence.
Usage: python3 sync_markets.py   then   python3 build.py [role ...]"""
import yaml, glob, os, re
D = os.path.dirname(os.path.abspath(__file__))
SCHEMA = '# yaml-language-server: $schema=https://raw.githubusercontent.com/rendercv/rendercv/refs/tags/v2.8/schema.json\n'
MARKETS = {
 'eu': ('EU citizen, no visa needed · Remote EU · Available now',
        'Seeking a full-time role; open to remote EU.'),
 'de': ('Berlin, Germany · EU citizen, no visa needed · Available now',
        'Based in Berlin, seeking a full-time role; open to Berlin hybrid/on-site and remote EU.'),
 'ua': ('Berlin, Germany · EU citizen, no visa needed · Available now',
        'Based in Berlin, seeking a full-time role; open to Berlin hybrid/on-site and remote EU.'),
 'bg': ('Sofia, Bulgaria · EU citizen · Available now',
        'Based in Sofia, seeking a full-time role; open to Sofia hybrid/on-site and remote EU.'),
}
SECTIONS = ['summary', 'experience', 'skills', 'Publications & Conferences', 'education', 'languages']  # education+languages render side by side (templates/sb2nov); languages must stay last
ORDER = ['WireBee', 'Osnova', 'Woolf', 'Earlier']
for f in sorted(glob.glob(os.path.join(D, 'yaml', 'eu', 'mykhailo-kapustin-cv-2026-*.yaml'))):
    base = yaml.safe_load(open(f))
    ex = base['cv']['sections']['experience']
    ex.sort(key=lambda e: next(i for i, n in enumerate(ORDER) if e['company'].startswith(n)))
    secs = base['cv']['sections']
    base['cv']['sections'] = {k: secs[k] for k in SECTIONS if k in secs}
    for mkt, (loc, tail) in MARKETS.items():
        c = yaml.safe_load(yaml.safe_dump(base, sort_keys=False))
        c['cv']['location'] = loc
        s = c['cv']['sections']['summary']
        s[0] = re.sub(r'\s*(\{\{MARKET\}\}|Based in .*|Seeking a full-time.*)$', '', s[0]) + ' ' + tail
        slug = re.search(r'2026-(.+)\.yaml', f).group(1)
        c['settings']['render_command']['output_folder'] = f'../../rendercv_output/{mkt}/{slug}'
        out = os.path.join(D, 'yaml', mkt); os.makedirs(out, exist_ok=True)
        open(os.path.join(out, os.path.basename(f)), 'w').write(SCHEMA + yaml.safe_dump(c, sort_keys=False, allow_unicode=True, width=10000))
        print('wrote', mkt, slug)
