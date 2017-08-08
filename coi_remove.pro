function coi_remove,t,wavelet,coi,val;,struct=struct,phz=phz,pwr=pwr

if keyword_set(struct) then begin
t=struct.t
coi=struct.coi
endif

maxt=max(t)
buff=wavelet
n_scales=n_elements(buff[0,*])
for i=0,n_scales -1 do begin
coi_val=coi[i]
buff[where(t le coi_val),i]=val

buff[where(t ge (maxt -coi_val)),i]=val

endfor

return, buff 
end
