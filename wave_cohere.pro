function wave_cohere,wave1,wave2,ensemble

ensem_avg=ensemble

xwt=wave1.complex_cwt*conj(wave2.complex_cwt)
phase=atan(imaginary(xwt),real_part(xwt),/phase)



xwt_ensem=smooth(xwt,[ensem_avg,1])

gxy=xwt_ensem*conj(xwt_ensem)

normxx=wave1.complex_cwt*conj(wave1.complex_cwt)
normyy=wave2.complex_cwt*conj(wave2.complex_cwt)

normxx=double(normxx)
normyy=double(normyy)

normxx_ensem=smooth(normxx,[ensem_avg,1])
normyy_ensem=smooth(normyy,[ensem_avg,1])
norm=normxx_ensem*normyy_ensem

xwt_cohere=double(gxy/norm)


;xwt_cohere=double(gxy_ensem/norm)

;stop
cohere={xwt:xwt,phz:phase,cohere:xwt_cohere,freqs:wave1.freqs,t:wave1.t,n_ensemble:ensemble,coi_f:wave1.coi_f}
return,cohere
end
