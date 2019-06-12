clear 

cd 'C:\Users\Jeff Brown\Desktop\MB2018 - ANNet\data'
s1 = simulateSignal([3.3 3.3 3.3], 1, [5 5 10], [0.001 0.001 0.001], [0.0005 0.0005 0.0005], [-0.00025 0.00025 -0.00019], "s1");
s2 = simulateSignal([3.3 3.3 3.3], 1, [5 5 10], [0.001 0.001 0.001], [0.0005 0.0005 0.0005], [-0.00025 0.00025 -0.00019], "s2");

data = [s1 ; 0.5*s1+0.2*s2; 0.2*s1+0.5*s2; s2];

convertAndSaveData(data, 1/80000, "twoSignals")

%cd 'C:\Users\Jeff Brown\Desktop\MB2018 - ANNet\Attention_Neuron'
runScriptDN

%cd 'C:\Users\Jeff Brown\Desktop\MB2018 - ANNet\Intermediate_Layer'
runScriptL1

%cd 'C:\Users\Jeff Brown\Desktop\MB2018 - ANNet\Output_Layer'
runScriptL2

inputFile='s1_truth.mat';
inputFolder='../data/';
load([inputFolder inputFile]);
F1 = computeFScore(truth, spikeTrainL2, 150);

inputFile='s2_truth.mat';
inputFolder='../data/';
load([inputFolder inputFile]);
F2 = computeFScore(truth, spikeTrainL2, 150);
