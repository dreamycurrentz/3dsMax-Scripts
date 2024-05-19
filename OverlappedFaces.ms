fn polygonsOverlap unwrapMod obj faceIndex1 faceIndex2 =
(
	vertIndexCount1 = unwrapMod.numberPointsInFace faceIndex1
	vertIndexCount2 = unwrapMod.numberPointsInFace faceIndex2
	
	for i = 1 to vertIndexCount1 do
	(
		print "Get Vertex Index From Face: "
		vertIndex1 = unwrapMod.getVertexIndexFromFace faceIndex1 i
		vert1 = unwrapMod.GetVertexPositionByNode 0 vertIndex1 obj
		
		vertIndex2 = unwrapMod.getVertexIndexFromFace faceIndex2 i
		vert2 = unwrapMod.GetVertexPositionByNode 0 vertIndex2 obj
		format "Vert1: %\n Vert2: %\n" vert1 vert2
	)
	
-- 	print(unwrapMod.GetVertexPositionByNode 0 1 obj)
-- 	print(unwrapMod.numberPointsInFace faceIndex)
-- 	print (unwrapMod.getVertexPosition 0 faceIndex)
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
		
		
		-- Iterate overlapped faces
		for i = 1 to overlappedFaces.count do
		(
			for j = 1 + 1 to overlappedFaces.count do
			(
				
				if (overlappedFaces[i] != overlappedFaces[j]) do
				(
					local status = polygonsOverlap unwrapMod obj overlappedFaces[i] overlappedFaces[j]
-- 					print overlappedFaces[i]
-- 					print overlappedFaces[j]
				)
			)
		)
		
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