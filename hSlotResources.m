%hSlotResources Slot resources extraction
%   [PDSCHINDICES,PDSCHSYMBOLS,DMRSINDICES,DMRSSYMBOLS] = hSlotResources(PDSCHARRAY,NSLOT) 
%   Extracts the PDSCHINDICES, PDSCHSYMBOLS, DMRSINDICES and DMRSSYMBOLS of slot number NSLOT 
%   given the content in PDSCHARRAY.

%   Copyright 2019 The MathWorks, Inc.

function [pdschIndices,pdschSymbols,dmrsIndices,dmrsSymbols] = hSlotResources(pdschArray,NSlot)

    pdschIndices = [];
    pdschSymbols = [];
    dmrsIndices = [];
    dmrsSymbols = [];

    % For all pdschs present
    for n = 1:length(pdschArray)
        if ~isempty(pdschArray(n).Resources)
            % Check if NSlot is part of the list of active slots
            activeSlots = [pdschArray(n).Resources.NSlot];
            [~,slotIdx] = ismember(NSlot,activeSlots);
            if slotIdx % If the PDSCH is present in this slot, get the indices and symbols
                pdschIndices = [pdschIndices; pdschArray(n).Resources(slotIdx).ChannelIndices];
                pdschSymbols = [pdschSymbols; pdschArray(n).Resources(slotIdx).ChannelSymbols];
                dmrsIndices = [dmrsIndices; pdschArray(n).Resources(slotIdx).DMRSIndices];
                dmrsSymbols = [dmrsSymbols; pdschArray(n).Resources(slotIdx).DMRSSymbols];
            end
        end
    end

end