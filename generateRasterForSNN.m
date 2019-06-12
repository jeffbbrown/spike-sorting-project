function plotSpikes = generateRasterForSNN(st)    
    spikeTrain = st;
    nNeurons = spikeTrain.nNeurons;
    timeStamps = spikeTrain.timeStamps;
    neuronTags = spikeTrain.neuronTags;

    spikeCell = cell(nNeurons, 1);
    tmp = size(timeStamps);
    pts = tmp(2);
    for i = 1:pts
        spikeCell{neuronTags(i)} = [spikeCell{neuronTags(i)}, timeStamps(i)];
    end
    figure;
    plotRaster(spikeCell);
end