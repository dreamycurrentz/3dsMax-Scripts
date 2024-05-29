fn SubsetArray overlappedFacesArray currOverlappedFaces =
(

	format "\n\n\n\n\n Debug checking subset of arrays\n"
	format "\n OverlappedFacesArray count %" overlappedFacesArray.count
	format "\n CurrOverlappedFaces.count %" currOverlappedFaces.count
	format "\n OverlappedFacesArray %" overlappedFacesArray
	
	overlappedFacesArrayType = classOf overlappedFacesArray
	currOverlappedFacesType = classOf currOverlappedFaces
	
	format "\n\n\n overlappedFacesArrayType: % currOverlappedFacesType: %" overlappedFacesArrayType currOverlappedFacesType
	
	for i = 1 to overlappedFacesArray.count do
	(
		format "\nOverlapped Faces: %\n" overlappedFacesArray[i]
		for overlappedFacesIndex in overlappedFacesArray[i] do
		(
			for currOverlappedFacesIndex in currOverlappedFaces do
			(
				if overlappedFacesIndex == currOverlappedFacesIndex do
				(
					format "Entered and Equal"
					format "\n % \n " overlappedFacesArray[i][currOverlappedFacesIndex]
					
					for k in currOverlappedFaces do
					(
						format "\n currOverlappedFaces[k] %\n" k
						overlappedFacesArray[i][k] = true
					)
					format "\n % \n" overlappedFacesArray
					return 1
				)
			)
		)
	)
	
	return 0
)
	
-- 	for i = 1 to overlappedFacesArray.count do
-- 	(
-- 		for index in overlappedFacesArray[i] do
-- 		(
-- 			for j = 1 to currOverlappedFaces.count do
-- 			(
-- 				if (index == currOverlappedFaces[j]) do
-- 				(
-- 					for k = 1 to currOverlappedFaces.count do
-- 					(
-- 						print "\n\n\nOverlapped Faces\n\n\n"
-- 						format "\n%\n" currOverlappedFaces[k]
-- 						print(overlappedFacesArray[currOverlappedFaces[k]])
-- 					)
-- 					return 1
-- 				)
-- 			)
-- 		)
-- 	)
	
-- 	for i = 1 to overlappedFacesArray.count do
-- 	(
-- 		format "\ni loop: %" i
-- 		for j = 1 to currOverlappedFaces.count do
-- 		(
-- 			format "\nj loop: %" j
-- 			if(overlappedFacesArray[i] == currOverlappedFaces[j]) do
-- 			(
-- 				format "\ni == j"
-- 				break
-- 			)
-- 		)
-- 		if (j == overlappedFacesArray.count) do
-- 		(
-- 			format "\nj == overlappedFacesArray.count"
-- 			return 0
-- 		)
-- 	)
-- 	format "\nReturn 1 / return true"

	

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
	
	format "\nGet Vertices Index From Face: %\n" faceIndex1
	
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
-- 		redrawViews()
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
		format "\n OverlappedFacesAsArray: % \n" overlappedFaces
		
		global overlappedFacesArray = #()
		global currOverlappedFaces = #{}
		
		local status = false
		
		-- Iterate overlapped faces
		for i = 1 to overlappedFaces.count do
		(
		
			currOverlappedFaces = #{}
			
			for j = 1 + 1 to overlappedFaces.count do
			(
				if (overlappedFaces[i] != overlappedFaces[j]) do
				(
					format "\nChecking face index % \n" overlappedFaces[i]
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
			
			format "\n Curr Overlapped Faces: % " currOverlappedFaces
			
			if (currOverlappedFaces.numberSet > 0) do
			(
				if (overlappedFacesArray.count == 0) then
				(
					appendIfUnique overlappedFacesArray currOverlappedFaces
					
				)
				else
				(
					format "\n Entered the second set of selected faces"
					status = SubsetArray overlappedFacesArray currOverlappedFaces
					
					if status == 0 do
					(
						format "\n Status : % \n" status
						appendIfUnique overlappedFacesArray currOverlappedFaces
					)
				)
			)
		)
		
		
-- 		className = classOf currOverlappedFaces
-- 		format "\n\n\nTotal overlapped array: % Object type: %" overlappedFacesArray className
		
		format "\n\n\nTotal overlapped array: % \n" overlappedFacesArray
		
		for i = 1 to overlappedFacesArray.count do
		(
			unwrapMod.selectFaces overlappedFacesArray[i]
			unwrapMod.GroupCreateBySelection()
		)
	/*
		-- Create Group By Selection
		unwrapMod.GroupCreateBySelection()
	*/
	
	
	)
)
