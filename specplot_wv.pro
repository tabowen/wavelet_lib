pro specplot_wv,wv,limits=limits,xwt=xwt,coi=coi,phz=phz,coh=coh


  main_limits={zlog:1,position:[.15,.15,.85,.85]}
  def_position={position:[.15,.15,.85,.85]}
  def_zlog={zlog:1}

  if keyword_set(xwt) then begin
     plot_buff=abs(wv.xwt)
     print,'xwt'
  endif

  
  if keyword_set(xwt) eq 0 and keyword_set(phz) eq 0 and keyword_set(cohere) eq 0 then plot_buff=wv.cwt
  t=wv.t
  freqs=wv.freqs
  
  if keyword_set(phz) eq 1 then begin
     plot_buff=wv.phz
     print,'phz'
     main_limits.zlog=0
  endif


    if keyword_set(coh) eq 1 then begin
     plot_buff=wv.coh
     print,'coh'
     main_limits.zlog=0
  endif

  t=wv.t
  freqs=wv.freqs

  if keyword_set(limits) then begin
     mod_limits=limits
     if where (tag_names(mod_limits) eq 'POSITION') eq -1 then mod_limits=create_struct(mod_limits, def_position)
     if where (tag_names(mod_limits) eq 'ZLOG') eq -1 then mod_limits=create_struct(mod_limits, def_zlog)

  endif
  if keyword_set(limits) eq 0 then mod_limits=main_limits

  if keyword_set(abs) then plot_buff=abs(plot_buff)

  
  
specplot,t,freqs,plot_buff,limits=mod_limits
if keyword_set(coi) then oplot,wv.t,wv.coi_f
end
