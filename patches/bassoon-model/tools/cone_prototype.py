import numpy as np, math
from core import lp_pd, SR
def analyze(x,target):
    x=x[-int(SR*.4):]; x=x-x.mean(); pk=np.abs(x).max()
    if pk<1e-3: return dict(pk=0,f0=0,cents=None,h=None)
    n=1<<19; X=np.abs(np.fft.rfft(x*np.hanning(len(x)),n=n)); df=SR/n
    # f0 via autocorrelation near target, target/2, target*2 -> pick strongest periodicity
    ac=np.fft.irfft(np.abs(np.fft.rfft(x,n=1<<17))**2)
    best=None
    for mult in [3,2,1,0.5]:
        lag=SR/(target*mult); lo=int(lag*0.94); hi=int(lag*1.06)+2
        k=lo+np.argmax(ac[lo:hi]); v=ac[k]/ac[0]
        if best is None or v>best[0]+0.02: best=(v,k,mult)
    v,k,mult=best; y0,y1,y2=ac[k-1],ac[k],ac[k+1]; kk=k+.5*(y0-y2)/(y0-2*y1+y2); f0=SR/kk
    def amp(f):
        i=int(round(f/df)); w=max(int(f*.02/df),3); return X[i-w:i+w].max()
    h=[amp(f0*m) for m in range(1,9)]
    return dict(pk=round(pk,3),f0=round(f0,2),cents=round(1200*math.log2(f0/target),1),h=[int(round(20*math.log10(v/max(h)+1e-9))) for v in h])
def run(freq,b_target,cone=0.,dur=1.0,reed_stiff=.5,bore_damp=.3,attack=15.,integ='trap',pfeed='pm',trim=0.0):
    N=int(SR*dur); bore=np.zeros(8192); wi=0
    apx=apy=0.; cone_dc=0.; bore_lp=0.; bs=0.; w=0.; pprev=0.
    bfc=1000+bore_damp*7000; ba=1-math.exp(-2*math.pi*bfc/SR); bb=1-ba
    atk=1-math.exp(-1/(SR*attack*.001)); om=2*math.pi*freq/SR; P=SR/freq
    ang=(1-cone)*math.pi/2
    adj=min(max(P*0.5*(1+cone)-lp_pd(om,bb)+trim,4),8190)
    ik=0. if cone<=0 else 2*math.pi/(P*math.tan(ang))
    ip=math.floor(adj-0.1); fr=adj-ip; eta=(1-fr)/(1+fr); g=.75-reed_stiff*.45; pM=.65+.35*reed_stiff
    out=np.zeros(N)
    for n in range(N):
        bs+=atk*(b_target-bs)
        x=bore[(wi-ip)%8192]; br=eta*x+apx-eta*apy; apx=x; apy=br
        cone_dc+=.0002*(br-cone_dc); hp=br-cone_dc; bore_lp+=ba*(hp-bore_lp)
        cr=min(max(-bore_lp*.85,-1.5),1.5)
        dp=min(max(bs*.9-cr,0),1); xn=min(dp/pM,1.0)
        flow=1.75*pM*math.sqrt(xn)*(1-xn)*min(max(bs*8,0),1)
        pin=flow*g+cr-w
        p=pin+cr
        w=(w+ik*(0.5*(p+pprev) if integ=='trap' else p))*0.9999; pprev=p
        bore[wi]=min(max(pin,-2),2); wi=(wi+1)%8192; out[n]=hp
    return out
if __name__=='__main__':
    for cone in [0.,.3,.6,.8,.9]:
        print('== cone',cone)
        for f in [58.27,110,220,440,622]:
            print('  ',f,' | '.join('b%.1f pk%.2f %sc %s'%(b,a['pk'],a['cents'],a['h'][:6] if a['h'] else None) for b in [.5,.8] for a in [analyze(run(f,b,cone=cone),f)]))
