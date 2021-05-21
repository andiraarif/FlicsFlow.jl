function getnodestopology(nodes, faces)
    for node in nodes
        for face in faces
            if node.index in face.inodes
                push!(node.ifaces, face.index)
                if !(face.iowner in node.icells)
                    push!(node.icells, face.iowner)
                end
            end
        end
    end
end

function getfacestopology(nodes, faces)
end

function getcellstopology(nodes, faces, cells)
    for i in 1:length(faces)
        findnodes = false
        iowner = faces[i].iowner
        ineighbour = faces[i].ineighbour
        if !(i in cells[iowner].ifaces)
            push!(cells[iowner].ifaces, i)
            findnodes = true
            for node in faces[i].inodes
                if !(node in cells[iowner].inodes)
                    push!(cells[iowner].inodes, node)
                end
            end
        end
        if ineighbour != -1
            push!(cells[iowner].ineighbours, ineighbour)
            push!(cells[ineighbour].ineighbours, iowner)
            if !(i in cells[ineighbour].ifaces)
                push!(cells[ineighbour].ifaces, i)
                findnodes = true
                for node in faces[i].inodes
                    if !(node in cells[ineighbour].inodes)
                        push!(cells[ineighbour].inodes, node)
                    end
                end
            end
        end
    end
    for cell in cells
        cell.nneighbours = length(cell.ineighbours)
        for iface in cell.ifaces
            if faces[iface].iowner == cell.index
                push!(cell.facesign, 1)
            elseif faces[iface].ineighbour == cell.index
                push!(cell.facesign, -1)
            end
        end
    end
end
