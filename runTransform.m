clear 

cd 'C:\Users\Jeff Brown\Desktop\MB2018 - ANNet\data'
data = simulateSignal([3.3 3.3 3.3], 4.6, [5 5 10], [0.001 0.001 0.001], [0.0005 0.0005 0.0005], [-0.00025 0.00025 -0.00019], "s3");

convertAndSaveData(data, 1/80000, "transformedData")

cd 'C:\Users\Jeff Brown\Desktop\MB2018 - ANNet\Attention_Neuron'
runScriptDN

cd 'C:\Users\Jeff Brown\Desktop\MB2018 - ANNet\Intermediate_Layer'
runScriptL1

cd 'C:\Users\Jeff Brown\Desktop\MB2018 - ANNet\Output_Layer'
runScriptL2

inputFile='s3_truth.mat';
inputFolder='../data/';
load([inputFolder inputFile]);
F1 = computeFScore(truth, spikeTrainL2, 150);



