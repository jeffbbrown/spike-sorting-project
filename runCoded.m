cd 'C:\Users\Jeff Brown\Desktop\MB2018 - ANNet\Attention_Neuron'
runScriptDN

cd 'C:\Users\Jeff Brown\Desktop\MB2018 - ANNet\Intermediate_Layer'
runScriptL1

cd 'C:\Users\Jeff Brown\Desktop\MB2018 - ANNet\Output_Layer'
runScriptL2

inputFile='s1_truth.mat';
inputFolder='../data/';
load([inputFolder inputFile]);
F1 = computeFScore(truth, spikeTrainL2, 150);

inputFile='s2_truth.mat';
inputFolder='../data/';
load([inputFolder inputFile]);
F2 = computeFScore(truth, spikeTrainL2, 150);