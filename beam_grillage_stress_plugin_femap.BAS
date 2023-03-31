Sub Main
    Dim App As femap.model
    Set App = feFemap()

    Dim ouSetID As Long

    Dim sfOuVecAP1 As femap.Output
    Set sfOuVecAP1 = App.feOutput

    Dim sfOuVecAP2 As femap.Output
    Set sfOuVecAP2 = App.feOutput

	Dim sfOuVecBP1 As femap.Output
    Set sfOuVecBP1 = App.feOutput

    Dim sfOuVecBP2 As femap.Output
    Set sfOuVecBP2 = App.feOutput

    Dim bmOuVecP1 As femap.Output
    Set bmOuVecAP1 = App.feOutput

    Dim bmOuVecAP2 As femap.Output
    Set bmOuVecAP2 = App.feOutput

	Dim bmOuVecBP1 As femap.Output
    Set bmOuVecBP1 = App.feOutput

    Dim bmOuVecBP2 As femap.Output
    Set bmOuVecBP2 = App.feOutput

    Dim ssOuVecAP1 As femap.Output
    Set ssOuVecAP1= App.feOutput

    Dim ssOuVecAP2 As femap.Output
    Set ssOuVecAP2= App.feOutput

    Dim ssOuVecBP1 As femap.Output
    Set ssOuVecBP1= App.feOutput

    Dim ssOuVecBP2 As femap.Output
    Set ssOuVecBP2= App.feOutput

    Dim nsOuVecAP1 As femap.Output
    Set nsOuVecAP1 = App.feOutput

    Dim nsOuVecAP2 As femap.Output
    Set nsOuVecAP2 = App.feOutput

    Dim nsOuVecBP1 As femap.Output
    Set nsOuVecBP1 = App.feOutput

    Dim nsOuVecBP2 As femap.Output
    Set nsOuVecBP2 = App.feOutput

  	Dim vmOuVecAP1 As femap.Output
    Set vmOuVecAP1 = App.feOutput

	Dim vmOuVecAP2 As femap.Output
    Set vmOuVecAP2 = App.feOutput

    Dim vmOuVecBP1 As femap.Output
    Set vmOuVecBP1 = App.feOutput

    Dim vmOuVecBP2 As femap.Output
    Set vmOuVecBP2 = App.feOutput

 
    Dim feView As femap.View
    Set feView = App.feView
    Dim viewID As Long

    Dim feElem As femap.Elem
    Set feElem = App.feElem

	Dim pr As Object
	Set pr = App.feProp

	rc = App.feAppGetActiveView( viewID )
    rc = feView.Get( viewID )
    ouSetID = feView.OutputSet

    ssOuVecAP1.InitScalarAtElem( ouSetID, 301800, "Beam EndA Plane1 Shear stress", FOT_STRESS, False)
    ssOuVecAP2.InitScalarAtElem( ouSetID, 301900, "Beam EndA Plane2 Shear stress", FOT_STRESS, False)
    ssOuVecBP1.InitScalarAtElem( ouSetID, 302000, "Beam EndB Plane1 Shear stress", FOT_STRESS, False)
    ssOuVecBP2.InitScalarAtElem( ouSetID, 302100, "Beam EndB Plane2 Shear stress", FOT_STRESS, False)

    nsOuVecAP1.InitScalarAtElem( ouSetID, 302200, "Beam EndA Plane1 Normal stress", FOT_STRESS, False)
    nsOuVecAP2.InitScalarAtElem( ouSetID, 302300, "Beam EndA Plane2 Normal stress", FOT_STRESS, False)
    nsOuVecBP1.InitScalarAtElem( ouSetID, 302400, "Beam EndB Plane1 Normal stress", FOT_STRESS, False)
    nsOuVecBP2.InitScalarAtElem( ouSetID, 302500, "Beam EndB Plane2 Normal stress", FOT_STRESS, False)

    vmOuVecAP1.InitScalarAtElem( ouSetID, 302600, "Beam EndA Plane1 VonMisses stress", FOT_STRESS, False)
    vmOuVecAP2.InitScalarAtElem( ouSetID, 302700, "Beam EndA Plane2 VonMisses stress", FOT_STRESS, False)
    vmOuVecBP1.InitScalarAtElem( ouSetID, 302800, "Beam EndB Plane1 VonMisses stress", FOT_STRESS, False)
    vmOuVecAP2.InitScalarAtElem( ouSetID, 302900, "Beam EndB Plane2 VonMisses stress", FOT_STRESS, False)

    sfOuVecAP1.setID = ouSetID
    sfOuVecAP1.setID = ouSetID
    sfOuVecBP1.setID = ouSetID
    sfOuVecBP2.setID = ouSetID

    bmOuVecAP1.setID = ouSetID
    bmOuVecAP2.setID = ouSetID
    bmOuVecBP1.setID = ouSetID
 	bmOuVecBP2.setID = ouSetID

    rc = bmOuVecAP1.Get( 3014 ) 'Beam Moment End A Plane 1
    vout = bmOuVecAP1.vcomponent

    rc = bmOuVecAP2.Get( 3015 ) 'Beam Moment End A Plane 2
    vout = bmOuVecAP2.vcomponent

    rc = bmOuVecBP1.Get( 3016 ) 'Beam Moment End B Plane 1
    vout = bmOuVecBP1.vcomponent

    rc = bmOuVecBP2.Get( 3017 ) 'Beam Moment End B Plane 2
    vout = bmOuVecBP2.vcomponent
 
    rc = sfOuVecAP1.Get( 3018 ) 'Beam Shear End A Plane 1
    vout = sfOuVecAP1.vcomponent

    rc = sfOuVecAP2.Get( 3019 ) 'Beam Shear End A Plane 2
    vout = sfOuVecAP2.vcomponent

    rc = sfOuVecBP1.Get( 3020 ) 'Beam Shear End B Plane 1
    vout = sfOuVecBP1.vcomponent

    rc = sfOuVecBP2.Get( 3021 ) 'Beam Shear End B Plane 2
    vout = sfOuVecBP2.vcomponent

    While feElem.Next
      If feElem.type = FET_L_BEAM Then
        propID = feElem.propID
				rc = pr.Get(propID)

				Atw = pr.pval(0)

				If Atw = 1000000 Then
					W = 1000000

					ssOuVecAP1.value(feElem.ID) = sfOuVecAP1.value(feElem.ID)/Atw
					ssOuVecAP2.value(feElem.ID) = sfOuVecAP2.value(feElem.ID)/Atw
					ssOuVecBP1.value(feElem.ID) = sfOuVecBP1.value(feElem.ID)/Atw
					ssOuVecBP2.value(feElem.ID) = sfOuVecBP2.value(feElem.ID)/Atw

					nsOuVecAP1.value(feElem.ID) = -bmOuVecAP1.value(feElem.ID)/W
					nsOuVecAP2.value(feElem.ID) = -bmOuVecAP2.value(feElem.ID)/W
					nsOuVecBP1.value(feElem.ID) = -bmOuVecBP1.value(feElem.ID)/W
					nsOuVecBP2.value(feElem.ID) = -bmOuVecBP2.value(feElem.ID)/W

					vmOuVecAP1.value(feElem.ID) = Sqr((nsOuVecAP1.value(feElem.ID)^2)+3*(ssOuVecAP1.value(feElem.ID)^2))
					vmOuVecAP2.value(feElem.ID) = Sqr((nsOuVecAP2.value(feElem.ID)^2)+3*(ssOuVecAP2.value(feElem.ID)^2))
					vmOuVecBP1.value(feElem.ID) = Sqr((nsOuVecBP1.value(feElem.ID)^2)+3*(ssOuVecBP1.value(feElem.ID)^2))
					vmOuVecBP2.value(feElem.ID) = Sqr((nsOuVecBP2.value(feElem.ID)^2)+3*(ssOuVecBP2.value(feElem.ID)^2))
				Else
					Iyy = pr.pval(1)
					Izz = pr.pval(2)
					h = pr.pval(40)
					bp = pr.pval(41)
					bm = pr.pval(42)
					gp = pr.pval(43)
					gm = pr.pval(44)
					bs = pr.pval(45)
					hs = h - gp - gm

					Ap = bp * gp
					Asr = hs * gs
					Am = bm * gm
					A = Ap + Asr + Am

					Sp = Ap * (gm + hs + 0.5 * gp)
					Ss = Asr * (gm + 0.5 * hs)
					Sm = Am * 0.5 * gm

					ys = (Sp + Ss + Sm)/A

					WwP1 = -Iyy/(h - ys)
					WwP2 = -Izz/(h - ys)
					WzP1 = Iyy/ys
					WzP2 = Izz/ys

					ssOuVecAP1.value(feElem.ID) = sfOuVecAP1.value(feElem.ID)/Atw
					ssOuVecAP2.value(feElem.ID) = sfOuVecAP2.value(feElem.ID)/Atw
					ssOuVecBP1.value(feElem.ID) = sfOuVecBP1.value(feElem.ID)/Atw
					ssOuVecBP2.value(feElem.ID) = sfOuVecBP2.value(feElem.ID)/Atw

					If Abs(WzP1) > Abs(WwP1) Then
						nsOuVecAP1.value(feElem.ID) = -bmOuVecAP1.value(feElem.ID)/WwP1
						nsOuVecBP1.value(feElem.ID) = -bmOuVecBP1.value(feElem.ID)/WwP1
					Else
						nsOuVecAP1.value(feElem.ID) = -bmOuVecAP1.value(feElem.ID)/WzP1
						nsOuVecBP1.value(feElem.ID) =-bmOuVecBP1.value(feElem.ID)/WzP1
					End If

					If Abs(WzP2) > Abs(WwP2) Then
						nsOuVecAP2.value(feElem.ID) = -bmOuVecAP2.value(feElem.ID)/WwP2
						nsOuVecBP2.value(feElem.ID) = -bmOuVecBP2.value(feElem.ID)/WwP2
					Else
						nsOuVecAP2.value(feElem.ID) = -bmOuVecAP2.value(feElem.ID)/WzP2
						nsOuVecBP2.value(feElem.ID) =-bmOuVecBP2.value(feElem.ID)/WzP2
					End If

					vmOuVecAP1.value(feElem.ID) = Sqr((nsOuVecAP1.value(feElem.ID)^2)+3*(ssOuVecAP1.value(feElem.ID)^2))
					vmOuVecAP2.value(feElem.ID) = Sqr((nsOuVecAP2.value(feElem.ID)^2)+3*(ssOuVecAP2.value(feElem.ID)^2))
					vmOuVecBP1.value(feElem.ID) = Sqr((nsOuVecBP1.value(feElem.ID)^2)+3*(ssOuVecBP1.value(feElem.ID)^2))
					vmOuVecBP2.value(feElem.ID) = Sqr((nsOuVecBP2.value(feElem.ID)^2)+3*(ssOuVecBP2.value(feElem.ID)^2))

				End If
      End If
	Wend

	vout(0) = 301800
	vout(1) = 302000
	
	ssOuVecAP1.hascomponent = 3
	ssOuVecAP1.vcomponent = vout
	rc = ssOuVecAP1.Put(301800)
	
	ssOuVecBP1.hascomponent = 3
	ssOuVecBP1.vcomponent = vout
	rc = ssOuVecBP1.Put(302000)

	vout(0) = 301900
	vout(1) = 302100
	
	ssOuVecAP2.hascomponent = 3
	ssOuVecAP2.vcomponent = vout
	rc = ssOuVecAP2.Put(301900)
	
	ssOuVecBP2.hascomponent = 3
	ssOuVecBP2.vcomponent = vout
	rc = ssOuVecBP2.Put(302100)

	vout(0) = 302200
	vout(1) = 302400
	
	nsOuVecAP1.hascomponent = 3
	nsOuVecAP1.vcomponent = vout
	rc = nsOuVecAP1.Put(302200)

	nsOuVecBP1.hascomponent = 3
	nsOuVecBP1.vcomponent = vout
	rc = nsOuVecBP1.Put(302400)

	vout(0) = 302300
	vout(1) = 302500
	
	nsOuVecAP2.hascomponent = 3
	nsOuVecAP2.vcomponent = vout
	rc = nsOuVecAP2.Put(302300)

	nsOuVecBP2.hascomponent = 3
	nsOuVecBP2.vcomponent = vout
	rc = nsOuVecBP2.Put(302500)

	vout(0) = 302600
	vout(1) = 302800

	vmOuVecAP1.hascomponent = 3
	vmOuVecAP1.vcomponent = vout
	rc = vmOuVecAP1.Put(302600)
	
	vmOuVecBP1.hascomponent = 3
	vmOuVecBP1.vcomponent = vout
	rc = vmOuVecBP1.Put(302800)

	vout(0) = 302700
	vout(1) = 302900

	vmOuVecAP2.hascomponent = 3
	vmOuVecAP2.vcomponent = vout
	rc = vmOuVecAP2.Put(302700)
	
	vmOuVecBP2.hascomponent = 3
	vmOuVecBP2.vcomponent = vout
	rc = vmOuVecBP2.Put(302900)
End Sub
