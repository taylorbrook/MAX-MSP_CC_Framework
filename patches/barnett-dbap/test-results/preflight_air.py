import numpy as np
SR=48000
def run(x, fc_msgs, sr=SR):
    """fc_msgs: per-sample target fc (0 = skip). Mirrors the codebox difference equations."""
    fceil=min(20000,0.45*sr); fcoef=1-np.exp(-1/(0.010*sr))
    lp=0.0; fprev=0.0; aprev=0; y=np.empty_like(x)
    for n in range(len(x)):
        k=fc_msgs[n]; act=1 if k>0 else 0
        fcs=fprev+(k-fprev)*fcoef; s=lp
        if act and not aprev: fcs=k; s=x[n]
        g=np.tan(np.pi*min(max(fcs,20),fceil)/sr); G=g/(1+g)
        v=G*(x[n]-s); low=v+s; lp=low+v
        if np.isnan(lp): lp=0.0   # gen~ fixnan: NaN -> 0 (inf survives one more sample, then NaN -> 0)
        fprev=fcs; aprev=act
        y[n]=low if act else x[n]
    return y
rng=np.random.default_rng(1)
# 1. -3 dB at fc for several cutoffs and rates
for sr in (44100,48000,96000):
    for fc in (500,2000,6700,15000):
        n=sr; t=np.arange(n)/sr; x=np.sin(2*np.pi*fc*t)
        y=run(x,np.full(n,float(fc)),sr)
        db=20*np.log10(np.sqrt(np.mean(y[n//2:]**2))/np.sqrt(np.mean(x[n//2:]**2)))
        assert abs(db+3.0103)<0.02,(sr,fc,db)
print('1 ok: -3.01 dB at fc (TPT prewarp exact) at 44.1/48/96k')
# 2. skip is bit-exact
x=rng.standard_normal(20000); y=run(x,np.zeros(20000)); assert np.array_equal(x,y); print('2 ok: fc 0 bit-exact')
# 3. engage edge: y[n]=x[n] exactly on the edge sample, and max slew vs signal slew
t=np.arange(9600)/SR; x=np.sin(2*np.pi*1000*t); fc=np.zeros(9600); fc[4801:]=800.0
y=run(x,fc); assert y[4801]==x[4801]
slew=np.max(np.abs(np.diff(y)))/np.max(np.abs(np.diff(x))); print('3 ok: edge sample exact; max slew ratio %.3f (<=1 = no click)'%slew); assert slew<=1.0001
# 4. cutoff step 20k -> 500 Hz while running (mouse-rate js update): no slew beyond the signal's own
fc=np.full(9600,20000.0); fc[4800:]=500.0; y=run(x,fc)
slew=np.max(np.abs(np.diff(y)))/np.max(np.abs(np.diff(x))); print('4 ok: fc step 20k->500 slew ratio %.3f (a click would be >> 1)'%slew); assert slew<=1.25
# 5. 22.05 kHz host rate: ceiling 9922 Hz, tan finite, stable
x=rng.standard_normal(22050); y=run(x,np.full(22050,20000.0),22050); assert np.all(np.isfinite(y)) and np.max(np.abs(y))<=np.max(np.abs(x))*1.0001; print('5 ok: 22.05 kHz stable')
# 6. inf input recovers (fixnan on the state)
x=rng.standard_normal(2000); x[500]=np.inf; y=run(x,np.full(2000,3000.0)); assert np.all(np.isfinite(y[520:])); print('6 ok: state recovers after a non-finite sample')
