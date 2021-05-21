using LinearAlgebra
include("../Utils/MeshGeometryUtils.jl")


function getnodesgeometricalquantities(nodes, faces)
end

function getfacesgeometricalquantities(nodes, faces)
    for face in faces
        inodes = face.inodes

        # Collect the nodes of the face
        facepoints = []
        for inode in inodes
            push!(facepoints, nodes[inode].centroid)
        end

        # Compute the geometric center of the face
        facegc = computegeometriccenter(facepoints)

        # Start computing face centroid, surface normal, and area --------------
        facecentroid = [0, 0, 0]
        facesf = [0, 0, 0]
        facearea = 0

        # Loop over the entire sub-triangles (local faces)
        for i in 1:length(facepoints)
            r1 = facepoints[i]
            if i < length(facepoints)
                r2 = facepoints[i + 1]
            else
                r2 = facepoints[1]
            end

            # Collect points that make up the local face
            localfacepoints = [r1, r2, facegc]

            # Compute the local face centroid
            localfacecentroid = computegeometriccenter(localfacepoints)

            # Compute the local face surface normal and area
            localfacesf = computesurfacenormal(localfacepoints)
            localfacearea = computemagnitude(localfacesf)

            # Update the face properties
            facecentroid += localfacearea*localfacecentroid
            facesf += localfacesf
            facearea += localfacearea
        end

        # Store face properties
        face.centroid = facecentroid/facearea
        face.sf = facesf
        face.area = facearea

        # End computing total face centorid, surface normal, and area ----------
    end
end

function getcellsgeometricalquantities(nodes, faces, cells)
    for cell in cells
        inodescell = cell.inodes

        # Collect the nodes of the cell
        cellpoints = []
        for inode in inodescell
            push!(cellpoints, nodes[inode].centroid)
        end

        # Compute the geometric center of the cell
        cellgc = computegeometriccenter(cellpoints)

        # Start computing cell centroid and volume -----------------------------
        cellcentroid = [0, 0, 0]
        cellvolume = 0

        # Loop over the entire faces of the cell (local cells)
        for iface in cell.ifaces
            # Get the face geometric quantities that have been calculated
            facearea = faces[iface].area
            facecentroid = faces[iface].centroid
            faceinodes = faces[iface].inodes

            # Collect the nodes of the face
            facepoints = []
            for inode in faceinodes
                push!(facepoints, nodes[inode].centroid)
            end
            push!(facepoints, cellgc)

            # Compute the geometric center of the local cell (pyramid)
            localcellgc = computegeometriccenter(facepoints)

            # Compute the centroid of the local cell
            localcellcentroid = 0.75*facecentroid + 0.25*localcellgc

            # Compute the volume of the local cell
            localcellbase = facearea
            localcellheight = computemagnitude(cellgc - facecentroid)
            localcellvolume = (1/3)*localcellbase*localcellheight

            # Update the cell properties
            cellcentroid += localcellvolume*localcellcentroid
            cellvolume += localcellvolume
        end
        # Store the computed cell properties
        cell.centroid = cellcentroid / cellvolume
        cell.volume = cellvolume
    end
end

function getfacesremainingproperties(nodes, faces, cells)
    for face in faces
        iowner = face.iowner
        ineighbour = face.ineighbour
        sf = face.sf
        ef = sf/(computemagnitude(sf))
        dof = face.centroid - cells[iowner].centroid

        if ineighbour != -1
            # Compute geometric factor (gf)
            dfn = cells[ineighbour].centroid - face.centroid
            gf = dot(dof, ef) / (dot(dof, ef) + dot(dfn, ef))

            # Compute distance vector T joining owner and neighbour
            T = dfn + dof

            # Compute wall distance
            walldist = 0
        else
            # Compute geometric factor (gf)
            gf = 1

            # Compute distance vector T joining owner and neighbour
            T = dof

            # Compute wall distance
            walldist = dot(dof, ef)
        end

        # Store the face remaining properties
        face.gf = gf
        face.cn = dof
        face.T = T
        face.walldist = walldist

    end
end
