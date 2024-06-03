%% EVM Measurement of 5G NR PDSCH Waveforms
% Copyright 2019-2021 The MathWorks, Inc.
%% Simulation parameters
% Select the NR-TM simulation parameters
nrtm = "NR-FR1-TM3.1"; % reference channel
bw   = "20MHz"; % channel bandwidth
scs  = "30kHz"; % subcarrier spacing
dm   = "FDD";   % duplexing mode
%%
targetRNTIs = [];
displayEVM = true;
plotEVM = true;
evm3GPP = true;
%% Create waveform generator object and generate the waveform
tmwavegen = hNRReferenceWaveformGenerator(nrtm,bw,scs,dm);% generator object for the selected NR-TM
[ txWaveform,tmwaveinfo,resourcesinfo] = generateWaveform(tmwavegen,...
    tmwavegen.Config.NumSubframes); % Generate the waveform txWaveform for TDD.
%% Measure duration and power of input signal
Tstop = length(txWaveform)/tmwaveinfo.Info.SampleRate                      %Stop time
pin = 20*log10(rms(txWaveform/sqrt(50)))+30                                %input power
%% Simple RF model 
Gain = 20; %dB
OIP3 = 10; %dBm
a = 10^(Gain/20); %Gain in Watts
c = (4/3)*(a^3)/(50*10^((OIP3-30)/20)); 
rxWaveform = a*txWaveform+c*txWaveform.^3;
%% Plot input/output spectrum
SpectAnalyzer = dsp.SpectrumAnalyzer; %Create the dsp.SpectrumAnalyzer object and set its properties (dsp system toolbox)
SpectAnalyzer.SampleRate = tmwaveinfo.Info.SampleRate;
SpectAnalyzer.ShowLegend = true;
SpectAnalyzer.ChannelNames = {'IN', 'OUT'};
SpectAnalyzer.RBWSource ="Property";
SpectAnalyzer.RBW = 1e5;
SpectAnalyzer.SpectralAverages = 8;
SpectAnalyzer.ReferenceLoad = 50;
SpectAnalyzer([txWaveform rxWaveform]);
pout = 20*log10(rms(rxWaveform/sqrt(50)))+30                               %#ok 