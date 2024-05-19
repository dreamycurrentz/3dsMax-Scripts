function addSkirt =
(
	if subObjectLevel == 2 or subObjectLevel == 3 then
	(
		local obj = selection[1]
		local currEdgeSelection = polyOp.getEdgeSelection obj
		
		if currEdgeSelection.numberSet > 0 then
		(
			obj.edgeExtrudeHeight = -1
			obj.edgeExtrudeWidth = 0
			obj.buttonOp #Extrude
			modPanel.addModToSelection(push push_value:1)
			collapseStack obj
			subObjectLevel = 2
			obj.ConvertSelection #Edge #Face
			subObjectLevel = 4
		)
		else
		(
			messagebox "Select edges first."
		)
	)
	else
	(
		messageBox "Go into Edge or Border mode and select 1 or more edges"
	)
)

function addSmoothingGroup =
(
	obj = selection[1]
	obj.autoSmoothThreshold = 30
	polyop.autoSmooth obj
	selectedFaces = polyop.getFaceSelection obj
	for faceIndex in selectedFaces do
	(
		print "Face index: "; print faceIndex
		local currSmoothingGroup = -1
				
		currSmoothingGroup = polyop.getFaceSmoothGroup obj faceIndex
		print "Current smoothing group: "; print currSmoothingGroup
					
		if currSmoothingGroup > -1 do
		(
			currSmoothingGroupInt = log(currSmoothingGroup)/log(2) + 1
			print "Current smoothing group: "; print currSmoothingGroupInt
						
			currSmoothingGroupInt += 20
						
			if(currSmoothingGroupInt > 32) then
			(
				messageBox "Error with the smoothing groups"
			)
			else
			(
				currSmoothingGroup = 2^(currSmoothingGroupInt-1)
				polyOp.setFaceSmoothGroup obj faceIndex currSmoothingGroup add:false
			)
		)
	)
)


if selection.count == 1 then
(
	if isKindOf selection[1] Editable_Poly then 
	(
		addSkirt()
		addSmoothingGroup()
	)
	else
	(
			messageBox "Selected object needs to be Editable Poly"
	)
)
else if selection.count == 0 then
(
	messageBox "No objects selected"
)
else
(
	messageBox "More than one objects selected"
)