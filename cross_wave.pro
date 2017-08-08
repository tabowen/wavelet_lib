function cross_wave,wave1,wave2

xwt=wave1.complex_cwt*conj(wave2.complex_cwt)


gxy=xwt*conj(xwt)


pow=abs(xwt)
phase=atan(imaginary(xwt),real_part(xwt),/phase)
xwt={xwt:xwt,pow:pow,phz:phase,freqs:wave1.freqs,t:wave1.t,coi_f:wave1.coi_f,coi_t:wave1.coi_t}

return,xwt
end
