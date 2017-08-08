function cross_cohere_wave,wave1,wave2
  nscales=N_elements(wave1.scales)
  scales=wave1.scales
  cwt1=wave1.complex_cwt
  cwt2=wave2.complex_cwt

  gxx=cwt1*conj(cwt1)
  gyy=cwt2*conj(cwt2)
  
  xwt=cwt1*conj(cwt2)
  sm_xwt=xwt
  sm_gxx=cwt1
  sm_gyy=cwt2
  scale_decoherence=.6
  
  
  for i=0,nscales -1 do begin
;     if scales[i] gt 10 then stop
     scale_sm_inds= where(abs(scales -scales[i]) lt scale_decoherence*scales[i]/2.,n_inds)
     if n_inds gt 1 then begin
        scale_sm_xwt=total(xwt[*,scale_sm_inds],2)/n_inds
        scale_sm_gxx=total(gxx[*,scale_sm_inds],2)/n_inds
        scale_sm_gyy=total(gyy[*,scale_sm_inds],2)/n_inds
     endif


      if n_inds eq 1 then begin
        scale_sm_xwt=xwt[*,scale_sm_inds]
        scale_sm_gxx=gxx[*,scale_sm_inds]
        scale_sm_gyy=gyy[*,scale_sm_inds]
     endif
     
     
     t_sm_xwt=gauss_smooth(scale_sm_xwt,scales[i],kernel=kernel,/edge_truncate,width=99)
     t_sm_gxx=gauss_smooth(scale_sm_gxx,scales[i],kernel=kernel,/edge_truncate,width=99)
     t_sm_gyy=gauss_smooth(scale_sm_gyy,scales[i],kernel=kernel,/edge_truncate,width=99)
     
     sm_xwt[*,i]=t_sm_xwt
     sm_gxx[*,i]=t_sm_gxx
     sm_gyy[*,i]=t_sm_gyy
          

 
  endfor
  gxy=sm_xwt*conj(sm_xwt)
  coh=gxy/(sm_gxx*sm_gyy)

  pow=abs(xwt)
  phase=atan(sm_xwt,/phase)
  xwt_struct={xwt:xwt,pow:pow,phz:phase,coh:coh,freqs:wave1.freqs,t:wave1.t,coi_f:wave1.coi_f,coi_t:wave1.coi_t}
  
  return,xwt_struct
end
