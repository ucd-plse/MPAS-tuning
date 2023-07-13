load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

begin

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


  r2d = 57.2957795             ; radians to degrees

  wks = gsn_open_wks("pdf","supercell")

  f = addfile("output.nc","r")

  alpha = f->angleEdge(:)
  xCell   = f->xCell(:)/1000.
  yCell   = f->yCell(:)/1000.


  res                      = True
  res@gsnMaximize          = True
  res@gsnSpreadColors      = True

  res@sfXArray             = xCell
  res@sfYArray             = yCell

  res@tiXAxisFontHeightF   = 0.018
  res@tiXAxisString        ="X (km)"
  res@tiYAxisFontHeightF   = 0.018
  res@tiYAxisString        ="Y (km)"
  res@tmXBPrecision        = 2
  res@tmYLPrecision        = 2

  do Time = 1, 4
;  Time = 1


  res@sfXArray             = xCell
  res@sfYArray             = yCell
  iTime = Time*1800

  print(" plotting time "+iTime)

  res@gsnRightString     = "MPAS"
  res@gsnRightStringFontHeightF = 0.014
  res@gsnContourNegLineDashPattern = 1

  res@cnLevelSelectionMode = "ManualLevels"
  res@cnMinLevelValF       =  -6.0
  res@cnMaxLevelValF       =   6.0
  res@cnLevelSpacingF      =   0.3 
  res@cnFillOn             = True
  res@cnLinesOn            = True
  res@cnLineLabelsOn       = False
  ;res@cnInfoLabelOn        = False
  res@lbLabelBarOn         = True

  ;res@lbLabelAutoStride    = True
  ;res@lbBoxLinesOn         = False

  gsn_define_colormap(wks,"testcmap")
  
  res@gsnSpreadColorStart        =   1
  res@gsnSpreadColorEnd          = 201

  k=0
  Level = k+1
  res@gsnLeftString     = "perturbation theta, Level "+ Level +" at " + iTime +"s" 
  res@gsnLeftStringFontHeightF = 0.014

  h = f->theta(Time,:,k)
  h0= f->theta_base(Time,:,k)
  qv= f->qv(Time,:,k)
  qv0= f->qv(0,:,k)

  fld = h/(1.+1.61*qv) - h0/(1.+1.61*qv0) 
  res@cnLineDashPattern = 0
  plot = gsn_csm_contour(wks,fld,res)
;=====================================
  k=4
  Level = k+1
  res@cnMinLevelValF       =  -2.4
  res@cnMaxLevelValF       =   2.4
  res@cnLevelSpacingF      =   0.2 
  res@gsnLeftString     = "perturbation theta, Level "+ Level +" at " + iTime +"s" 

  h = f->theta(Time,:,k)
  h0= f->theta_base(Time,:,k)
  qv= f->qv(Time,:,k)
  qv0= f->qv(0,:,k)

  fld = h/(1.+1.61*qv) - h0/(1.+1.61*qv0) 
  res@cnLineDashPattern = 0
  plot = gsn_csm_contour(wks,fld,res)
;=====================================
  k=9
  Level = k+1
  res@cnMinLevelValF       =  -8.0
  res@cnMaxLevelValF       =   8.0
  res@cnLevelSpacingF      =   0.4 
  res@gsnLeftString     = "perturbation theta, Level "+ Level +" at " + iTime +"s" 

  h = f->theta(Time,:,k)
  h0= f->theta_base(Time,:,k)
  qv= f->qv(Time,:,k)
  qv0= f->qv(0,:,k)


  fld = h/(1.+1.61*qv) - h0/(1.+1.61*qv0) 
  res@cnLineDashPattern = 0
  plot = gsn_csm_contour(wks,fld,res)
;=====================================
;=====================================
  k=4
  Level = k+1
  gsn_define_colormap(wks,"BlWhRe")

  res@cnMinLevelValF       =  -12.0
  res@cnMaxLevelValF       =   12.0
  res@cnLevelSpacingF      =   1.0 
  res@gsnSpreadColorStart  =   1
  res@gsnSpreadColorEnd    = 103

  res@gsnLeftString     = "w, Level "+ Level +" at " + iTime +"s" 


  fld = f->w(Time,:,k)
  res@cnLineDashPattern = 0
  plot = gsn_csm_contour(wks,fld,res)
;=====================================
  k=9
  Level = k+1
  res@cnMinLevelValF       =  -24.0
  res@cnMaxLevelValF       =   24.0
  res@cnLevelSpacingF      =   2.0 

  res@gsnLeftString     = "w, Level "+ Level +" at " + iTime +"s" 


  fld = f->w(Time,:,k)
  res@cnLineDashPattern = 0
  plot = gsn_csm_contour(wks,fld,res)
;=====================================
;=====================================
  k=0
  Level = k+1
  gsn_define_colormap(wks,"ViBlGrWhYeOrRe")

  res@cnMinLevelValF       =  0.5
  res@cnMaxLevelValF       =  5.0
  res@cnLevelSpacingF      =  0.5 
  res@gsnSpreadColorStart        =    51
  res@gsnSpreadColorEnd          =   103

  res@gsnLeftString     = "qr, Level "+ Level +" at " + iTime +"s" 

  fld = f->qr(Time,:,k)*1000.
  res@cnLineDashPattern = 0
  plot = gsn_csm_contour(wks,fld,res)
;=====================================
  k=4
  Level = k+1

  res@cnMinLevelValF       =  0.5
  res@cnMaxLevelValF       =  6.0
  res@cnLevelSpacingF      =  0.5 

  res@gsnLeftString     = "qr, Level "+ Level +" at " + iTime +"s" 

  fld = f->qr(Time,:,k)*1000.
  res@cnLineDashPattern = 0
  plot = gsn_csm_contour(wks,fld,res)
;=====================================
  k=9
  Level = k+1

  res@cnMinLevelValF       =  1.0
  res@cnMaxLevelValF       =  9.0
  res@cnLevelSpacingF      =  1.0 

  res@gsnLeftString     = "qr, Level "+ Level +" at " + iTime +"s" 

  fld = f->qr(Time,:,k)*1000.
  res@cnLineDashPattern = 0
  plot = gsn_csm_contour(wks,fld,res)
;=====================================
;=====================================
  plot_yz1 = new((/40,156/),double)
  z= new((/41/),double)
  z(0) = 0.
  do k=2,41
     z(k-1) = z(k-2) + 500.
  end do
  z1= new((/40/),double)
  do k=1,40
     z1(k-1) = (z(k-1)+z(k))*0.5
  end do
;  print (z1)

  y = new((/156/),double)

  nCells = dimsizes(xCell)
  cnt=0
  do iCell=0,nCells-1
     if (xCell(iCell).ge.50.0 .and. xCell(iCell).le.50.5) then
        h1d_t = f->theta(Time,iCell,:)
        h1d_t0 = f->theta_base(Time,iCell,:)
        h1d_qv = f->qv(Time,iCell,:)
        plot_yz1(:,cnt) = h1d_t/(1.+1.61*h1d_qv) - h1d_t0 
        y(cnt) = yCell(iCell)
        cnt = cnt+1
        x = xCell(iCell) 
     end if
  end do
  plot_yz1!0 = "Z1"
  plot_yz1&Z1 = z1/1000. 
  plot_yz1!1 = "Y"
  plot_yz1&Y = y 

  delete(res@sfXArray)
  delete(res@sfYArray)

  gsn_define_colormap(wks,"testcmap")
  res@tiYAxisString        ="Z (km)"
  res@tiXAxisString        ="Y (km)"
  res@cnMinLevelValF             =  -8.0
  res@cnMaxLevelValF             =   8.0
  res@cnLevelSpacingF            =   1.0
  res@gsnSpreadColorStart        =     1
  res@gsnSpreadColorEnd          =   201

  res@gsnLeftString     = "perturbation theta, x="+x +"km at " + iTime +"s" 

  plot = gsn_csm_contour(wks,plot_yz1,res)
;=====================================
  gsn_define_colormap(wks,"BlWhRe")
  res@cnMinLevelValF             = -36.0
  res@cnMaxLevelValF             =  36.0
  res@cnLevelSpacingF            =   2.0
  res@gsnSpreadColorStart        =     1
  res@gsnSpreadColorEnd          =   103

  plot_yz= new((/41,156/),double)
  cnt=0
  do iCell=0,nCells-1
     if (xCell(iCell).ge.50.5 .and. xCell(iCell).le.51.) then
        plot_yz(:,cnt) = f->w(Time,iCell,:)
        cnt = cnt+1
     end if
  end do
  plot_yz!0 = "Z"
  plot_yz&Z = z/1000. 
  plot_yz!1 = "Y"
  plot_yz&Y = y 

  res@gsnLeftString     = "w, x="+x +"km at " + iTime +"s"

  plot = gsn_csm_contour(wks,plot_yz,res)
;=====================================
  gsn_define_colormap(wks,"ViBlGrWhYeOrRe")
  res@cnMinLevelValF             =   1.0
  res@cnMaxLevelValF             =  15.0
  res@cnLevelSpacingF            =   1.0
  res@gsnSpreadColorStart        =    51
  res@gsnSpreadColorEnd          =   103

  cnt=0
  do iCell=0,nCells-1
     if (xCell(iCell).ge.50.5 .and. xCell(iCell).le.51.) then
        plot_yz1(:,cnt) = f->qr(Time,iCell,:)*1000.
        cnt = cnt+1
     end if
  end do
  res@gsnLeftString     = "qr, x="+x +"km at " + iTime +"s"

  plot = gsn_csm_contour(wks,plot_yz1,res)

  delete(plot_yz1)
  delete(z)
  delete(z1)
  delete(y)
  delete(plot_yz)

  end do

end

