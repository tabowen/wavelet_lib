function make_wavelet,t,arr,order,nscale,log_space,start_scale

t=t-t[0]
n_samples=n_elements(t)
IF N_ELEMENTS(start_scale) eq 0 then start_scale=2

bandwidth=1.0/t[1]/n_samples

wave=wv_cwt(arr,'Morlet',order,scale=scales,nscale=nscale,dscale=log_space,start_scale=start_scale)

wavepow=abs(wave*wave)
phase=atan(wave,/phase)                                
freq=order/(2*!dpi*t[1]*scales) 
power=total(wavepow,1)
norm=1.0/(float(n_samples)*n_samples*bandwidth)

coi_t=sqrt(2)*scales*t[1]
half_t=reform(t,n_elements(t)/2.0,2.0)

coi_s=(half_t[*,0]/sqrt(2))/t[1]

coi_f=order/(2*!dpi*t[1]*coi_s)

coi_f=[coi_f,reverse(coi_f)]

wavelet={CWT:wavepow, complex_cwt:wave, Wave_PSD:power,phase:phase,freqs:freq,norm:norm,scales:scales,coi_t:coi_t,coi_f:coi_f,order:order,log_space:log_space,start_scale:start_scale,t:t}
return, wavelet

end
