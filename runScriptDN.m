%file names
inputFile='transformedData.mat';
inputFolder='../data/';

AN_simu_name='ANrun1';
AN_saveFolder='';

%load files
load([inputFolder inputFile]);
signalTransformed = signal;

transform = 0;
if transform
    val = signalTransformed.data;
    t1 = [diff(val, 1)./signalTransformed.dt 0];
    t2 = [diff(val, 2)./signalTransformed.dt^2 0 0];
    signalTransformed.data = t1.^2 - t2.*val;
end

ns = size(signalTransformed.data);
signalTransformed.nSignals = ns(1);

%prepare parameters
simuparameter;
PARAM_DN=createParamDN(SIMU);
SPIKETRANSPOSITION=prepareSpikeTransposition(SIMU,signalTransformed);
neuron = createNewDNNeuron(SIMU,size(signalTransformed.data,2));

%run simulation
start=signalTransformed.start/signalTransformed.dt;
stop=start+size(signalTransformed.data,2);
tic
[neuron]=DNFromSignal(neuron,struct(signalTransformed),SPIKETRANSPOSITION,PARAM_DN,start,stop);
toc
  
%save results
%spikeTrainD=convertNeuronToSpikeTrain(neuron,1/signal.dt,start,stop);
spikeTrainAN=convertNeuronToSpikeTrain(neuron,signalTransformed.dt);
ANPotHist=neuron.PotHist;

resultfile=[AN_saveFolder AN_simu_name '_on_' inputFile];
save(resultfile,'spikeTrainAN','SIMU','ANPotHist');
        


