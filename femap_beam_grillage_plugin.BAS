Sub Main
    Dim App As femap.model
    Set App = feFemap()

    Dim ouSetID As Long

    Dim sfOuVecA As femap.Output
    Set sfOuVecA = App.feOutput

	Dim sfOuVecB As femap.Output
    Set sfOuVecB = App.feOutput

    Dim bmOuVecA As femap.Output
    Set bmOuVecA = App.feOutput

	Dim bmOuVecB As femap.Output
    Set bmOuVecB = App.feOutput

    Dim ssOuVecA As femap.Output
    Set ssOuVecA = App.feOutput

    Dim ssOuVecB As femap.Output
    Set ssOuVecB = App.feOutput

    Dim axOuVecA As femap.Output
    Set axOuVecA = App.feOutput

    Dim axOuVecB As femap.Output
    Set axOuVecB = App.feOutput

  	Dim vmOuVecA As femap.Output
    Set vmOuVecA = App.feOutput

    Dim vmOuVecB As femap.Output
    Set vmOuVecB = App.feOutput

 
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

    ssOuVecA.InitScalarAtElem( ouSetID, 301800, "Beam EndA Shear stress", FOT_STRESS, False)
    ssOuVecB.InitScalarAtElem( ouSetID, 302000, "Beam EndB Shear stress", FOT_STRESS, False)

    axOuVecA.InitScalarAtElem( ouSetID, 302200, "Beam EndA Axial stress", FOT_STRESS, False)
    axOuVecB.InitScalarAtElem( ouSetID, 302300, "Beam EndV Axial stress", FOT_STRESS, False)

    vmOuVecA.InitScalarAtElem( ouSetID, 302600, "Beam EndA VonMisses stress", FOT_STRESS, False)
    vmOuVecB.InitScalarAtElem( ouSetID, 302800, "Beam EndB VonMisses stress", FOT_STRESS, False)

    sfOuVecA.setID = ouSetID
    sfOuVecB.setID = ouSetID

    bmOuVecA.setID = ouSetID
    bmOuVecB.setID = ouSetID
 
    rc = sfOuVecA.Get( 3018 ) 'Beam Shear End A
    vout = sfOuVecA.vcomponent

    rc = sfOuVecB.Get( 3020 ) 'Beam Shear End B
    vout = sfOuVecB.vcomponent

	rc = bmOuVecA.Get( 3014 ) 'Beam Moment End A
    vout = bmOuVecA.vcomponent

    rc = bmOuVecB.Get( 3016 ) 'Beam Moment End B
    vout = bmOuVecB.vcomponent



    While feElem.Next
        If feElem.type = FET_L_BEAM Then
            propID = feElem.propID
			rc = pr.Get(propID)

			area = pr.pval(0)

			If area = 1000000 Then
				sectionModulus = 1000000

				ssOuVecA.value(feElem.ID) = sfOuVecA.value(feElem.ID)/area
				ssOuVecB.value(feElem.ID) = sfOuVecB.value(feElem.ID)/area

				axOuVecA.value(feElem.ID) = bmOuVecA.value(feElem.ID)/sectionModulus
				axOuVecB.value(feElem.ID) = bmOuVecB.value(feElem.ID)/sectionModulus

				vmOuVecA.value(feElem.ID) = Sqr((axOuVecA.value(feElem.ID)^2)+3*(ssOuVecA.value(feElem.ID)^2))
				vmOuVecB.value(feElem.ID) = Sqr((axOuVecB.value(feElem.ID)^2)+3*(ssOuVecB.value(feElem.ID)^2))
			Else
				zInertia = pr.pval(1)
				height = pr.pval(40)
				topWidth = pr.pval(41)
				botWidth = pr.pval(42)
				topThick = pr.pval(43)
				botThick = pr.pval(44)
				webThick = pr.pval(45)
				webHeight = height - topThick - botThick

				topArea = topWidth * topThick
				webArea = webHeight * webThick
				botArea = botWidth * bodThick

				topStaticMoment = topArea* (botThick + webHeight + 0.5 * topThick)
				webStaticMoment = webArea * (botThick + 0.5 * webHeight)
				botStaticMoment = botArea * 0.5 * botThick

				centerOffset = (topStaticMoment + webStaticMoment + botStaticMoment)/area

				sectionModulusTop = zInertia/(height - centerOffset)
				sectionModulusBot = zInertia/centerOffset

				ssOuVecA.value(feElem.ID) = sfOuVecA.value(feElem.ID)/webArea
				ssOuVecB.value(feElem.ID) = sfOuVecB.value(feElem.ID)/webArea

				If sectionModulusBot > sectionModulusTop Then
					axOuVecA.value(feElem.ID) = bmOuVecA.value(feElem.ID)/sectionModulusTop
					axOuVecB.value(feElem.ID) = bmOuVecA.value(feElem.ID)/sectionModulusTop
				Else
					axOuVecA.value(feElem.ID) = bmOuVecA.value(feElem.ID)/sectionModulusBot
					axOuVecB.value(feElem.ID) = bmOuVecA.value(feElem.ID)/sectionModulusBot
				End If

				vmOuVecA.value(feElem.ID) = Sqr((axOuVecA.value(feElem.ID)^2)+3*(ssOuVecA.value(feElem.ID)^2))
				vmOuVecB.value(feElem.ID) = Sqr((axOuVecB.value(feElem.ID)^2)+3*(ssOuVecB.value(feElem.ID)^2))

			End If
        End If
	Wend

	vout(0) = 301800
	vout(1) = 302000
	
	ssOuVecA.hascomponent = 3
	ssOuVecA.vcomponent = vout
	rc = ssOuVecA.Put(301800)
	
	ssOuVecB.hascomponent = 3
	ssOuVecB.vcomponent = vout
	rc = ssOuVecB.Put(302000)

	vout(0) = 302200
	vout(1) = 302300
	
	axOuVecA.hascomponent = 3
	axOuVecA.vcomponent = vout
	rc = axOuVecA.Put(302200)

	axOuVecB.hascomponent = 3
	axOuVecB.vcomponent = vout
	rc = axOuVecB.Put(302300)

	vout(0) = 302600
	vout(1) = 302800

	vmOuVecA.hascomponent = 3
	vmOuVecA.vcomponent = vout
	rc = vmOuVecA.Put(302600)
	
	vmOuVecB.hascomponent = 3
	vmOuVecB.vcomponent = vout
	rc = vmOuVecB.Put(302800)
End Sub
