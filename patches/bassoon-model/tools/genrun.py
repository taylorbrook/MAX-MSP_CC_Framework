"""Minimal GenExpr -> Python runner for the bassoon codebox (sequential History semantics)."""
import re, math, random, numpy as np
from core import analyze, SR
def transpile(code):
    params={}; hist={}; body=[]
    for raw in code.splitlines():
        l=raw.split('//')[0].rstrip()
        if not l.strip(): continue
        m=re.match(r'\s*Param (\w+)\(([-\d.]+)',l)
        if m: params[m[1]]=float(m[2]); continue
        m=re.match(r'\s*History (\w+)\(([-\d.]+)\)',l)
        if m: hist[m[1]]=float(m[2]); continue
        if l.strip().startswith('Data'): continue
        body.append(l)
    src=' '.join(body) if False else '\n'.join(body)
    # join continuation lines (statements end with ; or { or })
    stmts=[]; cur=''
    for l in body:
        cur=(cur+' '+l.strip()) if cur else l
        if cur.rstrip().endswith((';','{','}')): stmts.append(cur); cur=''
    out=[]; ind=1
    def ex(e):
        e=e.replace('&&',' and ').replace('||',' or ')
        m=re.match(r'^(.*?)\s\?\s(.*)\s:\s(.*)$',e)
        if m: return f'(({m[2]}) if ({m[1]}) else ({m[3]}))'
        return e
    for s in stmts:
        s=s.strip()
        m=re.match(r'^if \((.*)\) \{ (.*) \}$',s)
        if m:
            out.append('    '*ind+f'if {ex(m[1])}:'); 
            for a in m[2].split(';'):
                if a.strip(): out.append('    '*(ind+1)+a.strip())
            continue
        m=re.match(r'^if \((.*)\) \{$',s)
        if m: out.append('    '*ind+f'if {ex(m[1])}:'); ind+=1; continue
        if s=='}': ind-=1; continue
        s=s.rstrip(';'); lhs,rhs=s.split(' = ',1) if ' = ' in s else (None,s)
        if lhs is None:
            out.append('    '*ind+ex(rhs)); continue
        out.append('    '*ind+f'{lhs.strip()} = {ex(rhs.strip())}')
    return params,hist,out
def make(code):
    params,hist,lines=transpile(code)
    names=list(hist)
    fn=['def tick(S,P,in1,in2,bore,rng):']
    fn+=[f'    {n}=S["{n}"]' for n in names]+[f'    {n}=P["{n}"]' for n in params]
    fn+=['    samplerate=%r'%SR]+lines+[f'    S["{n}"]={n}' for n in names]+['    return out1, cone_hp']
    env=dict(math.__dict__); env.update(TWOPI=2*math.pi,HALFPI=math.pi/2,
        clamp=lambda x,a,b:min(max(x,a),b), noise=lambda:random.uniform(-1,1),
        peek=lambda d,i,c:d[int(i)], poke=None)
    def poke(d,v,i,c): d[int(i)]=v
    env['poke']=poke
    exec('\n'.join(fn),env)
    return env['tick'],params,hist
def render(code,freq,breath_fn,dur=1.0,seed=1,**over):
    random.seed(seed); tick,params,hist=make(code); P=dict(params); P.update(over); S=dict(hist); bore=np.zeros(8192)
    N=int(SR*dur); o=np.zeros(N); lp=np.zeros(N)
    for n in range(N):
        t=n/SR; f=freq(t) if callable(freq) else freq
        o[n],lp[n]=tick(S,P,f,breath_fn(t),bore,None)
    return o,lp
if __name__=='__main__':
    code=open('new_code.genexpr').read()
    print('== defaults: pitch/level/DC vs freq & breath (vib off)')
    for f in [58.27,110,220,440,622]:
        row=[]
        for b in [.2,.3,.4,.5,.7,.9,1.0]:
            o,lp=render(code,f,lambda t:b,dur=.9)
            a=analyze(o,f); row.append('%.3f/%s/dc%.3f'%(a['pk'],'-' if a['cents'] is None else '%+d'%a['cents'],a['dc']))
        print(f,' '.join(row))
