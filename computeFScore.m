function F = computeFScore(truth, output, t_aft)
nNeuronsOut = output.nNeurons;
timeStampsOut = output.timeStamps;
neuronTagsOut = output.neuronTags;

outCell = cell(nNeuronsOut, 1);
pts1 = length(timeStampsOut);
for i = 1:pts1
    outCell{neuronTagsOut(i)} = [outCell{neuronTagsOut(i)}, timeStampsOut(i)];
end

nNeuronsTruth = truth.nNeurons;
timeStampsTruth = truth.timeStamps;
neuronTagsTruth = truth.neuronTags;

truthCell = cell(nNeuronsTruth, 1);
pts2 = length(timeStampsTruth);
for i = 1:pts2
    truthCell{neuronTagsTruth(i)} = [truthCell{neuronTagsTruth(i)}, timeStampsTruth(i)];
end

F = zeros(nNeuronsTruth, nNeuronsOut);

for i = 1:nNeuronsTruth
    for j = 1:nNeuronsOut
        oc = outCell(j);
        oc = oc{:};
        oc = oc(oc >= t_aft);
        tc = truthCell(i);
        tc = tc{:};
        tc = tc(tc >= t_aft);
        O = length(oc);
        
        T = length(tc);
        H = 0;
        for h = tc
            if ~isempty(oc(h+1.5 >= oc & oc >= h-1.5))
                H = H + 1;
            end
        end
        F(i, j) = 2*H/(T+O);
    end
end

end