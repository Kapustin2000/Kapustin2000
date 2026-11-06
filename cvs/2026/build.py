#!/usr/bin/env python3
"""Render all CV variants: yaml/{eu,ua}/*.yaml (senior sources) x levels -> PDFs in <role>/<EU|UA>/<senior|mid|junior>/.
Usage: python3 build.py [role ...]   (run from anywhere)"""
import yaml, glob, re, os, subprocess, sys, shutil, copy
D = os.path.dirname(os.path.abspath(__file__))
FOLDER = {'fullstack': 'full-stack', 'fullstack-ai': 'full-stack-ai'}
YEARS = re.compile(r'\b(with )?10\+ years of software engineering experience\b[,.]?\s*')

def level(c, lvl):
    """Derive mid/junior from a senior source. Hides entries; never edits facts of kept entries."""
    cv = c['cv']; sec = cv['sections']; ex = sec['experience']
    keep = [e for e in ex if not e['company'].startswith('Earlier') and not e['company'].startswith('LAB325')]
    if lvl == 'junior':
        keep = [e for e in keep if not e['company'].startswith('Advanced')]
    sec['experience'] = keep
    h = cv['headline'].replace('Senior ', '').replace(' (Backend-focused)', '')
    if lvl == 'junior' and not h.startswith('Junior'): h = 'Junior ' + h
    cv['headline'] = h
    s = sec['summary'][0]
    s = re.sub(r'^(Senior )?([A-Za-z\- &]+?)( Engineer)? with 10\+ years of software engineering experience(, backend-first)?\.', lambda m: (('Junior ' if lvl=='junior' else '') + m.group(2).replace('Senior ','').strip() + ' Engineer' + (', backend-first' if m.group(4) else '') + '.'), s)
    s = re.sub(r'^(AI Engineer|Voice AI Engineer) with 10\+ years of software engineering experience,', lambda m: ('Junior ' if lvl=='junior' else '') + m.group(1) + ',', s)
    sec['summary'] = [s]
    if lvl == 'junior':
        sec.pop('publications', None) if False else None
    return c

def render(c, mkt, slug, suffix):
    out = os.path.join(D, 'rendercv_output', mkt, slug + suffix)
    c = copy.deepcopy(c)
    c['settings']['render_command']['output_folder'] = out
    gen = os.path.join(D, 'yaml', '_gen'); os.makedirs(gen, exist_ok=True)
    p = os.path.join(gen, f'{mkt}-{slug}{suffix}.yaml')
    open(p, 'w').write(yaml.safe_dump(c, sort_keys=False, allow_unicode=True, width=10000))
    r = subprocess.run(['uvx', '--from', 'rendercv[full]', 'rendercv', 'render', p], capture_output=True, text=True)
    pdf = os.path.join(out, 'Mykhailo_Kapustin_CV.pdf')
    if not os.path.exists(pdf): print('FAIL', p, r.stdout[-300:], r.stderr[-300:]); return
    d = os.path.join(D, FOLDER.get(slug, slug), mkt.upper(), suffix[1:] if suffix else 'senior'); os.makedirs(d, exist_ok=True)
    name = f"Mykhailo Kapustin - {FOLDER.get(slug, slug)} - {mkt.upper()} - {suffix[1:] if suffix else 'senior'}.pdf"
    shutil.copy(pdf, os.path.join(d, name)); print('ok', name)

want = set(sys.argv[1:])
for f in sorted(glob.glob(os.path.join(D, 'yaml', '*', 'mykhailo-kapustin-cv-2026-*.yaml'))):
    mkt = f.split(os.sep)[-2]
    if mkt.startswith('_'): continue
    slug = re.search(r'2026-(.+)\.yaml', f).group(1)
    if want and slug not in want: continue
    base = yaml.safe_load(open(f))
    render(base, mkt, slug, '')
    for lvl in (() if slug == 'fde' else ('mid', 'junior')):  # fde: senior only
        render(level(copy.deepcopy(base), lvl), mkt, slug, '-' + lvl)
shutil.rmtree(os.path.join(D, 'yaml', '_gen'), ignore_errors=True)
