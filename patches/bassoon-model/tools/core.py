import numpy as np, math
SR=44100.0
def hp_lead(w,a=0.001):
    b=1-a; return math.pi/2 - w/2 - math.atan2(b*math.sin(w),1-b*math.cos(w))
def lp_pd(w,bb): return math.atan(bb*math.sin(w)/(1-bb*math.cos(w)))/max(w,1e-4)
def analyze(x,target):
    x=x[-int(SR*.4):]; dc=x.mean(); x=x-dc; pk=np.abs(x).max()
    if pk<1e-4: return dict(dc=dc,pk=0,f0=0,cents=None,h=None)
    n=1<<19; X=np.abs(np.fft.rfft(x*np.hanning(len(x)),n=n)); df=SR/n
    def pkf(f):
        i=int(f/df); w=max(int(f*0.03/df),3); j=i-w+np.argmax(X[i-w:i+w]); 
        y0,y1,y2=X[j-1],X[j],X[j+1]; return (j+.5*(y0-y2)/(y0-2*y1+y2))*df, X[j]
    # candidates: target/2, target
    fh,ah=pkf(target/2); ft,at=pkf(target)
    sub = ah>0.1*X.max()
    f0=fh if sub else ft
    h=[pkf(f0*k)[1] for k in range(1,9)]
    return dict(dc=round(dc,3),pk=round(pk,3),f0=round(f0,2),cents=round(1200*math.log2(f0/target),1),h=[int(round(20*math.log10(v/max(h)+1e-9))) for v in h])

def sax(freq,breath,dur=1.0,pos=0.2,slope=0.3,offset=0.7,refl=0.95,bore_damp=.3,attack=15.,reed='stk',g=1.0,trim=0.0,noise=0.0,seed=1):
    rng=np.random.default_rng(seed)
    N=int(SR*dur); d0=np.zeros(8192); d1=np.zeros(8192); wi=0
    apx=apy=0.; dcs=0.; lp=0.; bs=0.
    bfc=1000+bore_damp*7000; ba=1-math.exp(-2*math.pi*bfc/SR); bb=1-ba
    atk=1-math.exp(-1/(SR*attack*.001))
    w=2*math.pi*freq/SR
    total=SR/freq - lp_pd(w,bb) + hp_lead(w)/w + trim
    n1=max(int(round(total*pos)),1); rest=total-n1
    ip=math.floor(rest-0.1); fr=rest-ip   # frac in [0.1,1.1)
    eta=(1-fr)/(1+fr)
    out=np.zeros(N)
    for n in range(N):
        bs+=atk*(breath-bs); b=bs*(1+noise*rng.uniform(-1,1))
        x=d0[(wi-ip)%8192]; y=eta*x+apx-eta*apy; apx=x; apy=y
        dcs+=.001*(y-dcs); hp=y-dcs
        lp+=ba*(hp-lp)
        temp=-refl*lp
        d1o=d1[(wi-n1)%8192]
        lf=temp-d1o
        pd=b-lf
        if reed=='stk':
            t=min(max(offset+slope*pd,-1),1); inj=b-pd*t-temp
        d1[wi]=temp; d0[wi]=min(max(inj,-2),2); wi=(wi+1)%8192
        out[n]=lf
    return out
if __name__=='__main__':
    print('STK saxofony topology, defaults')
    for f in [58.27,110,220,440,622]:
        for b in [.3,.5,.7,.9]:
            print(f,b,analyze(sax(f,b),f))
