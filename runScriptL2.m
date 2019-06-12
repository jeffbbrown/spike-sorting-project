%file names
inputFile='transformedData.mat';
inputFolder='../data/';

AN_saveFolder='../Attention_Neuron/';
AN_simu_name='ANrun1';

L1_saveFolder='../Intermediate_Layer/';
L1_simu_name='L1run1';

L2_saveFolder='';
L2_simu_name='L2run1';

%load files
load([inputFolder inputFile]);
ns = size(signal.data);
signal.nSignals = ns(1);
%signal.data = [signal.data signal.data signal.data signal.data(:, 1:end-3)];

ANfile=[ AN_simu_name '_on_' inputFile];
L1file=[ L1_simu_name '_on_' inputFile];

clear spikeTrain1;
load([L1_saveFolder L1file],'spikeTrainL1');

load([AN_saveFolder ANfile],'spikeTrainAN');

%prepare parameters
simuparameter;
PARAM_L2=createParamLayer2(SIMU);
INPUT_SPIKES = prepareInputSpikes( spikeTrainL1,1/signal.dt,SIMU.L2_delay,SIMU.L2_nbDelays);
DN_SPIKES = prepareDNSpikes( spikeTrainAN,1/signal.dt);
neuron2 = createNewNeuronLayer2(SIMU,INPUT_SPIKES);

%run simulation
start=signal.start/signal.dt;
stop=start+size(signal.data,2);
tic
[neuron2,INPUT_SPIKES]=STDPFromSpikes(neuron2,INPUT_SPIKES,DN_SPIKES,PARAM_L2,start,stop);
toc

%save results
spikeTrainL2=convertNeuronToSpikeTrain(neuron2,signal.dt);
L2WeightPos={neuron2.weight};
L2WeightNeg={neuron2.weightNeg};
L2PotHist=reshape([neuron2.PotHist],numel(neuron2(1).PotHist),numel(neuron2));
L2ThHist=reshape([neuron2.ThHist],numel(neuron2(1).ThHist),numel(neuron2));
L2WHistPos=[neuron2.WHist];
L2WHistNeg=[neuron2.WNegHist];

resultfile=[L2_saveFolder L2_simu_name '_on_' inputFile];
save(resultfile,'spikeTrainL2','L2WeightPos','L2WeightNeg','SIMU','AN_simu_name','L1_simu_name','L2WHistPos','L2WHistNeg');
