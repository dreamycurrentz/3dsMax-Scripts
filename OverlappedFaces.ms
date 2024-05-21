fn findMinMax face1VertArray face2VertArray faceIndex1 faceIndex2= 
(
	local minX = face1VertArray[1].x
	local maxX = face1VertArray[1].x
	local minY = face1VertArray[1].y
	local maxY = face1VertArray[1].y
	
	format "Min Max: % % % %" minX maxX minY maxY
	
-- 	format "\nFace 1 vert array %" face1VertArray
-- 	format "\nFace 1 vert array Index %" face1VertArray[1].x
	
	for i = 2 to face1VertArray.count do
	(
		if face1VertArray[i].x < minX do
		(
			minX = face1VertArray[i].x
		)
		
		if face1VertArray[i].x > maxX do
		(
			maxX = face1VertArray[i].x
		)
		
		if face1VertArray[i].y < minY do
		(
			minY = face1VertArray[i].y
		)
		
		if face1VertArray[i].y > maxY do
		(
			maxY = face1VertArray[i].y
		)
	)
	format "\n MinX: % MaxX: % MinY: % MaxY: % " minX maxX minY maxY

	for i = 1 to face2VertArray.count do
	(
		format "\nFace 2 Vertex array %: %" i face2VertArray[i]
		
		if (face2VertArray[i].x > minX and face2VertArray[i].x < maxX and face2VertArray[i].y > minY and face2VertArray[i].y < maxY) do
		(
-- 			format "\n\nFace % and Face % are Overlapping\n\n" faceIndex1 faceIndex2
			return true
		)
	)
	
	return false
)


fn polygonsOverlap unwrapMod obj faceIndex1 faceIndex2 =
(
	vertIndexCount1 = unwrapMod.numberPointsInFace faceIndex1
	vertIndexCount2 = unwrapMod.numberPointsInFace faceIndex2
	
	local face1VertArray = #()
	local face2VertArray = #()
	
	format "Get Vertices Index From Face: %\n" faceIndex1
	
	for i = 1 to vertIndexCount1 do
	(
		vertIndex1 = unwrapMod.getVertexIndexFromFace faceIndex1 i
		face1VertIndex = unwrapMod.GetVertexPositionByNode 0 vertIndex1 obj
		
		format "Point %: %\n" i face1VertIndex
		append face1VertArray face1VertIndex
	)
	
	format "Get Vertices Index From Face: %\n" faceIndex2
	
	for i = 1 to vertIndexCount2 do
	(
		vertIndex2 = unwrapMod.getVertexIndexFromFace faceIndex2 i
		face2VertIndex = unwrapMod.GetVertexPositionByNode 0 vertIndex2 obj
		
		format "Point %: %\n" i face2VertIndex
		append face2VertArray face2VertIndex
	)
	
	return findMinMax face1VertArray face2VertArray faceIndex1 faceIndex2
	
)


if selection.count == 1 then
(
	if isKindOf selection[1] Editable_Poly then
	(
		redrawViews()
		local obj = selection[1]
		max modify mode
		unwrapMod = Unwrap_UVW()
		addModifier obj unwrapMod
		unwrapMod.edit()
		unwrapMod.setTVSubObjectMode 3
		
		unwrapMod.selectOverlappedFaces()
		
		unwrapMod.setTVElementMode true
		overlappedFaces = unwrapMod.getSelectedFaces()
		
		overlappedFaces = overlappedFaces as array
		print "Overlapped Faces: "
		
		overlappedFacesArray = #()
		
		local status = false
		
		-- Iterate overlapped faces
		for i = 1 to overlappedFaces.count do
		(
			
			local currOverlappedFaces = #{}
			
			for j = 1 + 1 to overlappedFaces.count do
			(
				if (overlappedFaces[i] != overlappedFaces[j]) do
				(
					format "Checking face index % \n" overlappedFaces[i]
					status = polygonsOverlap unwrapMod obj overlappedFaces[i] overlappedFaces[j]
					
					format "\n \n Face % and Face % :" overlappedFaces[i] overlappedFaces[j]
					
					if(status) do
					(
						currOverlappedFaces[overlappedFaces[i]] = true
						currOverlappedFaces[overlappedFaces[j]] = true
						status = false
					)
				)
			)
			format "\nOverlapped Faces: % " currOverlappedFaces
			if (currOverlappedFaces.numberSet > 0) do
			(
				appendIfUnique overlappedFacesArray currOverlappedFaces	
			)
		)
		
		format "\n\n\nTotal overlapped array: %" overlappedFacesArray
		
		uniqueArray = makeUniqueArray overlappedFacesArray
		
		format "\n\n\nTotal overlapped unique array test: %" uniqueArray
		
		/*
		for faceIndex in overlappedFaces do
		(
			format "FaceIndex: \n"
			print faceIndex
			bb1 = getUVBoundingBox unwrapMod obj faceIndex
		)
		
	
		for i = 1 to overlappedFaces.numberSet do
		(
			for j = (i+1) to overlappedFaces.numberSet do
			(
				if polygonsOverlap unwrapMod i j do
				(
					appendIfUnique overlaps i
					appendIfUnique overlaps j
				)
			)
		)
		-- Create Group By Selection
		unwrapMod.GroupCreateBySelection()
	*/
	
	)
)
